package stepdefs.ejar.web;

import automation.framework.Element;
import automation.framework.propmanager.PropManager;
import automation.framework.threadData.DriverFactory;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.junit.Assert;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import stepdefs.generic.GenericStepDefs;

/**
 * Step definitions for Ejar login scenario assisted by local AI (Ollama, e.g. qwen3-coder:30b at localhost:11434).
 */
public class AiStepDefs {

    private static final Logger log = LoggerFactory.getLogger(AiStepDefs.class);
    private final GenericStepDefs genericStepDefs = new GenericStepDefs();
    private static final String OLLAMA_DEFAULT_URL = "http://localhost:11434";
    private static final String OLLAMA_DEFAULT_MODEL = "qwen3-coder:30b";
    ThreadLocal<String> aiBaseUrl = new ThreadLocal<>();
    ThreadLocal<String> modelName = new ThreadLocal<>();;


    @Given("^AI server (.*) using model (.*)$")
    public void setAIServerAndModel(String ollamaBaseUrl, String model) {
         this.aiBaseUrl.set(ollamaBaseUrl != null && !ollamaBaseUrl.isBlank() ? ollamaBaseUrl.trim() : OLLAMA_DEFAULT_URL);
         this.modelName.set(model != null && !model.isBlank() ? model.trim() : OLLAMA_DEFAULT_MODEL);
    }


    @Given("^Ejar login page is opened for AI-assisted login$")
    public void openEjarLoginPageForAi() {
        PropManager.getInstance().getPropertiesValues().get("appProperties.properties").put("execution.project.name", "ejar web");
        String baseUrl = PropManager.getInstance().getProperty("ejar.environment.url");
        genericStepDefs.navigateToUrl(baseUrl);
        genericStepDefs.waitForPageToLoad();
        Element.waitForLoadingIconToBeNotPresentStatic();
    }

    @And("^AI get page inner text and respond with yes or no based on the following prompt: (.*)$")
    public void aiRespondToPrompt(String prompt) {
        String pageText = getPageInnerText();
        automation.framework.business.OllamaClient client = new automation.framework.business.OllamaClient(aiBaseUrl.get(), modelName.get());
        String response = client.chat(prompt  + ". Reply with exactly YES or NO only, nothing else.\n\n" + pageText);
        System.out.println("AI get page inner text and respond with yes or no based on the following prompt:" + prompt + " AI response was: " + response);
        Assert.assertEquals("AI at " + aiBaseUrl + " didn't confirm yes based on prompt. Response: " + response, "yes", response.toLowerCase());
    }

    @And("^AI get page html and respond with yes or no based on the following prompt: (.*)$")
    public void aiGetPageHtmlAndRespondToPrompt(String prompt) {
        String pageHtml = getPageHtml();
        automation.framework.business.OllamaClient client = new automation.framework.business.OllamaClient(aiBaseUrl.get(), modelName.get());
        String response = client.chat(prompt  + ". Reply with exactly YES or NO only, nothing else."+"\n\npage HTML is:" + pageHtml);
        System.out.println("AI get page html and respond with yes or no based on the following prompt:" + prompt + " AI response was: " + response);
        Assert.assertEquals("AI at " + aiBaseUrl + " didn't confirm yes based on prompt. Response: " + response, "yes", response.toLowerCase());
    }

    public String getPageHtml() {
        String pageHtml="";
        int globalWaitTime = Integer.parseInt( PropManager.getInstance().getProperty("driver.element.wait"));
        while ( pageHtml.isBlank() || pageHtml.isEmpty() && globalWaitTime != 0 ) {
            try {
                pageHtml = (String) DriverFactory.getDriver().evaluate(
                        "() => document.body ? document.body.outerHTML : ''");
            } catch (Exception e) {
                log.warn("Could not get page text for AI: {}", e.getMessage());
                pageHtml = "";
            }
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            globalWaitTime--;
        }
        return pageHtml;
    }

    public String getPageInnerText() {
        String pageText="";
        int globalWaitTime = Integer.parseInt( PropManager.getInstance().getProperty("driver.element.wait"));
        while ( pageText.isBlank() || pageText.isEmpty() && globalWaitTime != 0 ) {
            try {
                pageText = (String) DriverFactory.getDriver().evaluate(
                        "() => document.body ? document.body.innerText : ''");
            } catch (Exception e) {
                log.warn("Could not get page text for AI: {}", e.getMessage());
                pageText = "";
            }
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            globalWaitTime--;
        }
        return pageText;
    }

    @When("^user logs in to Ejar with tenant: (.*) and user name: (.*) and password: (.*)$")
    public void userLogsInToEjarWithTenantAndCredentials(String tenant, String username, String password) {
        genericStepDefs.LoginWithTenantNameUsernameAndPassword(tenant.trim(), username.trim(), password.trim(), "/app/main/dashboard");
    }

    @Then("^Ejar dashboard is displayed$")
    public void ejarDashboardIsDisplayed() {
        genericStepDefs.waitForElementToBeVisible("ejar.dashboard.menu.title.byxpath", 60);
        genericStepDefs.verifyPageIsDisplayed("/app/main/dashboard");
    }
}
