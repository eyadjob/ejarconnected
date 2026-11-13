package automation.framework.ai;

import automation.framework.mcp.McpPlaywrightClient;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.time.Duration;

/**
 * Drives a page through the Playwright MCP server by asking DeepSeek what to do next.
 *
 * <p>Each turn the agent reads the accessibility snapshot the MCP server produces — every element in it
 * carries a stable {@code [ref=eN]} — sends the snapshot plus the goal to DeepSeek, and executes the single
 * action the model picks through the MCP tools themselves ({@code browser_click}, {@code browser_type},
 * {@code browser_select_option}, {@code browser_press_key}). The loop stops when the model answers
 * {@code done}, when it answers {@code fail}, or after {@link #MAX_TURNS} turns.</p>
 *
 * <p>Nothing here knows about selectors or JavaScript: the judgement about *which* control to use belongs to
 * the model, exactly like a human clicking through the page.</p>
 */
public class DeepSeekPageAgent {

    /** Safety stop: how many single actions one goal may use. Autocomplete steps need type + pick + confirm. */
    private static final int MAX_TURNS = 10;
    /** Snapshot budget so a huge page does not blow the request. */
    private static final int MAX_SNAPSHOT_CHARS = 14_000;

    private static final String SYSTEM_PROMPT =
            "You are a browser automation agent. You receive the accessibility snapshot of the current page "
            + "produced by Playwright MCP; every element that can be acted on carries a [ref=eN] token. "
            + "Choose exactly ONE next action that makes progress towards the user's goal. "
            + "Reply with json only: {\"action\":\"click|type|select|press|done|fail\",\"ref\":\"e12\","
            + "\"element\":\"short human description\",\"value\":\"text for type/select/press\",\"reason\":\"why\"}. "
            + "Rules: use ONLY refs that appear verbatim in the snapshot; for a dropdown click it first and pick "
            + "the option on a later turn; after typing, submit the form if the goal requires it; answer done as "
            + "soon as the goal is visibly satisfied; answer fail when the snapshot cannot reach the goal. "
            + "When the goal asks to pick the first entry of a suggestion or autocomplete list, type the given text "
            + "first and then, on a later turn, click the FIRST option the list shows in the snapshot — do not try "
            + "to guess which record exists. "
            + "If a previous action failed (for example a click was intercepted by an overlay), do NOT repeat it "
            + "unchanged: choose an alternative such as pressing Enter or using another element. "
            + "Never invent refs and never return more than one action.";

    private final String endpoint;
    private final String model;
    private final HttpClient httpClient;
    private final String apiKey;

    public DeepSeekPageAgent() {
        this.endpoint = System.getProperty("deepseek.api.url", "https://api.deepseek.com/chat/completions");
        this.model = System.getProperty("deepseek.model", "deepseek-flash");
        this.httpClient = HttpClient.newBuilder().connectTimeout(Duration.ofSeconds(30)).build();
        this.apiKey = DeepSeekVisionValidator.resolveApiKey();
    }

    /** Runs the agent loop until the goal is reached, the model gives up, or the turn budget is spent. */
    public void act(McpPlaywrightClient mcp, String goal) throws IOException, InterruptedException {
        String lastResult = "";
        for (int turn = 1; turn <= MAX_TURNS; turn++) {
            String snapshot = snapshotWhenReady(mcp);
            JsonObject decision = ask(goal, snapshot, lastResult);

            String action = get(decision, "action").toLowerCase();
            String ref = get(decision, "ref");
            String element = get(decision, "element");
            String value = get(decision, "value");
            String reason = get(decision, "reason");
            System.out.println("DeepSeek action [" + turn + "/" + MAX_TURNS + "]: " + action
                    + " ref=" + ref + " element=" + element
                    + (value.isEmpty() ? "" : " value=\"" + value + "\"")
                    + (reason.isEmpty() ? "" : " — " + reason));

            if ("done".equals(action)) {
                return;
            }
            if ("fail".equals(action)) {
                throw new IllegalStateException("DeepSeek could not perform \"" + goal + "\": " + reason);
            }

            try {
                switch (action) {
                    case "click":
                        lastResult = mcp.callTool("browser_click", args(element, ref, null));
                        break;
                    case "type":
                        lastResult = mcp.callTool("browser_type", args(element, ref, value));
                        break;
                    case "select":
                        JsonObject selectArgs = args(element, ref, null);
                        com.google.gson.JsonArray values = new com.google.gson.JsonArray();
                        values.add(value);
                        selectArgs.add("values", values);
                        lastResult = mcp.callTool("browser_select_option", selectArgs);
                        break;
                    case "press":
                        JsonObject pressArgs = new JsonObject();
                        pressArgs.addProperty("key", value.isEmpty() ? "Enter" : value);
                        lastResult = mcp.callTool("browser_press_key", pressArgs);
                        break;
                    default:
                        throw new IllegalStateException("DeepSeek returned an unknown action: " + action);
                }
            } catch (Exception toolFailure) {
                // Hand the failure back to the model so the next turn can choose an alternative action.
                lastResult = "ERROR: " + toolFailure.getMessage();
                System.out.println("MCP action failed, asking DeepSeek for an alternative: "
                        + abbreviate(toolFailure.getMessage()));
            }
            Thread.sleep(1200);
        }
        throw new IllegalStateException("DeepSeek did not complete \"" + goal + "\" within " + MAX_TURNS + " actions");
    }

