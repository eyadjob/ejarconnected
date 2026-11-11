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

    /** System role for {@link #validateAgainstMockup}: image 1 is the design, image 2 the implementation. */
    private static final String MOCKUP_SYSTEM_PROMPT =
            "You are a meticulous UI verification assistant for an automated test suite. "
            + "You receive two images: image 1 is an approved MOCKUP/design, image 2 is a screenshot of the "
            + "IMPLEMENTED page. Your job is to prove that the implementation covers the design and that the page "
            + "is healthy. "
            + "Enumerate the distinct elements you can identify in the mockup (logos, headings, labels, inputs, "
            + "buttons, icons, links, footer copy, colour blocks) and, for each one, decide whether the implemented "
            + "page shows it in the same place and with the same purpose. "
            + "Always finish with exactly one item stating that the implemented page shows no error state: no "
            + "validation messages, no red error banner, no stack trace, no 'something went wrong' text, no broken "
            + "image and no blank or half-rendered page. "
            + "Ignore harmless differences: anti-aliasing, exact pixel positions, font rendering, browser chrome, "
            + "scrollbars and image-compression artefacts. "
            + "When an element is missing or visibly different, or an error is visible, mark that item NOT "
            + "satisfied (ok=false) and explain it in findings. Never resolve ambiguity in the page's favour. "
            + "Answer with json only, no prose.";

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
        return requestVerdict(buildPayload(imageBytes, requirement, checklist, apiKey), apiKey);
    }

    /**
     * Compares the screenshot of the implemented page against a mockup/design image.
     *
     * <p>Unlike {@link #validate(byte[], String, String)} no checklist is supplied: the model derives the
     * element list from the mockup itself, verifies every element on the page, and finally asserts that the
     * page shows no error state (validation errors, fatal banner, stack trace, blank page, broken image).</p>
     *
     * @param pageScreenshot screenshot of the running page - shown to the model as image 2
     * @param mockupImage    approved design / mockup - shown to the model as image 1
     * @param requirement    one-line description of what is being compared
     * @throws IllegalStateException when no API key is configured
     */
    public Verdict validateAgainstMockup(byte[] pageScreenshot, byte[] mockupImage, String requirement)
            throws IOException, InterruptedException {
        if (pageScreenshot == null || pageScreenshot.length == 0) {
            throw new IllegalArgumentException("Page screenshot is empty; nothing to compare.");
        }
        if (mockupImage == null || mockupImage.length == 0) {
            throw new IllegalArgumentException("Mockup image is empty; nothing to compare against.");
        }
        String apiKey = resolveApiKey();
        return requestVerdict(buildMockupPayload(pageScreenshot, mockupImage, requirement), apiKey);
    }

    /** Sends the payload and parses the verdict; retries once when the model returns nothing usable. */
    private Verdict requestVerdict(String payload, String apiKey) throws IOException, InterruptedException {
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

    /**
     * Payload for {@link #validateAgainstMockup(byte[], byte[], String)}: the mockup is image 1 and the page
     * screenshot image 2, so the model compares design against implementation instead of a written checklist.
     */
    private String buildMockupPayload(byte[] pageScreenshot, byte[] mockupImage, String requirement) {
        String userText =
                "Requirement: " + requirement + "\n\n"
                + "Image 1 = MOCKUP (approved design). Image 2 = IMPLEMENTED PAGE (screenshot of the running app).\n"
                + "Do this, in order:\n"
                + "1. List every distinct element of the mockup, in reading order.\n"
                + "2. For each element decide whether the implemented page shows the same element, in the same "
                + "place, with the same purpose.\n"
                + "3. Finish with exactly one item that checks the implemented page shows no error state.\n\n"
                + "Return json exactly in this shape:\n"
                + "{\"items\": [{\"item\": \"<design element>\", \"ok\": true, \"evidence\": \"<where it appears on the page>\"}], "
                + "\"pass\": true, \"confidence\": 0.95, \"findings\": []}\n"
                + "Keep every string under 20 words. Mark ok=false when an element is missing or visibly "
                + "different, or when an error state is visible, and put a one-line reason in findings for each "
                + "failing item. Leave findings empty when everything holds.";

        JsonObject textPart = new JsonObject();
        textPart.addProperty("type", "text");
        textPart.addProperty("text", userText);

        JsonArray content = new JsonArray();
        content.add(textPart);
        content.add(imagePart(mockupImage));
        content.add(imagePart(pageScreenshot));

        JsonObject userMessage = new JsonObject();
        userMessage.addProperty("role", "user");
        userMessage.add("content", content);

        JsonObject systemMessage = new JsonObject();
        systemMessage.addProperty("role", "system");
        systemMessage.addProperty("content", MOCKUP_SYSTEM_PROMPT);

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
        return body.toString();
    }

    /** OpenAI-compatible {@code image_url} content part; the MIME type is sniffed from the bytes. */
    private static JsonObject imagePart(byte[] imageBytes) {
        JsonObject imageUrl = new JsonObject();
        imageUrl.addProperty("url", "data:" + mimeType(imageBytes) + ";base64,"
                + Base64.getEncoder().encodeToString(imageBytes));
        imageUrl.addProperty("detail", "high");
        JsonObject part = new JsonObject();
        part.addProperty("type", "image_url");
        part.add("image_url", imageUrl);
        return part;
    }

    /** PNG/JPEG/GIF/WebP detection so a mockup supplied as .jpg is not mislabelled as PNG. */
    private static String mimeType(byte[] b) {
        if (b.length > 3 && (b[0] & 0xFF) == 0x89 && b[1] == 0x50 && b[2] == 0x4E && b[3] == 0x47) {
            return "image/png";
        }
        if (b.length > 3 && (b[0] & 0xFF) == 0xFF && (b[1] & 0xFF) == 0xD8) {
            return "image/jpeg";
        }
        if (b.length > 3 && b[0] == 'G' && b[1] == 'I' && b[2] == 'F') {
            return "image/gif";
        }
        if (b.length > 12 && b[0] == 'R' && b[1] == 'I' && b[2] == 'F' && b[3] == 'F'
                && b[8] == 'W' && b[9] == 'E' && b[10] == 'B' && b[11] == 'P') {
            return "image/webp";
        }
        return "image/png";
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
