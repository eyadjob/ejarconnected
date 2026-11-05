package stepdefs.yelo.web;

import automation.framework.DatabaseHelper;
import automation.framework.Element;
import automation.framework.ScenarioContextSingleton;
import automation.framework.business.*;
import automation.framework.listener.DateHelper;
import automation.framework.propmanager.PropManager;
import automation.framework.threadData.DriverFactory;
import automation.framework.threadData.TestData;
import com.microsoft.playwright.Locator;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import org.apache.commons.math3.util.Precision;
import org.junit.Assert;
import stepdefs.generic.GenericPage;
import stepdefs.generic.GenericStepDefs;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.*;
import java.util.stream.Collectors;

import static automation.framework.Element.waitForLoadingIconToBeNotPresentStatic;

public class YeloGenericStepDefs {

    GenericStepDefs genericStepDefs = new GenericStepDefs();
    GenericPage genericPage = new GenericStepDefs();

    public static void executeMultipleCommandLines(String[] commands) {
        try {
            // Create ProcessBuilder for cmd.exe
            ProcessBuilder builder = new ProcessBuilder("cmd.exe");

            // Redirect error stream to output stream
            builder.redirectErrorStream(true);

            // Start the process
            Process process = builder.start();

            // Get input and output streams
            OutputStream stdin = process.getOutputStream();
            InputStream stdout = process.getInputStream();

            // Create a writer to send commands
            BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(stdin));

            // Send commands to the process
            for (String cmd : commands) {
                writer.write(cmd);
                writer.newLine();
            }
            writer.flush();

            // Read the output
            BufferedReader reader = new BufferedReader(new InputStreamReader(stdout));
            String line;
            while ((line = reader.readLine()) != null) {
                System.out.println(line);
            }

            // Wait for the process to complete
            int exitCode = process.waitFor();
            System.out.println("Exited with code: " + exitCode);

        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
        }
    }

    public static Map<String, String> getExecutionVariables() {
        Map<String, String> executionVariables = new HashMap<>();
        executionVariables.put("scriptName", System.getProperty("scriptName"));
        executionVariables.put("isSaas", System.getProperty("isSaas"));
        executionVariables.put("environmentHost", System.getProperty("environmentHost"));
        executionVariables.put("environmentHostApi", System.getProperty("environmentHostApi"));
        executionVariables.put("tenantName", System.getProperty("tenantName"));
        executionVariables.put("isHttpSecure", System.getProperty("isHttpSecure"));
        executionVariables.put("scriptNamCleaned", executionVariables.get("scriptName").replace(".jmx", "").replace("-", " ").replaceAll("\\s+", " "));
        executionVariables.put("rentalAgentTempFolderPath", (PropManager.getInstance().getProperty("execution.reports.backup.folder.rentalAgentTempFolder") + " " + executionVariables.get("scriptNamCleaned").replace("  ", " ")));
        executionVariables.put("scriptToRunPath", PropManager.getInstance().getProperty("automated.rentalAgent.scripts.location") + "\\" + executionVariables.get("scriptName"));
        executionVariables.forEach((key, value) -> System.out.println("Eyad the value of execution variable: " + key + " ,was: " + value));
        return executionVariables;
    }

    @Given("^user open page yelo page: (.*)$")
    public void openYeloPage(String pageUrl) {
        waitForLoadingIconToBeNotPresentStatic("yelo web");
        String projectUrl =ScenarioContextSingleton.getInstance().getContextValue("websiteBaseUrl");
        if (pageUrl.equals("/")) {
            genericStepDefs.navigateToUrl(projectUrl);
        } else {
            genericStepDefs.navigateToUrl(projectUrl + pageUrl.trim());
        }
    }

    @Given("^user open website page: (.*)")
    public void openWebsitePage(String websiteName) throws InterruptedException {
        genericStepDefs.setProjectExecution("yelo");
        String projectUrl;
        EnvironmentNames environmentName =  EnvironmentNames.fromString(websiteName);
        if (environmentName.name().equals("Yelo")) {
            projectUrl = PropManager.getInstance().getProperty("yelo.environment.url");
        } else if (environmentName.name().equals("Alyam")) {
            projectUrl = PropManager.getInstance().getProperty("alyam.environment.url");
        } else {
            projectUrl = PropManager.getInstance().getProperty("yelo.environment.url");
        }

        if (PropManager.getInstance().getProperty("execution.lang").equalsIgnoreCase("ar")) projectUrl += "ar";
        else projectUrl += "en";
        ScenarioContextSingleton.getInstance().setContextValue("websiteBaseUrl", projectUrl);
        genericStepDefs.navigateToUrl(projectUrl);
        waitForLoadingIconToBeNotPresentStatic("yelo web");
        GenericPage.dismissCookieBanner("cookieconsent_status","dismiss");
    }

    public void clickOnMinimizeChatWindow() {
        com.microsoft.playwright.Page page = DriverFactory.getDriver();
        Locator ifame = new Element("chatewindow.iframe.byxpath", "//iframe[@data-test-id='ChatWidgetWindow-iframe']").waitForElementUntilPresent(ElementStatus.PRESENT, 10);
        if (ifame != null && page.frames().size() > 1) {
            DriverFactory.setCurrentFrame(page.frames().get(1));
            new Element("yelo.chatwindow.dialog.minimize.action.byxpath").waitForElement(ElementStatus.PRESENT, 10).click();
            DriverFactory.setCurrentFrame(null);
        }
    }

    @Given("^login to yelo site with user: (.*) and password: (.*)$")
    public void loginToYeloSite(String userEmail, String password) {
        PropManager.getInstance().getPropertiesValues().get("appProperties.properties").put("execution.project.name", "yelo web");
        genericStepDefs.waitForPageToLoad();
        genericStepDefs.waitPageToLoad(DocumentStatusRecord.INSTANCE.load());
        waitForLoadingIconToBeNotPresentStatic("yelo web");
        genericStepDefs.clickElement("yelo.header.login-link.byxpath");
        Element loginModal = new Element("yelo.header.yeloLoginForm.byxpath");
        if (!loginModal.isElementPresentAfterWait(5))
            genericStepDefs.clickElement("yelo.header.login-link.byxpath");
        genericStepDefs.setValue(userEmail, "yelo.login.email.field.byxpath");
        genericStepDefs.setValue(password, "yelo.login.password.field.byxpath");
        genericStepDefs.clickElement("yelo.login.submitlogin.byxpath");
        genericStepDefs.waitForSeconds(2);
    }

    @Given("^login to yelo site with context key: (.*) and password: (.*)$")
    public void loginToYeloSiteWithContextKey(String contextKey, String password) {
        String email = ScenarioContextSingleton.getInstance().getContextValue("email");

        genericStepDefs.clickElement("yelo.homepage.loginlink.byxpath");
        genericStepDefs.setValue(email, "yelo.login.email.field.byxpath");
        genericStepDefs.setValue(password, "yelo.login.password.field.byxpath");
        genericStepDefs.clickElement("yelo.login.submitlogin.byxpath");
    }

    @Given("^cancel latest booking if exist on yelo$")
    public void cancelBookingIfExistOnYelo() {
        openYeloPage("/Profile/MyBookings");
        //genericStepDefs.clickElement("yelo.pay.mybooking.button.byxpath");
        int i = 0;
        while (new Element("yelo.pay.cancel.button.byxpath").checkElementPresent(ElementStatus.PRESENT, 1) && i < 6) {
            genericStepDefs.clickElement("yelo.pay.cancel.button.byxpath");
            genericStepDefs.clickElement("yelo.pay.confirmCancel.button.byxpath");
            waitForLoadingIconToBeNotPresentStatic("yelo web");
            i++;
        }
        genericPage.waitForElementNotPresent("yelo.pay.cancel.button.byxpath", 2);
        genericStepDefs.clickElement("yelo.homepage.image.icon.byxpath");
    }

    @Given("^cancel latest booking if exist on yelo and booking value stored in: (.*)")
    public void cancelBookingIfExistOnYeloAndDeleteBookingPaymentAttempts(String bookingNumber) {
        openYeloPage("/Profile/MyBookings");
        //genericStepDefs.clickElement("yelo.pay.mybooking.button.byxpath");
        int i = 0;
        while (new Element("yelo.pay.cancel.button.byxpath").checkElementPresent(ElementStatus.PRESENT, 1) && i < 1) {
            if (i == 1) {
                new DatabaseHelper().deletePaymentAttemptsWithReference(ScenarioContextSingleton.getInstance().getContextValue(bookingNumber));
            }
            genericStepDefs.clickElement("yelo.pay.cancel.button.byxpath");
            genericStepDefs.clickElement("yelo.pay.confirmCancel.button.byxpath");
            waitForLoadingIconToBeNotPresentStatic("yelo web");
            i++;
        }
        genericPage.waitForElementNotPresent("yelo.pay.cancel.button.byxpath", 2);
        genericStepDefs.clickElement("yelo.homepage.image.icon.byxpath");
    }

    @Given("^cancel latest booking if exist on yelo by user email: (.*)")
    public void cancelBookingIfExistOnYeloAndByUserEmailAndDeleteBookingPaymentAttempts(String userEmail) {
        if (!DriverFactory.getDriver().url().toLowerCase().contains("/profile/mybookings")) {
            openYeloPage("/profile/MyBookings");
        }

        new DatabaseHelper().deleteRelatedBookings(userEmail.trim());
        new DatabaseHelper().deleteRelatedBookingsFromCustomerRepo(userEmail.trim());
        genericStepDefs.clickElement("yelo.homepage.image.icon.byxpath");
    }

    public String getBaseYeloUrl(String url) {
//        return new RegxHelper().getRegxMatch("^(https?:\\/\\/[a-zA-Z0-9\\-\\.]+(?::\\d+)?(?:\\/[a-zA-Z0-9_\\-]+)*?\\/[a-zA-Z]{2})(?:\\/.*)?$",1,url);
        return ScenarioContextSingleton.getInstance().getContextValue("websiteBaseUrl");
    }

    @Given("^cancel all bookings if exist on yelo sequentially")
    public void cancelBookingIfExistOnYeloManually() {
        if (!DriverFactory.getDriver().url().toLowerCase().contains("/profile/mybookings")) {
            String baseurl = getBaseYeloUrl(DriverFactory.getDriver().url());
            genericStepDefs.navigateToUrl(baseurl + "/profile/myBookings");
        }
        waitForLoadingIconToBeNotPresentStatic("yelo web");
        Element element = new Element("yelo.pay.cancel.button.byxpath");
        int i = 0;
        System.out.println("we are entering cancelling bookings loop");
        while (new Element("yelo.pay.cancel.button.byxpath").checkElementPresent(ElementStatus.PRESENT, 3) && i < 6) {
            System.out.println("we are in cancelling bookings loop: " + i);
            genericStepDefs.clickElement("yelo.pay.cancel.button.byxpath");
            genericStepDefs.waitForSeconds(0.5);
            genericStepDefs.clickElement("yelo.pay.confirmCancel.button.byxpath");
            System.out.println("new Element(\"yelo.pay.cancel.button.byxpath\").checkElementPresent(ElementStatus.PRESENT, 1):" + new Element("yelo.pay.cancel.button.byxpath").checkElementPresent(ElementStatus.PRESENT, 1));
            i++;
            waitForLoadingIconToBeNotPresentStatic("yelo web");
            if (!element.isElementPresentAfterWait(1)) {
                genericStepDefs.reloadPage();
            }

        }
        genericStepDefs.clickElement("yelo.homepage.image.icon.byxpath");
    }


    @Given("^cancel latest bookings if exist on yelo")
    public void cancelLatestBookingIfExistOnYelo() {
        if (!DriverFactory.getDriver().url().toLowerCase().contains("/profile/mybookings")) {
            openYeloPage("/profile/MyBookings");
        }
        List<Locator> bookingsAvailableToCancel = new Element("yelo.pay.cancel.button.byxpath").getWebElements(3);

        if (bookingsAvailableToCancel != null) {
            int bookingsAvailableToCancelSize = bookingsAvailableToCancel.size();
            for (Locator bookingAvailableToCancel : bookingsAvailableToCancel) {
                bookingAvailableToCancel.click();
                genericStepDefs.waitForSeconds(0.5);
                genericStepDefs.clickElement("yelo.pay.confirmCancel.button.byxpath");
                waitForLoadingIconToBeNotPresentStatic("yelo web");
                if (bookingsAvailableToCancelSize == new Element("yelo.pay.cancel.button.byxpath").getWebElements().size()) {
                    Assert.fail("The cancel button is still present after clicking cancel");
                }

            }
        }
        genericStepDefs.clickElement("yelo.homepage.image.icon.byxpath");

    }

    @Given("^cancel latest booking if exist on yelo with assertion$")
    public void cancelLatestBookingIfExistOnYeloManually() {
        cancelLatestBookingIfExistOnYeloManuallyWithPageRefresh(false);
    }

    @Given("^cancel latest booking if exist on yelo with assertion and page refresh$")
    public void cancelLatestBookingIfExistOnYeloManuallyWithPageRefresh() {
        cancelLatestBookingIfExistOnYeloManuallyWithPageRefresh(true);
    }

    public void cancelLatestBookingIfExistOnYeloManuallyWithPageRefresh(boolean refreshPage) {
        if (!DriverFactory.getDriver().url().toLowerCase().contains("/profile/mybookings")) {
            String baseurl = getBaseYeloUrl(DriverFactory.getDriver().url());
            genericStepDefs.navigateToUrl(baseurl + "/profile/MyBookings");
        }
        Element element = new Element("yelo.pay.cancel.button.byxpath");
        System.out.println("we are cancelling the latest booking");

        genericStepDefs.clickElement("yelo.pay.cancel.button.byxpath");
        genericStepDefs.waitForSeconds(0.5);
        genericStepDefs.clickElement("yelo.pay.confirmCancel.button.byxpath");
        waitForLoadingIconToBeNotPresentStatic("yelo web");
        int i = 0;
        while (i < 2 && element.isElementPresentAfterWait(2)) {
            if (refreshPage)
                genericStepDefs.reloadPage();
            i++;
        }
        if (element.isElementPresentAfterWait(2)) {
            Assert.fail("The cancel button is still present after clicking cancel");
        }
        genericStepDefs.clickElement("yelo.homepage.image.icon.byxpath");

    }

    @Given("^select branch in home page in yelo: (.*)$")
    public void selectBranchInYelo(String branchName) {
        branchName = genericStepDefs.getOptionBasedOnLangWithoutTrimFromParamDirectly(branchName).trim();
        genericStepDefs.waitPageToLoad(DocumentStatusRecord.INSTANCE.load());
        genericStepDefs.clickOnActionIfExistStepDef("yelo.dismiss.cookies.dialog.ok.action.byxpath", "1");
        genericStepDefs.clickElement("yelo.homepage.searchLocation.input.byxpath");
        genericStepDefs.sendKeysToElement("yelo.homepage.searchLocation.input.byxpath", branchName, 50);
        Element element = new Element("yelo.homepage.searchLocation.input.byxpath");
        element.sendKeysInElementWithoutClear(" ");
        element.sendKeysInElementKey("Backspace");
        waitForLoadingIconToBeNotPresentStatic("yelo web");
        genericStepDefs.clickElementWithXpath("yelo.branch.name.inbranchlist.byxpath", "(//li[contains(@class,\"branch-station\") and  (contains(@data-name,'" + branchName + "'))])[1]");
    }

    @Then("^user set date in yelo date field: (.*) plus days: (.*)$")
    public void selectDateInYeloCalendarStepDefs(String elementName, int days) {
        genericStepDefs.selectDateInCalendarFieldForYelo(elementName, days, 0, "MM-dd-YYYY");
    }

    @Then("^user set time in yelo time field: (.*) plus minutes: (.*)$")
    public void selectTimeInYeloCalendarStepDefs(String elementName, int minutes) {
        genericStepDefs.selectTimeInCalendarFieldForYelo(elementName, 0, minutes, "hh:mm a");
    }

    @Then("^user set date time in yelo pickup field plus days: (.*) and time: (.*)$")
    public void setDateTimeInYeloPickupStepDefs(int days, String time) {
        genericStepDefs.scrollByPixcelsMethod(0, -300);
        genericStepDefs.selectDateInCalendarFieldForYelo("yelo.homepage.pickup.date.hidden.byxpath", "yelo.homepage.pickup.date.activeday.byxpath", days, 0, "MMM/dd/yyyy");
        genericStepDefs.setTimeInCalendarFieldForYelo("yelo.homepage.pickup.time.byxpath", time);
    }

    @Then("^user set date time in yelo return field plus days: (.*) and time: (.*)$")
    public void setDateTimeInYeloReturnStepDefs(int days, String time) {
        genericStepDefs.selectDateInCalendarFieldForYelo("yelo.homepage.return.date.hidden.byxpath", "yelo.homepage.return.date.activeday.byxpath", days, 0, "MMM/dd/yyyy");
        genericStepDefs.setTimeInCalendarFieldForYelo("yelo.homepage.return.time.byxpath", time);
    }

    @Then("^user set date time V2 in yelo pickup field plus days: (.*) and time: (.*)$")
    public void setDateTimeInYeloPickupStepDefsV2(int days, String time) {
        genericStepDefs.scrollByPixcelsMethod(0, -300);
        String currentProjectUrl =  ScenarioContextSingleton.getInstance().getContextValue("websiteBaseUrl");
         if (currentProjectUrl.toLowerCase().contains("yelo")) {
            genericStepDefs.selectDateInCalendarFieldForYeloV2("yelo.homepage.newPickupDate.div.byxpath", days, 0, "d/MMM/yyyy");
            genericStepDefs.setTimeInCalendarFieldForYeloV2("yelo.pickup.time.byxpath", time, false);
            genericStepDefs.clickElement("yelo.homepage.applyDates.button.byxpath");
        } else {
            genericStepDefs.selectDateInCalendarFieldForSaas("yelo.homepage.pickup.date.hidden.byxpath", days, 0, "d/MMM/yyyy", true);
            genericStepDefs.setTimeInCalendarFieldForSaas(time, true);
        }
    }

    @Then("^user set date time V2 in yelo return field plus days: (.*) and time: (.*)$")
    public void setDateTimeInYeloReturnStepDefsV2(int days, String time) {
        genericStepDefs.scrollByPixcelsMethod(0, -300);
        String currentProjectUrl =  ScenarioContextSingleton.getInstance().getContextValue("websiteBaseUrl");
        if (currentProjectUrl.toLowerCase().contains("yelo")) {
            genericStepDefs.selectDateInCalendarFieldForYeloV2("yelo.homepage.newReturnDate.div.byxpath", days, 0, "d/MMM/yyyy");
            genericStepDefs.setTimeInCalendarFieldForYeloV2("yelo.return.time.byxpath", time, true);
            genericStepDefs.clickElement("yelo.homepage.applyDates.button.byxpath");
        } else {
            genericStepDefs.selectDateInCalendarFieldForSaas("yelo.homepage.pickup.date.hidden.byxpath", days, 0, "d/MMM/yyyy", false);
            genericStepDefs.setTimeInCalendarFieldForSaas(time, false);
            genericStepDefs.clickElement("saas.homepage.applyDates.button.byxpath");
        }
    }


    @Then("^fill credit card info in yelo fill name: (.*) and card number: (.*) and ccv: (.*) and expire date: (.*)$")
    public void setDateTimeInYeloReturnStepDefs(String name, String cardNumber, String ccv, String expireDate) {
        new Element("yelo.booking.error.byxpath").waitForElementNotPresent(3);
        genericStepDefs.waitForSeconds(1);
        genericPage.clickElement("yalo.payment.paynowinpaymentoptiondialog.byxpath");
        genericStepDefs.setValue(name, "yelo.pay.card_holder_name.field.byxpath");
        genericStepDefs.setValue(cardNumber, "yelo.pay.txtCardNumber.field.byxpath");
        genericStepDefs.setValue(ccv, "yelo.pay.card_security_code.field.byxpath");
        Element element = new Element("yelo.pay.expiry_date_tmp.field.byxpath");
        String id = element.getWebElement().getAttribute("id");
        if (id != null) element.executeJsQuery("document.getElementById('" + id + "').removeAttribute('readonly')");
        genericStepDefs.setValue(expireDate, "yelo.pay.expiry_date_tmp.field.byxpath");
        element.sendKeysInElementKey("Enter");
        ScenarioContextSingleton.getInstance().setContextValue("paymentPageRetnalTotal", new Element("yelo.payment.total.byxpath").getWebElement().innerText().replaceAll("(?!([+-]?([0-9]*[.])?[0-9]+)).", "").trim());
    }

    @Then("^delete the created booking from the database$")
    public void deleteBookingRecordFromDatabase() {
//        new DatabaseHelper().deleteBookingWithReference(ScenarioContextSingleton.getInstance().getContextValue("bookingId"));
        new DatabaseHelper().deletePaymentAttemptsWithReference(ScenarioContextSingleton.getInstance().getContextValue("bookingId"));

    }

    @Then("store the booking total from element: (.*)")
    public void storeBookingValueElementValue(String elementName) {
        String bookingTotal = new Element(elementName).getWebElement().innerText();
        ScenarioContextSingleton.getInstance().setContextValue("bookingTotal", bookingTotal);
    }

    @Then("store element value: (.*) and value name: (.*) and keep number only: (.*)$")
    public void storeElementsValue(String elementName, String valueName, boolean numberOnly) {
        String value = new Element(elementName).getWebElement().innerText();
        if (numberOnly) value = value.replaceAll("(?!([+-]?([0-9]*[.])?[0-9]+)).", "").trim();
        ScenarioContextSingleton.getInstance().setContextValue(valueName, value.trim());
    }

    @Then("store element value: (.*) value name: (.*) text only: (.*) and remove new line: (.*)$")
    public void storeElementsValue(String elementName, String valueName, boolean textOnly, boolean newLine) {
        String value = new Element(elementName).getWebElement().innerText();
        if (textOnly) value = value.replaceAll("[^\\p{L}]", "").trim();
        if (newLine) value = value.replaceAll("\\n", "");
        ScenarioContextSingleton.getInstance().setContextValue(valueName, value.trim());
    }

    @Then("store element attribute value: (.*) and value name: (.*) and keep number only: (.*)$")
    public void storeElementsValueAttribute(String elementName, String valueName, boolean numberOnly) {
        String value = new Element(elementName).getWebElement().getAttribute("value");
        if (numberOnly) value = value.replaceAll("(?!([+-]?([0-9]*[.])?[0-9]+)).", "").trim();
        ScenarioContextSingleton.getInstance().setContextValue(valueName, value);
    }

    @Then("store element attribute id: (.*) and value name: (.*) and keep number only: (.*)$")
    public void storeElementsIdAttribute(String elementName, String valueName, boolean numberOnly) {
        String value = new Element(elementName).getWebElement().getAttribute("id");
        if (numberOnly) value = value.replaceAll("(?!([+-]?([0-9]*[.])?[0-9]+)).", "").trim();
        ScenarioContextSingleton.getInstance().setContextValue(valueName, value);
    }

    @Then("verify two values are equal, first value: (.*) second value: (.*) param type: (.*)$")
    public void compareTwoValues(String firstValue, String secondValue, String paramType) {
        System.out.println("we are comparing values, the first value is: " + ScenarioContextSingleton.getInstance().getContextValue(firstValue) + " , and the second value is: " + ScenarioContextSingleton.getInstance().getContextValue(secondValue));
        switch (paramType.toLowerCase()) {
            case "integer":
                Assert.assertEquals("The first value: " + firstValue + " , didn't match the second value: " + secondValue, Integer.parseInt(ScenarioContextSingleton.getInstance().getContextValue(firstValue)), Integer.parseInt(ScenarioContextSingleton.getInstance().getContextValue(secondValue)));
                break;
            case "decimal":
                Assert.assertEquals("The first value: " + firstValue + " , didn't match the second value: " + secondValue, Double.parseDouble(ScenarioContextSingleton.getInstance().getContextValue(firstValue)), Double.parseDouble(ScenarioContextSingleton.getInstance().getContextValue(secondValue)), 0.1);
                break;
            case "string":
                Assert.assertEquals("The first value: " + firstValue + " , didn't match the second value: " + secondValue, ScenarioContextSingleton.getInstance().getContextValue(firstValue).toLowerCase(Locale.ROOT).trim(), ScenarioContextSingleton.getInstance().getContextValue(secondValue).toLowerCase(Locale.ROOT).trim());
                break;
        }
    }

    @Then("verify two values are equal after operation, first value: (.*) second value: (.*) param type: (.*) and operation on second value: (.*) by value: (.*)$")
    public void doOperationOnValues(String firstValue, String secondValue, String paramType, String operationType, String operationFactor) {

        switch (operationType) {
            case "multiple":
                ScenarioContextSingleton.getInstance().setContextValue(secondValue, String.valueOf(Double.parseDouble(ScenarioContextSingleton.getInstance().getContextValue(secondValue)) * Double.parseDouble(operationFactor)));
                break;
            case "divide":
                ScenarioContextSingleton.getInstance().setContextValue(secondValue, String.valueOf(Double.parseDouble(ScenarioContextSingleton.getInstance().getContextValue(secondValue)) / Double.parseDouble(operationFactor)));
                break;
        }
        compareTwoValues(firstValue, secondValue, paramType);
    }

    @Then("verify yelo booking confirmation page$")
    public void verifyBookingConfirmationPage() {
        waitForLoadingIconToBeNotPresentStatic("yelo web");
        genericStepDefs.clickOnActionIfExistStepDef("yelo.insurance.deposit.message.byxpath", "2");
        genericStepDefs.toVerifyElementPresent("yelo.booking.confirmation.id.byxpath");
        genericStepDefs.toVerifyElementPresent("yelo.booking.booking-pickup-info.byxpath");
        genericStepDefs.toVerifyElementPresent("yelo.booking.booking-dropoff-info.byxpath");
        genericStepDefs.toVerifyElementPresent("yelo.booking.booking-step-header.byxpath");
        genericStepDefs.verifyTextPresentOnPageStepDef("yelo.register.booking-step-header.text");
        genericStepDefs.toVerifyElementPresent("yelo.booking.booking-confirmation-info.byxpath");
        genericStepDefs.toVerifyElementPresent("yelo.booking.booking-reference.byxpath");
        genericStepDefs.toVerifyElementPresent("yelo.booking.car-details.byxpath");
        genericStepDefs.toVerifyElementPresent("yelo.booking.row-TotalRent.byxpath");
        genericStepDefs.toVerifyElementPresent("yelo.booking.booking-confirmation.byxpath");
        genericStepDefs.toVerifyElementPresent("yelo.booking.booking-confirmation-amyali-box.byxpath");
        genericStepDefs.toVerifyElementPresent("yelo.booking.confirmation-assistance.byxpath");
        genericStepDefs.toVerifyElementPresent("yelo.booking.membership.byxpath");
        genericStepDefs.toVerifyElementPresent("yelo.booking.contact.byxpath");
        genericStepDefs.toVerifyElementPresent("yelo.booking.booking-confirmation-questions.byxpath");
        genericStepDefs.toVerifyElementPresent("yelo.booking.booking-confirmation-Disclaimer.byxpath");
        genericStepDefs.toVerifyElementPresent("yelo.booking.booking-step.byxpath");
        genericStepDefs.verifyTextPresentOnPageStepDef("yelo.register.thank-u-message.text");
//        genericStepDefs.verifyTextPresentOnPageStepDef("yelo.register.thank-u-message1.text");
//        genericStepDefs.verifyTextPresentOnPageStepDef("yelo.register.amyali-membership.text");
//        genericStepDefs.verifyTextPresentOnPageStepDef("yelo.register.need-assistance.text");
//        genericStepDefs.verifyTextPresentOnPageStepDef("yelo.register.message1.text");
//        genericStepDefs.verifyTextPresentOnPageStepDef("yelo.register.message2.text");
//        genericStepDefs.verifyTextPresentOnPageStepDef("yelo.register.questions.text");
//        genericStepDefs.verifyTextPresentOnPageStepDef("yelo.register.message3.text");
//        genericStepDefs.verifyTextPresentOnPageStepDef("yelo.register.disclaimer.text");
//        genericStepDefs.verifyTextPresentOnPageStepDef("yelo.register.message4.text");
        genericStepDefs.waitForSeconds(3);
    }

    @Then("^close the yelo cookies dialog$")
    public void closeYeloCookiesDialog() {
        genericPage.clickOnActionIfExist("yelo.cookies.dialog.ok.action.byxpath");
    }

    @Then("^verify booking email data, check booking id match: (.*) and rental total: (.*) for email: (.*) and password: (.*)$")
    public void verifyBookingEmailDataMethod(String bookingId, String rentalTotal, String email, String password) {
        genericPage.verifyEmailBookingId(bookingId, email, password);
        genericPage.verifyEmailBookingRentalTotal(rentalTotal, email, password);
    }

    @Then("^verify number of bookings in my booking page: (.*)$")
    public void ValidateCountOfActiveBookingsMethod(int count) {
        if (!DriverFactory.getDriver().url().toLowerCase().contains("/profile/mybookings")) {
            String baseurl = getBaseYeloUrl(DriverFactory.getDriver().url());
            genericStepDefs.navigateToUrl(baseurl +"/profile/myBookings");
        }
        genericPage.ValidateCountOfElements(count, "yelo.pay.cancelAll.button.byxpath");
    }

    @Then("^user: (.*) with password: (.*) placed pay later booking on branch: (.*) and pickup day: (.*) and time: (.*) and return day: (.*) and time: (.*)$")
    public void placePlayLaterBookingMethod(String email, String password, String branchName, int pickupDay, String pickupTime, int returnDay, String returnTime) {
        loginToYeloSite(email, password);
        placePlayLaterBookingMethod(branchName, pickupDay, pickupTime, returnDay, returnTime);
    }

    @Then("^place pay later booking on branch: (.*) and pickup day: (.*) and time: (.*) and return day: (.*) and time: (.*)$")
    public void placePlayLaterBookingMethod(String branchName, int pickupDay, String pickupTime, int returnDay, String returnTime) {
        genericStepDefs.clickElement("yelo.header.yelo-logo.byxpath");
        genericStepDefs.scrollToTheTop();
        genericStepDefs.clickElement("yelo.homepage.searchLocation.input.byxpath");
        selectBranchInYelo(branchName);
        setDateTimeInYeloPickupStepDefsV2(pickupDay, pickupTime);
        setDateTimeInYeloReturnStepDefsV2(returnDay, returnTime);
        genericStepDefs.scrollToElementMethod("yelo.homepage.vehicle.search.button.byxpath");
        genericStepDefs.clickElement("yelo.homepage.vehicle.search.button.byxpath");
        storeElementsValue("yelo.pay.firstCarModelName.p.byxpath","carModalName",false);
        genericStepDefs.clickElement("yelo.pay.book-now.button.byxpath");
        genericStepDefs.clickOnActionIfExist("yelo.pay.confirm.button.byxpath");
        genericStepDefs.scrollByPixcelsMethod(0, -800);
        genericStepDefs.clickElement("yelo.pay.paylater.button.byxpath");
        genericStepDefs.clickElement("yelo.pay.confirmpaytype.byxpath");
        genericStepDefs.clickElement("yelo.pay.agreebookingconditions.button.byxpath");
        genericStepDefs.waitForSeconds(1);
        genericStepDefs.clickElement("yelo.pay.SaveBooking.button.byxpath");
    }

    @Then("^place pay now booking on branch: (.*) and pickup day: (.*) and time: (.*) and return day: (.*) and time: (.*) and credit card name: (.*) and credit card number: (.*) and credit card ccv: (.*) and credit card expiry date: (.*)$")
    public void placePlayNowBookingMethod(String branchName, int pickupDay, String pickupTime, int returnDay, String returnTime, String creditCardName, String creditCardNumber, String creditCardCCV, String creditCardExpiryDate) {
        genericStepDefs.clickElement("yelo.header.yelo-logo.byxpath");
        genericStepDefs.selectDateInCalendarFieldForYelo("yelo.homepage.pickup.date.hidden.byxpath", "yelo.homepage.pickup.date.activeday.byxpath", pickupDay, 0, "MMM/dd/yyyy");
        genericStepDefs.setTimeInCalendarFieldForYelo("yelo.homepage.pickup.time.byxpath", pickupTime);
        genericStepDefs.selectDateInCalendarFieldForYelo("yelo.homepage.return.date.hidden.byxpath", "yelo.homepage.return.date.activeday.byxpath", returnDay, 0, "MMM/dd/yyyy");
        genericStepDefs.setTimeInCalendarFieldForYelo("yelo.homepage.return.time.byxpath", returnTime);
        genericStepDefs.clickElement("yelo.homepage.searchLocation.input.byxpath");
        selectBranchInYelo(branchName);
        genericStepDefs.clickElement("yelo.homepage.vehicle.search.button.byxpath");
        storeElementsValue("yelo.pay.oldPrice.div.byxpath", "BookingPrice", true);
        genericStepDefs.clickElement("yelo.pay.book-now.button.byxpath");
        genericStepDefs.clickOnActionIfExist("yelo.pay.confirm.button.byxpath");
        genericStepDefs.scrollByPixcelsMethod(0, -800);
        genericStepDefs.clickElement("yelo.pay.paylnow.button.byxpath");
        genericStepDefs.clickElement("yelo.pay.confirmpaytype.byxpath");
        genericStepDefs.clickElement("yelo.pay.agreebookingconditions.button.byxpath");
        genericStepDefs.clickElement("yelo.pay.SaveBooking.button.byxpath");
        genericStepDefs.clickElement("yalo.payment.selectcreditcardoption.byxpath");
        setDateTimeInYeloReturnStepDefs(creditCardName, creditCardNumber, creditCardCCV, creditCardExpiryDate);
        genericStepDefs.clickElement("yelo.pay.SubmitPayment.button.byxpath");
        genericStepDefs.waitForElementToBePresent("yelo.gateway.iframe.byxpath");
        genericStepDefs.changeIframe("challengeFrame");
        genericStepDefs.clickElement("yelo.paymentgatewaysubmit.button.byxpath");
        genericStepDefs.verifyElementTextPresentMethod("yelo.payment-common.error.byxpath", "yelo.payment-success-message.text");
        genericStepDefs.clickElement("yelo.pay.GetBookingContentView.button.byxpath");
        storeElementsValue("yelo.booking.confirmation.id.byxpath", "BookingNumberInConfirmationTabWithText", false);
        genericStepDefs.clickElement("yelo.header.yelo-logo.byxpath");
    }

    @Given("^switch page currency to: (.*)$")
    public void switchPageCurrency(String currencyName) {
        new Element("yelo.header.currencyArrow.img.byxpath").clickElement();
        List<Locator> currencyElements = new Element("currencies.byxpath", "//input[contains(@data-action,'changeCurrency')]/parent::li//label[contains(@class,'float-normal')]").getChildWebElementFromElement(ElementStatus.PRESENT);
        System.out.println("currencyElements elements saved from popup " + currencyElements.toString());
        List<String> currenciesNames = currencyElements.stream().map(Locator::innerText).collect(Collectors.toList());
        if (ScenarioContextSingleton.getInstance().getContextValue("CurrenciesNames") == null)
            ScenarioContextSingleton.getInstance().setContextValue("CurrenciesNames", String.join(",", currenciesNames));
        currencyName = genericStepDefs.getOptionBasedOnLangWithoutTrimFromParamDirectly(currencyName);
        genericStepDefs.clickOnCurrency(currencyName);
    }

    @Given("^verify page currency : (.*) exists in page and other currencies are not exist$")
    public void verifyPageCurrency(String currencyName) {

        currencyName = genericStepDefs.getOptionBasedOnLangWithoutTrimFromParamDirectly(currencyName);
        String currenciesNames = ScenarioContextSingleton.getInstance().getContextValue("CurrenciesNames").trim();
        System.out.println("currencyElements elements after getting from context in method verifyPageCurrency " + currenciesNames);
        genericStepDefs.verifyTextPresentOnPageStepDef(currencyName);
        for (String cn : currenciesNames.split(",")) {
            cn = cn.trim();
            if (!currencyName.trim().equals(cn)) {
                System.out.println("current switched to:" + currencyName + " ,currency to check not present is: " + cn);
                new Element("current.currency.to.check.byxpath", "//div//*[not(ancestor::ul[contains(@class,'currency-dropdown-menu')]) and not(descendant::script) and not(local-name()='script') and not(descendant::ul[contains(@class,'currency-dropdown-menu')]) and not(local-name()='ul') and not(contains(., '\u20C1')) and contains(.,'" + cn + "')]").waitForElementNotPresent(15);
            }
        }
    }

    @Given("^switch and verify page currency to: (.*)$")
    public void switchAndVerifyPageCurrency(String currencyName) {
        currencyName = genericStepDefs.getOptionBasedOnLangWithoutTrimFromParamDirectly(currencyName);

        cancelBookingIfExistOnYelo();
        switchPageCurrency(currencyName);
        setDateTimeInYeloPickupStepDefs(1, "01:30 pm");
        setDateTimeInYeloReturnStepDefs(2, "01:30 pm");
        selectBranchInYelo("Abha Airport,مطار ابها");
        genericStepDefs.clickOnLink("yelo.homepage.search.button.byxpath");
        verifyPageCurrency(currencyName);
        genericStepDefs.clickOnLink("yelo.pay.book-now.button.byxpath");
        genericStepDefs.clickOnActionIfExistStepDef("yelo.pay.confirm.button.byxpath");
        verifyPageCurrency(currencyName);
        genericStepDefs.clickOnLink("yelo.pay.paylater.button.byxpath");
        genericStepDefs.clickOnLink("yelo.pay.confirmpaytype.byxpath");
        verifyPageCurrency(currencyName);
        genericStepDefs.clickOnLink("yelo.pay.agreebookingconditions.button.byxpath");
        genericStepDefs.clickOnLink("yelo.pay.SaveBooking.button.byxpath");
        verifyPageCurrency(currencyName);
    }

    @Then("^click on forget password link for email: (.*) and password: (.*)$")
    public void clickOnForgetPasswordlink(String email, String password) {
        genericPage.clickOnForgetPasswordlink(email, password);
    }
    @And("click on yelo action with xpath: (.*) with replacing variable with stored value: (.*)$")
    public void clickOnActionXpathWithVariable(String xpathToCLick, String variableName) {
        genericStepDefs.clickOnActionXpathWithVariableMethod(xpathToCLick, ScenarioContextSingleton.getInstance().getContextValue(variableName));
    }

    @Then("^Validate refund amount after cancel by email: (.*) and password: (.*)$")
    public void validateRefundAmountAfterCancel(String email, String password) {
        String expectedRefundAmount = ScenarioContextSingleton.getInstance().getContextValue("myBookingsRentalValue");
        genericPage.ValidateRefundAmountAfterCancel(expectedRefundAmount, email, password);
    }

    @Then("^select extras: (.*)$")
    public void selectExtrasMethod(int extrasCount) {
        genericPage.selectExtras(extrasCount);
    }

    @Then("^validate array of elements is selected: (.*) count: (.*)$")
    public void validateElementIsSelected(String elementName, int count) {
        for (int i = 1; i <= count; i++) {
            String elementXpath = PropManager.getInstance().getProperty(elementName) + "[" + i + "]";
            Assert.assertTrue("The element with xpath: " + elementXpath + " ,was expected to be selected and it was not! ", "true".equalsIgnoreCase(new Element("yelo.pay.element.input.byxpath", elementXpath).getWebElement(ElementStatus.PRESENT).getAttribute("checked")));
        }
    }

    @Then("^register new user using temp email with password:: (.*)$")
    public void RegisterNewUser(String password) {
        openYeloPage("/Home");
        genericStepDefs.clickOnLink("yelo.register.button.byxpath");
        genericStepDefs.setValueInField("yelo.register.firstName.field.byxpath", "Eyad");
        genericStepDefs.setValueInField("yelo.register.lastName.field.byxpath", "Sawafteh");
        genericStepDefs.openOtherBrowserTabMethod("https://cryptogmail.com/");
        genericStepDefs.switchToBrowserTab(1);
        storeElementsValue("yelo.register.tempMail.input.byxpath", "email", false);
        genericStepDefs.switchToBrowserTab(0);
        genericStepDefs.setValueIntoElementByContextKeyMethod("yelo.register.email.field.byxpath", "email");
        genericStepDefs.setValueInField("yelo.register.mobile.field.byxpath", "516754786");
        genericStepDefs.setValueInField("yelo.register.Password.field.byxpath", password);
        genericStepDefs.clickOnLink("yelo.acceptTermsConditions.label.byxpath");
        genericStepDefs.removeAttribute("yelo.register.submit.button.id", "disabled");
        genericStepDefs.clickOnLink("yelo.register.registration.button.byxpath");
        genericStepDefs.switchToBrowserTab(1);
        genericStepDefs.waitForElementPresentHere("yelo.register.activationCode.email.a.byxpath", 500);
        genericStepDefs.scrollToElementMethod("yelo.register.activationCode.email.a.byxpath");
        genericStepDefs.clickOnElementMethod("yelo.register.activationCode.email.a.byxpath");
        storeElementsValue("yelo.register.activationCode.b.byxpath", "activationCode", true);
        genericStepDefs.switchToBrowserTab(0);
        genericStepDefs.setValueIntoElementByContextKeyMethod("yelo.register.verifyCodePart.input.byxpath", "activationCode");
        genericStepDefs.clickOnElementMethod("yelo.register.continue.button.byxpath");
        genericStepDefs.clickOnElementMethod("yelo.register.SaudiResident.a.byxpath");
        genericPage.clickOnActionIfExist("yelo.cookies.dialog.ok.action.byxpath");
        clickOnMinimizeChatWindow();
    }

    @Then("^save higher price vehicles: (.*) then click on: (.*) with count: (.*)$")
    public void SelectAndSaveHigherPriceVehicles(String priceElementName, String elementNameToClickOn, int elementsToClickOnCount) {
        List<Locator> pricesElements = new Element(priceElementName).getChildWebElementFromElement(ElementStatus.PRESENT);
        double firstPrice = Double.parseDouble(pricesElements.get(0).innerText().replaceAll("(?!([+-]?([0-9]*[.])?[0-9]+)).", "").trim());
        List<Double> selectedPrices = new ArrayList<>();

        for (int i = 1; i < pricesElements.size(); i++) {
            double elementPrice = Double.parseDouble(pricesElements.get(i).innerText().replaceAll("(?!([+-]?([0-9]*[.])?[0-9]+)).", "").trim());
            if (elementPrice > firstPrice) {
                selectedPrices.add(elementPrice);
                String elementXpath = PropManager.getInstance().getProperty(elementNameToClickOn) + "[" + (i + 1) + "]";
                new Element("yelo.search.elementToClickOnItem.byxpath", elementXpath).clickElement();
            }
            if (selectedPrices.size() == elementsToClickOnCount) break;
        }

        ScenarioContextSingleton.getInstance().setContextValue("SelectedPrices", selectedPrices.stream().map(Object::toString).collect(Collectors.joining(", ")));
    }

    @Then("^validate higher price vehicles displayed: (.*)$")
    public void ValidateHigherPriceVehiclesDisplayed(String elementName) {
        List<Locator> priceElements = new Element(elementName).getChildWebElementFromElement(ElementStatus.VISIBLE);
        String[] selectedPrices = ScenarioContextSingleton.getInstance().getContextValue("SelectedPrices").trim().split(",");

        for (int i = 0; i < priceElements.size(); i++) {
            double price = Double.parseDouble(priceElements.get(i).innerText().replaceAll("(?!([+-]?([0-9]*[.])?[0-9]+)).", "").trim());
            Assert.assertEquals(price, Double.parseDouble(selectedPrices[i]), 0);
        }
    }

    @Then("^save for later$")
    public void SaveForLater() {
        genericStepDefs.scrollByPixcelsMethod(0, -900);
        genericStepDefs.changeBrowserWindowZoomLevel(0.4);
        storeElementsIdAttribute("yelo.search.firstSaveForLater.byxpath", "SaveForLaterId", false);
        genericPage.clickElement("yelo.search.firstSaveForLater.byxpath");
        genericPage.clickElement("yelo.search.saveForLaterBtn.byxpath");

        List<Locator> elements = new Element("yelo.search.saveForLater.byxpath").getChildWebElementFromElement(ElementStatus.VISIBLE);

        Assert.assertEquals(elements.size(), 1);

        String id = elements.get(0).getAttribute("id");
        String expectedId = ScenarioContextSingleton.getInstance().getContextValue("SaveForLaterId");

        Assert.assertEquals(id, expectedId);
    }

    @Then("^validate list of elements: (.*) with text: (.*)$")
    public void validateListOfElementsText(String elementName, String textToVerifyProperty) {
        genericPage.validateListOfElementsText(elementName, textToVerifyProperty);
    }

    @Then("^validate new amount after discount: (.*)$")
    public void validateNewNetAmount(double discountPercentage) {

        double oldNetAmount = Double.parseDouble(ScenarioContextSingleton.getInstance().getContextValue("OldNetAmount"));

        double expectedNewNetAmount = oldNetAmount - ((discountPercentage / 100) * oldNetAmount);
        expectedNewNetAmount = Precision.round(expectedNewNetAmount, 1);

        double newNetAmount = Double.parseDouble(ScenarioContextSingleton.getInstance().getContextValue("NewNetAmount"));
        newNetAmount = Precision.round(newNetAmount, 1);

        Assert.assertEquals(newNetAmount, expectedNewNetAmount, 0);
    }

    @Then("^enter promo code from variable: (.*) in field: (.*) and apply button: (.*)$")
    public void enterAndApplyPromoCode(String variable,String promoCodeField,String applyButton){
        String value = ScenarioContextSingleton.getInstance().getContextValue(variable);
        Element element = new Element(promoCodeField);
        genericStepDefs.setValueIntoElement_V2(value,promoCodeField);
        element.sendKeysInElementWithoutClear(" ");
        element.sendKeysInElementKey("Backspace");
        genericPage.clickElement(applyButton);
    }

    @Then("^validate new discount$")
    public void validateNewDiscount() {

        double totalAmount = Double.parseDouble(ScenarioContextSingleton.getInstance().getContextValue("TotalAmount"));

        double newNetAmount = Double.parseDouble(ScenarioContextSingleton.getInstance().getContextValue("NewNetAmount"));

        double totalDifferenceAmount = totalAmount - newNetAmount;

        double expectedNewDiscount = (totalDifferenceAmount / totalAmount) * 100;
        expectedNewDiscount = Precision.round(expectedNewDiscount, 1);

        double newDiscount = Double.parseDouble(ScenarioContextSingleton.getInstance().getContextValue("NewDiscount"));
        newDiscount = Precision.round(newDiscount, 1);

        Assert.assertEquals(newDiscount, expectedNewDiscount, 0);
    }

    @Given("^Run automated rental agent script$")
    public void runAutomatedRenatAgent2() {
        Map<String, String> executionVariables = getExecutionVariables();
        setExecutionEnvironmentVariablesForScript(executionVariables);
        System.out.println("Eyad started running automated rental, and script name is: " + executionVariables.get("scriptName") + " ,and results will be created in the following path: " + executionVariables.get("rentalAgentTempFolderPath"));
        String[] commands = {"CD\\", "D:", "CD apache-jmeter-5.6.3\\bin", "jmeter -n -t \"" + executionVariables.get("scriptToRunPath") + "\" -l \"" + executionVariables.get("rentalAgentTempFolderPath") + "\\Rental Automated Regression Test Results.csv\" -e -o \"" + executionVariables.get("rentalAgentTempFolderPath") + "\" ", "CCD\\", "exit"};
        System.out.println("The commands value is: " + Arrays.toString(commands));
        executeMultipleCommandLines(commands);
    }

    public void setExecutionEnvironmentVariablesForScript(Map<String, String> executionVariables) {
        String rentalAgentFileString = FileHandler.readFile(new File(Paths.get(executionVariables.get("scriptToRunPath")).toUri()));
        rentalAgentFileString = rentalAgentFileString.replaceAll("<elementProp name=\"ejarApiHost\" elementType=\"Argument\">\\n*\\s*<stringProp name=\"Argument.name\">ejarApiHost<\\/stringProp>\\n*\\s*<stringProp name=\"Argument.value\">(.*?)</stringProp>", "<elementProp name=\"ejarApiHost\" elementType=\"Argument\">\n           <stringProp name=\"Argument.name\">ejarApiHost<\\/stringProp>\n            <stringProp name=\"Argument.value\">" + executionVariables.get("environmentHost") + "</stringProp>");
        rentalAgentFileString = rentalAgentFileString.replaceAll("<elementProp name=\"ejarApiPort\" elementType=\"Argument\">\\n*\\s*<stringProp name=\"Argument.name\">ejarApiPort<\\/stringProp>\\n*\\s*<stringProp name=\"Argument.value\">(.*?)</stringProp>", "<elementProp name=\"ejarApiPort\" elementType=\"Argument\">\n           <stringProp name=\"Argument.name\">ejarApiPort<\\/stringProp>\n            <stringProp name=\"Argument.value\">" + executionVariables.get("environmentHostApi") + "</stringProp>");
        rentalAgentFileString = rentalAgentFileString.replaceAll("<elementProp name=\"tenantName\" elementType=\"Argument\">\\n*\\s*<stringProp name=\"Argument.name\">tenantName<\\/stringProp>\\n*\\s*<stringProp name=\"Argument.value\">(.*?)</stringProp>", "<elementProp name=\"tenantName\" elementType=\"Argument\">\n           <stringProp name=\"Argument.name\">tenantName<\\/stringProp>\n            <stringProp name=\"Argument.value\">" + executionVariables.get("tenantName") + "</stringProp>");
        rentalAgentFileString = rentalAgentFileString.replaceAll("<elementProp name=\"isSAAS\" elementType=\"Argument\">\\n*\\s*<stringProp name=\"Argument.name\">isSAAS<\\/stringProp>\\n*\\s*<stringProp name=\"Argument.value\">(.*?)</stringProp>", "<elementProp name=\"isSAAS\" elementType=\"Argument\">\n           <stringProp name=\"Argument.name\">isSAAS<\\/stringProp>\n            <stringProp name=\"Argument.value\">" + executionVariables.get("isSaas") + "</stringProp>");
        rentalAgentFileString = rentalAgentFileString.replaceAll("<elementProp name=\"httpProtocol\" elementType=\"Argument\">\\n*\\s*<stringProp name=\"Argument.name\">httpProtocol<\\/stringProp>\\n*\\s*<stringProp name=\"Argument.value\">(.*?)</stringProp>", "<elementProp name=\"httpProtocol\" elementType=\"Argument\">\n           <stringProp name=\"Argument.name\">httpProtocol<\\/stringProp>\n            <stringProp name=\"Argument.value\">" + (executionVariables.get("isHttpSecure").equals("true") ? "https" : "http") + "</stringProp>");

        try {
            Files.writeString(Paths.get(executionVariables.get("scriptToRunPath")), rentalAgentFileString);
        } catch (IOException e) {
            System.out.println("writing on the script files has been failed:" + executionVariables.get("scriptPathToRun"));
            throw new RuntimeException(e);
        }
    }

    @Then("^change zoom level: (.*)$")
    public void changeZoomLevel(double zoom) {
        genericStepDefs.waitForSeconds(1);
        genericPage.changeBrowserWindowZoomLevel(zoom);
    }

    @Then("^navigate if the element: (.*) is not present to: (.*)$")
    public void refreshIfElementIsNotPresent(String loc, String url) {
        Element element = new Element(loc);
        for (int i = 0; i < 6; i++) {
            if (!element.isElementPresentAfterWait(5)) {
                openYeloPage(url);
            }

        }
    }

    @Then("^verify if current date equals date on element: (.*) in inquiry page$")
    public void  assertDateEqualsCurrentDateInquiry(String element) {
        assertElementTextEqualsDate(element, new Date(), "EEEE, MMMM d 'at' hh a");
    }

    public void assertElementTextEqualsDate(String element, Date dateToCompare, String pattern) {
        Element actualElement = new Element(element);
        String actualTextFromUI = actualElement.getWebElement().innerText().strip();
        String expected = DateHelper.getDateInFormat(dateToCompare, pattern);
        Assert.assertEquals(actualTextFromUI, expected);
        System.out.println("Actual date: "+actualTextFromUI+", Expected Date" + expected);
    }

}