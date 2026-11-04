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
        features = {"src/test/resources/feature/yelo/"},
        monochrome = true,
        glue = {"stepdefs"},
        name = {"^validate yelo pay later - happy case$|^validate edit booking - pay later - edit pickup date - price should be changed$|^validate yelo currency - change currency - currency in displayed prices should be changed$|^validate forget password - Not registered email - error message should be displayed$|^validate manage my booking - search for existing booking$|^verify my profile page$|^verify header elements$|^verify footer page$|^verify site map page$|^verify services page$|^verify open kilometers page$|^verify yelo shield plus page$|^verify shipping between cities page$|^verify other services page$|^verify register page$|^verify login page$|^verify home page$|^verify fleet page$|^family membership page$|^verify deals page$|^verify contact us page$|^Verify All Cities Elements$|^verify careers page$|^validate Membership Information page$|^validate no membership$|^verify branches page$|^verify about us page$|^validate login email - wrong email - no @ char - error message should be displayed$|^validate login email - wrong email - more than one @ char - error message should be displayed$|^validate login email - wrong email - special char - error message should be displayed$|^validate login email - wrong email - space - error message should be displayed$|^validate login email - wrong email - double dot - error message should be displayed$|^validate login email - wrong email then correct email - error message should be displayed then disappeared$|^validate login - wrong password - error message should be displayed$"})
public class TestRunner_Yelo_Rental_Agent_V2_English {

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