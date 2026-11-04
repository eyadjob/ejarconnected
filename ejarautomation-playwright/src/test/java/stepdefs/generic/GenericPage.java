package stepdefs.generic;

import automation.framework.Element;
import automation.framework.EmailValidator;
import automation.framework.ScenarioContextSingleton;
import automation.framework.business.ElementStatus;
import automation.framework.listener.DateHelper;
import automation.framework.propmanager.PropManager;
import automation.framework.threadData.DriverFactory;
import com.microsoft.playwright.Locator;
import com.microsoft.playwright.Page;
import com.microsoft.playwright.options.LoadState;
import com.microsoft.playwright.options.WaitUntilState;
import lombok.AllArgsConstructor;
import lombok.Data;
import org.junit.Assert;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Random;
import java.util.stream.Collectors;

import static automation.framework.Element.waitForLoadingIconToBeNotPresentStatic;
import static com.microsoft.playwright.options.WaitForSelectorState.VISIBLE;


/**
 * this class has the generic actions that are needed to deal with web elements, by using java reflection
 *
 * @author e.mubarak@iyelo.com
 */
@AllArgsConstructor
@Data
public class GenericPage {


    /**
     * this method wait for the page to load completely and time out set to 10 seconds
     */
    public void waitForPageToLoad() {
        Page page = DriverFactory.getDriver();
        long timeOut = 120000;
        long end = System.currentTimeMillis() + timeOut;

        while (System.currentTimeMillis() < end) {
            if ("complete".equals(page.evaluate("() => document.readyState").toString()) || "interactive".equals(page.evaluate("() => document.readyState").toString())) {
                System.out.println("document is loaded");
                break;
            }
        }
    }

    /**
     * Navigates to the URL; waits for DOMContentLoaded, not the full load event (images, subresources, etc.).
     *
     * @param url the url to navigate to
     */
    public void navigateToUrl(String url) {
        String timeoutStr = PropManager.getInstance().getProperty("driver.element.wait");
        long calculatedTimeout = Long.parseLong(timeoutStr) * 10000;
        DriverFactory.getDriver().navigate(url,
                new Page.NavigateOptions()
                        .setTimeout(calculatedTimeout)
                        .setWaitUntil(WaitUntilState.DOMCONTENTLOADED));
        waitForLoadingIconToBeNotPresentStatic();
    }

    public void waitPageToLoad(String status) {
        if (status.equals("load")) {
            DriverFactory.getDriver().waitForLoadState(
                    LoadState.DOMCONTENTLOADED,
                    new Page.WaitForLoadStateOptions().setTimeout(1000 * Integer.parseInt(PropManager.getInstance().getProperty("driver.element.wait"))));
        }
        DriverFactory.getDriver().waitForLoadState(LoadState.LOAD,new Page.WaitForLoadStateOptions().setTimeout(1000 * Integer.parseInt(PropManager.getInstance().getProperty("driver.element.wait"))) );

    }

    public void endDriver() {
        DriverFactory.destroyDriverObject();
    }

    /**
     * to set value in the web element provided as argument
     *
     * @param value       the value to fill in the web element
     * @param elementName the web element to be filled
     */
    public void setValueIntoElement(String value, String elementName) {
        waitForPageToLoad();
        Element element = new Element(elementName);
        element.setValueInElement(value);
    }


    public void clearElement(String elementName) {
        waitForPageToLoad();
        Element element = new Element(elementName);
        element.clearElement();
    }

    /**
     * click on web element that is provided as an argument
     *
     * @param elementName the web element name
     */
    public void clickElement(String elementName) {
        Element.waitForLoadingIconToBeNotPresentStatic();
        waitForPageToLoad();
        Element element = new Element(elementName);
        waitForElementClickability(element);
        element.clickElement();
        Element.waitForLoadingIconToBeNotPresentStatic();

    }

    public void clickOnActionInViewRelatedToColumnMethod(String actionNameEnglish, String actionNameArabic, String recordName, String recordIndex) {
        Element.waitForLoadingIconToBeNotPresentStatic();
        waitForPageToLoad();
        Element element = new Element("ejar.generic.view.dynamic.action.byxpath");
        element.setLocatorValue(element.getLocatorValue().replaceAll("\\$\\{recordName}", recordName).replaceAll("\\$\\{actionNameEnglish}", actionNameEnglish).replaceAll("\\$\\{actionNameArabic}", actionNameArabic));
        waitForElementClickability(element);
        element.clickElement();
        Element.waitForLoadingIconToBeNotPresentStatic();
    }
    public void clickOnActionInViewRelatedToColumnMethod(String actionNameEnglish, String actionNameArabic,  String recordIndex) {
        Element.waitForLoadingIconToBeNotPresentStatic();
        waitForPageToLoad();
        Element element = new Element("ejar.generic.view.dynamic.action.byxpath");
        element.setLocatorValue(element.getLocatorValue().replaceAll("\\$\\{recordName}", "").replaceAll("\\$\\{actionNameEnglish}", actionNameEnglish).replaceAll("\\$\\{actionNameArabic}", actionNameArabic));
        element.setLocatorValue(new StringBuilder(element.getLocatorValue()).append(")[").append(recordIndex).append("]").insert(0,"(").toString());
        waitForElementClickability(element);
        element.clickElement();
        Element.waitForLoadingIconToBeNotPresentStatic();
    }

    public String getPlateNumberForVehicleWithStatusMethod(String filterFieldValueAttributeValue, String columnName, String vehicleStatusName) {
        filterResultsInViewBasedOnColumnNameMethodBySelectDropDownOption(filterFieldValueAttributeValue,"(//gridpagelayout//kendo-grid//th//span[contains(.,'"+columnName+"')]//kendo-grid-filter-menu//a )[1]",columnName,vehicleStatusName);
        Element element = new Element("ejar.generic.view.plateNumber.value.byxpath","(//kendo-grid-list//tr//td//a[contains(@class,'palteNo')])[1]");
        return element.getWebElement().innerText();
    }



    public void clickOnActionInViewInRecordAtIndexMethod(String actionNameEnglish, String actionNameArabic, String recordValue) {
        Element.waitForLoadingIconToBeNotPresentStatic();
        waitForPageToLoad();
        Element element = new Element("ejar.generic.view.dynamic.action.byxpath");
        element.setLocatorValue(element.getLocatorValue().replaceAll("\\$\\{actionNameEnglish}", actionNameEnglish).replaceAll("\\$\\{actionNameArabic}", actionNameArabic));
        waitForElementClickability(element);
        element.clickElement();
        Element.waitForLoadingIconToBeNotPresentStatic();
    }


    public void filterResultsInViewBasedOnColumnNameMethod(String columnName, String searchText) {
        filterResultsInViewBasedOnColumnNameMethod(columnName, searchText,"ejar.generic.view.column.filter.action.byxpath");
    }

