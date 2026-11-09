
package automation.framework.ApiAutomation;

import automation.framework.propmanager.PropManager;
import com.google.gson.Gson;
import com.microsoft.playwright.APIRequest;
import com.microsoft.playwright.APIRequestContext;
import com.microsoft.playwright.APIResponse;
import com.microsoft.playwright.Playwright;
import com.microsoft.playwright.options.RequestOptions;

import java.util.HashMap;
import java.util.Map;

/**
 * The API engine. Written once, used by every API class.
 * State is kept per thread, so each scenario has its own session,
 * headers and stored values.
 */
public class ApiClient {

    // ASSUMED standard ABP login endpoint.
    // Check it against your JMeter login request.
    private static final String LOGIN_ENDPOINT =
            "api/TokenAuth/Authenticate";

    private static final Gson GSON = new Gson();

    private static final ThreadLocal<Playwright> playwright =
            new ThreadLocal<>();

    private static final ThreadLocal<APIRequestContext> session =
            new ThreadLocal<>();

    private static final ThreadLocal<Map<String, String>> headers =
            new ThreadLocal<>();

    private static final ThreadLocal<Map<String, Object>> stored =
            new ThreadLocal<>();

    private static final ThreadLocal<String> lastBody =
            new ThreadLocal<>();

    private static final ThreadLocal<Integer> lastStatus =
            new ThreadLocal<>();

    // ---------- login records ----------

    public record AuthRequest(
            String userNameOrEmailAddress,
            String password,
            boolean rememberClient) {
    }

    public record AuthResult(String accessToken) {
    }

    public record AuthResponse(
            AuthResult result,
            boolean success) {
    }

    // ---------- session and headers ----------

    /** Creates the session and the default headers on first use */
    private static APIRequestContext session() {

        if (session.get() == null) {

            playwright.set(Playwright.create());

            session.set(playwright.get().request().newContext(
                    new APIRequest.NewContextOptions()
                            .setBaseURL(
                                    PropManager.getInstance()
                                            .getProperty("api.base.url")
                            )
                            .setIgnoreHTTPSErrors(
                                    Boolean.parseBoolean(
                                            PropManager.getInstance()
                                                    .getProperty("api.ignore.https.errors")
                                    )
                            )
            ));

            headers.set(new HashMap<String, String>());

            headers.get().put("Accept", "application/json");
            headers.get().put("Accept-Language", "en");
            headers.get().put("X-Requested-With", "XMLHttpRequest");

            headers.get().put(
                    "Abp.TenantId",
                    PropManager.getInstance()
                            .getProperty("api.tenant.id")
            );
        }

        return session.get();
    }

    /** Add or replace a header for the rest of the scenario */
    public static void header(String name, String value) {

        session();

        headers.get().put(name.trim(), value.trim());
    }

    /**
     * Logs in once per scenario.
     * Every GET/POST/PUT/DELETE calls it,
     * so nobody has to.
     */
    private static void ensureLoggedIn() {

        session();

        if (headers.get().containsKey("Authorization")) {
            return;
        }

        send("POST", LOGIN_ENDPOINT, new AuthRequest(
                PropManager.getInstance()
                        .getProperty("api.admin.username"),
                PropManager.getInstance()
                        .getProperty("api.admin.password"),
                false
        ));

        System.out.println("API login status: " + lastStatus.get());

        AuthResponse parsed = readBody(AuthResponse.class);

        if (parsed == null
                || parsed.result() == null
                || parsed.result().accessToken() == null) {

            throw new IllegalStateException(
                    "API login failed. Status: " + lastStatus.get()
                            + ", body: " + lastBody.get()
            );
        }

        headers.get().put(
                "Authorization",
                "Bearer " + parsed.result().accessToken()
        );
    }

    // ---------- requests ----------

    public static APIResponse get(String endpoint) {

        ensureLoggedIn();

        return send("GET", endpoint, null);
    }

    /** body can be a record, any object or a ready JSON String */
    public static APIResponse post(String endpoint, Object body) {

        ensureLoggedIn();

        return send("POST", endpoint, body);
    }

    public static APIResponse put(String endpoint, Object body) {

        ensureLoggedIn();

        return send("PUT", endpoint, body);
    }

    public static APIResponse delete(String endpoint) {

        ensureLoggedIn();

        return send("DELETE", endpoint, null);
    }

    private static APIResponse send(
            String method,
            String endpoint,
            Object body) {

        session();

        RequestOptions options = RequestOptions.create();

        for (Map.Entry<String, String> h : headers.get().entrySet()) {
            options.setHeader(h.getKey(), h.getValue());
        }

        if (body != null) {

            options.setHeader("Content-Type", "application/json");

            options.setData(
                    body instanceof String
                            ? (String) body
                            : GSON.toJson(body)
            );
        }

        APIResponse response;

        switch (method) {

            case "GET":
                response = session().get(endpoint, options);
                break;

            case "POST":
                response = session().post(endpoint, options);
                break;

            case "PUT":
                response = session().put(endpoint, options);
                break;

            case "DELETE":
                response = session().delete(endpoint, options);
                break;

            default:
                throw new IllegalArgumentException(
                        "Unsupported method: " + method
                );
        }

        // Store the last API response
        lastStatus.set(response.status());
        lastBody.set(response.text());

        return response;
    }

    // ---------- last response ----------

    public static String lastBody() {
        return lastBody.get();
    }

    public static int lastStatus() {
        return lastStatus.get();
    }

    public static <T> T readBody(Class<T> type) {
        return GSON.fromJson(lastBody.get(), type);
    }

    // ---------- values shared between steps ----------

    public static void store(String key, Object value) {

        if (stored.get() == null) {
            stored.set(new HashMap<String, Object>());
        }

        stored.get().put(key, value);
    }

    public static <T> T stored(String key, Class<T> type) {

        if (stored.get() == null
                || !stored.get().containsKey(key)) {

            throw new IllegalStateException(
                    "Nothing was stored under the key: " + key
            );
        }

        return type.cast(stored.get().get(key));
    }

    // ---------- cleanup ----------

    public static void close() {

        if (session.get() != null) {
            session.get().dispose();
            session.remove();
        }

        if (playwright.get() != null) {
            playwright.get().close();
            playwright.remove();
        }

        headers.remove();
        stored.remove();
        lastBody.remove();
        lastStatus.remove();
    }
}
