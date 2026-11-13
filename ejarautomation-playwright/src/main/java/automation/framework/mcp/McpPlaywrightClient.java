package automation.framework.mcp;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * Minimal Model Context Protocol (MCP) client that drives the Playwright MCP server over stdio.
 *
 * <p>Unlike {@link automation.framework.threadData.DriverFactory}, which controls the browser through
 * the Playwright Java library, this class starts {@code npx @playwright/mcp} as a child process and
 * exchanges JSON-RPC 2.0 messages with it, so a test can exercise the same browser tools an AI agent
 * would use.</p>
 *
 * <p>Configured through system properties (all optional):</p>
 * <ul>
 *   <li>{@code mcp.playwright.package} - npm package to run (default {@code @playwright/mcp@latest})</li>
 *   <li>{@code mcp.playwright.browser} - browser channel (default {@code chrome}; use {@code chromium},
 *       {@code msedge}, {@code firefox} or {@code webkit} as needed)</li>
 *   <li>{@code mcp.playwright.headless} - {@code true} to run without a visible window (default {@code false})</li>
 *   <li>{@code mcp.playwright.outputDir} - where the server writes snapshots/screenshots</li>
 * </ul>
 *
 * <p>Instances are not thread-safe; create one per scenario.</p>
 */
public class McpPlaywrightClient implements AutoCloseable {

    /** MCP protocol revision this client speaks. */
    private static final String PROTOCOL_VERSION = "2025-06-18";
    private static final long DEFAULT_TIMEOUT_MS = 180_000L;
    private static final String RESULT_MARKER = "### Result";

    private final List<String> command;
    private final long timeoutMs;
    private final com.google.gson.Gson gson = new com.google.gson.Gson();

    private Process process;
    private BufferedWriter stdin;
    private BufferedReader stdout;
    private int nextId = 1;
    private boolean started;

    public McpPlaywrightClient() {
        this(buildDefaultCommand(), DEFAULT_TIMEOUT_MS);
    }

    public McpPlaywrightClient(List<String> command, long timeoutMs) {
        this.command = new ArrayList<>(command);
        this.timeoutMs = timeoutMs;
    }

    /** Starts the server process and performs the MCP initialize handshake. */
    public synchronized void start() throws IOException {
        if (started) {
            return;
        }
        ProcessBuilder builder = new ProcessBuilder(command);
        // The server logs to stderr; keeping it inherited surfaces start-up problems in the test log.
        builder.redirectError(ProcessBuilder.Redirect.INHERIT);
        process = builder.start();
        stdin = new BufferedWriter(new OutputStreamWriter(process.getOutputStream(), StandardCharsets.UTF_8));
        stdout = new BufferedReader(new InputStreamReader(process.getInputStream(), StandardCharsets.UTF_8));

        JsonObject params = new JsonObject();
        params.addProperty("protocolVersion", PROTOCOL_VERSION);
        params.add("capabilities", new JsonObject());
        JsonObject clientInfo = new JsonObject();
        clientInfo.addProperty("name", "ejarautomation-cucumber");
        clientInfo.addProperty("version", "1.0");
        params.add("clientInfo", clientInfo);

        JsonObject init = call("initialize", params);
        String serverName = init.has("serverInfo") && init.getAsJsonObject("serverInfo").has("name")
                ? init.getAsJsonObject("serverInfo").get("name").getAsString() : "unknown";
        String serverVersion = init.has("serverInfo") && init.getAsJsonObject("serverInfo").has("version")
                ? init.getAsJsonObject("serverInfo").get("version").getAsString() : "unknown";
        System.out.println("MCP server '" + serverName + "' " + serverVersion + " initialized (protocol "
                + (init.has("protocolVersion") ? init.get("protocolVersion").getAsString() : PROTOCOL_VERSION) + ")");

        notify("notifications/initialized");
        started = true;
    }

    /** Calls a tool and returns the text of its first content item. */
    public String callTool(String toolName, JsonObject arguments) throws IOException {
        JsonObject params = new JsonObject();
        params.addProperty("name", toolName);
        params.add("arguments", arguments == null ? new JsonObject() : arguments);
        JsonObject result = call("tools/call", params);

        JsonObject content = firstContent(result);
        String text = content != null && content.has("text") ? content.get("text").getAsString() : "";
        boolean isError = result.has("isError") && result.get("isError").getAsBoolean();
        if (isError) {
            throw new IllegalStateException("MCP tool '" + toolName + "' failed: " + text);
        }
        return text;
    }

