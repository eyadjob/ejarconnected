package runner.testrunners.ejar.en;

import automation.framework.business.RegxHelper;
import automation.framework.listener.RunnerListener;
import automation.framework.propmanager.PropManager;
import com.aventstack.extentreports.cucumber.adapter.ExtentCucumberAdapter;
import io.cucumber.testng.AbstractTestNGCucumberTests;
import io.cucumber.testng.CucumberOptions;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.DataProvider;

import java.io.IOException;

/**
 * this is the cucumber running initiator, which generate reports for each feature
 *
 * @author y.abulebbeh@qoad.com
 */
@CucumberOptions(plugin = {
        "com.aventstack.extentreports.cucumber.adapter.ExtentCucumberAdapter:",
},
        features = {"src/test/resources/feature/ejar/web/forms/verification/"},
        monochrome = true,
        glue = {"stepdefs"},
        name = {"^Execute existing Individual Spot booking$|^Close existing Individual Spot contract$|^Execute existing broker booking$|^Cancel existing Individual Spot contract$|^Extend existing individual contract$|^Cancel existing individual booking$|^Edit existing individual booking$|^Cancel existing broker booking$|^Edit existing broker booking$|^Cancel existing Broker Spot contract$|^Close existing Broker Spot contract$|^Extend existing Broker spot contract$"})

public class TestRunner_Ejar_Existing_Data_English extends AbstractTestNGCucumberTests {

    @BeforeClass
    public static void testRunnerBeforeClass() throws IOException {
        System.setProperty("dataproviderthreadcount", "3");
        PropManager.getInstance().setExecutionLanguageProperty("en");
        PropManager.getInstance().setTheExecutionProject("ejar web");
        Class<?> currentClass = new Object() {
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

    @Override
    @DataProvider(parallel = true)
    public Object[][] scenarios() {
        return super.scenarios();
    }
}