    public void filterResultsInViewBasedOnColumnNameMethod(String columnName, String searchText, String elementName) {
        Element.waitForLoadingIconToBeNotPresentStatic();
        waitForPageToLoad();
        Element element = new Element(elementName);
        element.setLocatorValue(element.getLocatorValue().replaceAll("\\$\\{columnName}", columnName));
        waitForElementClickability(element);
        element.clickElement();
        Element.waitForLoadingIconToBeNotPresentStatic();
        Element filterInputFiled = new Element("ejar.generic.view.column.filter.input.field.byxpath");
        filterInputFiled.setValueInElement(searchText);
        Element filterSubmitAction = new Element("ejar.generic.view.column.submitFilter.action.field.byxpath");
        filterSubmitAction.clickElement();
    }

    public void filterResultsInViewBasedOnColumnNameMethodBySelectDropDownOption(String columnName, String dropDownOption) {
        Element.waitForLoadingIconToBeNotPresentStatic();
        waitForPageToLoad();
        Element element = new Element("ejar.generic.view.column.filter.action.byxpath");
        element.setLocatorValue(element.getLocatorValue().replaceAll("\\$\\{columnName}", columnName));
        waitForElementClickability(element);
        element.clickElement();
        Element.waitForLoadingIconToBeNotPresentStatic();
        Element filterInputFiled = new Element("ejar.generic.view.column.dropDownOption.field.byxpath");
        filterInputFiled.setLocatorValue(filterInputFiled.getLocatorValue().replaceAll("\\$\\{columnName}",columnName));
        selectOptionByTextInKendoWithoutWithoutTypingWithoutClickEmpty(filterInputFiled,dropDownOption);
        Element filterSubmitAction = new Element("ejar.generic.view.column.submitFilter.action.field.byxpath");
        filterSubmitAction.clickElement();
    }

    public void filterResultsInViewBasedOnColumnNameMethodBySelectDropDownOption(String elementName,String columnName, String dropDownOption) {
        Element.waitForLoadingIconToBeNotPresentStatic();
        waitForPageToLoad();
        Element element = new Element(elementName);
        element.setLocatorValue(element.getLocatorValue().replaceAll("\\$\\{columnName}", columnName));
        waitForElementClickability(element);
        element.clickElement();
        Element.waitForLoadingIconToBeNotPresentStatic();
        Element filterInputFiled = new Element("ejar.generic.view.column.dropDownOption2.field.byxpath");
        selectOptionByTextInKendoWithoutWithoutTypingWithoutClickEmpty(filterInputFiled,dropDownOption);
        clickElement("ejar.generic.view.column.submitFilter.action.field.byxpath");
    }

    public void filterResultsInViewBasedOnColumnNameMethodBySelectDropDownOption(String filterFieldValueAttributeValue, String columnXpath,String columnName, String dropDownOption) {
        Element.waitForLoadingIconToBeNotPresentStatic();
        waitForPageToLoad();
        Element element = new Element("ejar.generic.view.column.filter.action.byxpath",columnXpath);
        waitForElementClickability(element);
        element.clickElement();
        Element.waitForLoadingIconToBeNotPresentStatic();
        Element filterInputFiled = new Element("ejar.generic.view.column.dropDownOption.field.byxpath");
        filterInputFiled.setLocatorValue(filterInputFiled.getLocatorValue().replaceAll("\\$\\{columnName}",filterFieldValueAttributeValue.toLowerCase()));
        selectOptionByTextInKendoWithoutWithoutTypingWithoutClickEmpty(filterInputFiled,dropDownOption);
        new Element("element.toClick.dummy.byxpath","//div[@id='kt_header']").clickElement();
    }



    public void clickOnFirstViewRecordCellUnderColumnNameMethod(String columnName) {
        Element.waitForLoadingIconToBeNotPresentStatic();
        Element element = new Element("Dynamic.tableHeaders.byxpath", "//gridpagelayout//table//thead//th");
        List<Locator> webElements = element.getWebElements();
       gridHeadersLoop: for (int i = 0; i < webElements.size(); i++) {
            try {
                if (webElements.get(i).innerText().equals(columnName)) {
                    Element cellToClickElement = new Element("Dynamic.cellToClick.byxpath", "(//kendo-grid-list//td//a)[" + (i + 1) + "]");
                    cellToClickElement.clickElement();
                    break gridHeadersLoop;
                }
                System.out.println("Element was Found");
            } catch (Exception e) {
                System.out.println(e.getMessage());

            }
        }
    }

    public void clickOnRecordCellContainsText(String recordText) {

        Element cellToClickElement = new Element("Dynamic.cellToClick.byxpath", "(//kendo-grid-list//td//a[contains(.,'" + recordText + "')])[1]");
        cellToClickElement.clickElement();
        Element.waitForLoadingIconToBeNotPresentStatic();

    }

    public void clickOnActionXpathWithVariableMethod(String xpathToClick, String variableName) {
        Element element = new Element(variableName + ".dynamic.xpath.byxpath", xpathToClick.replaceAll("\\$\\{DynamicVariable}",variableName));
        element.clickElement();
    }
    public void waitForActionXpathWithVariableMethod(String xpathToWait, String variableName) {
        Element element = new Element(variableName + ".dynamic.xpath.byxpath", xpathToWait.replaceAll("\\$\\{DynamicVariable}",variableName));
        element.waitForElement(ElementStatus.VISIBLE, Integer.parseInt(PropManager.getInstance().getProperty("driver.element.wait")));
    }

    public void scrollOnActionXpathWithVariableMethod(String xpathToClick, String variableName) {
        Element element = new Element(variableName + ".dynamic.xpath.byxpath", xpathToClick.replaceAll("\\$\\{DynamicVariable}",variableName));
        element.scrollToElement();
    }

    public void clickOnFirstViewRecordCellUnderColumnNameAndFormNameMethod(String formName, String columnName) {
        Element element = new Element("Dynamic.tableHeaders.byxpath", "//" + formName + "//table//thead//th");
        List<Locator> webElements = element.getWebElements();
        for (int i = 0; i < webElements.size(); i++) {
            try {
                if (webElements.get(i).innerText().equals(columnName)) {
                    Element cellToClickElement = new Element("Dynamic.cellToClick.byxpath", "(//kendo-grid-list//td//a)[" + (i + 1) + "]");
                    cellToClickElement.clickElement();
                    System.out.println("cellToClickElement.getLocatorValue: " + cellToClickElement.getLocatorValue());
                    System.out.println("webElements.get(i).innerText(): " + webElements.get(i).innerText());
                    Element.waitForLoadingIconToBeNotPresentStatic();
                    break;
                }
                System.out.println("Element was Found");
            } catch (Exception e) {
                System.out.println(e.getMessage());

            }
        }

    }