    /** Opens {@code url} in the MCP browser. */
    public String navigate(String url) throws IOException {
        JsonObject args = new JsonObject();
        args.addProperty("url", url);
        return callTool("browser_navigate", args);
    }

    /** Waits until {@code text} appears on the page (server-side action timeout otherwise). */
    public String waitForText(String text, int timeoutSeconds) throws IOException {
        JsonObject args = new JsonObject();
        args.addProperty("text", text);
        args.addProperty("time", timeoutSeconds);
        return callTool("browser_wait_for", args);
    }

    /**
     * Runs an arrow function in the page and parses the JSON it returns.
     *
     * @param function JavaScript such as {@code () => ({ title: document.title })}
     */
    public JsonObject evaluateJson(String function) throws IOException {
        JsonObject args = new JsonObject();
        args.addProperty("function", function);
        String text = callTool("browser_evaluate", args);
        String json = extractResultBlock(text);
        JsonElement parsed = JsonParser.parseString(json);
        if (!parsed.isJsonObject()) {
            throw new IllegalStateException("browser_evaluate did not return a JSON object: " + json);
        }
        return parsed.getAsJsonObject();
    }

    /** Runs an arrow function in the page and returns its raw text result. */
    public String evaluateText(String function) throws IOException {
        JsonObject args = new JsonObject();
        args.addProperty("function", function);
        return extractResultBlock(callTool("browser_evaluate", args));
    }

    /** Saves a screenshot; {@code fileName} is resolved against the server's output directory. */
    public String screenshot(String fileName) throws IOException {
        JsonObject args = new JsonObject();
        args.addProperty("filename", fileName);
        args.addProperty("type", "png");
        args.addProperty("scale", "css");
        return callTool("browser_take_screenshot", args);
    }

    /**
     * Reads the accessibility snapshot of the current page as text.
     *
     * <p>For large pages the MCP server answers with a file reference
     * ({@code - [Snapshot](test output/playwright-mcp/page-….yml)}) instead of inline YAML. That reference is
     * useless to a caller that needs the {@code [ref=eN]} tokens, so the file is read and inlined here.</p>
     */
    public String snapshot() throws IOException {
        String text = callTool("browser_snapshot", new JsonObject());
        return inlineSnapshotReference(text);
    }

    /** Replaces a {@code [Snapshot](path)} link with the content of that YAML file. */
    private static String inlineSnapshotReference(String text) {
        if (text == null) {
            return "";
        }
        java.util.regex.Matcher matcher =
                java.util.regex.Pattern.compile("\\[Snapshot\\]\\(([^)]+)\\)").matcher(text);
        if (!matcher.find()) {
            return text;
        }
        java.nio.file.Path file = java.nio.file.Paths.get(matcher.group(1).trim().replace('\\', java.io.File.separatorChar));
        if (!file.isAbsolute()) {
            file = java.nio.file.Paths.get(System.getProperty("user.dir")).resolve(file);
        }
        for (int attempt = 0; attempt < 20; attempt++) {
            try {
                if (java.nio.file.Files.isRegularFile(file)) {
                    String yaml = java.nio.file.Files.readString(file);
                    if (!yaml.isBlank()) {
                        System.out.println("MCP snapshot inlined from file: " + file.getFileName());
                        return text.substring(0, matcher.start())
                                + "\n```yaml\n" + yaml + "\n```\n"
                                + text.substring(matcher.end());
                    }
                }
                Thread.sleep(150);
            } catch (InterruptedException interrupted) {
                Thread.currentThread().interrupt();
                break;
            } catch (Exception unreadable) {
                break;
            }
        }
        return text;
    }

    @Override
    public synchronized void close() {
        if (!started) {
            destroyProcess();
            return;
        }
        try {
            callTool("browser_close", new JsonObject());
        } catch (Exception e) {
            System.err.println("MCP browser_close failed (ignored): " + e.getMessage());
        }
        destroyProcess();
        started = false;
    }

    private void destroyProcess() {
        if (process == null) {
            return;
        }
        try {
            stdin.close();
        } catch (Exception ignored) {
            // already gone
        }
        process.destroy();
        try {
            if (!process.waitFor(10, TimeUnit.SECONDS)) {
                process.destroyForcibly();
            }
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            process.destroyForcibly();
        }
        process = null;
    }

