package automation.framework.ai;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.Duration;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Collections;
import java.util.List;

/**
 * Asks a DeepSeek vision model whether a screenshot matches a written checklist.
 *
 * <p>This is the "LLM as judge" layer: the test still decides pass/fail, but the judgement about how
 * the page <em>looks</em> comes from the model instead of a hard-coded selector assertion. The model is
 * forced into JSON output so the verdict can be parsed deterministically.</p>
 *
 * <p>The API key is resolved from, in order:</p>
 * <ol>
 *   <li>the {@code DEEPSEEK_API_KEY} environment variable,</li>
 *   <li>the file named by {@code -Ddeepseek.key.file},</li>
 *   <li>{@code AI Agent Credentials/deepseek.key}, then {@code AI Agent Credentials/deepseek.key.txt}.</li>
 * </ol>
 *
 * <p>Overridable system properties: {@code deepseek.api.url}, {@code deepseek.model},
 * {@code deepseek.key.file}.</p>
 */
public class DeepSeekVisionValidator {

    public static final String API_KEY_ENV = "DEEPSEEK_API_KEY";

    private static final String DEFAULT_ENDPOINT = "https://api.deepseek.com/chat/completions";
    private static final String DEFAULT_MODEL = "deepseek-flash";
    /**
     * Untracked key files, tried in order. The bare name is preferred, the {@code .txt} variant is kept
     * so a renamed file does not silently break the run.
     */
    private static final String[] DEFAULT_KEY_FILES = {
            "AI Agent Credentials/deepseek.key",
            "AI Agent Credentials/deepseek.key.txt"
    };

    private static final String SYSTEM_PROMPT =
            "You are a meticulous UI verification assistant for an automated test suite. "
            + "You compare a screenshot of a web page with a checklist written by a tester. "
            + "Judge EVERY checklist line independently and return one entry per line, in the same order. "
            + "Be strict about the checklist items, but ignore harmless differences such as anti-aliasing, "
            + "exact pixel positions, or font rendering. "
            + "If a line is ambiguous, self-contradictory, or cannot be verified from the screenshot alone, "
            + "mark that line NOT satisfied (ok=false) and explain why \u2014 never resolve ambiguity in the "
            + "page's favour. Answer with json only, no prose.";

    /** One checklist line and the model's verdict for it. */
    public static class Item {
        private final String text;
        private final boolean ok;
        private final String evidence;

        Item(String text, boolean ok, String evidence) {
            this.text = text;
            this.ok = ok;
            this.evidence = evidence;
        }

        public String getText() {
            return text;
        }

        public boolean isOk() {
            return ok;
        }

        public String getEvidence() {
            return evidence;
        }

        @Override
        public String toString() {
            return (ok ? "OK   " : "FAIL ") + text
                    + (evidence == null || evidence.isEmpty() ? "" : " (" + evidence + ")");
        }
    }

    /** The model's judgement. */
    public static class Verdict {
        private final boolean pass;
        private final double confidence;
        private final List<Item> items;
        private final List<String> findings;
        private final String rawResponse;

        Verdict(boolean modelPass, double confidence, List<Item> items,
                List<String> findings, String rawResponse) {
            this.items = items == null ? Collections.emptyList() : items;
            // The model's own "pass" is only used when it returned no per-item verdicts: one failed
            // or ambiguous line must fail the whole run, regardless of the model's summary boolean.
            this.pass = this.items.isEmpty()
                    ? modelPass
                    : this.items.stream().allMatch(Item::isOk);
            this.confidence = confidence;
            this.findings = findings == null ? Collections.emptyList() : findings;
            this.rawResponse = rawResponse;
        }

        public boolean isPass() {
            return pass;
        }

        public double getConfidence() {
            return confidence;
        }

        public List<Item> getItems() {
            return items;
        }

        public List<String> getFindings() {
            return findings;
        }

        public String getRawResponse() {
            return rawResponse;
        }

        @Override
        public String toString() {
            List<Item> failed = new ArrayList<>();
            for (Item item : items) {
                if (!item.isOk()) {
                    failed.add(item);
                }
            }
            return "pass=" + pass + ", confidence=" + confidence
                    + (items.isEmpty() ? "" : ", failedItems=" + failed)
                    + ", findings=" + findings;
        }
    }

    private final String endpoint;
    private final String model;
    private final HttpClient httpClient;

