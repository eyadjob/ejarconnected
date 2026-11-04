package runner.testrunners.yelo.en;

import automation.framework.business.RegxHelper;
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
        features = {"src/test/resources/feature/yelo/validation/yelo pay later validation for performance test.feature"},
        monochrome = true,
        glue = {"stepdefs"})
public class TestRunner_Yelo_Performance_English {

    @BeforeClass
    public static void testRunnerBeforeClass() throws IOException {
        PropManager.getInstance().setExecutionLanguageProperty("en");
        PropManager.getInstance().setTheExecutionProject("yelo web");
        Class currentClass = new Object() {
        }.getClass().getEnclosingClass();
        System.out.println("test runner feature name is in before class : " + currentClass.getName());
        RunnerListener.testRunStarted(new RegxHelper().getRegxMatch("\\.(?!.+\\.)(.+)", 1, currentClass.getName()));
    }

    @AfterClass
    public static void testRunnerAfterClass() throws IOException {
        System.out.println("test runner - after class : " + new Object() {
        }.getClass().getEnclosingClass().getName());
        RunnerListener.testRunFinished(ExtentCucumberAdapter.getCurrentStep(), new RegxHelper().getRegxMatch("\\.(?!.+\\.)(.+)", 1, new Object() {
        }.getClass().getEnclosingClass().getName()));
    }
}
