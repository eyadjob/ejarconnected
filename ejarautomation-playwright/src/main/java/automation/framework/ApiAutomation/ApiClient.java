package automation.framework.ApiAutomation;

import automation.framework.propmanager.PropManager;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.microsoft.playwright.APIRequest;
import com.microsoft.playwright.APIRequestContext;
import com.microsoft.playwright.APIResponse;
import com.microsoft.playwright.Playwright;
import com.microsoft.playwright.options.RequestOptions;

import java.util.HashMap;
import java.util.Map;

/**
 * The API engine. One instance per scenario, so the session, headers,
 * last response and stored values belong to that scenario only.
 */
public class ApiClient {

    private final Gson gson = new Gson();
    private final ApiHeaders headers = new ApiHeaders();
    private final Map<String, Object> stored = new HashMap<String, Object>();

    private Playwright playwright;
    private APIRequestContext session;
    private String lastBody;
    private int lastStatus;

    // ---------- headers ----------
    public ApiHeaders getHeaders() {
        return headers;
    }

    // ---------- session ----------
    /** Creates the session and the default headers on first use */
    public APIRequestContext getSession() {
        if (session == null) {

            String baseUrl = PropManager.getInstance()
                    .getProperty("api.base.url");

            if (baseUrl == null || baseUrl.isBlank()) {
                throw new IllegalStateException(
                        "api.base.url is missing or empty");
            }

            baseUrl = baseUrl.trim();

            System.out.println("API Base URL: [" + baseUrl + "]");

            playwright = Playwright.create();

            session = playwright.request().newContext(
                    new APIRequest.NewContextOptions()
                            .setBaseURL(baseUrl)
                            .setIgnoreHTTPSErrors(Boolean.parseBoolean(
                                    PropManager.getInstance()
                                            .getProperty("api.ignore.https.errors")))
            );

            headers.setDefaults();
        }

        return session;
    }

    // ---------- requests ----------
    public APIResponse get(String uri) {
        return send("GET", uri, null);
    }

    /** body can be a record, any object or a ready JSON String */
    public APIResponse post(String uri, Object body) {
        return send("POST", uri, body);
    }

    public APIResponse put(String uri, Object body) {
        return send("PUT", uri, body);
    }

    public APIResponse delete(String uri) {
        return send("DELETE", uri, null);
    }

    public APIResponse send(String method, String uri, Object body) {
        APIRequestContext requestSession = getSession();

        RequestOptions options = RequestOptions.create();
        for (Map.Entry<String, String> h : headers.getAll().entrySet()) {
            options.setHeader(h.getKey(), h.getValue());
        }

        if (body != null) {
            options.setHeader(ApiHeaders.CONTENT_TYPE, ApiHeaders.JSON);
            options.setData(body instanceof String ? (String) body : gson.toJson(body));
        }

        APIResponse response;
        switch (method) {
            case "GET":
                response = requestSession.get(uri, options);
                break;
            case "POST":
                response = requestSession.post(uri, options);
                break;
            case "PUT":
                response = requestSession.put(uri, options);
                break;
            case "DELETE":
                response = requestSession.delete(uri, options);
                break;
            default:
                throw new IllegalArgumentException("Unsupported method: " + method);
        }

        // the body can be read only once, so keep it here for everyone to use
        lastStatus = response.status();
        lastBody = response.text();
        return response;
    }

    // ---------- last response ----------
    public String lastBody() {
        return lastBody;
    }

    public int lastStatus() {
        return lastStatus;
    }

    public <T> T readBody(Class<T> type) {
        return gson.fromJson(lastBody, type);
    }

    // ---------- values shared between steps ----------
    public void store(String key, Object value) {
        stored.put(key, value);
    }

    public <T> T stored(String key, Class<T> type) {
        if (!stored.containsKey(key)) {
            throw new IllegalStateException("Nothing was stored under the key: " + key);
        }
        return type.cast(stored.get(key));
    }

    public void assertStatusCode(int expectedStatus,String uri) {
        int actualStatus = lastStatus();
        String apiName = uri.split("\\?")[0].replaceAll(".*/", "");

        if (actualStatus != expectedStatus) {
            throw new AssertionError(
                    "\nAPI request failed\n"
                            +apiName
                            + " Expected status: " + expectedStatus
                            + ", Actual status: " + actualStatus
                            + ", \nResponse: " + lastBody()
            );
        }
    }

    public void assertApiSuccess() {
        if (!new Gson().fromJson(lastBody(), JsonObject.class)
                .get("success").getAsBoolean()) {
            throw new AssertionError("API failed! Response: " + lastBody());
        }

        System.out.println("API succeeded. Status: " + lastStatus());
    }

    // ---------- cleanup ----------
    public void close() {
        if (session != null) {
            session.dispose();
            session = null;
        }
        if (playwright != null) {
            playwright.close();
            playwright = null;
        }
        headers.clear();
        stored.clear();
        lastBody = null;
        lastStatus = 0;
    }
}