    public DeepSeekVisionValidator() {
        this.endpoint = System.getProperty("deepseek.api.url", DEFAULT_ENDPOINT);
        this.model = System.getProperty("deepseek.model", DEFAULT_MODEL);
        this.httpClient = HttpClient.newBuilder()
                .connectTimeout(Duration.ofSeconds(30))
                .build();
    }

    /**
     * @param imageBytes  PNG/JPEG/GIF/WebP screenshot
     * @param requirement one-line description of what is being checked
     * @param checklist   items the page must show, one per line
     * @throws IllegalStateException when no API key is configured
     */
    public Verdict validate(byte[] imageBytes, String requirement, String checklist)
            throws IOException, InterruptedException {
        if (imageBytes == null || imageBytes.length == 0) {
            throw new IllegalArgumentException("Screenshot is empty; nothing to validate.");
        }
        String apiKey = resolveApiKey();
        String payload = buildPayload(imageBytes, requirement, checklist, apiKey);

        String lastProblem = "";
        for (int attempt = 1; attempt <= 2; attempt++) {
            HttpRequest request = HttpRequest.newBuilder(URI.create(endpoint))
                    .header("Content-Type", "application/json")
                    .header("Authorization", "Bearer " + apiKey)
                    .timeout(Duration.ofSeconds(120))
                    .POST(HttpRequest.BodyPublishers.ofString(payload, StandardCharsets.UTF_8))
                    .build();

            HttpResponse<String> response = httpClient.send(request,
                    HttpResponse.BodyHandlers.ofString(StandardCharsets.UTF_8));
            if (response.statusCode() != 200) {
                throw new IOException("DeepSeek API returned HTTP " + response.statusCode() + ": "
                        + abbreviate(response.body()));
            }

            String content = extractContent(response.body());
            if (content == null || content.trim().isEmpty()) {
                // JSON mode replaces unparseable output with spaces; retry once.
                lastProblem = "empty content (finish_reason=" + extractFinishReason(response.body()) + ")";
                continue;
            }
            Verdict verdict = parseVerdict(content);
            if (verdict != null) {
                return verdict;
            }
            lastProblem = "content was not valid JSON: " + abbreviate(content);
        }
        throw new IOException("Could not obtain a JSON verdict from DeepSeek (" + lastProblem + ")");
    }

    private String buildPayload(byte[] imageBytes, String requirement, String checklist, String apiKey) {
        String base64 = Base64.getEncoder().encodeToString(imageBytes);
        String userText =
                "Requirement: " + requirement + "\n\n"
                + "Checklist (every item must hold):\n" + checklist + "\n\n"
                + "Return json exactly in this shape:\n"
                + "{\"items\": [{\"item\": \"<checklist line>\", \"ok\": true}], "
                + "\"pass\": true, \"confidence\": 0.95, \"findings\": []}\n"
                + "Provide exactly one items entry per checklist line, in the same order, "
                + "using the line text unchanged. Do not add any other keys, and keep every string under 20 words. "
                + "Set ok=false when a line is not satisfied, is ambiguous, or cannot be verified from the screenshot; "
                + "put a one-line reason in findings for each failing line and leave findings empty when all pass.";

        JsonObject textPart = new JsonObject();
        textPart.addProperty("type", "text");
        textPart.addProperty("text", userText);

        JsonObject imageUrl = new JsonObject();
        imageUrl.addProperty("url", "data:image/png;base64," + base64);
        imageUrl.addProperty("detail", "high");
        JsonObject imagePart = new JsonObject();
        imagePart.addProperty("type", "image_url");
        imagePart.add("image_url", imageUrl);

        JsonArray content = new JsonArray();
        content.add(textPart);
        content.add(imagePart);

        JsonObject userMessage = new JsonObject();
        userMessage.addProperty("role", "user");
        userMessage.add("content", content);

        JsonObject systemMessage = new JsonObject();
        systemMessage.addProperty("role", "system");
        systemMessage.addProperty("content", SYSTEM_PROMPT);

        JsonArray messages = new JsonArray();
        messages.add(systemMessage);
        messages.add(userMessage);

        JsonObject responseFormat = new JsonObject();
        responseFormat.addProperty("type", "json_object");

        JsonObject body = new JsonObject();
        body.addProperty("model", model);
        body.add("messages", messages);
        body.add("response_format", responseFormat);
        body.addProperty("temperature", 0);
        body.addProperty("max_tokens", 2000);
        body.addProperty("stream", false);
        // The key travels in the header only; it is never echoed into logs.
        return body.toString();
    }

