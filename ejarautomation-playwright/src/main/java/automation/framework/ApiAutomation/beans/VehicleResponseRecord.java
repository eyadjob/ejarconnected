
package automation.framework.ApiAutomation.beans;

import com.google.gson.JsonElement;

public record VehicleResponseRecord(
        JsonElement result,
        boolean success,
        JsonElement error,
        boolean unAuthorizedRequest) {

    public record Vehicle(
            String plateNo,
            String chassisNo,
            String branchId,
            String modelId,
            int year,
            String rawResponse) {
    }
}