    public void clickElementRelatedToForm(String elementName, String formName) {
        Element.waitForLoadingIconToBeNotPresentStatic();
        waitForPageToLoad();
        Element element = new Element(elementName);
        element.setLocatorValue(element.getLocatorValue().replaceAll("\\$\\{FormName}", formName));
        System.out.println("Element locator value after replacing the form name is: " + element.getLocatorValue());
        waitForElementClickability(element);
        element.clickElement();
        Element.waitForLoadingIconToBeNotPresentStatic();
    }


    public void clickViewActionRelatedToForm(String elementName, String formName) {
        Element.waitForLoadingIconToBeNotPresentStatic();
        waitForPageToLoad();
        Element element = new Element(elementName);
        element.setLocatorValue(element.getLocatorValue().replaceAll("\\$\\{FormName}", formName));
        System.out.println("Element locator value after replacing the form name is: " + element.getLocatorValue());
        waitForElementClickability(element);
        element.clickElement();
        Element.waitForLoadingIconToBeNotPresentStatic();
    }


    public void clickElementIfEnabled(String elementName) {
        Element element = new Element(elementName);
        if (element.getWebElement().getAttribute("disabled") == null) {
            clickElement(elementName);
        }
    }

    public void clickElementWithFormName(String formName, String elementName) {
        Element.waitForLoadingIconToBeNotPresentStatic();
        waitForPageToLoad();
        Element genericElementXpath = new Element(elementName);
        Element element = new Element(formName + ".byxpath", "//" + formName + genericElementXpath.getLocatorValue());
        waitForElementClickability(element);
        element.clickElement();
        Element.waitForLoadingIconToBeNotPresentStatic();
    }

    public void clickElementWithXpath(String elementName, String elementPath) {
        Element.waitForLoadingIconToBeNotPresentStatic();
        waitForPageToLoad();
        Element element = new Element(elementName, elementPath);
        waitForElementClickability(element);
        element.clickElement();
        Element.waitForLoadingIconToBeNotPresentStatic();
    }

    public void mouseOverElement(String elementName) {
        Element element = new Element(elementName);
        element.mouseOver();
    }

    public void waitForPageToLoadEjarConnected() {
        Element element = new Element("ejar.waitingicon.byxpath");
        element.waitForElementNotPresent();
    }

    /**
     * this method wait for the element to be clickable in the page up to 40 seconds
     *
     * @param element the web element to wait for until it become present to user
     */
    public void waitForElementClickability(Element element) {
        int waitSec = Integer.parseInt(PropManager.getInstance().getProperty("driver.element.wait"));
        element.getLocator().waitFor(new Locator.WaitForOptions().setState(VISIBLE).setTimeout(waitSec * 1000.0));
    }

    public void waitForElementToBeVisible(String elementName) {
        Element element = new Element(elementName);
        element.waitForElement(ElementStatus.VISIBLE, Integer.parseInt(PropManager.getInstance().getProperty("driver.element.wait")));
    }

    public void waitForElementToBeVisibleByXpath(String xpath) {
        Element element = new Element("dyanmic.wait.for.element.topresent.byxpath", xpath);
        element.waitForElement(ElementStatus.VISIBLE, Integer.parseInt(PropManager.getInstance().getProperty("driver.element.wait")));
    }



    public void waitForElementToBePresent(String elementName) {
        Element element = new Element(elementName);
        element.waitForElement(ElementStatus.PRESENT, Integer.parseInt(PropManager.getInstance().getProperty("driver.element.wait")));
    }

    public void waitForElementToBeVisible(String elementName, String elementXpath) {
        Element element = new Element(elementName, elementXpath);
        element.waitForElement(ElementStatus.VISIBLE, Integer.parseInt(PropManager.getInstance().getProperty("driver.element.wait")));
    }

    public void waitForElementToPresentByVisibilityStatus(String elementName, String elementXpath,String visibilityStatus) {
        Element element = new Element(elementName, elementXpath);
        element.waitForElement(visibilityStatus.equalsIgnoreCase("visible") ? ElementStatus.VISIBLE  : ElementStatus.PRESENT, Integer.parseInt(PropManager.getInstance().getProperty("driver.element.wait")));
    }


    public void waitForElementToBeVisible(String elementName, int waitPeriod) {
        Element element = new Element(elementName);
        element.waitForElement(ElementStatus.VISIBLE, waitPeriod);
    }

    public void waitForElementToBeVisible(Element element, int waitPeriod) {
        element.waitForElement(ElementStatus.VISIBLE, waitPeriod);
    }


    public void waitForElementToBeVisibleWithoutAssertion(String elementName, int waitPeriod) {
        Element element = new Element(elementName);
        element.waitForElementWithAssertion(ElementStatus.VISIBLE, waitPeriod);
    }
    public void waitForElementNotPresent(String elementName) {
        Element element = new Element(elementName);
        element.waitForElementNotPresent();
    }

    public void waitForElementNotPresent(String elementName, int waitingPeriod) {
        Element element = new Element(elementName);
        element.waitForElementNotPresent(waitingPeriod);
    }

    public void waitForElementNotPresent(String elementName, int waitingPeriod, String status) {
        Element element = new Element(elementName);
        element.waitForElementNotPresent(waitingPeriod, status);
    }

    public void verifyPageUrl(String url) {
        Assert.assertEquals(url, DriverFactory.getDriver().url());
    }

    /**
     * this to verify that the page element is present
     *
     * @param elements
     */
    public void verifyPageElementsArePresent(List<String> elements) {
        List<Element> elementList = elements.stream().map(e -> new Element(e)).collect(Collectors.toList());
        elementList.forEach(Element :: verifyElementPresent);
    }

    public void verifyElementPresent(String elementName, String elementXpath) {
        Element element= new Element(elementName, elementXpath);
        element.verifyElementPresent();
    }

    public void setValueIntoElement_V2(String value, String elementIdentifier) {
        waitForPageToLoad();
        Element element = new Element(elementIdentifier);
        element.setValueInElement(value);
    }


    public List<Locator> createListOfElements(String elementName) {
        Element mainElement = new Element(elementName);
        List<Locator> webElements = mainElement.getChildWebElementFromElement(ElementStatus.VISIBLE);
        return webElements;
    }

    public List<Locator> createListOfElements(String elementName, String elementStatus) {
        Element mainElement = new Element(elementName);
        if (elementStatus.equals("visible")) {
            List<Locator> webElements = mainElement.getChildWebElementFromElement(ElementStatus.VISIBLE);
            return webElements;
        } else {
            List<Locator> webElements = mainElement.getChildWebElementFromElement(ElementStatus.PRESENT);
            return webElements;
        }

    }


