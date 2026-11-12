package stepdefs.generic;

import automation.framework.ApiAutomation.ApiClient;
import automation.framework.ApiAutomation.VehicleOperationsApi;
import automation.framework.Element;
import automation.framework.ScenarioContextSingleton;
import automation.framework.business.StringHelper;
import automation.framework.propmanager.PropManager;
import automation.framework.threadData.DriverFactory;
import com.microsoft.playwright.Locator;
import com.microsoft.playwright.Page;
import com.microsoft.playwright.PlaywrightException;
import com.microsoft.playwright.options.WaitUntilState;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import org.junit.Assert;
import com.microsoft.playwright.ConsoleMessage;
import stepdefs.ejar.web.EjarPages;
import com.microsoft.playwright.Request;
import java.util.ArrayList;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import io.cucumber.java.After;

import static automation.framework.Element.waitForLoadingIconToBeNotPresentStatic;

public class GenericStepDefs extends GenericPage {

    ThreadLocal<String> formName = new ThreadLocal<>();
    EjarPages ejarPages = new EjarPages();
    ApiClient apiClient = new ApiClient();
    VehicleOperationsApi vehicleOperationsApi = new VehicleOperationsApi(apiClient);
    @Given("^ejar login and open url with user name: (.*) and password: (.*) url: (.*)$")
    public void LoginWithUsernameAndPassword(String username, String password, String url) {
        PropManager.getInstance().getPropertiesValues().get("appProperties.properties").put("execution.project.name", "ejar web");
        if (PropManager.getInstance().getProperty("execution.lang").equals("ar")) {

            try {
                Thread.sleep(2000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            clickElement("ejar.loginpage.arabic.language.icon.byxpath");
        }
        if (PropManager.getInstance().getProperty("isSaas").equals("true")) {
            waitForElementToBeVisible("ejar.loginpage.changetenant.byxpath");
            clickElement("ejar.loginpage.changetenant.byxpath");
            setValueInField("ejar.loginpage.tenantname.byxpath", "Default");
            clickElement("ejar.loginpage.tenantsumitbutton.byxpath");
        }
        setValueInField("ejar.loginpage.username.byxpath", username);
        waitForSeconds(0.5);
        setValueInField("ejar.loginpage.password.byxpath", password);
        clickElement("ejar.loginpage.loginaction.byxpath");
        waitForElementNotPresent("ejar.loginpage.username.byxpath");
        navigateToUrl(PropManager.getInstance().getProperty("ejar.environment.url") + url.trim());
    }


    @Given("^ejar open url and login with tenant: (.*) and user name: (.*) and password: (.*) url: (.*)$")
    public void LoginWithTenantNameUsernameAndPassword(String tenantName, String username, String password, String url) {
        PropManager.getInstance().getPropertiesValues().get("appProperties.properties").put("execution.project.name", "ejar web");
//        waitForSeconds(1);
//        clickElement("ejar.loginpage.changetenantlink.byxpath");
//        clickElement("ejar.loginpage.switchtotenant.checkbox.byxpath");
//        setValueInField("ejar.loginpage.tenantnamenew.byxpath", tenantName);
//        clickElement("ejar.loginpage.tenantsumitbuttonnew.byxpath");
        LoginWithUsernameAndPassword(username, password, url);
    }

    @Then("^close browser and close driver")
    public void closeDriver() {
        endDriver();
    }

    @And("^user open page using url: (.*)$")
    public void openPage(String url) {
        navigateToUrl(url);
        System.out.println("Storing Yelo Base URL :" + DriverFactory.getDriver().url());
        ScenarioContextSingleton.getInstance().setContextValue("websiteBaseUrl", DriverFactory.getDriver().url());
    }

    @And("^user open ejar project url$")
    public void openPageForProject() {
        setProjectExecution("ejar");
        navigateToUrl(PropManager.getInstance().getProperty("ejar.environment.url"));
        clickOnActionIfExist("login.internal.temp.byxpath");
    }

    @And("^reload page$")
    public void reloadPage() {
//        DriverFactory.getDriver().reload();
        String timeoutStr = PropManager.getInstance().getProperty("driver.element.wait");
        long calculatedTimeout = Long.parseLong(timeoutStr) * 10000;
        DriverFactory.getDriver().reload(
                new Page.ReloadOptions()
                        .setTimeout(calculatedTimeout)
                        .setWaitUntil(WaitUntilState.DOMCONTENTLOADED));
        waitForLoadingIconToBeNotPresentStatic();
    }

    @And("^change execution project to: (.*)$")
    public void setProjectExecution(String project) {
        if (project.toLowerCase().contains("ejar"))
            PropManager.getInstance().setTheExecutionProject("ejar web");
        else if (project.toLowerCase().trim().contains("yelo")) {
            PropManager.getInstance().setTheExecutionProject("yelo web");
        } else {
            System.out.println("none met the if statement so defaulting to ejar web as execution project for this run");
            PropManager.getInstance().setTheExecutionProject("ejar web");
        }
    }


    @And("^verify element present: (.*)$")
    public void toVerifyElementPresent(String elementName) {
        waitForElementToBeVisible(elementName.trim());
    }

    @And("^verify element present with xpath: (.*)$")
    public void toVerifyElementPresentWithXpath(String xpath) {
        waitForElementToBeVisibleByXpath(xpath);
    }

    @And("click on edit action related to the previously created form id: (.*)$")
    public void clickOnEditActionRelatedToThePrevisoulyCreatedForm(String firstElement) {
        System.out.println("clickOnEditActionRelatedToThePrevisoulyCreatedForm " + formName.get());
        clickElementRelatedToForm(firstElement, formName.get());
    }

    @And("click on view action related to the previously created form id: (.*)$")
    public void clickOnViewActionRelatedToThePrevisoulyCreatedForm(String firstElement) {
        System.out.println("clickOnViewActionRelatedToThePrevisoulyCreatedForm" + formName.get());
        clickViewActionRelatedToForm(firstElement, formName.get());
    }

    @And("verify any of two elements to be present, first element : (.*) the second element: (.*)$")
    public void verifyAnyOfTheTwoElementToBePresent(String firstElement, String secondElement) {
        boolean bothElementsNotFound = false, firstNotFound = false;
        try {
            waitForElementToBeVisibleWithoutAssertion(firstElement, 3);
        } catch (Exception e) {
            firstNotFound = true;
        }
        try {
            waitForElementToBeVisibleWithoutAssertion(secondElement, 4);
        } catch (Exception e) {
            if (firstNotFound)
                bothElementsNotFound = true;
        }

        if (bothElementsNotFound)
            Assert.fail("non of the two elements were found, first element name was: " + firstElement + " ,second element name was: " + secondElement);
    }

    public void verifyAnyOfTwoElementToBePresent(String firstElement, String secondElement) {
        waitForElementToBeVisible(firstElement, 3);
        waitForElementToBeVisible(secondElement, 5);
    }

    @And("^verify element present with status: (.*) status: (.*)$")
    public void toVerifyElementPresentWithStatus(String elementName, String status) {
        elementName = elementName.trim();
        switch (status) {
            case "present":
                waitForElementToBePresent(elementName);
                break;
            case "visible":
                waitForElementToBeVisible(elementName);
                break;
        }
    }

    @And("^wait for element present: (.*) for period in seconds: (.*)$")
    public void waitForElementPresentHere(String elementName, int seconds) {
        Element.waitForLoadingIconToBeNotPresentStatic();
        waitForElementToBeVisible(elementName, seconds);
    }

    @And("^wait for element not present: (.*)$")
    public void waitForElementNotPresentHere(String elementName) {
        waitForElementNotPresent(elementName);
    }

    @And("^verify element not present: (.*) within time of seconds: (.*) and status: (.*)$")
    public void waitForElementNotPresentHere(String elementName, int seconds, String status) {
        waitForElementNotPresent(elementName, seconds, status);
    }

    @And("^user click on action with id: (.*)$")
    public void clickAction(String elementName) {
        clickElement(elementName.trim());
    }

    @And("^user click on view action: (.*) related to record with text: (.*) then select record at index: (.*)$")
    public void clickOnActionInViewRelatedToColumn(String actionName, String recordString, String recordIndex) {
        String searchStringBasedOnLanguage = recordString.trim();
        if (recordString.contains(","))
            searchStringBasedOnLanguage = getOptionBasedOnLang(recordString.trim());
        clickOnActionInViewRelatedToColumnMethod(actionName.trim().split(",")[0], actionName.trim().split(",")[1], searchStringBasedOnLanguage, recordIndex);
    }


//    @And("^user click on view action: (.*) then select record at index: (.*)$")
//    public void clickOnActionInViewInRecordAtIndex(String actionName, String recordIndex) {
//        clickOnActionInViewInRecordAtIndexMethod(actionName.trim().split(",")[0],actionName.trim().split(",")[1],recordIndex);
//    }

    @And("^filter view on column name: (.*) and enter value: (.*)$")
    public void filterResultsInViewBasedOnColumnName(String columnName, String searchString) {
        String searchStringBasedOnLanguage = searchString.trim();
        if (searchString.contains(","))
            searchStringBasedOnLanguage = getOptionBasedOnLang(searchString.trim());
        filterResultsInViewBasedOnColumnNameMethod(getOptionBasedOnLang(columnName), searchStringBasedOnLanguage);
    }

    @And("^filter view on column name: (.*) and select dropdown list value: (.*)$")
    public void filterResultInViewBySelectingValue(String columnName, String value) {
        String searchStringBasedOnLanguage = value.trim();
        if (value.contains(","))
            searchStringBasedOnLanguage = getOptionBasedOnLang(value.trim());
        filterResultsInViewBasedOnColumnNameMethodBySelectDropDownOption("ejar.generic.view.column.filter.action.byxpath", getOptionBasedOnLang(columnName), searchStringBasedOnLanguage);
    }

    @And("^filter view based on state column name: (.*) and enter value:(.*)$")
    public void filterResultsInViewBasedOnColumnNameSelect(String columnName, String searchString) {
        String searchStringBasedOnLanguage = searchString.trim();
        if (searchString.contains(","))
            searchStringBasedOnLanguage = getOptionBasedOnLang(searchString.trim());
        filterResultsInViewBasedOnColumnNameMethodWithSelect(getOptionBasedOnLang(columnName), searchStringBasedOnLanguage, "ejar.generic.view.column.filter.action.byxpath");
        waitForSeconds(1);
    }

    public void filterResultsInViewBasedOnColumnNameMethodWithSelect(String columnName, String searchText, String elementName) {
        Element.waitForLoadingIconToBeNotPresentStatic();
        waitForPageToLoad();
        Element element = new Element(elementName);
        element.setLocatorValue(element.getLocatorValue().replaceAll("\\$\\{columnName}", columnName));
        waitForElementClickability(element);
        element.clickElement();
        Element.waitForLoadingIconToBeNotPresentStatic();
        Element filterInputFiled = new Element("ejar.generic.view.column.filter.select.field.byxpath");
        if (!filterInputFiled.isElementPresentAfterWait(1))
            element.clickElement();
        filterInputFiled.clickElement();
        filterInputFiled.sendKeysInElement(searchText);
        String optionTextXpath = "//kendo-popup//li[contains(.,'" + searchText + "')]";
        this.waitForSeconds(1);
        Element filterOptionElement = new Element("filterOptionElement.byxpath", optionTextXpath);
        filterOptionElement.clickElement();
        Element filterSubmitAction = new Element("ejar.generic.view.column.submitFilter.action.field.byxpath");
        filterSubmitAction.clickElement();
    }

    @And("^click on view first record cell under column name: (.*)$")
    public void clickOnFirstViewRecordCellUnderColumnName(String columnName) {
        waitForSeconds(1);
        clickOnFirstViewRecordCellUnderColumnNameMethod(returnStringBasedOnLanguage(columnName.trim()));
    }

    @And("^click on view first record cell under both column name: (.*) and form name: (.*)$")
    public void clickOnFirstViewRecordCellUnderColumnName(String columnName, String formName) {
        clickOnFirstViewRecordCellUnderColumnNameAndFormNameMethod(formName, returnStringBasedOnLanguage(columnName.trim()));
    }

    @And("^click on view record that contains text: (.*)$")
    public void clickOnViewRecordThatContainText(String recordString) {
        clickOnRecordCellContainsText(returnStringBasedOnLanguage(recordString.trim()));
    }


    @And("^user click on action if enabled with id: (.*)$")
    public void clickOnActionIfEnabled(String elementName) {
        clickElementIfEnabled(elementName);
    }

    @And("^user click on action with form name: (.*) and action id: (.*)$")
    public void clickAction(String formName, String elementName) {
        clickElementWithFormName(formName, elementName);
    }

    @And("^user click on action with xpath: (.*)$")
    public void clickActionWithXpath(String elementName) {
        clickElementWithXpath("dyanmic.byxpath", elementName.trim());
    }

    @And("^wait for number of seconds: (.*)$")
    public void waitForSeconds(double waitTime) {
        int waitTimeInt = (int) waitTime * 1000;
        try {
            Thread.sleep(waitTimeInt);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    @And("^user set in field: (.*) value: (.*)$")
    public void setValueInField(String field, String value) {
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        setValueIntoElement_V2(value, field);
    }

    @And("^clear field: (.*)$")
    public void clearField(String field) {
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        clearElement(field);
    }


    @And("^clear element: (.*) by back space: (.*)$")
    public void clearField(String element, int clickCount) {
        new Element(element).clickOnKey("Backspace", clickCount);
    }


    @And("^user enter value : (.*) in field : (.*)$")
    public void setValue(String value, String field) {
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        clearField(field);
        simulateClickingOnKeyMethod(field, value);
    }

    @And("^set random text into element: (.*) and store name: (.*)$")
    public void setRandomStringEntoElement(String elementName, String setNameFlag) {
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        if (setNameFlag.equals("yes")) {
            formName.set(StringHelper.getRandomStringOfSize(10));
            System.out.println("setRandomStringEntoElement" + formName.get());
        }
        setValueIntoElement(formName.get(), elementName);
    }

    @And("^set random text into element: (.*) with size: (.*) and initial string: (.*)$")
    public String setRandomStringInElement(String elementName, String stringSize, String initialString) {
        String randomString = initialString + " " + StringHelper.getRandomStringOfSize(Integer.parseInt(stringSize));
        setValueIntoElement(randomString, elementName);
        return randomString;
    }


    @And("^set random email into element: (.*)$")
    public void setRandomEmailText(String elementName) {
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        setValueIntoElement(StringHelper.getRandomEmail(), elementName);
    }

    @And("^set random number into element: (.*) of size: (.*)$")
    public void setRandomNumberOfSize(String elementName, String numberSize) {

        setValueIntoElement(StringHelper.getRandomNumberOfSize(Integer.parseInt(numberSize)), elementName);
    }

    @And("^set random plate number in the field: (.*)$")
    public void setRandomPlateNumber(String elementName) {

        setValueIntoElement(StringHelper.getRandomPlateNumber("saudi"), elementName);
    }


    @And("^user enter value of property: (.*) in field : (.*)$")
    public void setPropertyValue(String propertyName, String field) {
        Element.waitForLoadingIconToBeNotPresentStatic();
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        String value = PropManager.getInstance().getProperty(propertyName);
        Element.waitForLoadingIconToBeNotPresentStatic();
        simulateClickingOnKeyMethod(field, value);
    }

    @And("^verify page that contains url is displayed: (.*)$")
    public void verifyPageIsDisplayed(String url) {
        waitForPageToLoadEjarConnected();
        url = PropManager.getInstance().getProperty("ejar.environment.url") + url;
        verifyPageUrl(url);
    }

    @And("^verify page url doesn't contain :(.*)$")
    public void verifyPageUrlNotContain(String elementsString) {
        List<String> urlText = Arrays.asList(elementsString.split(","));
        urlText.forEach(this::verifyPageIsNotOpenedByUrl);
    }

    @And("^user click on submit for action with id :(.*)$")
    public void clickActionSubmit(String elementName) {
        clickElementSubmitAction(elementName);
    }

    @And("user scroll to the top of the page")
    public void scrollToTheTop() {
        scrollToTheTopOfPage();
    }

    @And("user scroll to the bottom of the page")
    public void scrollToBottomOfPageMethod() {
        scrollToBottomOfPageAtOnce();
    }

    @And("^user scroll to element: (.*)$")
    public void scrollToElementMethod(String elementName) {
        scrollToElement(elementName);
    }

    @And("^user click on element using java script executor: (.*)$")
    public void clickOnElementUsingJavaScriptExecutor(String elementName) {
        clickOnElementUsingJavaScriptExecutorMethod(elementName);
    }

    @And("^scroll by pixcels horizontally: (.*) and vertically: (.*)$")
    public void scrollByPixcelsMethod(int x, int y) {
        scrollByPixcels(x, y);
    }

    @Then("^click on link: (.*)$")
    public void clickOnLink(String element) {
        clickElement(element);
    }

    @Then("^click on the element: (.*) if element: (.*) is not present with wait: (.*)$")
    public void clickOnElementIfElementNotPresent(String clickElement, String elementNotPresent, String wait) {
        Element notPresentElement = new Element(elementNotPresent);
        if (!notPresentElement.isElementPresentAfterWait(Integer.parseInt(wait))) {
            clickElement(clickElement);
        }
    }


    @Then("^click on element: (.*)$")
    public void clickOnElementMethod(String element) {
        clickElement(element);
    }


    @Then("^mouse over: (.*)$")
    public void doMouseOver(String element) {
        mouseOverElement(element);
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    @Then("^verify element text present: (.*) with text: (.*)$")
    public void verifyElementTextPresentMethod(String element, String textToVerifyProperty) {
        verifyElementTextPresent(element, textToVerifyProperty);
    }


    @Then("^verify table header: (.*) with text: (.*)$")
    public void verifyTableHeaderStepDef(String element, String tableHeader) {
        changeBrowserWindowZoomLevel(.5);
        verifyListOfStringPresenceAndOrder(element.trim(), tableHeader.trim());
        changeBrowserWindowZoomLevel(1);
    }

    @Then("^verify table header with visibility status: (.*) with text: (.*) with element status: (.*)")
    public void verifyTableHeaderStepDef2(String element, String tableHeader, String elementStatus) {
        changeBrowserWindowZoomLevel(.5);
        verifyListOfStringPresenceAndOrder(element.trim(), tableHeader.trim(), elementStatus.trim());
        changeBrowserWindowZoomLevel(1);
    }


    @Then("^compare list of elements text: (.*) with text: (.*)$")
    public void compareListOfElementsText(String element, String elementsText) {
        verifyListOfStringPresenceAndOrder(element, elementsText);
    }

    @Then("^verify that drop down field: (.*) contains options: (.*)$")
    public void verifyDropDownFieldOptionsStepDef(String elementName, String options) {

        verifyDropDownFieldOptions(elementName, options);
    }

    @Then("^user select value in drop down field: (.*) by option text: (.*)$")
    public void selectOptionsInDropDownFieldByTextStepDef(String elementName, String optionText) {
        waitForSeconds(1);
        if (PropManager.getInstance().getProperty("execution.lang").equals("en"))
            optionText = optionText.split(",")[0].trim();
        else
            optionText = optionText.split(",")[1].trim();
        selectOptionByText(elementName, optionText);
    }


    @Then("^user select value in drop down field: (.*) by index: (.*)$")
    public void selectOptionsInDropDownFieldByIndexStepDef(String elementName, String indexValue) {
        selectOptionByIndex(elementName, indexValue.trim());
    }

    @Then("^user select value in drop down field: (.*) by option value: (.*)$")
    public void selectOptionsInDropDownFieldByValueStepDef(String elementName, String optionValue) {
        selectOptionByValue(elementName, optionValue.trim());
    }


    public String getOptionBasedOnLang(String optionsText) {
        if (PropManager.getInstance().getProperty("execution.lang").equals("en"))
            return optionsText.split(",")[0].trim();
        else
            return optionsText.split(",")[1].trim();
    }

    public String getOptionBasedOnLangWithoutTrimFromParamDirectly(String optionsText) {
        if (PropManager.getInstance().getProperty("execution.lang").equals("en"))
            return optionsText.split(",")[0];
        else
            return optionsText.split(",")[1];
    }

    @Then("^verify count of element: (.*) equals: (.*)$")
    public void getNumberOfElementsStepDef(String elementName, int count) {
        verifyCountOfElement(elementName, count);
    }

    @Then("^verify count of element with status: (.*) equals: (.*) with status: (.*)$")
    public void getNumberOfElementsWithStatusStepDef(String elementName, int count, String status) {
        verifyCountOfElement(elementName, count, status);
    }

    @Then("^verify text present on page: (.*)$")
    public void verifyTextPresentOnPageStepDef(String textProperty) {
        String expectedText = getPropertyTextValueBasedOnLanguage(textProperty);
        verityTextPresentAfterRemovingSpaces(expectedText);
    }

    @Then("^verify text not present on page: (.*)$")
    public void verifyTextNotPresentOnPageStepDef(String textProperty) {
        String expectedText = getPropertyTextValueBasedOnLanguage(textProperty);
        verityTextNotPresentAfterRemovingSpaces(expectedText);
    }

    @Then("^click on action if exist: (.*)$")
    public void clickOnActionIfExistStepDef(String elementName) {
        clickOnActionIfExist(elementName);
    }

    @Then("^click on action if exist with wait: (.*) waiting number of seconds: (.*)$")
    public void clickOnActionIfExistStepDef(String elementName, String numberOfSeconds) {
        clickOnActionIfExist(elementName, numberOfSeconds);
    }


    @Then("^upload file to element: (.*) with path:(.*)$")
    public void uploadFileWithPathToElement(String elementName, String filePath) throws IOException, InterruptedException {
        uploadFileToElement(elementName.trim(), filePath.trim());
    }


    @Then("^verify element: (.*) attribute: (.*) contains value: (.*) is: (.*)$")
    public void checkAttributeContainsWithCondition(String elementName, String attributeName, String value, boolean condition) {
        checkAttributeContainsValue(elementName, attributeName, value, condition);
    }

    @Then("^validate price of elements: (.*) minPriceElement: (.*) maxPriceElement: (.*)$")
    public void CheckCarsPricesInRange(String elementName, String minPriceElementName, String maxPriceElementName) {
        checkIfElementValuesInRange(elementName, minPriceElementName, maxPriceElementName);
    }

    @Then("drag the element: (.*) horizontally by pixels: (.*) and vertically by pixels: (.*)$")
    public void dragElementMethod(String elementName, int xDistance, int yDistance) {
        dragElement(elementName, xDistance, yDistance);
    }

    @Then("validate text of elements: (.*) equals element text: (.*)$")
    public void ValidateFilterByElementMethod(String elementName, String intendedElementName) {
        verifyTextEqualsForElements(elementName, intendedElementName);
    }

    @Then("^verify number of elements: (.*)$")
    public void ValidateCountOfElementsMethod(int count, String elementName) {
        ValidateCountOfElements(count, elementName);
    }

    @Then("remove attribute for element with id: (.*) attribute: (.*)$")
    public void SetElementAttributeMethod(String elementIdKey, String attributeName) {
        removeAttribute(elementIdKey, attributeName);
    }

    @Then("remove attribute for element: (.*) attribute: (.*)$")
    public void removeElementAttributeMethod(String elementName, String attributeName) {
        removeAttributeWithElementName(elementName.trim(), attributeName.trim());
    }

    @Given("^open other browser tab: (.*)$")
    public void openOtherBrowserTabMethod(String url) {
        openOtherBrowserTab(url);
    }

    @Given("^switch to browser tab : (.*)$")
    public void switchToMainBrowserTabMethod(int tabIndex) {
        switchToBrowserTab(tabIndex);
    }

    @Then("set value into element : (.*) by context key: (.*)$")
    public void setValueIntoElementByContextKeyMethod(String targetElementName, String contextKey) {
        setValueIntoElementByContextKey(targetElementName, contextKey);
    }

    @Then("set value into element : (.*) value: (.*)$")
    public void setValueIntoElementByValueMethod(String targetElementName, String value) {
        setValueIntoElementByValue(targetElementName, value);
    }

    @Then("validate tooltip present : (.*) when hover over: (.*)$")
    public void validatetoolTipMethod(String toolTipElementName, String elementName) {
        validatetoolTip(toolTipElementName, elementName);
    }

    @Then("^click on element by id: (.*)$")
    public void clickElementByIdMethod(String elementId) {
        clickElementById(elementId);
    }

    @Then("^check element not contains ar contains empty value: (.*) for attribute: (.*)$")
    public void checkElementEmptyAttributeOrNotContainsAttributeMethod(String elementName, String attributeName) {
        checkElementEmptyAttributeOrNotContainsAttribute(elementName, attributeName);
    }

    @Then("^simulate clicking on key: (.*)$")
    public void simulateClickingOnKeyMethod(String keyName) {
        simulateClickingOnKey(keyName);
    }


    @Then("^send keys to element: (.*) keys: (.*)$")
    public void simulateClickingOnKeyMethod(String elementName, String keys) {
        sendKeysToElement(elementName, keys);
    }


    @Then("^send keys to element: (.*) keys: (.*) with milli second delay: (.*)$")
    public void simulateClickingOnKeyWithMilliSecondDelayMethod(String elementName, String keys, String delay) {
        sendKeysToElement(elementName, keys, Integer.parseInt(delay));
    }


    @Then("^get page source")
    public void getPageSourceMethod() {
        DriverFactory.getDriver().content();
    }

    @Then("^change page zoom level to: (.*)$")
    public void changePageZoomLevelMethod(Double zoomLevel) {
        changeBrowserWindowZoomLevel(zoomLevel);
    }

    @And("^user click on view action: (.*) related to record at index: (.*)$")
    public void clickOnActionInViewRelatedToColumn(String actionName, String recordIndex) {
        clickOnActionInViewRelatedToColumnMethod(actionName.trim().split(",")[0], actionName.trim().split(",")[1], recordIndex);
    }


    @And("^verify ejar view title text: (.*)$")
    public void verifyEjarViewTitle(String viewTitle) {
        verifyElementTextPresent(new Element("viewTitle.text.byxpath", "//h1"), viewTitle);
    }

    @And("^verify ejar view sub title text: (.*)$")
    public void verifyEjarViewSubTitle(String viewSubTitle) {
        verifyElementTextPresent(new Element("viewSubTitle.text.byxpath", "//h1/following-sibling::div/span"), viewSubTitle);
    }

//    @And("^verify form page fields, field label: {fieldLabel}, field editable: {Editable}, field required: {Required}")
//    public void verifyFormPageFields(String viewSubTitle) {
//        verifyElementTextPresent(new Element("viewSubTitle.text.byxpath", "//h1/following-sibling::div/span"), viewSubTitle);
//    }

    @And("^change Yelo iframe with id: (.*) and click on element with id: (.*)$")
    public void changeYeloIframe(String iframe, String elementName) {
        waitForElementPresentHere("yelo.gateway.iframe.byxpath", 70);
        changeIframe(iframe);
        waitForElementPresentHere(elementName, 20);
        Element element = new Element(elementName);
        waitForElementClickability(element);
        try {
            element.clickAndIgnoreDetach();
        } finally {
            switchToMainPage();
        }
    }

    @And("^change iframe with id: (.*)$")
    public void changeIframe(String iframe) {
        com.microsoft.playwright.Frame frame = DriverFactory.getDriver().frame(iframe);
        DriverFactory.setCurrentFrame(frame);
    }

    @And("^switch back to main page iframe$")
    public void switchToMainPage() {
        // Setting current frame to null or the main page object
        // depending on how your DriverFactory is built
        DriverFactory.setCurrentFrame(null);
    }

    @And("wait for element present with xpath: (.*) and replace variable value: (.*) for period in seconds: (.*)$")
    public void waitForElementPresentWithVariable(String xpath, String value, int seconds) {
        Element.waitForLoadingIconToBeNotPresentStatic();
        String newXpath = xpath.replace("${valueToReplace}", value);
        Element element = new Element("elementToWaitTobeVisibleWithReplaceValue.byxpath", newXpath);
        waitForElementToBeVisible(element, seconds);
    }

    @And("verify array of elements:(.*) contains value:(.*)$")
    public void verifyArrayOfElementContains(String xpath, String value) {
        waitForLoadingIconToBeNotPresentStatic("yelo web");
        Element element = new Element(xpath.strip());
        for (Locator webElement : element.getWebElements(5)) {
            String elementText = webElement.textContent();
            Assert.assertTrue("Element text expected to contain:" + value + " ,but it text was: " + elementText, elementText.contains(value));
        }
    }

    @And("^ensure checkbox is checked with id: (.*)$")
    public void ensureCheckboxIsChecked(String elementName) {
        Element checkbox = new Element(elementName);
        Locator locator = checkbox.getWebElement();
        try {
            locator.check(new Locator.CheckOptions().setForce(true));
        } catch (PlaywrightException e) {
            if (!locator.isChecked()) {
                locator.click(new Locator.ClickOptions().setForce(true));
            }
        }
    }

    public void ensureCheckboxIsCheckedWithXpath(String xpath) {
        Element checkbox = new Element("checkboxchecked.byxpath", xpath);
        Locator locator = checkbox.getWebElement();
        try {
            locator.check(new Locator.CheckOptions().setForce(true));
        } catch (PlaywrightException e) {
            if (!locator.isChecked()) {
                locator.click(new Locator.ClickOptions().setForce(true));
            }
        }
    }

    @And("^ensure checkbox is unchecked with id: (.*)$")
    public void ensureCheckboxIsUnchecked(String elementName) {
        Element checkbox = new Element(elementName);
        Locator locator = checkbox.getWebElement();
        try {
            locator.uncheck(new Locator.UncheckOptions().setForce(true));
        } catch (PlaywrightException e) {
            if (locator.isChecked()) {
                locator.click(new Locator.ClickOptions().setForce(true));
            }
        }
    }

    public int getColumnIndex(String headerText) {
        String index;
        Element tableHeader = new Element("ejar.tableheader.byxpath", String.format("//th[not(ancestor::vehiclehistory) and .//span[normalize-space(text())='%s']]", headerText));

        index = tableHeader.getWebElement().getAttribute("aria-colindex");

        return Integer.parseInt(index);

    }


    @And("handle dialog with: (true|false) with prompt text: (.*)$")
    public void handleDialog(boolean accept, String promptText) {
        Page page = DriverFactory.getDriver();
        page.onceDialog(dialog -> {
            try {
                Thread.sleep(4000);
            } catch (InterruptedException e) {
                throw new RuntimeException(e);
            }
            System.out.println(dialog.type() + ": " + dialog.message());
            if (accept) {
                dialog.accept(promptText);
            } else {
                dialog.dismiss();
            }
        });
    }

    @And("create web dialog type: (alert|confirm|prompt) with message: (.*)$")
    public void createDialog(String type, String message) {
        Page page = DriverFactory.getDriver();
        Object result = page.evaluate("([t, m]) => window[t](m)", Arrays.asList(type, message));
        System.out.println("Dialog returned: " + result);
    }

    @And("^check console contains the following error message (.*) with assertion type: (hard|soft)$")
    public void checkConsoleContainsErrorMessage(String expectedMessage, String assertionType) {
        List<String> errors = collectConsoleErrors();

        List<String> matching = new ArrayList<>();
        for (String e : errors) {
            if (e.contains(expectedMessage)) {
                matching.add(e);
            }
        }

        if (!matching.isEmpty()) {
            reportFailure(assertionType, "Console contains " + matching.size()
                    + " error(s) with text: \"" + expectedMessage + "\". Matching errors: " + matching);
        }
    }

    @And("^check console has no error messages with assertion: (hard|soft)$")
    public void checkConsoleHasNoErrorMessages(String assertionType) {
        List<String> errors = collectConsoleErrors();
        if (!errors.isEmpty()) {
            reportFailure(assertionType, "Console has " + errors.size()
                    + " error message(s): " + errors);
        }
    }

    /**
     * Attaches listeners, reloads the page so its load errors are captured, returns the errors.
     */
    private List<String> collectConsoleErrors() {
        Page page = DriverFactory.getDriver();
        List<String> errors = new ArrayList<>();
        List<ConsoleMessage> msg = page.consoleMessages();
        for (ConsoleMessage singleMsg : msg) {
            if ("error".equals(singleMsg.type())) {
                errors.add(singleMsg.text());
            }
        }

        page.onPageError(error -> errors.add("Uncaught exception: " + error));
        return new ArrayList<>(errors);
    }

    private void reportFailure(String assertionType, String message) {
        if (assertionType.equals("hard")) {
            Assert.fail(message);
        } else {
            System.out.println("SOFT FAIL -> " + message);
            ejarPages.assertActualExpected(message);
        }
    }

@And("^check page requests contains the following request (.*) with assertion type: (hard|soft)$")
public void checkPageRequestsContains(String expectedUrlText, String assertionType) {
    Page page = DriverFactory.getDriver();
    List<Request> requests = page.requests();

    List<String> matching = new ArrayList<>();
    for (Request r : requests) {
        if (r.url().contains(expectedUrlText)) {
            matching.add(r.method() + " " + r.url());
        }
    }

    if (matching.isEmpty()) {
        reportFailure(assertionType, "No page request contains the text: \"" + expectedUrlText
                + "\". Number of requests checked: " + requests.size());
    }
    System.out.println("Found " + matching.size() + " request(s) containing \""
            + expectedUrlText + "\": " + matching);
}

    @And("^using API create a new vehicle with random plate and chassis numbers$")
    public void createVehicleUsingAPI() {
        vehicleOperationsApi.createVehicleWithRandomData();
    }

    @After("@API")
        public void closeApiSession() {
        apiClient.close();
  }

}
