
package automation.framework.ApiAutomation.beans;

import com.google.gson.JsonElement;

public record DefaultsResponseRecord(
        JsonElement result,
        boolean success,
        JsonElement error,
        boolean unAuthorizedRequest) {

}
