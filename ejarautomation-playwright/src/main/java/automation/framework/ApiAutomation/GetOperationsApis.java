package automation.framework.ApiAutomation;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class GetOperationsApis {
    private static final String GET_BRANCHES =
            "api/services/app/Branch/GetAllBranches?branchTypeId=8900&allActive=false";

    public static String getBranchId(String branchName) {

        // Execute GET API
        ApiClient.get(GET_BRANCHES);

        // Assert HTTP status
        if (ApiClient.lastStatus() != 200) {
            throw new AssertionError(
                    "GET Branches failed. Status: "
                            + ApiClient.lastStatus()
                            + ", Response: " + ApiClient.lastBody()
            );
        }

        // Parse JSON response
        JsonObject response = JsonParser.parseString(
                ApiClient.lastBody()).getAsJsonObject();

        // Assert API success
        if (!response.get("success").getAsBoolean()) {
            throw new AssertionError(
                    "GET Branches returned success=false: "
                            + ApiClient.lastBody()
            );
        }

        // Get result.items array
        JsonArray branches = response
                .getAsJsonObject("result")
                .getAsJsonArray("items");

        // Find branch by name
        for (var element : branches) {

            JsonObject branch = element.getAsJsonObject();

            if (branch.get("name").getAsString()
                    .trim().equalsIgnoreCase(branchName.trim())) {



                return branch.get("id").getAsString();
            }
        }

        throw new AssertionError(
                "Branch not found: " + branchName
        );
    }
}
