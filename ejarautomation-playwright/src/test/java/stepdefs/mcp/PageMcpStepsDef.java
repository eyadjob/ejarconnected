package stepdefs.mcp;

import automation.framework.ai.DeepSeekVisionValidator;
import automation.framework.listener.StepTimingFormatter;
import automation.framework.mcp.McpPlaywrightClient;
import io.cucumber.java.After;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.junit.Assert;

import java.nio.file.Files;
import java.nio.file.Paths;

/**
 * Steps that drive the Playwright MCP server instead of {@code DriverFactory}.
 *
 * <p>Every interaction goes through {@link McpPlaywrightClient}, which starts
 * {@code npx @playwright/mcp} and calls its tools ({@code browser_navigate},
 * {@code browser_wait_for}, {@code browser_take_screenshot}).</p>
 *
 * <p>Verification is delegated to the DeepSeek vision judge; the Java-side DOM assertions were removed
 * on purpose so the scenario relies on the model's judgement rather than selector-level checks.</p>
 *
 * <p>Each step is wrapped in {@link #timed} so the console shows {@code <step text>\t<duration>}
 * even when the feature is started from the IDE, where IntelliJ uses its own Cucumber formatter and
 * ignores the plugin configured in the runner. When {@link StepTimingFormatter} <em>is</em> active
 * (Maven runs), it prints the timings instead and this fallback stays silent.</p>
 */
public class PageMcpStepsDef {

    private static final String MCP_OUTPUT_DIR = "test output/playwright-mcp/";
    private static final String DEEPSEEK_SCREENSHOT = "deepseek-verification.png";
    private static final String TAB = "\t";

    /** Used only when the DeepSeek step is written without a docstring checklist. */
    private static final String DEFAULT_LOGIN_CHECKLIST =
            "- Rentey wordmark in the top-right corner\n"
            + "- Yellow YELO tenant logo above the login form\n"
            + "- Labels 'User name or email' and 'Password' with their inputs\n"
            + "- A 'Log in' button below the password field\n"
            + "- Footer mentioning Qoad Software Solutions and Rentey";

    /** A step body that may throw anything, including {@link AssertionError}. */
    @FunctionalInterface
    private interface StepBody {
        void run() throws Exception;
    }

    private McpPlaywrightClient mcp;

    @Given("^the Playwright MCP browser is started$")
    public void startPlaywrightMcpBrowser() throws Exception {
        timed("Given the Playwright MCP browser is started", () -> {
            mcp = new McpPlaywrightClient();
            mcp.start();
        });
    }

    @When("^I open the Yelo login page at \"(.*)\"$")
    public void openYeloLoginPage(String url) throws Exception {
        timed("When I open the Yelo login page at \"" + url + "\"", () -> {
            requireClient();
            mcp.navigate(url);
            // The login form is rendered by the SPA after the first paint; wait for it before asserting.
            mcp.waitForText("Log in", 30);
        });
    }

    /**
     * LLM-as-judge step: captures the page through the MCP browser, sends the screenshot plus the
     * checklist (the feature's docstring) to DeepSeek, and asserts on the model's JSON verdict.
     */
    @Then("^DeepSeek confirms the page matches the Yelo login design$")
    public void deepSeekConfirmsThePage(String checklist) throws Exception {
        timed("And DeepSeek confirms the page matches the Yelo login design", () -> {
            requireClient();
            String screenshotPath = MCP_OUTPUT_DIR + DEEPSEEK_SCREENSHOT;
            // Evidence comes from the same MCP browser the previous steps used.
            mcp.screenshot(screenshotPath);
            byte[] png = Files.readAllBytes(Paths.get(screenshotPath));

            String review = (checklist == null || checklist.trim().isEmpty())
                    ? DEFAULT_LOGIN_CHECKLIST : checklist.trim();
            DeepSeekVisionValidator.Verdict verdict = new DeepSeekVisionValidator()
                    .validate(png, "Yelo login page at https://ejarypp.qoad.com:4800/", review);

            System.out.println("DeepSeek verdict: " + verdict);
            Assert.assertTrue("DeepSeek did not confirm the login page design (" + verdict
                            + "). Findings: " + verdict.getFindings(),
                    verdict.isPass());
        });
    }

    @Then("^the Playwright MCP browser saves a screenshot named \"(.*)\"$")
    public void saveScreenshot(String fileName) throws Exception {
        timed("And the Playwright MCP browser saves a screenshot named \"" + fileName + "\"", () -> {
            requireClient();
            mcp.screenshot(MCP_OUTPUT_DIR + fileName);
            System.out.println("Screenshot saved: " + MCP_OUTPUT_DIR + fileName);
        });
    }

    @Then("^the Playwright MCP browser is closed$")
    public void closePlaywrightMcpBrowser() throws Exception {
        timed("And the Playwright MCP browser is closed", () -> {
            if (mcp != null) {
                mcp.close();
                mcp = null;
            }
        });
    }

    /** Safety net: never leave the server (and its browser) running if a step fails. */
    @After
    public void stopBrowserAfterScenario() {
        if (mcp != null) {
            mcp.close();
            mcp = null;
        }
    }

    /**
     * Prints {@code <step text>\t<milliseconds>} after the step finishes, unless
     * {@link StepTimingFormatter} already reports the timings for this run.
     */
    private void timed(String stepText, StepBody body) throws Exception {
        long start = System.nanoTime();
        try {
            body.run();
        } finally {
            if (!StepTimingFormatter.isActive()) {
                long millis = (System.nanoTime() - start) / 1_000_000L;
                System.out.println("    " + stepText + TAB + millis + " ms");
            }
        }
    }

    private void requireClient() {
        if (mcp == null) {
            throw new IllegalStateException("The Playwright MCP browser is not started; run the Given step first.");
        }
    }
}