    /** The SPA renders progressively; an empty or ref-less snapshot is retried before asking the model. */
    private static String snapshotWhenReady(McpPlaywrightClient mcp) throws IOException {
        String compact = "";
        for (int attempt = 1; attempt <= 5; attempt++) {
            compact = compact(mcp.snapshot());
            boolean hasRefs = compact.contains("[ref=");
            if (compact.length() > 40 && (hasRefs || !compact.contains("```yaml"))) {
                return compact;
            }
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
                break;
            }
        }
        return compact;
    }

    private static String abbreviate(String text) {
        if (text == null) {
            return "";
        }
        String oneLine = text.replaceAll("\\s+", " ").trim();
        return oneLine.length() > 200 ? oneLine.substring(0, 200) + "…" : oneLine;
    }

    private static JsonObject args(String element, String ref, String text) {
        JsonObject args = new JsonObject();
        args.addProperty("element", element == null || element.isEmpty() ? "element " + ref : element);
        if (ref != null && !ref.isEmpty()) {
            // The MCP tools expect the snapshot ref in the "target" argument.
            args.addProperty("target", ref);
        }
        if (text != null) {
            args.addProperty("text", text);
        }
        return args;
    }

    private JsonObject ask(String goal, String snapshot, String lastResult) throws IOException, InterruptedException {
        String user = "Goal: " + goal + "\n\n"
                + (lastResult == null || lastResult.isBlank() ? "" : "Result of the previous action: "
                    + lastResult.substring(0, Math.min(lastResult.length(), 400)) + "\n\n")
                + "Accessibility snapshot:\n" + snapshot + "\n\n"
                + "Return json only, shape: {\"action\":\"...\",\"ref\":\"...\",\"element\":\"...\","
                + "\"value\":\"...\",\"reason\":\"...\"}";

        JsonObject systemMessage = new JsonObject();
        systemMessage.addProperty("role", "system");
        systemMessage.addProperty("content", SYSTEM_PROMPT);
        JsonObject userMessage = new JsonObject();
        userMessage.addProperty("role", "user");
        userMessage.addProperty("content", user);

        com.google.gson.JsonArray messages = new com.google.gson.JsonArray();
        messages.add(systemMessage);
        messages.add(userMessage);

        JsonObject responseFormat = new JsonObject();
        responseFormat.addProperty("type", "json_object");

        JsonObject body = new JsonObject();
        body.addProperty("model", model);
        body.add("messages", messages);
        body.add("response_format", responseFormat);
        body.addProperty("temperature", 0);
        body.addProperty("max_tokens", 400);
        body.addProperty("stream", false);

        HttpRequest request = HttpRequest.newBuilder(URI.create(endpoint))
                .header("Content-Type", "application/json")
                .header("Authorization", "Bearer " + apiKey)
                .timeout(Duration.ofSeconds(90))
                .POST(HttpRequest.BodyPublishers.ofString(body.toString(), StandardCharsets.UTF_8))
                .build();

        HttpResponse<String> response = httpClient.send(request,
                HttpResponse.BodyHandlers.ofString(StandardCharsets.UTF_8));
        if (response.statusCode() != 200) {
            throw new IOException("DeepSeek API returned HTTP " + response.statusCode() + ": " + response.body());
        }
        JsonObject root = JsonParser.parseString(response.body()).getAsJsonObject();
        String content = root.getAsJsonArray("choices").get(0).getAsJsonObject()
                .getAsJsonObject("message").get("content").getAsString();
        int start = content.indexOf('{');
        int end = content.lastIndexOf('}');
        if (start < 0 || end <= start) {
            throw new IOException("DeepSeek did not return a JSON action: " + content);
        }
        return JsonParser.parseString(content.substring(start, end + 1)).getAsJsonObject();
    }

    /** Keeps only the yaml snapshot part and caps its size. */
    private static String compact(String snapshot) {
        String text = snapshot == null ? "" : snapshot;
        int yaml = text.indexOf("```yaml");
        if (yaml >= 0) {
            text = text.substring(yaml + 7);
        }
        int end = text.indexOf("```");
        if (end >= 0) {
            text = text.substring(0, end);
        }
        text = text.trim();
        return text.length() > MAX_SNAPSHOT_CHARS ? text.substring(0, MAX_SNAPSHOT_CHARS) : text;
    }

    private static String get(JsonObject json, String key) {
        return json.has(key) && !json.get(key).isJsonNull() ? json.get(key).getAsString().trim() : "";
    }
}
