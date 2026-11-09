package automation.framework.ApiAutomation;

import automation.framework.propmanager.PropManager;

public class AuthenticationOperationsApis {


    ApiClient apiClient = new ApiClient();


    requestAuthorication() {
    }

    ApiClient.send("POST",LOGIN_ENDPOINT, new ApiClient.AuthRequest(
            PropManager.getInstance()
                        .getProperty("api.admin.username"),
                PropManager.getInstance()
                        .getProperty("api.admin.password"),
                false
                        ));

}

}