    private static String extractContent(String responseBody) {
        JsonObject root = JsonParser.parseString(responseBody).getAsJsonObject();
        if (!root.has("choices") || root.getAsJsonArray("choices").size() == 0) {
            return null;
        }
        JsonObject choice = root.getAsJsonArray("choices").get(0).getAsJsonObject();
        if (!choice.has("message")) {
            return null;
        }
        JsonObject message = choice.getAsJsonObject("message");
        return message.has("content") && !message.get("content").isJsonNull()
                ? message.get("content").getAsString() : null;
    }

    /** Reason the model stopped, e.g. {@code stop} or {@code length}; helps explain an empty verdict. */
    private static String extractFinishReason(String responseBody) {
        try {
            JsonObject root = JsonParser.parseString(responseBody).getAsJsonObject();
            if (!root.has("choices") || root.getAsJsonArray("choices").size() == 0) {
                return "no-choices";
            }
            JsonObject choice = root.getAsJsonArray("choices").get(0).getAsJsonObject();
            return choice.has("finish_reason") && !choice.get("finish_reason").isJsonNull()
                    ? choice.get("finish_reason").getAsString() : "unknown";
        } catch (RuntimeException e) {
            return "unparseable-response";
        }
    }

    private static Verdict parseVerdict(String content) {
        try {
            String json = content.trim();
            int start = json.indexOf('{');
            int end = json.lastIndexOf('}');
            if (start < 0 || end <= start) {
                return null;
            }
            JsonObject verdict = JsonParser.parseString(json.substring(start, end + 1)).getAsJsonObject();

            boolean modelPass = verdict.has("pass") && verdict.get("pass").getAsBoolean();
            double confidence = verdict.has("confidence") && verdict.get("confidence").isJsonPrimitive()
                    ? verdict.get("confidence").getAsDouble() : 0.0;

            List<Item> items = new ArrayList<>();
            if (verdict.has("items") && verdict.get("items").isJsonArray()) {
                for (JsonElement element : verdict.getAsJsonArray("items")) {
                    if (!element.isJsonObject()) {
                        continue;
                    }
                    JsonObject item = element.getAsJsonObject();
                    String text = item.has("item") && !item.get("item").isJsonNull()
                            ? item.get("item").getAsString() : "";
                    boolean ok = item.has("ok") && item.get("ok").isJsonPrimitive()
                            && item.get("ok").getAsBoolean();
                    String evidence = item.has("evidence") && !item.get("evidence").isJsonNull()
                            ? item.get("evidence").getAsString() : "";
                    items.add(new Item(text, ok, evidence));
                }
            }

            List<String> findings = new ArrayList<>();
            if (verdict.has("findings") && verdict.get("findings").isJsonArray()) {
                for (JsonElement finding : verdict.getAsJsonArray("findings")) {
                    findings.add(finding.isJsonPrimitive() ? finding.getAsString() : finding.toString());
                }
            }
            return new Verdict(modelPass, confidence, items, findings, content.trim());
        } catch (RuntimeException malformed) {
            return null;
        }
    }

    /** Environment variable first, then the untracked key file. */
    static String resolveApiKey() {
        String fromEnv = System.getenv(API_KEY_ENV);
        if (fromEnv != null && !fromEnv.trim().isEmpty()) {
            return fromEnv.trim();
        }

        String explicit = System.getProperty("deepseek.key.file");
        List<Path> candidates = new ArrayList<>();
        if (explicit != null && !explicit.trim().isEmpty()) {
            candidates.add(Paths.get(explicit.trim()));
        } else {
            for (String name : DEFAULT_KEY_FILES) {
                candidates.add(Paths.get(name));
            }
        }

        for (Path path : candidates) {
            if (!Files.isRegularFile(path)) {
                continue;
            }
            try {
                String key = new String(Files.readAllBytes(path), StandardCharsets.UTF_8).trim();
                if (!key.isEmpty()) {
                    return key;
                }
            } catch (IOException e) {
                throw new IllegalStateException("Could not read DeepSeek key file: " + path.toAbsolutePath(), e);
            }
        }
        throw new IllegalStateException("No DeepSeek API key found. Set " + API_KEY_ENV
                + " or put the key in one of: " + candidates);
    }

    private static String abbreviate(String text) {
        if (text == null) {
            return "";
        }
        return text.length() > 300 ? text.substring(0, 300) + "..." : text;
    }
}