    /**
     * this to verify that page is not opened by checking the url provided is not present
     *
     * @param urlText the url text to verify
     */
    public void verifyPageIsNotOpenedByUrl(String urlText) {
        Assert.assertFalse(DriverFactory.getDriver().url().contains(urlText));
    }


    public void verifyListOfStringPresenceAndOrder(String elementName, String expectedListOfStringPropertyName) {
        List<Locator> webElements = createListOfElements(elementName);
        String expectedListOfString = getPropertyTextValueBasedOnLanguage(expectedListOfStringPropertyName);
        new Element(elementName).verifyListOfStringMatch(webElements, expectedListOfString);
    }

    public void verifyListOfStringPresenceAndOrder(String elementName, String expectedListOfStringPropertyName, String elementStatus) {
        List<Locator> webElements = createListOfElements(elementName, elementStatus);
        String expectedListOfString = getPropertyTextValueBasedOnLanguage(expectedListOfStringPropertyName);
        new Element(elementName).verifyListOfStringMatch(webElements, expectedListOfString);
    }


    public void verifyDropDownFieldOptions(String elementName, String expectedListOfOptionsText) {
        Element element = new Element(elementName);
        String expectedOptionsBasedOnLanguage = getPropertyTextValueBasedOnLanguage(expectedListOfOptionsText);
        element.verifyDropDownFieldTextOptions(expectedOptionsBasedOnLanguage);
    }

