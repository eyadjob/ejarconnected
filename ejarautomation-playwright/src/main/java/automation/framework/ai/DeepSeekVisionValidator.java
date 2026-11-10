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
            + "You compare a screenshot of a web page with a checklist written by a tester and decide "
            + "whether the page matches. Be strict about the checklist items, but ignore harmless "
            + "differences such as anti-aliasing, exact pixel positions, or font rendering. "
            + "Answer with json only, no prose.";

    /** The model's judgement. */
    public static class Verdict {
        private final boolean pass;
        private final double confidence;
        private final List<String> findings;
        private final String rawResponse;

        Verdict(boolean pass, double confidence, List<String> findings, String rawResponse) {
            this.pass = pass;
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

        public List<String> getFindings() {
            return findings;
        }

        public String getRawResponse() {
            return rawResponse;
        }

        @Override
        public String toString() {
            return "pass=" + pass + ", confidence=" + confidence + ", findings=" + findings;
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
                lastProblem = "empty content (finish_reason may be length)";
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
                + "{\"pass\": true, \"confidence\": 0.95, \"findings\": [\"short note\"]}\n"
                + "Set \"pass\" to false if any item is missing or clearly different. "
                + "Use \"findings\" for anything missing, different, or worth a human's attention, "
                + "and leave it as an empty array when everything matches.";

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
        body.addProperty("max_tokens", 800);
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

    private static Verdict parseVerdict(String content) {
        try {
            String json = content.trim();
            int start = json.indexOf('{');
            int end = json.lastIndexOf('}');
            if (start < 0 || end <= start) {
                return null;
            }
            JsonObject verdict = JsonParser.parseString(json.substring(start, end + 1)).getAsJsonObject();

            boolean pass = verdict.has("pass") && verdict.get("pass").getAsBoolean();
            double confidence = verdict.has("confidence") && verdict.get("confidence").isJsonPrimitive()
                    ? verdict.get("confidence").getAsDouble() : 0.0;

            List<String> findings = new ArrayList<>();
            if (verdict.has("findings") && verdict.get("findings").isJsonArray()) {
                for (JsonElement finding : verdict.getAsJsonArray("findings")) {
                    findings.add(finding.isJsonPrimitive() ? finding.getAsString() : finding.toString());
                }
            }
            return new Verdict(pass, confidence, findings, content.trim());
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
