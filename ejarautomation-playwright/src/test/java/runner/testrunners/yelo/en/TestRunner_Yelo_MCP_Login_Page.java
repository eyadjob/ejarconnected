package runner.testrunners.yelo.en;

import io.cucumber.junit.Cucumber;
import io.cucumber.junit.CucumberOptions;
import org.junit.runner.RunWith;

/**
 * Runs the Playwright MCP scenarios under {@code feature/yelo/AI MCP}.
 *
 * <p>Glue is limited to {@code stepdefs.mcp} on purpose: these scenarios drive the browser through the
 * MCP server, so the generic hooks (video, screenshots, DriverFactory tear-down) do not apply. This
 * runner also skips the report/email listeners used by the regression runners.</p>
 */
@RunWith(Cucumber.class)
@CucumberOptions(
        plugin = {"pretty"},
        features = {"src/test/resources/feature/yelo/AI MCP/"},
        monochrome = true,
        glue = {"stepdefs.mcp"})
public class TestRunner_Yelo_MCP_Login_Page {
}
