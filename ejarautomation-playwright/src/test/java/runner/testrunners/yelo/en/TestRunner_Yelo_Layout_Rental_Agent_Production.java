package runner.testrunners.yelo.en;

import automation.framework.business.RegxHelper;
import automation.framework.business.SendAggregatedReport;
import automation.framework.listener.RunnerListener;
import automation.framework.propmanager.PropManager;
import com.aventstack.extentreports.cucumber.adapter.ExtentCucumberAdapter;
import io.cucumber.junit.Cucumber;
import io.cucumber.junit.CucumberOptions;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.runner.RunWith;

import java.io.IOException;

/**
 * this is the cucumber running initiator, which generate reports for each feature
 *
 * @author e.mubarak@iyelo.com
 */
@RunWith(Cucumber.class)
@CucumberOptions(plugin = {
        "com.aventstack.extentreports.cucumber.adapter.ExtentCucumberAdapter:",
},
        features = {"src/test/resources/feature/yelo/"},
        monochrome = true,
        glue = {"stepdefs"},
//        name = {"^booking pay later validation Yelo production \\(iyelo\\.com\\)$|booking pay later validation Yelo production \\(iyelo\\.ch\\)"})
          name = {"^booking pay later validation Yelo production \\(iyelo\\.com\\)$"})
public class TestRunner_Yelo_Layout_Rental_Agent_Production {

    /**
     * Email design used by this runner only. The file lives in {@code src/test/resources} and must
     * define {@code report.email.header} / {@code report.email.footer} (and optionally
     * {@code report.email.logo.url}); see {@code SendAggregatedReport.buildLayoutTestResultsContent}.
     */
    private static final String EMAIL_LAYOUT_FILE = "emailProperites_yelo_layout.properties";

    @BeforeClass
    public static void testRunnerBeforeClass() throws IOException {
        System.setProperty("execution.use.production.resolution", "true");
        System.setProperty(SendAggregatedReport.EMAIL_LAYOUT_FILE_PROPERTY, EMAIL_LAYOUT_FILE);
        PropManager.getInstance().setProperty("email.sendProductionReportTo","e.mubarak@iyelo.com");
        PropManager.getInstance().setExecutionLanguageProperty("en");
        PropManager.getInstance().setTheExecutionProject("yelo web");
//        PropManager.getInstance().setProperty("attachVideoOnReportEmail","true");
        Class currentClass = new Object() {
        }.getClass().getEnclosingClass();
        System.out.println("test runner feature name is in before class : " + currentClass.getName());
        RunnerListener.testRunStarted(new RegxHelper().getRegxMatch("\\.(?!.+\\.)(.+)", 1, currentClass.getName()));
    }

    @AfterClass
    public static void testRunnerAfterClass() throws IOException {
        System.clearProperty("execution.use.production.resolution");
        System.out.println("test runner - after class : " + new Object() {
        }.getClass().getEnclosingClass().getName());
        try {
            RunnerListener.testRunFinished(ExtentCucumberAdapter.getCurrentStep(), new RegxHelper().getRegxMatch("\\.(?!.+\\.)(.+)", 1, new Object() {
            }.getClass().getEnclosingClass().getName()));
        } finally {
            // Cleared only after testRunFinished() (it renders the email body from it), and always —
            // a leaked value would switch every later runner in the same JVM to this layout.
            System.clearProperty(SendAggregatedReport.EMAIL_LAYOUT_FILE_PROPERTY);
        }
    }
}