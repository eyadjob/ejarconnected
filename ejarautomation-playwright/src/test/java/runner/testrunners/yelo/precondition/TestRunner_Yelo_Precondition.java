package runner.testrunners.yelo.precondition;

import automation.framework.propmanager.PropManager;
import io.cucumber.junit.Cucumber;
import io.cucumber.junit.CucumberOptions;
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
        //"com.aventstack.extentreports.cucumber.adapter.ExtentCucumberAdapter:",
},
        features = {"src/test/resources/feature/yelo/precondition/"},
        monochrome = true,
        glue = {"stepdefs"})
public class TestRunner_Yelo_Precondition {

    @BeforeClass
    public static void testRunnerBeforeClass() throws IOException {
        PropManager.getInstance().setExecutionLanguageProperty("en");
        PropManager.getInstance().setTheExecutionProject("ejar web");
        Class currentClass = new Object() {
        }.getClass().getEnclosingClass();
        System.out.println("test runner feature name is in before class : " + currentClass.getName());
        //RunnerListener.testRunStarted(new RegxHelper().getRegxMatch("\\.(?!.+\\.)(.+)", 1, currentClass.getName()));
    }
}
