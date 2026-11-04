package automation.framework.business;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import lombok.extern.slf4j.Slf4j;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.Collections;
import java.util.List;
import java.util.Map;

/**
 * Client for Ollama local LLM API (e.g. qwen3-coder:30b at http://localhost:11434).
 * Used by AI-assisted Ejar login scenarios.
 */
@Slf4j
public class OllamaClient {

    private static final String DEFAULT_BASE_URL = "http://localhost:11434";
    private static final String DEFAULT_MODEL = "qwen3-coder:30b";
    private static final int TIMEOUT_SECONDS = 120;

    private final String baseUrl;
    private final String model;
    private final HttpClient httpClient;
    private final Gson gson = new Gson();

    public OllamaClient() {
        this(DEFAULT_BASE_URL, DEFAULT_MODEL);
    }

    public OllamaClient(String baseUrl, String model) {
        this.baseUrl = baseUrl.replaceAll("/$", "");
        this.model = model != null ? model : DEFAULT_MODEL;
        this.httpClient = HttpClient.newBuilder()
                .connectTimeout(Duration.ofSeconds(10))
                .build();
    }

    /**
     * Send a chat prompt to Ollama and return the assistant's reply (non-streaming).
     *
     * @param userPrompt the user message
     * @return the model's response text, or empty string on error
     */
    public String chat(String userPrompt) {
        if (userPrompt == null || userPrompt.isBlank()) {
            return "";
        }
        try {
            Map<String, Object> body = Map.of(
                    "model", model,
                    "messages", List.of(Map.of("role", "user", "content", userPrompt)),
                    "stream", false
            );
            String json = gson.toJson(body);
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(baseUrl + "/api/chat"))
                    .header("Content-Type", "application/json")
                    .timeout(Duration.ofSeconds(TIMEOUT_SECONDS))
                    .POST(HttpRequest.BodyPublishers.ofString(json))
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            if (response.statusCode() != 200) {
                log.warn("Ollama API returned status {}: {}", response.statusCode(), response.body());
                return "";
            }
            JsonObject root = gson.fromJson(response.body(), JsonObject.class);
            if (root == null) return "";
            if (root.has("message") && root.get("message").isJsonObject()) {
                String content = root.getAsJsonObject("message").getAsJsonPrimitive("content").getAsString();
                return content != null ? content.trim() : "";
            }
            return "";
        } catch (Exception e) {
            log.warn("Ollama request failed (is Ollama running at {}?): {}", baseUrl, e.getMessage());
            return "";
        }
    }

    /**
     * Check if the Ollama API is reachable (e.g. GET /api/tags or simple request).
     */
    public boolean isAvailable() {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(baseUrl + "/api/tags"))
                    .timeout(Duration.ofSeconds(5))
                    .GET()
                    .build();
            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            return response.statusCode() == 200;
        } catch (Exception e) {
            log.debug("Ollama availability check failed: {}", e.getMessage());
            return false;
        }
    }

    public String getBaseUrl() { return baseUrl; }
    public String getModel() { return model; }
}
