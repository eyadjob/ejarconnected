package automation.framework.ApiAutomation;

import io.cucumber.java.After;

public class ApiStepDefs {



    @After("@API")
    public void closeApiSession() {
        ApiClient.close();
    }
}