    private static List<String> buildDefaultCommand() {
        boolean windows = System.getProperty("os.name", "").toLowerCase().contains("win");
        List<String> cmd = new ArrayList<>();
        if (windows) {
            // npx is a .cmd shim on Windows, so it has to run through the shell.
            cmd.addAll(Arrays.asList("cmd.exe", "/c"));
        }
        cmd.add("npx");
        cmd.add("-y");
        cmd.add(System.getProperty("mcp.playwright.package", "@playwright/mcp@latest"));
        cmd.add("--browser");
        cmd.add(System.getProperty("mcp.playwright.browser", "chrome"));
        // The QA environments use self-signed certificates.
        cmd.add("--ignore-https-errors");
        cmd.add("--output-dir");
        cmd.add(System.getProperty("mcp.playwright.outputDir", "test output/playwright-mcp"));
        // Optional viewport, e.g. a maximised window or the size the mockups were captured at.
        String viewport = System.getProperty("mcp.playwright.viewport", "");
        if (!viewport.isBlank()) {
            cmd.add("--viewport-size");
            cmd.add(viewport.trim());
        }
        // In-memory profile: a previous run must not leave the browser logged in / carrying stale state.
        // Set -Dmcp.playwright.isolated=false to reuse the on-disk profile while debugging.
        if (!"false".equalsIgnoreCase(System.getProperty("mcp.playwright.isolated", "true"))) {
            cmd.add("--isolated");
        }
        if ("true".equalsIgnoreCase(System.getProperty("mcp.playwright.headless", "false"))) {
            cmd.add("--headless");
        }
        return cmd;
    }

    private JsonObject call(String method, JsonObject params) throws IOException {
        int id = nextId++;
        JsonObject message = new JsonObject();
        message.addProperty("jsonrpc", "2.0");
        message.addProperty("id", id);
        message.addProperty("method", method);
        message.add("params", params);
        send(message);
        return awaitResponse(id);
    }

    private void notify(String method) throws IOException {
        JsonObject message = new JsonObject();
        message.addProperty("jsonrpc", "2.0");
        message.addProperty("method", method);
        message.add("params", new JsonObject());
        send(message);
    }

    private void send(JsonObject message) throws IOException {
        stdin.write(gson.toJson(message));
        stdin.write("\n");
        stdin.flush();
    }

    private JsonObject awaitResponse(int id) throws IOException {
        long deadline = System.currentTimeMillis() + timeoutMs;
        while (System.currentTimeMillis() < deadline) {
            String line = stdout.readLine();
            if (line == null) {
                throw new IOException("MCP server closed its output before answering request " + id);
            }
            line = line.trim();
            if (line.isEmpty() || !line.startsWith("{")) {
                continue;
            }
            JsonObject message;
            try {
                message = JsonParser.parseString(line).getAsJsonObject();
            } catch (RuntimeException notJsonRpc) {
                continue;
            }
            if (!message.has("id") || message.get("id").isJsonNull()
                    || !message.get("id").isJsonPrimitive()) {
                continue; // notification or server-initiated request
            }
            if (message.get("id").getAsInt() != id) {
                continue;
            }
            if (message.has("error")) {
                throw new IOException("MCP request '" + id + "' failed: " + message.get("error"));
            }
            return message.getAsJsonObject("result");
        }
        throw new IOException("Timed out after " + timeoutMs + " ms waiting for MCP response " + id);
    }

    private static JsonObject firstContent(JsonObject result) {
        if (result == null || !result.has("content")) {
            return null;
        }
        JsonArray content = result.getAsJsonArray("content");
        if (content.size() == 0) {
            return null;
        }
        JsonElement first = content.get(0);
        return first.isJsonObject() ? first.getAsJsonObject() : null;
    }

    /** Strips the Markdown wrapper the server adds around a tool's result. */
    private static String extractResultBlock(String text) {
        if (text == null) {
            return "";
        }
        int start = text.indexOf(RESULT_MARKER);
        if (start < 0) {
            return text.trim();
        }
        start += RESULT_MARKER.length();
        int end = text.indexOf("###", start);
        String block = end > start ? text.substring(start, end) : text.substring(start);
        return block.trim();
    }
}
