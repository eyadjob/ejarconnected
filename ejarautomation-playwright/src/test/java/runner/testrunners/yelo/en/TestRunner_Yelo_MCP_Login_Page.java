package runner.testrunners.yelo.en;

import io.cucumber.core.cli.Main;
import org.junit.Assert;
import org.junit.Test;

/**
 * Runs the Playwright MCP scenarios under {@code feature/yelo/AI MCP}.
 *
 * <p>Unlike the regression runners, this one is a plain JUnit test that invokes Cucumber's CLI and
 * asserts on its exit status. That is deliberate: with {@code @RunWith(Cucumber.class)} and this
 * Surefire version, a failed scenario is reported but never fails the build ({@code Tests run: 0}),
 * so a red run would still look green in CI.</p>
 *
 * <p>Glue is limited to {@code stepdefs.mcp} on purpose: these scenarios drive the browser through the
 * MCP server, so the generic hooks (video, screenshots, DriverFactory tear-down) do not apply, and no
 * report/email listeners run here.</p>
 */
public class TestRunner_Yelo_MCP_Login_Page {

    @Test
    public void yeloLoginPageViaMcp() {
        byte status = Main.run(new String[]{
                "src/test/resources/feature/yelo/AI MCP/",
                "--glue", "stepdefs.mcp",
                "--plugin", "automation.framework.listener.StepTimingFormatter",
                "--monochrome"
        }, Thread.currentThread().getContextClassLoader());

        Assert.assertEquals("Cucumber scenarios failed (exit status " + status + ")", 0, status);
    }
}
