package stepdefs.mcp;

import automation.framework.mcp.McpPlaywrightClient;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.After;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.junit.Assert;

import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * Steps that drive the Playwright MCP server instead of {@code DriverFactory}.
 *
 * <p>Every interaction goes through {@link McpPlaywrightClient}, which starts
 * {@code npx @playwright/mcp} and calls its tools ({@code browser_navigate},
 * {@code browser_wait_for}, {@code browser_evaluate}, {@code browser_take_screenshot}).</p>
 */
public class YeloLoginPageMcpSteps {

    private static final String MCP_OUTPUT_DIR = "test output/playwright-mcp/";
    private static final Gson GSON = new Gson();

    private McpPlaywrightClient mcp;

    @Given("^the Playwright MCP browser is started$")
    public void startPlaywrightMcpBrowser() throws IOException {
        mcp = new McpPlaywrightClient();
        mcp.start();
    }

    @When("^I open the Yelo login page at \"(.*)\"$")
    public void openYeloLoginPage(String url) throws IOException {
        requireClient();
        mcp.navigate(url);
        // The login form is rendered by the SPA after the first paint; wait for it before asserting.
        mcp.waitForText("Log in", 30);
    }

    @Then("^the page title should be \"(.*)\"$")
    public void thePageTitleShouldBe(String expectedTitle) throws IOException {
        JsonObject state = mcp.evaluateJson("() => ({ title: document.title, url: location.href })");
        Assert.assertEquals("Page title", expectedTitle, state.get("title").getAsString());
        Assert.assertTrue("Expected the login route, but the page is at " + state.get("url").getAsString(),
                state.get("url").getAsString().contains("/account/login"));
    }

    @Then("^the login form should show these fields:$")
    public void theLoginFormShouldShowTheseFields(DataTable fields) throws IOException {
        List<Map<String, String>> rows = fields.asMaps(String.class, String.class);
        for (Map<String, String> row : rows) {
            String label = row.get("label");
            String selector = row.get("selector");

            JsonObject state = mcp.evaluateJson("() => {" +
                    "  const visible = (e) => !!e && e.offsetParent !== null && e.getBoundingClientRect().width > 0;" +
                    "  const labelText = " + GSON.toJson(label) + ";" +
                    "  const labelEl = Array.from(document.querySelectorAll('label'))" +
                    "      .find(l => (l.innerText || '').trim() === labelText);" +
                    "  const input = document.querySelector(" + GSON.toJson(selector) + ");" +
                    "  return {" +
                    "    labelVisible: visible(labelEl)," +
                    "    inputVisible: visible(input)," +
                    "    inputType: input ? input.type : null" +
                    "  };" +
                    "}");

            Assert.assertTrue("Label '" + label + "' is not displayed", state.get("labelVisible").getAsBoolean());
            Assert.assertTrue("Field '" + selector + "' is not displayed", state.get("inputVisible").getAsBoolean());
            if (label.equalsIgnoreCase("Password")) {
                Assert.assertEquals("Password field must be masked", "password", state.get("inputType").getAsString());
            }
        }
    }

    @Then("^the \"(.*)\" button should be displayed$")
    public void theButtonShouldBeDisplayed(String buttonText) throws IOException {
        JsonObject state = mcp.evaluateJson("() => {" +
                "  const text = " + GSON.toJson(buttonText) + ";" +
                "  const button = Array.from(document.querySelectorAll('button'))" +
                "      .find(b => (b.innerText || '').trim() === text);" +
                "  const visible = !!button && button.offsetParent !== null && button.getBoundingClientRect().width > 0;" +
                "  return { found: !!button, visible: visible, text: button ? button.innerText.trim() : null };" +
                "}");
        Assert.assertTrue("Button '" + buttonText + "' was not found", state.get("found").getAsBoolean());
        Assert.assertTrue("Button '" + buttonText + "' is not displayed", state.get("visible").getAsBoolean());
    }

    @Then("^the tenant logo should be displayed$")
    public void theTenantLogoShouldBeDisplayed() throws IOException {
        JsonObject state = mcp.evaluateJson("() => {" +
                "  const logo = Array.from(document.querySelectorAll('img'))" +
                "      .find(i => (i.getAttribute('src') || '').includes('GetTenantLogo'));" +
                "  const visible = !!logo && logo.offsetParent !== null && logo.getBoundingClientRect().width > 0;" +
                "  return { found: !!logo, visible: visible, src: logo ? logo.getAttribute('src') : null };" +
                "}");
        Assert.assertTrue("Tenant logo image was not found", state.get("found").getAsBoolean());
        Assert.assertTrue("Tenant logo is not displayed", state.get("visible").getAsBoolean());
    }

    @Then("^the footer should mention \"(.*)\" and \"(.*)\"$")
    public void theFooterShouldMention(String first, String second) throws IOException {
        String bodyText = mcp.evaluateText("() => document.body.innerText");
        Assert.assertTrue("Footer does not mention '" + first + "'", bodyText.contains(first));
        Assert.assertTrue("Footer does not mention '" + second + "'", bodyText.contains(second));
    }

    @Then("^the customer service notice should be displayed$")
    public void theCustomerServiceNoticeShouldBeDisplayed() throws IOException {
        String bodyText = mcp.evaluateText("() => document.body.innerText");
        Assert.assertTrue("Notice text 'based on correct information' is missing",
                bodyText.contains("based on correct information"));
        Assert.assertTrue("Notice text 'Customer Service Team' is missing",
                bodyText.contains("Customer Service Team"));
    }

    @Then("^the Playwright MCP browser saves a screenshot named \"(.*)\"$")
    public void saveScreenshot(String fileName) throws IOException {
        requireClient();
        String response = mcp.screenshot(MCP_OUTPUT_DIR + fileName);
        System.out.println("MCP screenshot: " + MCP_OUTPUT_DIR + fileName + " -> " + response);
    }

    @Then("^the Playwright MCP browser is closed$")
    public void closePlaywrightMcpBrowser() {
        if (mcp != null) {
            mcp.close();
            mcp = null;
        }
    }

    /** Safety net: never leave the server (and its browser) running if a step fails. */
    @After
    public void stopBrowserAfterScenario() {
        if (mcp != null) {
            mcp.close();
            mcp = null;
        }
    }

    private void requireClient() {
        if (mcp == null) {
            throw new IllegalStateException("The Playwright MCP browser is not started; run the Given step first.");
        }
    }
}
