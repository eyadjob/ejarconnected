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
        String response = client.chat(prompt  + ". <body class=\"account header-fixed header-mobile-fixed subheader-fixed subheader-enabled subheader-solid aside-enabled aside-fixed page-loading \" data-kt-app-layout=\"light-sidebar\" data-kt-app-header-fixed=\"true\" data-kt-app-header-fixed-mobile=\"false\" data-kt-app-sidebar-enabled=\"true\" data-kt-app-sidebar-fixed=\"true\" data-kt-app-sidebar-hoverable=\"true\" data-kt-app-sidebar-push-header=\"true\" data-kt-app-toolbar-enabled=\"true\" data-kt-app-sidebar-push-toolbar=\"true\" data-kt-app-sidebar-push-footer=\"true\" data-kt-app-sidebar-minimize=\"off\" data-kt-app-toolbar-fixed=\"false\" data-kt-app-toolbar-fixed-mobile=\"false\" style=\"\">\n" +
                "    <app-root ng-version=\"15.2.9\">\n" +
                "        <router-outlet></router-outlet><ng-component class=\"ng-star-inserted\"><div class=\"login-wrapper row g-0 vh-100\">\n" +
                "    \n" +
                "    <div class=\"col-lg-7 col-md-7 login-left position-relative d-none d-md-block\">\n" +
                "        <div class=\"login-caption text-start text-white\">\n" +
                "            <h3><div><h2><font face=\"Verdana\">\uD83C\uDF1F</font><br></h2><h2><font face=\"Verdana\">A successful&nbsp;experience&nbsp;is based on correct information.&nbsp; Update your information about our services</font><br></h2></div><div><font color=\"#ffcd00\"><sub><font size=\"4\">&nbsp;Customer Service Team</font>&nbsp;</sub></font></div></h3>\n" +
                "        </div>\n" +
                "    </div>\n" +
                "\n" +
                "    \n" +
                "    <div class=\"col-lg-5 col-md-5 bg-white d-flex flex-column justify-content-center align-items-center position-relative\">\n" +
                "        \n" +
                "        <div class=\"brand-header w-50 d-flex justify-content-end pt-5\">\n" +
                "            <img alt=\"Rentey logo\" class=\"brand-image\" src=\"assets/common/images/Rentey-prod-logo.png\">\n" +
                "        </div>\n" +
                "        <div class=\"login-form-container d-flex flex-column flex-root w-100 px-4\" style=\"max-width: 500px;\">\n" +
                "            \n" +
                "            <a href=\"\" class=\"d-flex justify-content-center mb-8\">\n" +
                "                <img alt=\"logo\" class=\"h-40px ng-star-inserted\" src=\"https://ypp.qoad.com:2800/webapigw/TenantCustomization/GetTenantLogo?skin=light&amp;tenantId=1\"><!---->\n" +
                "            </a>\n" +
                "            \n" +
                "            <div class=\"tenant-container mb-4\">\n" +
                "                <!---->\n" +
                "                <router-outlet></router-outlet><ng-component _nghost-ghs-c358=\"\" class=\"ng-tns-c358-0 ng-star-inserted\"><div _ngcontent-ghs-c358=\"\" class=\"login-form ng-tns-c358-0 ng-trigger ng-trigger-routerTransition\" style=\"margin-top: 0px; opacity: 1;\">\n" +
                "<form _ngcontent-ghs-c358=\"\" novalidate=\"\" method=\"post\" class=\"login-form form ng-tns-c358-0 ng-untouched ng-pristine ng-invalid\">\n" +
                "    \n" +
                "    <div _ngcontent-ghs-c358=\"\" class=\"mb-4 ng-tns-c358-0\">\n" +
                "        <label _ngcontent-ghs-c358=\"\" class=\"form-label fw-semibold mb-2 ng-tns-c358-0\">\n" +
                "            User name or email\n" +
                "        </label>\n" +
                "        <input _ngcontent-ghs-c358=\"\" autofocus=\"\" type=\"text\" autocomplete=\"new-password\" name=\"userNameOrEmailAddress\" required=\"\" class=\"form-control ng-tns-c358-0 ng-untouched ng-pristine ng-invalid\">\n" +
                "      <validation-messages _ngcontent-ghs-c358=\"\" class=\"ng-tns-c358-0 ng-star-inserted\" style=\"\">\n" +
                "        <!---->\n" +
                "    </validation-messages><!---->\n" +
                "    </div>\n" +
                "\n" +
                "    \n" +
                "    <div _ngcontent-ghs-c358=\"\" class=\"mb-4 ng-tns-c358-0\">\n" +
                "        <label _ngcontent-ghs-c358=\"\" class=\"form-label fw-semibold mb-2 ng-tns-c358-0\">\n" +
                "            Password\n" +
                "        </label>\n" +
                "\n" +
                "    <div _ngcontent-ghs-c358=\"\" class=\"input-group position-relative ng-tns-c358-0\">\n" +
                "        <input _ngcontent-ghs-c358=\"\" autocomplete=\"new-password\" name=\"password\" required=\"\" maxlength=\"32\" class=\"form-control ng-tns-c358-0 ng-untouched ng-pristine ng-invalid\" type=\"password\">\n" +
                "    <button _ngcontent-ghs-c358=\"\" type=\"button\" tabindex=\"-1\" class=\"btn position-absolute end-0 top-0 h-100 border-0 bg-transparent px-3 ng-tns-c358-0\">\n" +
                "        <i _ngcontent-ghs-c358=\"\" class=\"fas ng-tns-c358-0 fa-eye\"></i>\n" +
                "    </button>\n" +
                "    </div>\n" +
                "    <!---->\n" +
                "    </div>\n" +
                "\n" +
                "\n" +
                "    \n" +
                "    <div _ngcontent-ghs-c358=\"\" class=\"mt-4 ng-tns-c358-0\">\n" +
                "<button _ngcontent-ghs-c358=\"\" type=\"submit\" class=\"btn w-100 btn-primary fw-bold fs-6 py-3 d-flex justify-content-center align-items-center ng-tns-c358-0\" disabled=\"\">\n" +
                "    \n" +
                "        Log in\n" +
                "    <!----><!---->\n" +
                "    \n" +
                "    <!---->\n" +
                "</button>\n" +
                "</div>\n" +
                "\n" +
                "</form>\n" +
                "<!---->\n" +
                "\n" +
                "</div>\n" +
                "</ng-component><!---->\n" +
                "            </div>\n" +
                "            \n" +
                "            <div class=\"language-section text-center mt-4\">\n" +
                "                <language-switch class=\"language-switch\" _nghost-ghs-c349=\"\"><div _ngcontent-ghs-c349=\"\" class=\"ms-1 mx-auto ng-star-inserted\">\n" +
                "    <div _ngcontent-ghs-c349=\"\" class=\"btn language-switch-btn btn-clean btn-icon p-0 me-1 ng-star-inserted\" title=\"English\">\n" +
                "        <i _ngcontent-ghs-c349=\"\" class=\"famfamfam-flags us\" aria-label=\"English\"></i>\n" +
                "    </div><div _ngcontent-ghs-c349=\"\" class=\"btn language-switch-btn btn-clean btn-icon p-0 me-1 ng-star-inserted\" title=\"French\">\n" +
                "        <i _ngcontent-ghs-c349=\"\" class=\"famfamfam-flags fr\" aria-label=\"French\"></i>\n" +
                "    </div><div _ngcontent-ghs-c349=\"\" class=\"btn language-switch-btn btn-clean btn-icon p-0 me-1 ng-star-inserted\" title=\"German\">\n" +
                "        <i _ngcontent-ghs-c349=\"\" class=\"de famfamfam-flags\" aria-label=\"German\"></i>\n" +
                "    </div><div _ngcontent-ghs-c349=\"\" class=\"btn language-switch-btn btn-clean btn-icon p-0 me-1 ng-star-inserted\" title=\"العربية\">\n" +
                "        <i _ngcontent-ghs-c349=\"\" class=\"famfamfam-flags sa\" aria-label=\"العربية\"></i>\n" +
                "    </div><!---->\n" +
                "</div><!---->\n" +
                "</language-switch>\n" +
                "            </div>\n" +
                "            \n" +
                "            <div class=\"footer text-center small mt-4\">\n" +
                "                © 2026, Qoad Software Solutions. All rights reserved. |\n" +
                "                <a target=\"_blank\" class=\"fw-semibold text-decoration-none ms-1\" href=\"https://qoad.com/en/products/rentey/\">Rentey</a>\n" +
                "            </div>\n" +
                "        </div>\n" +
                "    </div>\n" +
                "</div></ng-component><!----><!---->\n" +
                "\n" +
                "    </app-root>\n" +
                "<script src=\"polyfills.4f154d5bd2d22798.js\" type=\"module\"></script><script src=\"scripts.a615452b23f929be.js\" defer=\"\"></script><script src=\"main.ce4047c16fcf8380.js\" type=\"module\"></script>\n" +
                "<script src=\"https://ejarypp.qoad.com:4800/assets/metronic/common/js/components/util.js\"></script><script src=\"https://ejarypp.qoad.com:4800/assets/metronic/common/js/components/metronic-compat.js\"></script><script src=\"https://ejarypp.qoad.com:4800/assets/metronic/common/js/components/toggle.js\"></script><script src=\"https://ejarypp.qoad.com:4800/assets/metronic/common/js/components/menu.js\"></script><script src=\"https://ejarypp.qoad.com:4800/assets/metronic/common/js/components/offcanvas.js\"></script><script src=\"https://ejarypp.qoad.com:4800/assets/metronic/common/js/components/scrolltop.js\"></script><script src=\"https://ejarypp.qoad.com:4800/assets/metronic/common/js/components/header.js\"></script><script src=\"https://ejarypp.qoad.com:4800/assets/metronic/themes/default/js/components/event-handler.js\"></script><script src=\"https://ejarypp.qoad.com:4800/assets/metronic/themes/default/js/components/swapper.js\"></script><script src=\"https://ejarypp.qoad.com:4800/assets/metronic/themes/default/js/components/drawer.js\"></script><script src=\"https://ejarypp.qoad.com:4800/assets/metronic/themes/default/plugins/global/plugins.bundle.js\"></script><script src=\"https://ejarypp.qoad.com:4800/assets/metronic/themes/default/js/layout/app.js\"></script><script src=\"https://ejarypp.qoad.com:4800/assets/metronic/themes/default/js/layout/theme-mode.js\"></script></body>"+"\n\npage HTML is:" + pageHtml);
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
