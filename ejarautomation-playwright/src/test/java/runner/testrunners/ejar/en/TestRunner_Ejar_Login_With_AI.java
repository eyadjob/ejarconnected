package runner.testrunners.ejar.en;

import automation.framework.business.DateHelper;
import automation.framework.business.FileHandler;
import automation.framework.business.RegxHelper;
import automation.framework.propmanager.PropManager;
import automation.framework.threadData.SharedMethods;
import automation.framework.threadData.TestData;
import io.cucumber.junit.Cucumber;
import io.cucumber.junit.CucumberOptions;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.runner.RunWith;

import java.io.IOException;

/**
 * Runs Ejar AI-assisted login feature (Ollama at localhost:11434, model qwen3-coder:30b).
 * Does not require DB precondition; report teardown is fault-tolerant.
 */
@RunWith(Cucumber.class)
@CucumberOptions(
        plugin = {"com.aventstack.extentreports.cucumber.adapter.ExtentCucumberAdapter:"},
        features = {"src/test/resources/feature/ejar/web/ai/"},
        monochrome = true,
        glue = {"stepdefs"})
public class TestRunner_Ejar_Login_With_AI {

    @BeforeClass
    public static void testRunnerBeforeClass() throws IOException {
        PropManager.getInstance().setExecutionLanguageProperty("en");
        PropManager.getInstance().setTheExecutionProject("ejar web");
        Class<?> currentClass = new Object() {}.getClass().getEnclosingClass();
        System.out.println("test runner feature name is in before class : " + currentClass.getName());
        String executionName = new RegxHelper().getRegxMatch("\\.(?!.+\\.)(.+)", 1, currentClass.getName());
        // AI login runner: skip DB precondition (RunnerListener.testRunStarted) so test runs without SQL Server
        TestData.getInstance().getThreadSharedMethods().get().setTestName(executionName);
        TestData.getInstance().getThreadSharedMethods().get().setCopyPathForResults(
                PropManager.getInstance().getProperty("execution.reports.backup.folder") + "\\" + DateHelper.getCurrentDatePlusDays(0) + "\\" + executionName + " " + DateHelper.getCurrentDatePlusDays(0, "YYYY-MM-dd HH:mm").replace(":", "-"));
        FileHandler.deleteFilesInPath(TestData.getInstance().getThreadSharedMethods().get().getCustomReportWithoutFeaturePath());
    }

    @AfterClass
    public static void testRunnerAfterClass() throws IOException {
        System.out.println("test runner - after class : " + new Object() {}.getClass().getEnclosingClass().getName());
        // Skip RunnerListener.testRunFinished to avoid Gson/Throwable serialization issues on Java 17+
        FileHandler.deleteFilesInPath(SharedMethods.buildPathToFolder(PropManager.getInstance().getProperty("custom.report.folder")));
        FileHandler.deleteFilesInPath(SharedMethods.buildPathToFolder(PropManager.getInstance().getProperty("images.temp.folder")));
    }
}
