package automation.framework.ApiAutomation;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class GetOperationsApis {

    private final ApiClient apiClient;
    private final AuthenticationOperationsApi authenticationApi;

    public GetOperationsApis(ApiClient apiClient) {
        this.apiClient = apiClient;
        this.authenticationApi = new AuthenticationOperationsApi(apiClient);
    }

    public String getBranchId(String branchName) {
        authenticationApi.ensureLoggedIn();

        apiClient.get(ApiUris.GET_ALL_BRANCHES_URI);

        if (apiClient.lastStatus() != 200) {
            throw new AssertionError("GET Branches failed. Status: " + apiClient.lastStatus()
                    + ", Response: " + apiClient.lastBody());
        }

        JsonObject response = JsonParser.parseString(apiClient.lastBody()).getAsJsonObject();

        // Assert API success
        if (!response.get("success").getAsBoolean()) {
            throw new AssertionError("GET Branches returned success=false: " + apiClient.lastBody());
        }

        JsonArray branches = response.getAsJsonObject("result").getAsJsonArray("items");

        // Find branch by name
        for (JsonElement element : branches) {
            JsonObject branch = element.getAsJsonObject();

            if (branch.get("name").getAsString().trim().equalsIgnoreCase(branchName.trim())) {
                return branch.get("id").getAsString();
            }
        }

        throw new AssertionError("Branch not found: " + branchName);
    }
}