    public void selectOptionByText(String elementName, String optionText) {
        Element element = new Element(elementName);
        try {
            Thread.sleep(250);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        element.selectOptionInDropDownFieldByText(optionText);
    }

    public void selectOptionByValue(String elementName, String optionValue) {
        Element.waitForLoadingIconToBeNotPresentStatic();
        Element element = new Element(elementName);
        element.selectOptionInDropDownFieldByValue(optionValue);
    }

    public void selectOptionByIndex(String elementName, String optionIndex) {
        Element element = new Element(elementName);
        element.selectOptionInDropDownFieldByIndex(optionIndex);
    }
    public void selectFirstOptionInDropDownField(String elementName) {
        Element element = new Element(elementName);
        element.selectFirstOptionInDropDownField();
    }

    public void fillCalendarDialogWithDateTimeValue(String elementName, String dateTime) {
        Element element = new Element(elementName);
        element.clickElement();
        try {
            for (int i = 0; i < 5; i++) {
                element.sendKeysInElementKey("Backspace");
                Thread.sleep(75);
            }
            element.sendKeysInElementWithoutClear(dateTime.substring(0, 2));
            Thread.sleep(75);
            element.sendKeysInElementWithoutClear(dateTime.substring(3, 5));
            Thread.sleep(75);
            element.sendKeysInElementWithoutClear(dateTime.substring(6, 10));
            Thread.sleep(75);
            element.sendKeysInElementWithoutClear(dateTime.substring(11, 13));
            Thread.sleep(75);
            element.sendKeysInElementWithoutClear(dateTime.substring(14, 16));
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    public void fillCalendarDialogWithDateValue(String elementName, String date) {
        Element element = new Element(elementName);
        element.clickElement();
        try {
            for (int i = 0; i < 5; i++) {
                element.sendKeysInElementKey("Backspace");
                Thread.sleep(75);
            }
            element.sendKeysInElementWithoutClear(date.substring(0, 2));
            Thread.sleep(75);
            element.sendKeysInElementWithoutClear(date.substring(3, 5));
            Thread.sleep(75);
            element.sendKeysInElementWithoutClear(date.substring(6, 10));
            Thread.sleep(75);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
    public void fillCalendarDialogWithDateValueAndArrow(String elementName, String date) {
        Element element = new Element(elementName);
        element.clickElement();
        try {
            for (int i = 0; i < 5; i++) {
                element.sendKeysInElementKey("Backspace");
                Thread.sleep(75);
            }
            element.sendKeysInElementWithoutClear(date.substring(0, 2));
            Thread.sleep(75);
            element.sendKeysInElementWithoutClear(date.substring(3, 5));
            Thread.sleep(75);
            element.sendKeysInElementKey("ArrowRight");
            element.sendKeysInElementWithoutClear(date.substring(6, 10));
            Thread.sleep(75);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    public void selectDateTimeInCalendarFieldForEjar(String elementName, int days, int hours) {
        String dateTime = DateHelper.getCurrentDatePlusDaysAndHours(days, hours, "dd/MM/yyyy HH:mm");
        fillCalendarDialogWithDateTimeValue(elementName, dateTime);
    }

    public void selectDateTimeInCalendarFieldForEjarWithTimeValue(String elementName, int days, String time) {
        String dateTime = DateHelper.getCurrentDatePlusDaysAndHours(days, 0, "dd/MM/yyyy") + " " + time.trim();
        fillCalendarDialogWithDateTimeValue(elementName, dateTime);
    }

    public void selectDateInCalendarFieldForEjar(String elementName, int days) {
        String date = DateHelper.getCurrentDatePlusDays(days, "dd/MM/yyyy");
        fillCalendarDialogWithDateValue(elementName, date);
    }

    public void selectDateInCalendarFieldForEjarWithArrow(String elementName, int days) {
        String date = DateHelper.getCurrentDatePlusDays(days, "dd/MM/yyyy");
        fillCalendarDialogWithDateValueAndArrow(elementName, date);
    }

    public void selectOptionByTextInKendo(String elementName, String optionText) {
        selectOptionByTextInKendoWithoutClickOnEmptyMethod(elementName, optionText);
        Element emptyElement = new Element("ejar.header.element.byxpath");
        emptyElement.clickElement();
    }

    public void selectOptionByTextInKendoThenClickOnSpecificFieldMethod(String elementName, String optionText, String anotherElementToClick) {
        selectOptionByTextInKendoWithoutClickOnEmptyMethod(elementName, optionText);
        Element emptyElement = new Element(anotherElementToClick);
        emptyElement.clickElement();
    }

    public void selectOptionByTextInKendoWithoutClickOnEmptyMethod(String elementName, String optionText) {
        Element element = new Element(elementName);
        element.clickElement();
        try {
            Thread.sleep(250);
            element.sendKeysInElementWithoutClear(optionText);
            Thread.sleep(250);
            Element optionToClick = new Element("dynamic.option.in."+elementName, "//li[@role='option' and contains(.,'" + optionText.trim() + "')]");
            optionToClick.waitForElement(ElementStatus.PRESENT,Integer.parseInt(PropManager.getInstance().getProperty("driver.element.wait")));
            optionToClick.clickElement();
            Thread.sleep(250);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

    }

    public void selectOptionByTextInKendoWithoutClickOnEmptyMethodWithSpecification(String elementName, String optionText, int waitPeriod) {
        Element element = new Element(elementName);
        element.clickElement();
        try {
            Thread.sleep(waitPeriod);
            element.sendKeysInElementWithoutClear(optionText);
            Thread.sleep(waitPeriod);
            new Element("dynamic.option.in."+elementName, "//li[@role='option' and contains(.,'" + optionText.trim() + "')]").clickElement();
            Thread.sleep(waitPeriod);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

    }


    public void selectFirstOptionByTextInKendo(String elementName) {
        Element element = new Element(elementName);
        element.clickElement();
        try {
            Thread.sleep(250);
//            element.sendKeysInElement(optionText);
            Thread.sleep(250);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
//        new Element(elementName, "//li[@role='option' and contains(.,'" + optionText.trim() + "')]").clickElement();
        Element emptyElement = new Element("ejar.header.element.byxpath");
        emptyElement.clickElement();
    }


    public void selectOptionByTextInKendoWithoutWithoutTypingWithoutClickEmpty(String elementName, String optionText) {
        Element element = new Element(elementName);
        element.waitForElementToBeClickable();
        try {
            Thread.sleep(200);
            element.clickElement();
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        new Element(elementName, "//li[@role='option' and contains(.,'" + optionText.trim() + "')]").waitForElementToBeClickable();
        new Element(elementName, "//li[@role='option' and contains(.,'" + optionText.trim() + "')]").clickElement();
    }

    public void selectOptionByTextInKendoWithoutWithoutTypingWithoutClickEmpty(Element element, String optionText) {
        element.waitForElementToBeClickable();
        try {
            Thread.sleep(500);
            element.clickElement();
            Thread.sleep(250);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        new Element(element.getLocatorName(), "//li[@role='option' and contains(.,'" + optionText.trim() + "')]").clickElement();
    }

    public void electOptionInDropdownTreeViewMutiliselectFieldSMethod(String elementName, String optionText) {
        Element element = new Element(elementName);
        element.waitForElementToBeClickable();
        try {
            Thread.sleep(500);
            element.clickElement();
            Thread.sleep(250);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        new Element(elementName, "//kendo-treeview//li//span[contains(.,'"+ optionText.trim() +"')]//preceding-sibling::kendo-checkbox//input").clickElement();
        element.clickElement();
    }

    public void selectOptionByTextInKendoWithoutWithoutTyping(String elementName, String optionText) {
        Element element = new Element(elementName);
        element.waitForElementToBeClickable();
        try {
            Thread.sleep(250);
            element.clickElement();
            Thread.sleep(250);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        new Element(elementName, "//li[@role='option' and contains(.,'" + optionText.trim() + "')]").clickElement();
        Element emptyElement = new Element("ejar.header.element.byxpath");
        emptyElement.clickElement();
    }
    public void selectOptionByIndexInKendoWithoutWithoutTyping(String elementName, String optionIndex) {
        Element element = new Element(elementName);
        element.waitForElementToBeClickable();
        try {
            Thread.sleep(250);
            element.clickElement();
            Thread.sleep(250);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        new Element(elementName, "//li[@role='option' and @index='" + optionIndex.trim() + "']").clickElement();
        Element emptyElement = new Element("ejar.header.element.byxpath");
        emptyElement.clickElement();
    }

    public void selectOptionByIndexInKendoOptionField(String elementName, int index) {
        try {
            Thread.sleep(1000);
            Element element = new Element(elementName);
            element.clickElement();

            Thread.sleep(150);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        Element optionElement = new Element("ejar.options.fields.list.byxpath");
        List<Locator> optionsElement = optionElement.getChildWebElementFromElement(ElementStatus.PRESENT);
        optionsElement.get(index).click();
    }


    public String getPropertyTextValueBasedOnLanguage(String propertyName1) {
        if (PropManager.getInstance().getProperty("execution.lang").equals("en"))
            return PropManager.getInstance().getProperty(propertyName1 + ".en");
        else
            return PropManager.getInstance().getProperty(propertyName1 + ".ar");
    }

    public String returnStringBasedOnLanguage(String text) {
        if (PropManager.getInstance().getProperty("execution.lang").equals("en"))
            text = text.split(",")[0].trim();
        else
            text = text.split(",")[1].trim();
        return text;
    }

    public void verifyElementTextPresent(String elementName, String textToVerifyProperty) {
        Element element = new Element(elementName);
        String textToVerify = getPropertyTextValueBasedOnLanguage(textToVerifyProperty);
        element.verifyElementText(textToVerify.trim());
    }

    public void verifyElementTextPresent(Element element, String textToVerifyProperty) {
        String textToVerify = getPropertyTextValueBasedOnLanguage(textToVerifyProperty);
        element.verifyElementText(textToVerify.trim());
    }

    public void verifyElementContainsText(String elementName, String textToVerifyProperty) {
        Element element = new Element(elementName);
        String textToVerify = getPropertyTextValueBasedOnLanguage(textToVerifyProperty);
        element.verifyElementContainsText(textToVerify);
    }

    /**
     * this is to modify the css style to be visible for the provided web element
     *
     * @param elementName the element name
     */
    public void modifyActionCssStyleToBeVisible(String elementName) {

    }

    /**
     * to click submit action for the provided element as argument
     *
     * @param elementName the element name
     */
    public void clickElementSubmitAction(String elementName) {
        Element element = new Element(elementName);
        element.getWebElement().evaluate("el => el.form && el.form.submit()");
    }

    public void scrollToTheTopOfPage() {
        DriverFactory.getDriver().evaluate("window.scrollTo(0, 0)");
    }

    public void scrollToBottomOfPageAtOnce() {
        DriverFactory.getDriver().evaluate("window.scrollTo(1000000, 1000000)");
    }

    public void scrollToElement(String elementName) {
        Element element = new Element(elementName);
        element.getWebElement().evaluate("el => el.scrollIntoView(true)");
        scrollByPixcels(0, -100);
        try {
            Thread.sleep(5000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    public void scrollToBottomOfPage() {
        for (int i = 0; i < 15; i++) {
            DriverFactory.getDriver().evaluate("window.scrollBy(" + i * 250 + "," + i * 250 + ")");
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }

    public void clickOnElementUsingJavaScriptExecutorMethod(String elementName) {
        DriverFactory.getDriver().locator("xpath=" + new Element(elementName).getLocatorValue()).click();
    }

    public void scrollByPixcels(int x, int y) {
        DriverFactory.getDriver().evaluate("window.scrollBy(" + x + "," + y + ");");
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    public void selectCustomerNameInCustomerField(String elementName, String customerName, int index) {
        Element element = new Element(elementName);
        element.sendKeysInElement(customerName);
        Element customerRecordsDialog = new Element("ejar.customerList.records.dynamic.byxpath", "//div[contains(@class,'combobox-item-template')]//bdi");
        List<Locator> customerRecords = customerRecordsDialog.getChildWebElementFromElement(ElementStatus.VISIBLE);
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        customerRecords.get(index).click();
    }


    public void selectCustomerNameInCustomerFieldWithRandomIndex(String elementName, String customerName) {
        Element element = new Element(elementName);
        element.sendKeysInElement(customerName);
        Element customerRecordsDialog = new Element("ejar.customerList.records.dynamic.byxpath", "//div[contains(@class,'combobox-item-template')]//bdi");
        List<Locator> customerRecords = customerRecordsDialog.getChildWebElementFromElement(ElementStatus.VISIBLE);
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        int index = new Random().nextInt(customerRecords.size() - 1);
        customerRecords.get(index).click();
    }



    public void selectValueInSearchField(String elementName, String inputValue, int index) {
        Element element = new Element(elementName);
        element.sendKeysInElement(inputValue);
        element.clickElement();
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        Element valueRecordsDialog = new Element("ejar.valuesList.records.dynamic.byxpath", "//kendo-list//div//li");
        List<Locator> valueRecords = valueRecordsDialog.getChildWebElementFromElement(ElementStatus.VISIBLE);
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        valueRecords.get(index).click();
    }


    public void waitForActionToBeClickable(String elementName) {
        Element element = new Element(elementName);
        element.waitForElementToBeClickable();
    }

    public void selectCarInContractPage() {
        List<Locator> plateCards = new Element("ejar.contract.cars.cards.byxpath").getChildWebElementFromElement(ElementStatus.VISIBLE);
        new Element("dynamic.car.cards.byxpath", "(//div[contains(@class,'card')]//img)[" + plateCards.size() + "]").clickElement();
    }

    public void verifyCountOfElement(String elementName, int count) {
        Element element = new Element(elementName);
        List<Locator> elements = element.getChildWebElementFromElement(ElementStatus.PRESENT);
        Assert.assertEquals("The number of elements expected: " + count + " ,didn't match the actual number of elements: " + elements.size() + " ,for element with name: " + elementName + " ,with xpath: " + element.getLocatorValue(), count, elements.size());
    }


    public void verifyCountOfElement(String elementName, int count, String status) {
        Element element = new Element(elementName);
        List<Locator> elements = element.getChildWebElementFromElement(status.equalsIgnoreCase("present") ? ElementStatus.PRESENT : ElementStatus.VISIBLE);
        Assert.assertEquals("The number of elements expected: " + count + " ,didn't match the actual number of elements: " + elements.size() + " ,for element with name: " + elementName + " ,with xpath: " + element.getLocatorValue(), count, elements.size());
    }

    public void clickOnActionIfExist(String elementName) {
        new Element(elementName).clickOnElementIfExist();
    }

    public void clickOnActionIfExist(String elementName,String numberOfSecond) {
        new Element(elementName).clickOnElementIfExist( elementName,numberOfSecond);
    }

    public void changeBrowserWindowZoomLevel(double zoomLevel) {
        DriverFactory.getDriver().evaluate("document.body.style.zoom = '" + zoomLevel + "'");
    }

    public void verityTextPresentAfterRemovingSpaces(String text) {
        com.microsoft.playwright.Locator loc = DriverFactory.getDriver().locator("xpath=//*[contains(normalize-space(.),'" + text + "') or contains(.,'" + text + "')]");
        if (loc.count() == 0) {
            Assert.fail("The intended text: " + text);
        }
    }


    public void verityTextNotPresentAfterRemovingSpaces(String text) {
        com.microsoft.playwright.Locator loc = DriverFactory.getDriver().locator("xpath=//*[contains(normalize-space(.),'" + text + "') or contains(.,'" + text + "')]");
        if (loc.count() > 0) {
            Assert.fail("The intended text: " + text);
        }
    }

    public void selectDateInCalendarFieldForYelo(String elementName, int days, int minutes, String format) {
        String dateTime = DateHelper.getCurrentDatePlusDaysOrHoursOrMinutes(days, 0, 0, format);

        Element element = new Element(elementName);
        String id = element.getWebElement(ElementStatus.PRESENT).getAttribute("id");
        if (id != null) {
            element.executeJsQuery("document.getElementById('" + id + "').setAttribute('type','')");
            element.executeJsQuery("document.getElementById('" + id + "').removeAttribute('type')");
        }
        element.getWebElement().clear();
        element.getWebElement().fill(dateTime);
    }

    public void selectDateInCalendarFieldForYelo(String elementName, String activeDay, int days, int minutes, String format) {
        String dateTime = DateHelper.getCurrentDatePlusDaysOrHoursOrMinutes(days, 0, 0, format);
        Element element = new Element(elementName);
        element.clickElement();
        new Element(activeDay).clickElement();
        String id = element.getWebElement(ElementStatus.PRESENT).getAttribute("id");
        if (id != null) {
            element.executeJsQuery("document.getElementById('" + id + "').setAttribute('type','')");
            element.executeJsQuery("document.getElementById('" + id + "').removeAttribute('type')");
        }
        element.getWebElement().clear();
        element.getWebElement().fill(dateTime);
    }

    public void selectTimeInCalendarFieldForYelo(String elementName, int days, int minutes, String format) {
        String dateTime = DateHelper.getCurrentDatePlusDaysOrHoursOrMinutes(days, 0, minutes, format);
        int roundedMinutes = (int) (30 * (Math.round(Double.parseDouble(dateTime.substring(3, 5)) / 30)));
        dateTime = dateTime.replaceAll(":..", ":" + String.format("%02d", roundedMinutes));
        Element element = new Element(elementName);
        String id = element.getWebElement().getAttribute("id");
        if (id != null) element.executeJsQuery("document.getElementById('" + id + "').removeAttribute('readonly')");
        element.setValueInElement(dateTime);
        new Element("PickUpReturnLocation.byxpath","//div[@id='pikup-return-location-container']//label[not(preceding-sibling::input)]").clickElement();
    }

    public void selectDateInCalendarFieldForYeloV2(String elementName, int days, int minutes, String format) {
        String dateTime = DateHelper.getCurrentDatePlusDaysOrHoursOrMinutes(days, 0, minutes, format);
        String day = dateTime.split("/")[0];
        String month = dateTime.split("/")[1];
        clickElement(elementName);
        Element newMonth;
        Element newDay;

        String currentMonthYearString = DateHelper.getCurrentDatePlusDaysOrHoursOrMinutes(0, 0, 0, "d/MMMM/yyyy");
        String currentYear = currentMonthYearString.split("/")[2];
        String currentMonth = currentMonthYearString.split("/")[1];
        Element currentMonthYear = new Element("yelo.currentMonthYear.span.byxpath","(//div[@class='datepicker-days']//th[@class='datepicker-switch'])[1]");
            currentMonthYear.clickElement();
            newMonth = new Element("yelo.newMonth.span.byxpath", "//div[contains(@class,'months')  and not(@style='display: none;')]//span[normalize-space()='" + month + "']");
            clickOnActionIfExist("yelo.homepage.pickupMonth.th.byxpath");
            newMonth.clickElement();
             newDay= new Element("yelo.newDay.td.byxpath", "( //div[@id='range-date-piker']//td[not(contains(@class,'disable')) and normalize-space()='" + day + "'] )[1]");
             newDay.clickElement();

    }

    public void setTimeInCalendarFieldForYeloV2(String elementName, String time,Boolean isReturn) {
    Element newTime;
        if(!isReturn) {
            clickOnActionIfExist("yelo.homepage.backReturnCalendar.button.byxpath");
            newTime = new Element(elementName, "//div[@id='pickup-time-piker']//li[not (contains(@class,'disable')) and normalize-space()='" + time + "']");
            newTime.clickElement();
        }
        else {
            newTime = new Element(elementName,"//div[@id='return-time-piker']//li[not (contains(@class,'disable')) and normalize-space()='" + time + "']");
            newTime.clickElement();
        }
    }

    public void selectDateInCalendarFieldForSaas(String elementName, int days, int minutes, String format,Boolean isPickup) {
        String dateTime = DateHelper.getCurrentDatePlusDaysOrHoursOrMinutes(days, 0, minutes, format);
        GenericStepDefs genericStepDefs = new GenericStepDefs();
        String day = dateTime.split("/")[0];
        String month = dateTime.split("/")[1];
        genericStepDefs.scrollToTheTop();
        if(isPickup) {
            clickElement(elementName);
            genericStepDefs.clickOnElementIfElementNotPresent(elementName,"alyam.editBooking.calendar.div.byxpath","5");
            System.out.println("The calendar was not present clicking again");
        }
        Element dayMonth = new Element("saas.dayMonth.td.byxpath","//div[contains(@class,'calendar')]//table[descendant::th[contains(.,'"+month+"')]]//td[(not(contains(@class,'off end')) and contains(@class,'available')) and normalize-space()='"+day+"']");
        dayMonth.clickElement();
    }

    public void setTimeInCalendarFieldForSaas(String time,Boolean isPickup) {
        String index = isPickup ? "[1]" : "[2]";

        String xpathHours = "(//select[@class='hourselect'])" + index;
        String xpathMinutes = "(//select[@class='minuteselect'])" + index;
        String xpathTimeNotation = "(//select[@class='ampmselect'])" + index;

        String[] timeParts = time.split(" ");
        String[] hmParts = timeParts[0].split(":");

        String hour = hmParts[0];
        String minutes =hmParts[1];
        String timeNotation =timeParts[1].toUpperCase();

        Element newHour = new Element("saas.hour.select.byxpath", xpathHours);
        Element newMinutes = new Element("saas.hour.select.byxpath",xpathMinutes);
        Element newTimeNotation = new Element("saas.hour.select.byxpath",xpathTimeNotation);

        newHour.selectOptionInDropDownFieldByValue(hour);
        newMinutes.selectOptionInDropDownFieldByValue(minutes);
        newTimeNotation.selectOptionInDropDownFieldByValue(timeNotation);
    }

    /**
     * Yelo home time widget does not close on Escape; {@code fill()} can leave the list open.
     * Prefer clicking the matching list row, then neutral targets outside the overlay (location label, hero).
     */


    public void setTimeInCalendarFieldForYelo(String elementName, String time) {
        Element element = new Element(elementName);
        String id = element.getWebElement().getAttribute("id");
        if (id != null) element.executeJsQuery("document.getElementById('" + id + "').removeAttribute('readonly')");
        element.setValueInElement(time);
        new Element("PickUpReturnLocation.byxpath","//div[@id='pikup-return-location-container']//label[not(preceding-sibling::input)]").clickElement();
    }


    public void uploadFileToElement(String elementName, String filePath) throws IOException, InterruptedException {
        Element element = new Element(elementName);
        String filePathFinal = System.getProperty("user.dir") + filePath;
        System.out.println("filePathFinal: " + filePathFinal);
        element.waitForElement(ElementStatus.PRESENT, 1).setInputFiles(Paths.get(filePathFinal));
        waitForPageToLoad();
    }

    public String returnElementAttributeValue(String elementName, String attributeName) {
        Element element = new Element(elementName);
        return element.getWebElement(ElementStatus.PRESENT).getAttribute(attributeName);
    }

    public void checkAttributeContainsValue(String elementName, String attributeName, String value, boolean condition) {
        String attributeValue = returnElementAttributeValue(elementName, attributeName);
        if (condition)
            Assert.assertTrue("The attribute: (" + attributeName + ") ,doesn't contain the intended value: (" + value + ") ,in the element: (" + elementName + ")", attributeValue.contains(value));
        else
            Assert.assertTrue("The attribute: (" + attributeName + ") ,does contain the intended value: (" + value + ") ,in the element: (" + elementName + ") ,and it should not!", !attributeValue.contains(value));

    }

    public void checkElementEmptyAttributeOrNotContainsAttribute(String elementName, String attributeName) {
        String attributeValue = returnElementAttributeValue(elementName, attributeName);
        Assert.assertTrue("The attribute: (" + attributeName + ") , contains non empty value ,in the element: (" + elementName + ")", attributeValue == null || attributeValue.trim().equals(""));
    }

    public void verifyEmailBookingId(String bookingId, String email, String password) {
        EmailValidator emailValidator = new EmailValidator(email, password);
        String emailBookingId = emailValidator.getBookingReferenceFromEmail("alwefaq");

        String bookingIdValue = ScenarioContextSingleton.getInstance().getContextValue(bookingId);

        Assert.assertEquals("The booking id in the email: " + emailBookingId + " ,The booking id provided in the booking process: " + bookingIdValue, bookingIdValue, emailBookingId);
    }

    public void verifyEmailBookingRentalTotal(String rentalTotal, String email, String password) {
        EmailValidator emailValidator = new EmailValidator(email, password);
        double emailRentalTotal = emailValidator.getRentalTotalFromLatestEmail("alwefaq");
        double rentalTotalValue = Double.parseDouble(ScenarioContextSingleton.getInstance().getContextValue(rentalTotal));
        Assert.assertEquals("The booking rental total in the email: " + emailRentalTotal + " ,The booking id provided in the booking process: " + rentalTotalValue, rentalTotalValue, emailRentalTotal, 0.0);
    }

    public void checkIfElementValuesInRange(String elementName, String minPriceElementName, String maxPriceElementName) {
        scrollByPixcels(0, 1100);
        while (new Element("yelo.search.loadMore.byxpath").checkElementPresent(ElementStatus.VISIBLE, 10)) {
            clickElement("yelo.search.loadMore.byxpath");
            Element.waitForLoadingIconToBeNotPresentStatic();
            scrollByPixcels(0, 1100);
        }
        List<Locator> element = new Element(elementName).getChildWebElementFromElement(ElementStatus.PRESENT);
        double minPrice = Double.parseDouble(new Element(minPriceElementName).getWebElement().getAttribute("aria-valuenow"));
        double maxPrice = Double.parseDouble(new Element(maxPriceElementName).getWebElement().getAttribute("aria-valuenow"));
        for (int i = 0; i <= element.size() - 1; i++) {
            String value = element.get(i).innerText().trim().replaceAll("(?!([+-]?([0-9]*[.])?[0-9]+)).", "");
            Assert.assertTrue("The actual value: " + value + " ,was not within the expected range, the min value was: " + minPrice + " ,and the max value was: " + maxPrice, Double.parseDouble(value) >= minPrice && Double.parseDouble(value) <= maxPrice);
        }
    }

    public void dragElement(String elementName, int xDistance, int yDistance) {
        Element element = new Element(elementName);
        element.dragElement(xDistance, yDistance);
    }

    public void verifyTextEqualsForElements(String elementName, String intendedElement) {
        List<Locator> elements = new Element(elementName).getChildWebElementFromElement(ElementStatus.PRESENT);
        String intendedByElementText = (new Element(intendedElement).getWebElement()).innerText();

        for (int i = 0; i <= elements.size() - 1; i++) {
            String elementText = elements.get(i).innerText();
            Assert.assertEquals("The actual element text: " + elementText + " is not the same as expected: " + intendedByElementText, elementText, intendedByElementText);
        }
    }

    public void ValidateCountOfElements(int count, String elementName) {
        List<Locator> elements = new Element(elementName).getChildWebElementFromElement(ElementStatus.PRESENT);
        Assert.assertTrue("Elements Count: " + elements.size() + " is not the same as expected: " + count, elements.size() == count);
    }

    public void clickOnCurrency(String currencyName) {
        clickElementWithXpath("yelo.currency.changeCurrency.a.byxpath", "(//li[input[contains(@data-action,'changeCurrency')] and contains(normalize-space(.), '"+currencyName+"')])[1]");
    }

    public void clickOnForgetPasswordlink(String email, String password) {
        EmailValidator emailValidator = new EmailValidator(email, password);
        String forgetPasswordLink = emailValidator.getResetPasswordLink("Reset Password Request");
        navigateToUrl(forgetPasswordLink);
    }

    public void ValidateRefundAmountAfterCancel(String expectedRefundAmount, String email, String password) {
        EmailValidator emailValidator = new EmailValidator(email, password);
        String refundAmount = emailValidator.getRefundAmountAfterCancel("Your transaction has been refunded");
        Assert.assertTrue("Refund Amount: " + refundAmount + " is not the same as expected: " + expectedRefundAmount, expectedRefundAmount == refundAmount);
    }

    public void selectExtras(int extrasCount) {
        Element element = new Element("yelo.pay.element.label.byxpath");
        String elementLocatorValue = element.getLocatorValue();

        for (int i = 1; i <= extrasCount; i++) {
            clickElementWithXpath("yelo.pay.extra.i.label.byxpath", elementLocatorValue + "[" + i + "]");
            clickOnActionIfExist("yelo.pay.agreeExtra.button.byxpath");
        }
    }

    public void removeAttribute(String elementIdKey, String attributeName) {

        String elementIdValue = PropManager.getInstance().getProperty(elementIdKey);

        System.out.println("Removing attribute " + attributeName + "for element with id: " + elementIdValue);

        DriverFactory.getDriver().evaluate("document.getElementById('" + elementIdValue + "').removeAttribute('" + attributeName + "')");
    }

    public void removeAttributeWithElementName(String elementName, String attributeName) {

        Element element = new Element(elementName);
        element.getWebElement().evaluate("el => el.removeAttribute('" + attributeName + "')");
    }

    public void openOtherBrowserTab(String url) {
        Page current = DriverFactory.getDriver();
        Page newPage = current.context().waitForPage(() -> {
            current.evaluate("window.open('" + url.replace("'", "\\'") + "','_blank')");
        });
        if (newPage != null) {
            DriverFactory.setCurrentPage(newPage);
        }
        waitForPageToLoad();
    }

    public void switchToBrowserTab(int tabIndex) {
        List<Page> pages = DriverFactory.getBrowserContext().pages();
        if (tabIndex < pages.size()) {
            Page p = pages.get(tabIndex);
            p.bringToFront();
            DriverFactory.setCurrentPage(p);
        }
        waitForPageToLoad();
    }

    public void setValueIntoElementByContextKey(String targetElementName, String contextKey) {
        waitForPageToLoad();
        String value = ScenarioContextSingleton.getInstance().getContextValue(contextKey);
        new Element(targetElementName).setValueInElement(value);
    }

    public void setValueIntoElementByValue(String targetElementName, String value) {
        waitForPageToLoad();
        new Element(targetElementName).setValueInElement(value);
    }

    public void validatetoolTip(String toolTipElementName, String elementName) {
        Element element = new Element(elementName);
        Element toolTipElement = new Element(toolTipElementName);
        element.validatetoolTip(toolTipElement);
    }

    public void clickElementById(String elementId) {
        Element.waitForLoadingIconToBeNotPresentStatic();
        waitForPageToLoad();
        DriverFactory.getDriver().evaluate("document.getElementById('" + elementId + "').click()");
        Element.waitForLoadingIconToBeNotPresentStatic();
    }

    public void validateListOfElementsText(String elementName, String textToVerifyProperty) {
        scrollByPixcels(0, 1100);
        while (new Element("yelo.search.loadMore.byxpath").checkElementPresent(ElementStatus.VISIBLE, 10)) {
            clickElement("yelo.search.loadMore.byxpath");
            Element.waitForLoadingIconToBeNotPresentStatic();
            scrollByPixcels(0, 1100);
        }

        String textToVerify = getPropertyTextValueBasedOnLanguage(textToVerifyProperty);

        List<Locator> elements = new Element(elementName).getChildWebElementFromElement(ElementStatus.PRESENT);
        for (int i = 0; i < elements.size(); i++) {
            String elementText = elements.get(i).innerText().trim();
            Assert.assertEquals("The first value: " + elementText + " , didn't match the second value: " + textToVerify, elementText, textToVerify);
        }
    }

    void simulateClickingOnKey(String keyName) {
        DriverFactory.getDriver().keyboard().press(keyName);
    }


    public void sendKeysToElement(String elementName, String keys) {
        Element element = new Element(elementName);
        element.sendKeysInElement(keys);
    }

    public void sendKeysToElement(String elementName, String keys, Integer delay) {
        Locator.PressSequentiallyOptions pressOptions = new Locator.PressSequentiallyOptions().setDelay(delay);
        Element element = new Element(elementName);
        element.sendKeysInElement(keys, pressOptions);
    }


}