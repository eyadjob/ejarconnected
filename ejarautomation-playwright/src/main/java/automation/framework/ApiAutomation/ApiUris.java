package automation.framework.ApiAutomation;

import automation.framework.propmanager.PropManager;

public class ApiUris {

    public static final String AUTHENTICATE_URI =
            "api/TokenAuth/Authenticate";

    public static final String CREATE_VEHICLES_URI =
            "api/services/app/Vehicle/CreateVehicles";

    public static final String GET_ALL_BRANCHES_URI =
            "api/services/app/Branch/GetBranchesComboboxItems?countryId="+ PropManager.getInstance().getProperty("api.country.id");
}