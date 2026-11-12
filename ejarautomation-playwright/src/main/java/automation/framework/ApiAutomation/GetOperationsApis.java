
package automation.framework.ApiAutomation;

import automation.framework.ApiAutomation.beans.ComboboxResponseRecord;
import automation.framework.ApiAutomation.beans.DefaultsResponseRecord;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import lombok.Builder;

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

        apiClient.assertStatusCode(200, ApiUris.GET_ALL_BRANCHES_URI);
        apiClient.assertApiSuccess(ApiUris.GET_ALL_BRANCHES_URI);

        ComboboxResponseRecord comboboxResponseRecord = apiClient.readBody(ComboboxResponseRecord.class);


        for (ComboboxResponseRecord.result.Item item: comboboxResponseRecord.result().items()) {
            if ( item.displayText().equals(branchName.trim())){
                return String.valueOf(item.value());
            }
        }

        throw new AssertionError("Branch not found: " + branchName);
    }
}