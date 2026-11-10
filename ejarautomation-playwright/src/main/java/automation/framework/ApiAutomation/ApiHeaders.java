package automation.framework.ApiAutomation;

import automation.framework.propmanager.PropManager;

import java.util.HashMap;
import java.util.Map;

public class ApiHeaders {

    // ---------- header names ----------
    public static final String ACCEPT = "Accept";
    public static final String ACCEPT_LANGUAGE = "Accept-Language";
    public static final String X_REQUESTED_WITH = "X-Requested-With";
    public static final String TENANT_ID = "Abp.TenantId";
    public static final String AUTHORIZATION = "Authorization";
    public static final String CONTENT_TYPE = "Content-Type";

    // ---------- header values ----------
    public static final String JSON = "application/json";
    public static final String XML_HTTP_REQUEST = "XMLHttpRequest";
    public static final String BEARER_PREFIX = "Bearer ";

    private final Map<String, String> headers = new HashMap<String, String>();

    /** The headers JMeter sends, except the ones Playwright adds by itself. Never overrides a header already set. */
    public void setDefaults() {
        headers.putIfAbsent(ACCEPT, JSON);
        headers.putIfAbsent(ACCEPT_LANGUAGE, "en");
        headers.putIfAbsent(X_REQUESTED_WITH, XML_HTTP_REQUEST);
        headers.putIfAbsent(TENANT_ID, PropManager.getInstance().getProperty("api.tenant.id"));
    }

    public void set(String name, String value) {
        headers.put(name.trim(), value.trim());
    }

    public void remove(String name) {
        headers.remove(name.trim());
    }

    public boolean has(String name) {
        return headers.containsKey(name.trim());
    }

    public void setBearerToken(String token) {
        set(AUTHORIZATION, BEARER_PREFIX + token.trim());
    }

    /** A copy, so callers can't change the headers by accident */
    public Map<String, String> getAll() {
        return new HashMap<String, String>(headers);
    }

    public void clear() {
        headers.clear();
    }
}