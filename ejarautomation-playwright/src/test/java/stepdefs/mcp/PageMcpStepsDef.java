package stepdefs.mcp;

import automation.framework.ai.DeepSeekVisionValidator;
import automation.framework.listener.StepTimingFormatter;
import automation.framework.listener.StepTimingSupport;
import automation.framework.mcp.McpPlaywrightClient;
import io.cucumber.java.After;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.junit.Assert;

import java.nio.file.Files;
import java.nio.file.Path;
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
    /** Page screenshot captured for the mockup comparison, kept next to the other MCP artefacts. */
    private static final String MOCKUP_SCREENSHOT = "mockup-compare-page.png";

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
    @Then("^DeepSeek confirms the page matches the Yelo login design based on description$")
    public void deepSeekConfirmsThePage(String checklist) throws Exception {
        timed("And DeepSeek confirms the page matches the Yelo login design", () -> {
            requireClient();
            String screenshotPath = MCP_OUTPUT_DIR + DEEPSEEK_SCREENSHOT;
            // Evidence comes from the same MCP browser the previous steps used.
            mcp.screenshot(screenshotPath);
            byte[] png = Files.readAllBytes(Paths.get(screenshotPath));
            DeepSeekVisionValidator.Verdict verdict = new DeepSeekVisionValidator()
                    .validate(png, "Yelo login page at https://ejarypp.qoad.com:4800/", checklist.trim());

            System.out.println("DeepSeek verdict: " + verdict);
            Assert.assertTrue("DeepSeek did not confirm the login page design (" + verdict
                            + "). Findings: " + verdict.getFindings(),
                    verdict.isPass());
        });
    }

    /**
     * Visual comparison against a design image: the model receives the mockup as image 1 and the page
     * screenshot as image 2, derives the element list from the mockup itself, and must confirm that every
     * element is present on the page and that the page shows no error state.
     */
    @Then("^DeepSeek compares the opened page with the mockup image \"(.*)\"$")
    public void deepSeekComparesPageWithMockup(String mockupPath) throws Exception {
        timed("And DeepSeek compares the opened page with the mockup image \"" + mockupPath + "\"", () -> {
            requireClient();
            Path mockup = Paths.get(mockupPath);
            if (!Files.isRegularFile(mockup)) {
                throw new IllegalStateException("Mockup image not found: " + mockup.toAbsolutePath()
                        + " - drop the design image there or pass an absolute path.");
            }
            String screenshotPath = MCP_OUTPUT_DIR + MOCKUP_SCREENSHOT;
            mcp.screenshot(screenshotPath);
            byte[] pageScreenshot = Files.readAllBytes(Paths.get(screenshotPath));
            byte[] mockupImage = Files.readAllBytes(mockup);

            DeepSeekVisionValidator.Verdict verdict = new DeepSeekVisionValidator()
                    .validateAgainstMockup(pageScreenshot, mockupImage,
                            "The implemented page must contain every element of the mockup and must not show "
                                    + "any error state.");

            System.out.println("DeepSeek mockup verdict: " + verdict);
            for (DeepSeekVisionValidator.Item item : verdict.getItems()) {
                System.out.println("    " + item);
            }
            Assert.assertTrue("The page does not match the mockup " + mockup.getFileName() + " (" + verdict
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
     * Publishes the step text so the generic {@code Hook} can print
     * {@code <step text>\t<milliseconds> ms} for this step as well, then runs the body.
     * The console line itself is emitted by the hook, so MCP and ordinary features stay identical.
     */
    private void timed(String stepText, StepBody body) throws Exception {
        StepTimingSupport.setLabel(stepText);
        body.run();
    }

    private void requireClient() {
        if (mcp == null) {
            throw new IllegalStateException("The Playwright MCP browser is not started; run the Given step first.");
        }
    }
}
