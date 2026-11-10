package automation.framework.ApiAutomation;

import automation.framework.ApiAutomation.beans.AuthenticationRecords.AuthenticationRequest;
import automation.framework.ApiAutomation.beans.AuthenticationRecords.AuthenticationResponse;
import automation.framework.propmanager.PropManager;

public class AuthenticationOperationsApi {

    private final ApiClient apiClient;

    public AuthenticationOperationsApi(ApiClient apiClient) {
        this.apiClient = apiClient;
    }

    public boolean isLoggedIn() {
        return apiClient.getHeaders().has(ApiHeaders.AUTHORIZATION);
    }

    /** Logs in only if this scenario hasn't logged in yet */
    public void ensureLoggedIn() {
        if (!isLoggedIn()) {
            login();
        }
    }

    public void login() {
        AuthenticationRequest request = new AuthenticationRequest(
                PropManager.getInstance().getProperty("api.admin.username"),
                PropManager.getInstance().getProperty("api.admin.password"),
                false);

        apiClient.post(ApiUris.AUTHENTICATE_URI, request);
        System.out.println("API login status: " + apiClient.lastStatus());

        AuthenticationResponse response = apiClient.readBody(AuthenticationResponse.class);
        if (response == null || response.result() == null || response.result().accessToken() == null) {
            throw new IllegalStateException("API login failed. Status: " + apiClient.lastStatus()
                    + ", body: " + apiClient.lastBody());
        }

        apiClient.getHeaders().setBearerToken(response.result().accessToken());
    }
}