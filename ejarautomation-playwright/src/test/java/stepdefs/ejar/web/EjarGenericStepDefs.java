package stepdefs.ejar.web;

import automation.framework.Element;
import automation.framework.ScenarioContextSingleton;
import automation.framework.beans.FieldValidationResult;
import automation.framework.beans.HtmlTableBuilderForSoftAssertions;
import automation.framework.business.RegxHelper;
import automation.framework.business.StringHelper;
import automation.framework.propmanager.PropManager;
import automation.framework.threadData.DriverFactory;
import automation.framework.threadData.TestData;
import com.aventstack.extentreports.cucumber.adapter.ExtentCucumberAdapter;
import com.microsoft.playwright.Locator;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import stepdefs.generic.GenericStepDefs;
import com.microsoft.playwright.Page;
import java.io.IOException;
import java.time.LocalTime;
import java.time.temporal.ChronoUnit;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
public class EjarGenericStepDefs {

    GenericStepDefs genericStepDefs = new GenericStepDefs();
    EjarPages ejarPages = new EjarPages();

    ThreadLocal<String> vehiclePlateNumber = new ThreadLocal<>();
    ThreadLocal<String> employeeFirstNameLocal = new ThreadLocal<>();

    public static String returnPathOfElementBasedOnEditableOrNot(String formName, String fieldLabel, boolean expectedToBeEditable) {
        if (expectedToBeEditable) return "//" + formName + "//label[text()='" + fieldLabel + "']";
        else return "//label[text()='" + fieldLabel + "']/following-sibling::label";
    }

    @Given("^switch to language property$")
    public void switchToLanguagePropertyStepDef() {
        if (PropManager.getInstance().getProperty("execution.lang").equals("ar"))
            genericStepDefs.clickElement("ejar.loginpage.arabic.language.icon.byxpath");
    }

    @Then("^open page using url: (.*)$")
    public void openPageUsingUrl(String url) {
        genericStepDefs.navigateToUrl(PropManager.getInstance().getProperty("ejar.environment.url") + url.trim());
    }

    @Given("^ejar login with user name: (.*) and password: (.*)$")
    public void LoginWithUsernameAndPassword(String username, String password) {
        if (PropManager.getInstance().getProperty("execution.lang").equals("ar"))
            genericStepDefs.clickElement("ejar.loginpage.arabic.language.icon.byxpath");
        genericStepDefs.setValueInField("ejar.loginpage.username.byxpath", username);
        genericStepDefs.waitForSeconds(1);
        genericStepDefs.setValueInField("ejar.loginpage.password.byxpath", password);
        genericStepDefs.waitForSeconds(5);
        genericStepDefs.clickElement("ejar.loginpage.loginaction.byxpath");
        genericStepDefs.waitForElementNotPresent("ejar.loginpage.username.byxpath");
        genericStepDefs.waitForElementToBeVisible("ejar.dashboard.menu.title.byxpath", 240);
        genericStepDefs.verifyPageIsDisplayed("/app/main/dashboard");
    }

    @Given("^set in the users view search field with the stored name$")
    public void searchForTheEmployeeWithTheStoredName() {
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        genericStepDefs.setValueIntoElement_V2(employeeFirstNameLocal.get(), "ejar.user.view.search.field.byxpath");

    }

    @Given("^create employee with random name and store name in variable: (.*)$")
    public void createNewEmployeeWithRandomName(String variableName) {
        genericStepDefs.clickElement("ejar.employees.createnew.button.byxpath");
        String employeeFirstName = "UI Employee" + " " + StringHelper.getRandomStringOfSize(Integer.parseInt("7"));
        ScenarioContextSingleton.getInstance().setContextValue(variableName.trim(),employeeFirstName.trim());
        genericStepDefs.setValueIntoElement(employeeFirstName, "ejar.employees.firstName.field.byxpath");
        genericStepDefs.setValueIntoElement("UI Employee" + " " + StringHelper.getRandomStringOfSize(Integer.parseInt("7")), "ejar.employees.secondName.field.byxpath");
        genericStepDefs.setValueIntoElement("UI Employee" + " " + StringHelper.getRandomStringOfSize(Integer.parseInt("7")), "ejar.employees.familyName.field.byxpath");

        String optionText = "Saudi,سعودي";
        if (PropManager.getInstance().getProperty("execution.lang").equals("en"))
            optionText = optionText.split(",")[0].trim();
        else optionText = optionText.split(",")[1].trim();
        genericStepDefs.selectOptionByText("ejar.employees.nationalityCombobox.field.byxpath", optionText);
        genericStepDefs.waitForSeconds(1);

        String optionText2 = "Male,ذكر";
        if (PropManager.getInstance().getProperty("execution.lang").equals("en"))
            optionText2 = optionText2.split(",")[0].trim();
        else optionText2 = optionText2.split(",")[1].trim();
        genericStepDefs.selectOptionByText("ejar.employees.genderCombobox.field.byxpath", optionText2);
        genericStepDefs.waitForSeconds(1);

        String optionText3 = "Saudi Arabia, المملكة العربية السعودية";
        if (PropManager.getInstance().getProperty("execution.lang").equals("en"))
            optionText3 = optionText3.split(",")[0].trim();
        else optionText3 = optionText3.split(",")[1].trim();
        genericStepDefs.selectOptionByText("ejar.employees.workingCountryCombobox.field.byxpath", optionText3);
        genericStepDefs.waitForSeconds(1);

        genericStepDefs.setValueIntoElement(StringHelper.getRandomNumberOfSize(Integer.parseInt("10")), "ejar.employees.employeeNumber.field.byxpath");
        genericStepDefs.clickElement("ejar.employees.save.button.byxpath");
        genericStepDefs.clickElement("ejar.generic.yes.action.byxpath");

    }

    @Then("^click on menu link: (.*)$")
    public void clickOnMenuLinkStepDef(String element) {
        genericStepDefs.clickElement(element);
        genericStepDefs.clickElement("ejar.header.element.byxpath");
    }

    @Then("^user select date time in ejar calendar field: (.*) plus days: (.*) and plus hours: (.*)$")
    public void selectDateTimeInEjarCalendarStepDefs(String elementName, int days, int hours) {
        genericStepDefs.selectDateTimeInCalendarFieldForEjar(elementName, days, hours);
    }

    @Then("^user select date in ejar calendar field: (.*) plus days: (.*)$")
    public void selectDateInEjarCalendarStepDefs(String elementName, int days) {
        genericStepDefs.selectDateInCalendarFieldForEjar(elementName, days);
    }
    @Then("^user select date in ejar calendar field with arrow: (.*) plus days: (.*)$")
    public void selectDateInEjarCalendarWithArrowStepDefs(String elementName, int days) {
        genericStepDefs.selectDateInCalendarFieldForEjarWithArrow(elementName, days);
    }

    @Then("^user select date time in ejar calendar field: (.*) plus days: (.*) and time: (.*)$")
    public void selectDateTimeInWithTimeValueEjarCalendarStepDefs(String elementName, int days, String time) {
        genericStepDefs.selectDateTimeInCalendarFieldForEjarWithTimeValue(elementName, days, time);
    }

    @Then("^user select option by text in ejar kendo option field: (.*) option: (.*)$")
    public void selectOptionByTextInKendoStepDefs(String elementName, String optionText) {
        genericStepDefs.selectOptionByTextInKendo(elementName, genericStepDefs.getOptionBasedOnLang(optionText));
    }

    @Then("^user select option by text in ejar kendo option field: (.*) option is: (.*) then click on specific field: (.*)$")
    public void selectOptionByTextInKendoThenClickOnSpecificFieldStepDefs(String elementName, String optionText, String anotherElementToClick) {
        genericStepDefs.selectOptionByTextInKendoThenClickOnSpecificFieldMethod(elementName, genericStepDefs.getOptionBasedOnLang(optionText), anotherElementToClick);
    }

    @Then("^user select option by text in ejar kendo option field without click on empty field: (.*) option: (.*)$")
    public void selectOptionByTextInKendoWithClickOnEmptyStepDefs(String elementName, String optionText) {
        genericStepDefs.selectOptionByTextInKendoWithoutClickOnEmptyMethod(elementName, genericStepDefs.getOptionBasedOnLang(optionText));
    }

    @Then("^user select option by text in ejar kendo option field without click on empty field: (.*) with option value from stored variable: (.*)$")
    public void selectOptionByTextInKendoWithClickOnEmptyWithStoredValueStepDefs(String elementName, String variableName) {
        genericStepDefs.selectOptionByTextInKendoWithoutClickOnEmptyMethodWithSpecification(elementName, ScenarioContextSingleton.getInstance().getContextValue(variableName), 700);
    }

    @Then("^user select first option by text in ejar kendo option field: (.*)$")
    public void selectFirstOptionByTextInKendoStepDefs(String elementName) {
        genericStepDefs.selectFirstOptionByTextInKendo(elementName);
    }

    @Then("^user select option by text in ejar kendo option field without typing: (.*) option: (.*)$")
    public void selectOptionByTextInKendoWithoutTypingStepDefs(String elementName, String optionText) {
        genericStepDefs.selectOptionByTextInKendoWithoutWithoutTyping(elementName, genericStepDefs.getOptionBasedOnLang(optionText));
    }

    @Then("^user select option by index in ejar kendo option field without typing: (.*) index: (.*)$")
    public void selectOptionByIndexInKendoWithoutTypingStepDefs(String elementName, String index) {
        genericStepDefs.selectOptionByIndexInKendoWithoutWithoutTyping(elementName, index);
    }

    @Then("^user select option by text in ejar kendo option field without click on empty element and without typing: (.*) option: (.*)$")
    public void selectOptionByTextInKendoWithoutTypingWithtouClickingOnEmptyStepDefs(String elementName, String optionText) {
        genericStepDefs.selectOptionByTextInKendoWithoutWithoutTypingWithoutClickEmpty(elementName, genericStepDefs.getOptionBasedOnLang(optionText));
    }

    @Then("^user select option in dropdown tree view mutiliselect field: (.*) option: (.*)")
    public void electOptionInDropdownTreeViewMutiliselectFieldStepDefs(String elementName, String optionText) {
        genericStepDefs.electOptionInDropdownTreeViewMutiliselectFieldSMethod(elementName, genericStepDefs.getOptionBasedOnLang(optionText));
    }

    @Then("^select option in ejar kendo option field: (.*) by index: (.*)$")
    public void selectFirstOptionByInKendoStepDefs(String elementName, int index) {
        genericStepDefs.selectOptionByIndexInKendoOptionField(elementName, index);
    }

    @Then("^search for customer in customer search field: (.*) with name: (.*) then select record at index: (.*)$")
    public void selectCustomerInCustomerSearchFieldStepDef(String elementName, String customerName, int index) {
        genericStepDefs.selectCustomerNameInCustomerField(elementName, customerName, index);
    }

    @Then("^search for customer in customer search field: (.*) with name: (.*) then select record at random index$")
    public void selectCustomerInCustomerSearchFieldStepDef(String elementName, String customerName) {
        genericStepDefs.selectCustomerNameInCustomerFieldWithRandomIndex(elementName, customerName);
        Element.waitForLoadingIconToBeNotPresentStatic();
    }

    @Then("^search for value in search field: (.*) with name: (.*) then select record at index: (.*)$")
    public void selectValueInSearchField(String elementName, String optionText, int index) {
        genericStepDefs.selectValueInSearchField(elementName, genericStepDefs.getOptionBasedOnLang(optionText.trim()), index);
    }

    @Then("^search for value in search field: (.*) with value in variable: (.*) then select record at index: (.*)$")
    public void selectValueInSearchFieldFromVariable(String elementName, String variableName, int index) {
        genericStepDefs.selectValueInSearchField(elementName, ScenarioContextSingleton.getInstance().getContextValue(variableName.trim()), index);
    }

    @Then("^wait for action to be clickable: (.*)$")
    public void waitForActionToBeClickableStepDef(String elementName) {
        genericStepDefs.waitForActionToBeClickable(elementName);
    }

    @Then("^select latest car in contract page$")
    public void selectCarInContractPageStepDef() {
        Element.waitForLoadingIconToBeNotPresentStatic();
        genericStepDefs.selectCarInContractPage();
    }

    @Then("^verify ejar fields count in view: (.*) count: (.*)$")
    public void verifyFieldCountByTypeInViewStepDef(String viewName, int count) {
        ejarPages.verifyFieldCountByTypeInViewStep(genericStepDefs.getOptionBasedOnLangWithoutTrimFromParamDirectly(viewName), count);
    }

    @Then("^verify ejar fields label in view: (.*) text: (.*)$")
    public void verifyFieldLabelsStepDef(String viewName, String elementsLabelProperty) {
        viewName = genericStepDefs.getOptionBasedOnLangWithoutTrimFromParamDirectly(viewName);
//        ejarPages.checkElementsExpectedString(viewName + ".fields.labels" + ".byxpath", "//span[text()='" + viewName + "']//parent::div//parent::title-header//following-sibling::div//label[not(ancestor::*[contains(@class,'paginator')]) and not(ancestor::*[contains(@class,'k-pager-sizes')])]", elementsLabelProperty);
        ejarPages.checkElementsExpectedString(viewName + ".fields.labels" + ".byxpath", "//h1[contains(text(),'" + viewName + "')]/ancestor::ng-component[1]//*[local-name()='secondaryactionbar' or local-name()='sub-header']/following-sibling::div//label[not(ancestor::*[contains(@class,'paginator')]) and not(ancestor::*[contains(@class,'k-pager-sizes')])]", elementsLabelProperty);


    }

    @Then("^verify ejar fields label in the opened report view: (.*)$")
    public void verifyReportFieldsLabelStepDef(String expectedFieldsLabel) {
        ejarPages.checkElementsExpectedString("ejar.report.view.preview.fields.labels.byxpath", expectedFieldsLabel);
    }

    @Then("^verify ejar buttons label in the opened report view: (.*)$")
    public void verifyReportButtonsLabelStepDef(String expectedFieldsLabel) {
        ejarPages.checkElementsExpectedString("ejar.report.view.preview.buttons.byxpath", expectedFieldsLabel);
    }

    @Then("^verify ejar fields count in the opened report view: (.*)$")
    public void verifyReportFieldsCountStepDef(int fieldsCount) {
        genericStepDefs.waitForElementPresentHere("ejar.report.view.preview.fields.byxpath",60);
        genericStepDefs.waitForSeconds(1);
        ejarPages.verifyCountOfElement("ejar.report.view.preview.fields.byxpath", fieldsCount);
    }

    @Then("^verify ejar buttons label in view: (.*) text: (.*)$")
    public void verifyButtonsLabelsStepDef(String viewName, String buttonsLabelsProperty) {
        viewName = genericStepDefs.getOptionBasedOnLangWithoutTrimFromParamDirectly(viewName);
//        ejarPages.checkElementsExpectedString(viewName + ".buttons.labels" + ".byxpath", "//*[(local-name()='button' or local-name()='span') and contains(.,'" + viewName + "')]//parent::div//parent::title-header//following-sibling::div/button[not(ancestor::dropdowntreeviewmutiliselect) and not(ancestor::table)]", buttonsLabelsProperty);
        ejarPages.checkElementsExpectedString(viewName + ".buttons.labels" + ".byxpath", "//h1[contains(text(),'" + viewName + "')]/ancestor::ng-component[1]//*[local-name()='secondaryactionbar' or local-name()='sub-header']/following-sibling::div//button[not(contains(@class,'Popup')) and contains(@class,'btn') and not(ancestor::div[contains(@class,'AdvanceSearch')]) and not(ancestor::kendo-pager-page-sizes) and not(ancestor::confirmation-dialog) ]", buttonsLabelsProperty);
    }

    @Then("^verify ejar view secondary bar buttons in view: (.*) text: (.*)$")
    public void verifySecondaryBarActionsStepDef(String viewName, String buttonsLabelsProperty) {
        viewName = genericStepDefs.getOptionBasedOnLangWithoutTrimFromParamDirectly(viewName);
//        ejarPages.checkElementsExpectedString(viewName + ".secondary.bar.actions.labels" + ".byxpath", "//*[(local-name()='button' or local-name()='span' or local-name()='i') and contains(.,'" + viewName + "')]//ancestor::body//secondaryactionbar//button[contains(@class,'btn_wefaq_second_bar')]", buttonsLabelsProperty);
        ejarPages.checkElementsExpectedString(viewName + ".secondary.bar.actions.labels" + ".byxpath", "//h1[contains(text(),'" + viewName + "')]/ancestor::ng-component[1]//*[ local-name()='secondaryactionbar' or local-name()='sub-header' or local-name()='app-new-secondry-action-bar']//div[not(contains(@class,'advanced_search'))]/*[(local-name()='button' or local-name()='a') and contains(@class,'btn') and not(ancestor::div[contains(@class,'AdvanceSearch')])]", buttonsLabelsProperty);
    }

    @Then("^verify ejar view secondary bar buttons in view by xpath: (.*) text: (.*)$")
    public void verifySecondaryBarActionsByxpathStepDef(String buttonsXpath, String buttonsLabelsProperty) {
        ejarPages.checkElementsExpectedString("dynamic.secondary.bar.actions.labels" + ".byxpath", buttonsXpath, buttonsLabelsProperty);
    }

    @Then("^verify ejar view: (.*) table headers: (.*)$")
    public void verifyEjarViewTableHeadersStepDef(String viewName, String tableHeadersProperty) {
        viewName = genericStepDefs.getOptionBasedOnLangWithoutTrimFromParamDirectly(viewName);
        genericStepDefs.changeBrowserWindowZoomLevel(.2);
//        ejarPages.checkElementsExpectedString(viewName + ".table.header.labels" + ".byxpath", "//h1[contains(text(),'" + viewName + "')]/ancestor::ng-component[1]//table[ancestor::div[preceding-sibling::secondaryactionbar]]//thead//th[(contains(@class,'k-header') or contains(@class,'ng')) and not(ancestor::vehicle-history-grid) and not(ancestor::ejar-modal-template)] | //h1[contains(text(),'" + viewName + "')]/ancestor::ng-component[1]//table[ancestor::div[preceding-sibling::sub-header]]//thead//th[(contains(@class,'k-header') or contains(@class,'ng')) and not(ancestor::vehicle-history-grid) and not(ancestor::ejar-modal-template)]", tableHeadersProperty);
        ejarPages.checkElementsExpectedString(viewName + ".table.header.labels" + ".byxpath", "//h1[contains(text(),'" + viewName + "')]/ancestor::ng-component[1]//table[ancestor::div]//thead//th[(contains(@class,'k-header') or contains(@class,'ng')) and not(ancestor::*[@aria-hidden='true']) and not(ancestor::ejar-modal-template)] | //h1[contains(text(),'" + viewName + "')]/ancestor::ng-component[1]//table[ancestor::div]//thead//th[(contains(@class,'k-header') or contains(@class,'ng')) and not(ancestor::*[@aria-hidden='true']) and not(ancestor::ejar-modal-template)]", tableHeadersProperty);

        genericStepDefs.changeBrowserWindowZoomLevel(1);
    }


    @Then("^verify ejar view: (.*) table headers with filter: (.*)$")
    public void verifyEjarViewTableHeadersWithFilterStepDef(String viewName, String tableHeadersProperty) {
        viewName = genericStepDefs.getOptionBasedOnLangWithoutTrimFromParamDirectly(viewName);
        genericStepDefs.changeBrowserWindowZoomLevel(.2);
//        ejarPages.checkElementsExpectedString(viewName + ".table.headers.with.filter" + "." + ".byxpath", "//*[(local-name()='button' or local-name()='span') and contains(.,'" + viewName + "')]//ancestor::div//ancestor::title-header//following-sibling::div//table//thead//th//a", tableHeadersProperty);
        ejarPages.checkElementsExpectedString(viewName + ".table.headers.with.filter" + "." + ".byxpath", "//h1[contains(text(),'" + viewName + "')]/ancestor::ng-component[1]//table//thead//th[(contains(@class,'k-header') or contains(@class,'ng')) and not(ancestor::*[@aria-hidden='true']) and not(ancestor::ejar-modal-template) and contains(@class,'k-filterable')]", tableHeadersProperty);
        genericStepDefs.changeBrowserWindowZoomLevel(1);
    }

    @Then("^verify ejar view pages footer")
    public void verifyEjarViewFooterStepDef() {
        genericStepDefs.waitForElementToBeVisible("ejar.view.footer.section.byxpath");
        genericStepDefs.waitForElementToBeVisible("ejar.view.footer.action.first.page.byxpath");
        genericStepDefs.waitForElementToBeVisible("ejar.view.footer.action.previous.page.byxpath");
        genericStepDefs.waitForElementToBeVisible("ejar.view.footer.action.next.page.byxpath");
        genericStepDefs.waitForElementToBeVisible("ejar.view.footer.action.last.page.byxpath");
        genericStepDefs.waitForElementToBeVisible("ejar.view.footer.page.size.select.byxpath");
        genericStepDefs.waitForElementToBeVisible("ejar.view.footer.page.size.select.byxpath");
        genericStepDefs.waitForElementToBeVisible("ejar.view.footer.page.info.byxpath");
        genericStepDefs.toVerifyElementPresent("ejar.view.footer.page.size.select.byxpath");
        genericStepDefs.verifyElementContainsText("ejar.view.footer.page.size.section.byxpath", "ejar.view.footer.page.size.section.text");
        genericStepDefs.verifyElementContainsText("ejar.view.footer.page.info.byxpath", "ejar.view.footer.page.info.text");
    }

    @Then("^verify ejar report view standard actions present$")
    public void verifyReportViewStandardActionsStepDef() {
//        genericStepDefs.verifyElementContainsText("ejar.report.view.preview.header.byxpath", "ejar.report.view.preview.common.header.text");
        genericStepDefs.waitForElementToBeVisible("ejar.report.view.standard.action.first.page.byxpath");
        genericStepDefs.waitForElementToBeVisible("ejar.report.view.standard.action.previous.page.byxpath");
        genericStepDefs.waitForElementToBeVisible("ejar.report.view.standard.page.selector.byxpath");
        genericStepDefs.waitForElementToBeVisible("ejar.report.view.standard.action.next.page.byxpath");
        genericStepDefs.waitForElementToBeVisible("ejar.report.view.standard.action.last.page.byxpath");
        genericStepDefs.waitForElementToBeVisible("ejar.report.view.standard.action.toggle.multipage.byxpath");
        genericStepDefs.waitForElementToBeVisible("ejar.report.view.standard.action.zoon.out.byxpath");
        genericStepDefs.waitForElementToBeVisible("ejar.report.view.standard.zoom.level.editor.byxpath");
        genericStepDefs.waitForElementToBeVisible("ejar.report.view.standard.action.zoon.in.byxpath");
        genericStepDefs.waitForElementToBeVisible("ejar.report.view.standard.action.highlight.editing.fields.byxpath");
        genericStepDefs.waitForElementToBeVisible("ejar.report.view.standard.action.print.byxpath");
        ejarPages.checkElementsExpectedString("ejar.report.view.preview.buttons.byxpath", "ejar.report.view.preview.common.buttons.text");
    }

    @Then("^verify ejar report view toolbar present$")
    public void verifyReportViewToolBarStepDef() {
//        genericStepDefs.verifyElementContainsText("ejar.report.view.preview.header.byxpath", "ejar.report.view.preview.common.header.text");
        genericStepDefs.waitForElementToBeVisible("ejar.report.view.standard.action.first.page.byxpath");
        genericStepDefs.waitForElementToBeVisible("ejar.report.view.standard.action.previous.page.byxpath");
        genericStepDefs.waitForElementToBeVisible("ejar.report.view.standard.page.selector.byxpath");
        genericStepDefs.waitForElementToBeVisible("ejar.report.view.standard.action.next.page.byxpath");
        genericStepDefs.waitForElementToBeVisible("ejar.report.view.standard.action.last.page.byxpath");
        genericStepDefs.waitForElementToBeVisible("ejar.report.view.standard.action.toggle.multipage.byxpath");
        genericStepDefs.waitForElementToBeVisible("ejar.report.view.standard.action.zoon.out.byxpath");
        genericStepDefs.waitForElementToBeVisible("ejar.report.view.standard.zoom.level.editor.byxpath");
        genericStepDefs.waitForElementToBeVisible("ejar.report.view.standard.action.zoon.in.byxpath");
        genericStepDefs.waitForElementToBeVisible("ejar.report.view.standard.action.highlight.editing.fields.byxpath");
        genericStepDefs.waitForElementToBeVisible("ejar.report.view.standard.action.print.byxpath");
    }

    @Then("^mouse over ejar menu: (.*) and click on link: (.*)$")
    public void clickOnActionIfExistStepDef(String menuName, String pageLink) {
        ejarPages.clickOnMenuLink(genericStepDefs.getOptionBasedOnLang(menuName), pageLink);
    }

    @Then("^mouse over ejar menu: (.*) then mouse over sub menu: (.*) then click on link: (.*)$")
    public void clickOnSubMenuStepDef(String menuName, String subMenuName, String pageLink) {
        ejarPages.clickOnMenuLink(genericStepDefs.getOptionBasedOnLang(menuName), genericStepDefs.getOptionBasedOnLang(subMenuName), pageLink);
    }

    @Then("^verify ejar report standard actions$")
    public void verifyEjarReportStandardActionsStepDef() {
        ejarPages.verifyEjarReportStandardActions();
    }

    @Then("^verify ejar fields label in form: (.*) text: (.*)$")
    public void verifyFieldLabelsFormStepDef(String formName, String elementsLabelProperty) {
        ejarPages.checkElementsExpectedString(formName + ".fields.labels" + ".byxpath", "//" + formName + "//label", elementsLabelProperty);
    }

    @Then("^verify ejar fields label with soft assertion in form: (.*) text: (.*)$")
    public void verifyFieldLabelsFormStepDefWithSoftAssertion(String formName, String elementsLabelProperty) {
        genericStepDefs.waitForSeconds(3);
        ejarPages.checkElementsExpectedStringWithSoftAssertion(formName + ".fields.labels" + ".byxpath", "//" + formName + "//label[not(contains(@class,'inherited'))]", elementsLabelProperty);
    }

    @Then("^verify ejar fields label in form using xpath: (.*) text: (.*)$")
    public void verifyFieldLabelsUsingXpathStepDef(String xpath, String elementsLabelProperty) {
        genericStepDefs.changeBrowserWindowZoomLevel(.5);
        ejarPages.checkElementsExpectedString(xpath + ".fields.labels" + ".byxpath", xpath, elementsLabelProperty);
        genericStepDefs.changeBrowserWindowZoomLevel(1);
    }

    @Then("^verify form fields using labels xpath: (.*) text: (.*)$")
    public void verifyFormFieldLabelsUsingXpathStepDef(String xpath, String elementsLabelProperty) {
        genericStepDefs.changeBrowserWindowZoomLevel(.5);
        ejarPages.checkElementsExpectedString(xpath + ".fields.labels" + ".byxpath", xpath, elementsLabelProperty);
        genericStepDefs.changeBrowserWindowZoomLevel(1);
    }

    @Then("^verify ejar fields present using labels in form: (.*) text: (.*)$")
    public void verifyFieldsPresentUsingLabelsFormStepDef(String formName, String elementsLabelProperty) {
        String expectedString = genericStepDefs.getPropertyTextValueBasedOnLanguage(elementsLabelProperty);
        Arrays.stream(expectedString.split(",")).forEach(e -> genericStepDefs.waitForElementToBeVisible(formName + ".fields.present.using.label." + e + ".byxpath", "//" + formName + "//label [not(contains(@class, 'inherited-label')) and text()='" + e + "']//following-sibling::*[local-name()='input' or local-name()='select' or  local-name()='label' or parent::div//following-sibling::kendo-multiselect]"));
    }

    @Then("^verify list of elements present by labels in form: (.*) text: (.*)$")
    public void verifyListOfElementPresentByXpath(String xpathForElements, String elementsLabelProperty) {
        String expectedString = genericStepDefs.getPropertyTextValueBasedOnLanguage(elementsLabelProperty);
        Arrays.stream(expectedString.split(",")).map(String::trim).forEach(e -> genericStepDefs.waitForElementToBeVisible("fields.present.using.label." + e + ".byxpath", xpathForElements.replace("${elementLabel}", e)));
    }

    @Then("^verify list of elements present by labels in form and visibility status: (.*) text: (.*) and with visibility status: (.*)$")
    public void verifyListOfElementPresentByXpathAndStatus(String xpathForElements, String elementsLabelProperty, String visibilityStatus) {
        String expectedString = genericStepDefs.getPropertyTextValueBasedOnLanguage(elementsLabelProperty);
        Arrays.stream(expectedString.split(",")).map(String::trim).forEach(e -> genericStepDefs.waitForElementToPresentByVisibilityStatus("fields.present.using.label." + e + ".byxpath", xpathForElements.replace("${elementLabel}", e), visibilityStatus.trim()));
    }

    @Then("^verify list of elements present by labels in view: (.*) text: (.*)$")
    public void verifyListOfElementPresentByXpath2(String xpathForElements, String elementsLabelProperty) {
        String expectedString = genericStepDefs.getPropertyTextValueBasedOnLanguage(elementsLabelProperty);
        Arrays.stream(expectedString.split(",")).forEach(e -> genericStepDefs.waitForElementToBeVisible("fields.present.using.label." + e + ".byxpath", xpathForElements.replace("${elementLabel}", e)));
    }

    @Then("^click on car card with title: (.*)$")
    public void selectCarCategoryCard(String categoryName) {
        Element.waitForLoadingIconToBeNotPresentStatic();
        categoryName = genericStepDefs.getOptionBasedOnLang(categoryName.trim());
        genericStepDefs.clickElementWithXpath("ejar.contract.car.category.card.byxpath", "//span[contains(@class,'card-title')]//div[ contains(.,'" + categoryName + "')]");
    }

    @Then("^Create branch with random name and store name in variable: (.*)$")
    public void createEjarBranchWithRandomName(String variableNameToStore) {
        genericStepDefs.navigateToUrl(PropManager.getInstance().getProperty("ejar.environment.url") + "/app/fleet-management/branches");
        genericStepDefs.clickElement("ejar.branches.createnew.byxpath");
        String randomNameBranchName = genericStepDefs.setRandomStringInElement("ejar.branches.name_en.field.byxpath", "5", "UI Branch");
        genericStepDefs.setValueIntoElement_V2(randomNameBranchName, "ejar.branches.name_ar.field.byxpath");
        ScenarioContextSingleton.getInstance().setContextValue(variableNameToStore, randomNameBranchName);
        genericStepDefs.selectOptionByTextInKendoWithoutWithoutTyping("ejar.branches.countries.field.byxpath", genericStepDefs.getOptionBasedOnLang("Saudi Arabia,المملكة العربية السعودية"));
        genericStepDefs.selectOptionByTextInKendoWithoutWithoutTyping("ejar.branches.cities.field.byxpath", genericStepDefs.getOptionBasedOnLang("Automation Riyadh,Automation Riyadh"));
        genericStepDefs.setRandomNumberOfSize("ejar.branches.licenseNumber.field.byxpath", "10");
        genericStepDefs.setValueIntoElement_V2("46.07824398566", "ejar.branches.longitude.field.byxpath");
        genericStepDefs.setValueIntoElement_V2("24.77736844726", "ejar.branches.latitude.field.byxpath");
        genericStepDefs.setRandomNumberOfSize("ejar.branches.code.field.byxpath", "5");
        genericStepDefs.clickElement("ejar.generic.save.action.byxpath");
        genericStepDefs.clickElement("ejar.generic.yes.action.byxpath");
    }

    @Then("^user select value in drop down field: (.*) by option text stored in variable: (.*)$")
    public void selectOptionsInDropDownFieldByTextStepDef(String elementName, String variableName) {
        genericStepDefs.selectOptionByText(elementName, ScenarioContextSingleton.getInstance().getContextValue(variableName));
    }

    @Then("^user select option in dropdown tree view mutiliselect field: (.*) option stored in variable: (.*)")
    public void electOptionInDropdownTreeViewMutiliselectStoredInVariable(String elementName, String variableName) {
        genericStepDefs.electOptionInDropdownTreeViewMutiliselectFieldSMethod(elementName, ScenarioContextSingleton.getInstance().getContextValue(variableName));
    }

    @Then("^Create organization with random name and store name in variable: (.*)$")
    public void createEjarOrganizationWithRandomName(String variableNameToStore) {
        genericStepDefs.navigateToUrl(PropManager.getInstance().getProperty("ejar.environment.url") + "/app/crm/organizations");
        genericStepDefs.waitForElementNotPresent("ejar.waitingicon.byxpath");
        genericStepDefs.waitForElementToBePresent("ejar.organizations.createnew.byxpath");
        genericStepDefs.clickElement("ejar.organizations.createnew.byxpath");
        genericStepDefs.selectOptionByTextInKendoWithoutWithoutTypingWithoutClickEmpty("ejar.organizations.countries.fields.byxpath", genericStepDefs.getOptionBasedOnLang("Saudi Arabia, المملكة العربية السعودية"));
        String randomNameOrganizationName = genericStepDefs.setRandomStringInElement("ejar.organizations.name.fields.byxpath", "10", "UI Automation Organization");
        genericStepDefs.setValueIntoElement_V2(randomNameOrganizationName, "ejar.organizations.name.fields.byxpath");
        ScenarioContextSingleton.getInstance().setContextValue(variableNameToStore, randomNameOrganizationName);
        genericStepDefs.setValueIntoElement_V2("UI Area", "ejar.organizations.area.fields.byxpath");
        genericStepDefs.setValueIntoElement_V2("UI street", "ejar.organizations.street.fields.byxpath");
        genericStepDefs.setValueIntoElement_V2("UI building and floor", "ejar.organizations.BuildingOrFloor.fields.byxpath");
        genericStepDefs.setValueIntoElement_V2("11623", "ejar.organizations.PostalCode.fields.byxpath");
        genericStepDefs.selectOptionByIndexInKendoOptionField("ejar.organizations.classifications.fields.byxpath", 1);
        genericStepDefs.clickElement("ejar.organizations.save.button.byxpath");
        genericStepDefs.waitForElementNotPresentHere("ejar.organizations.modalVisible.div.byxpath");
    }

    @Then("^Create corporate with the name variable: (.*)$")
    public void createEjarCorporatWithRandomName(String variableName) {
        genericStepDefs.navigateToUrl(PropManager.getInstance().getProperty("ejar.environment.url") + "/app/crm/corporates");
        genericStepDefs.waitForElementToBePresent("ejar.corporate.createnew.byxpath");
        genericStepDefs.clickAction("ejar.corporate.createnew.byxpath");
        genericStepDefs.selectOptionByTextInKendoWithoutWithoutTypingWithoutClickEmpty("ejar.createcorporate.country.field.byxpath", genericStepDefs.getOptionBasedOnLang("Saudi Arabia, المملكة العربية السعودية"));
        setRandomStringInElementAndStoreInVariable("ejar.createcorporate.name.field.byxpath","10","Automation UI Corporate ",variableName);
        genericStepDefs.selectOptionByTextInKendoWithoutWithoutTypingWithoutClickEmpty("ejar.createcorporate.city.field.byxpath", genericStepDefs.getOptionBasedOnLang("Automation Riyadh, Automation Riyadh"));
        genericStepDefs.setValueInField("ejar.createcorporate.contactpersoninformation.primaryphone.field.byxpath", "553336666");
        new Element("ejar.createcorporate.titleTab.field.byxpath").clickElement();
        genericStepDefs.setRandomStringInElement("ejar.createcorporate.area.field.read.byxpath","5","UI Automation Area ");
        genericStepDefs.setRandomStringInElement("ejar.createcorporate.street.field.read.byxpath","5","UI Automation Street ");
        genericStepDefs.setValueIntoElementByValueMethod("ejar.createcorporate.buildingOrFloor.field.read.byxpath","21");
        genericStepDefs.setValueIntoElementByValueMethod("ejar.createcorporate.postalCode.field.read.byxpath","28721");
        genericStepDefs.selectOptionByIndexInKendoOptionField("ejar.createcorporate.classification.field.byxpath", 1);
        genericStepDefs.selectOptionByIndexInKendoOptionField("ejar.createcorporate.accountmanager.field.byxpath", 1);
        genericStepDefs.setRandomStringInElement("ejar.createcorporate.contactpersoninformation.name.field.byxpath", "10", "UI Automation Contact");
        genericStepDefs.setRandomEmailText("ejar.createcorporate.contactpersoninformation.email.field.byxpath");
        genericStepDefs.setValueIntoElement_V2("554446666", "ejar.createcorporate.contactpersoninformation.corporatephone.field.byxpath");
        genericStepDefs.clearField("ejar.createcorporate.contactpersoninformation.email.field.byxpath");
        genericStepDefs.setRandomEmailText("ejar.createcorporate.contactpersoninformation.email.field.byxpath");
        genericStepDefs.setValueInField("ejar.createcorporate.contactpersoninformation.corporatephone.field.byxpath", "554446666");
        genericStepDefs.clickAction("ejar.generic.save.action.byxpath");
        genericStepDefs.clickAction("ejar.generic.yes.action.byxpath");
        genericStepDefs.waitForElementToBePresent("ejar.corporate.createnew.byxpath");
    }

    @Then("^Create broker with random name and store name in variable: (.*)$")
    public void createEjarBrokerWithRandomName(String variableName) {
        genericStepDefs.navigateToUrl(PropManager.getInstance().getProperty("ejar.environment.url") + "/app/crm/brokers");
        genericStepDefs.waitForElementPresentHere("ejar.brokers.create.button.byxpath",120);
        genericStepDefs.clickElement("ejar.brokers.create.button.byxpath");
        genericStepDefs.selectOptionByTextInKendoWithoutWithoutTypingWithoutClickEmpty("ejar.broker.country.field.byxpath", genericStepDefs.getOptionBasedOnLang("Saudi Arabia,المملكة العربية السعودية"));
        setRandomStringInElementAndStoreInVariable("ejar.brokers.name.field.input.byxpath","10","Automation UI Broker ",variableName);
        genericStepDefs.selectOptionByTextInKendoWithoutWithoutTypingWithoutClickEmpty("ejar.broker.city.field.byxpath", genericStepDefs.getOptionBasedOnLang("Automation Riyadh,Automation Riyadh"));
        genericStepDefs.setValueIntoElement_V2("553336666", "ejar.broker.phoneNumber2.field.byxpath");
        genericStepDefs.setRandomStringInElement("ejar.brokers.area.field.edit.byxpath","5","UI Automation Area ");
        genericStepDefs.setRandomStringInElement("ejar.brokers.streetAddress.field.edit.byxpath","5","UI Automation Street ");
        genericStepDefs.setValueIntoElementByValueMethod("ejar.brokers.buildingFloor.field.edit.byxpath","21");
        genericStepDefs.setValueIntoElementByValueMethod("ejar.brokers.postalCode.field.edit.byxpath","28721");
        genericStepDefs.selectOptionByIndexInKendoOptionField("ejar.broker.classification.field.byxpath", 1);
        genericStepDefs.selectOptionByIndexInKendoOptionField("ejar.broker.accountManger.field.byxpath", 1);
        genericStepDefs.setValueIntoElement_V2("Automation Name", "ejar.broker.contractName.field.byxpath");
        genericStepDefs.setValueIntoElement_V2("512224444", "ejar.broker.phoneNumber.field.byxpath");
        genericStepDefs.setValueIntoElement_V2("AutomationEmail@gmail.com", "ejar.broker.email.field.byxpath");
        genericStepDefs.setValueIntoElement_V2("100", "ejar.broker.creditLimit.field.byxpath");
        genericStepDefs.clickAction("ejar.brokers.save.button.byxpath");
        genericStepDefs.clickAction("ejar.generic.yes.action.byxpath");
        this.filterResultsInViewBasedOnColumnNameValueStoredInVariable("Name,الاسم",variableName);
        genericStepDefs.clickElement("ejar.brokers.firstrow.button.byxpath");
        genericStepDefs.clickElement("ejar.broker.approve.button.byxpath");
        genericStepDefs.setRandomStringInElement("ejar.brokers.commentModal.field.textarea.byxpath","10","UI Automation comment ");
        genericStepDefs.clickElement("ejar.broker.approveconfirmation.button.byxpath");

    }

    @And("^filter view on column name: (.*) and enter value stored in variable: (.*)$")
    public void filterResultsInViewBasedOnColumnNameValueStoredInVariable(String columnName, String variableName) {
        String variableValue;
        if (ScenarioContextSingleton.getInstance().getContextValue(variableName) == null || ScenarioContextSingleton.getInstance().getContextValue(variableName).isEmpty() || ScenarioContextSingleton.getInstance().getContextValue(variableName).isBlank()) {
            variableValue = ScenarioContextSingleton.getInstance().getContextValue(variableName);
            ScenarioContextSingleton.getInstance().setContextValue(variableName, variableValue);
        } else {
            variableValue = ScenarioContextSingleton.getInstance().getContextValue(variableName);
        }
        genericStepDefs.filterResultsInViewBasedOnColumnNameMethod(genericStepDefs.returnStringBasedOnLanguage(columnName.trim()), variableValue);
    }

    @And("^filter view on column name by xpath: (.*) and enter value stored in variable: (.*) with xpath of element: (.*)$")
    public void filterResultsInViewBasedOnColumnNameValueStoredInVariableWithXpath(String columnName, String variableName, String elementName) {
        genericStepDefs.filterResultsInViewBasedOnColumnNameMethod(genericStepDefs.returnStringBasedOnLanguage(columnName.trim()), ScenarioContextSingleton.getInstance().getContextValue(variableName), elementName);
    }

    @And("^user click on view action: (.*) related to record with text stored in variable: (.*) then select record at index: (.*)$")
    public void clickOnActionInViewRelatedToColumn(String actionName, String variableName, String index) {
        genericStepDefs.clickOnActionInViewRelatedToColumnMethod(actionName.trim().split(",")[0], actionName.trim().split(",")[1], ScenarioContextSingleton.getInstance().getContextValue(variableName), index);
    }

    @And("^set random text in variable and into element: (.*) with size: (.*) and initial string: (.*) and store value in variable: (.*)$")
    public String setRandomStringInElementAndStoreInVariable(String elementName, String stringSize, String initialString, String variableName) {
        String randomString = initialString.trim() + " " + StringHelper.getRandomStringOfSize(Integer.parseInt(stringSize));
//        ScenarioContextSingleton.getInstance().setContextValue(variableName.trim(), randomString);
        ScenarioContextSingleton.getInstance().setContextValue(variableName.trim(), randomString);
        genericStepDefs.setValueIntoElement(randomString.trim(), elementName.trim());
        return randomString;
    }

    @And("^set random number into element: (.*) with size: (.*) and store value in variable: (.*)$")
    public void setRandomNumberInElementAndStoreInVariable(String elementName, String numberSize, String variableName) {
        String randomNumber = StringHelper.getRandomNumberOfSize(Integer.parseInt(numberSize));
//        ScenarioContextSingleton.getInstance().setContextValue(variableName.trim(), randomNumber);
        ScenarioContextSingleton.getInstance().setContextValue(variableName.trim(), randomNumber);
        genericStepDefs.setValueIntoElement(randomNumber.trim(), elementName.trim());
    }

    @And("^set value into field: (.*) from stored variable: (.*)$")
    public void setValueInField(String field, String variableName) {
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        genericStepDefs.setValueIntoElement_V2(ScenarioContextSingleton.getInstance().getContextValue(variableName.trim()), field.trim());
    }

    @And("^click on view record cell that contains stored variable text: (.*)$")
    public void clickOnViewRecordThatContainTextStoredInVariable(String variableName) {
        genericStepDefs.clickOnRecordCellContainsText(ScenarioContextSingleton.getInstance().getContextValue(variableName));
    }

    @And("click on action with xpath: (.*) with replacing variable with stored value: (.*)$")
    public void clickOnActionXpathWithVariable(String xpathToCLick, String variableName) {
        genericStepDefs.clickOnActionXpathWithVariableMethod(xpathToCLick, ScenarioContextSingleton.getInstance().getContextValue(variableName.trim()));
    }

    @And ("wait for element present with xpath: (.*) and replace variable value: (.*)$")
    public void waitForActionXpathWithVariable(String xpathToCLick, String variableName) {
        genericStepDefs.waitForActionXpathWithVariableMethod(xpathToCLick, ScenarioContextSingleton.getInstance().getContextValue(variableName.trim()));
    }

    @And ("wait for element present with locator: (.*) and replace variable value: (.*)$")
    public void waitForElementWithLocatorSwapVariable(String locatorKey, String variableName) {
        String xpath = new Element(locatorKey).getLocatorValue();
        genericStepDefs.waitForActionXpathWithVariableMethod(xpath, ScenarioContextSingleton.getInstance().getContextValue(variableName.trim()));
    }

    @And("click on action with locator: (.*) with replacing variable with stored value: (.*)$")
    public void clickOnActionLocatorWithVariable(String locatorKey, String variableName) {
        String xpath = new Element(locatorKey).getLocatorValue();
//        genericStepDefs.clickOnActionXpathWithVariableMethod(xpath, ScenarioContextSingleton.getInstance().getContextValue(variableName.trim()));
        genericStepDefs.clickOnActionXpathWithVariableMethod(xpath, ScenarioContextSingleton.getInstance().getContextValue(variableName.trim()));
    }

    @And("scroll to element with xpath: (.*) with replacing variable with stored value: (.*)$")
    public void ScrollOnActionXpathWithVariable(String xpathToScroll, String variableName) {
        genericStepDefs.clickOnActionXpathWithVariableMethod(xpathToScroll, ScenarioContextSingleton.getInstance().getContextValue(variableName.trim()));
    }

    @And("^get plate number of a vehicle with status: (.*)$")
    public void getPlateNumberForVehicleWithStatus(String vehicleStatus) {
        String currentUrl = DriverFactory.getDriver().url();
        if(!currentUrl.contains("/app/fleet-management/vehicles"))
            openPageUsingUrl("/app/fleet-management/vehicles");
        Element.waitForLoadingIconToBeNotPresentStatic();
        genericStepDefs.waitForElementToBePresent("ejar.generic.search.action.byxpath");
        genericStepDefs.clickOnActionIfExist("ejar.generic.search.action.byxpath");
        String plateNumberValue = genericStepDefs.getPlateNumberForVehicleWithStatusMethod("status", genericStepDefs.getOptionBasedOnLang("Status,الحالة"), genericStepDefs.getOptionBasedOnLang(vehicleStatus.trim()));
        Element.waitForLoadingIconToBeNotPresentStatic();
        vehiclePlateNumber.set(plateNumberValue);
        ScenarioContextSingleton.getInstance().setContextValue("vehiclePlateNumber", plateNumberValue);
    }

    @And("^get plate number of a vehicle with waiting for damages estimation status and store in variable: (.*)$")
    public void getPlateNumberWithAdditionalStatus(String variableName){
        String currentUrl = DriverFactory.getDriver().url();
        if(!currentUrl.contains("/app/rental/branches-vehicles"))
            openPageUsingUrl("/app/rental/branches-vehicles");
        String plateNumberValue;
        selectAllBranchesByUnselectingBranch("ejar.maintenanceCard.branches.button.byxpath");
        genericStepDefs.clickElement("ejar.maintenanceCard.additionalStatus.kendo-multiselect.byxpath");
        genericStepDefs.clickElement("ejar.maintenanceCard.damagesEstimation.li.byxpath");
        genericStepDefs.clickElement("ejar.generic.search.action.byxpath");
        Element plateNo = new Element("ejar.maintenanceCard.plateNo.li.byxpath");
        plateNumberValue = plateNo.getWebElement().innerText();
        ScenarioContextSingleton.getInstance().setContextValue(variableName, plateNumberValue.trim());
    }

    @And("^select all branches by unselecting the current branch from the field: (.*)$")
    public void selectAllBranchesByUnselectingBranch(String elementName){
        Element element = new Element(elementName);
        element.clickElement();
        storeEjarElementsValue("ejar.changebranch.currentBranch.span.byxpath","currentBranch",false);
        setValueInField("ejar.maintenanceCard.branchesSearch.input.byxpath","currentBranch");
        genericStepDefs.clickOnActionIfExistStepDef("ejar.maintenanceCard.clickOnActiveBranch.button.byxpath","2");
    }

    @And("^user set the stored plate number value in field: (.*)$")
    public void setStoredPlateNumberValueInField(String field) {
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        genericStepDefs.setValueIntoElement_V2(vehiclePlateNumber.get(), field);
    }

    @And("^click on view record that contains text stored in variable: (.*)$")
    public void clickOnViewRecordThatContainText(String variableName) {
        genericStepDefs.clickOnRecordCellContainsText(ScenarioContextSingleton.getInstance().getContextValue(variableName));
    }

    @And("^inactivate organization with name stored in variable: (.*)")
    public void inactivateOrganizationWithNameStoredInVariable(String variableName) {
        genericStepDefs.navigateToUrl(PropManager.getInstance().getProperty("ejar.environment.url") + "/app/crm/organizations");
        genericStepDefs.waitForElementToBePresent("ejar.organizations.createnew.byxpath");
        genericStepDefs.waitForSeconds(2);
        genericStepDefs.waitForElementNotPresent("ejar.generic.gridload.byxpath");
        genericStepDefs.filterResultsInViewBasedOnColumnNameMethod(genericStepDefs.returnStringBasedOnLanguage("Name,الاسم".trim()), ScenarioContextSingleton.getInstance().getContextValue(variableName));
        genericStepDefs.clickOnActionInViewRelatedToColumnMethod("Edit,تعديل".trim().split(",")[0], "Edit,تعديل".trim().split(",")[1], ScenarioContextSingleton.getInstance().getContextValue(variableName), "1");
        genericStepDefs.clickElement("ejar.organizations.isactive.fields.byxpath");
        genericStepDefs.clickElement("ejar.organizations.save.button.byxpath");
        genericStepDefs.waitForElementNotPresentHere("ejar.organizations.modalVisible.div.byxpath");
    }

    @And("^approve corporate with name stored in variable: (.*)")
    public void approveCorporateWithNameStoredInVariable(String variableName) {
        genericStepDefs.navigateToUrl(PropManager.getInstance().getProperty("ejar.environment.url") + "/app/crm/corporates");
        genericStepDefs.waitForElementToBePresent("ejar.corporate.createnew.byxpath");
        genericStepDefs.filterResultsInViewBasedOnColumnNameMethod(genericStepDefs.returnStringBasedOnLanguage("Name,الاسم".trim()), ScenarioContextSingleton.getInstance().getContextValue(variableName));
        genericStepDefs.waitForSeconds(2);
        genericStepDefs.waitForElementNotPresent("ejar.generic.gridload.byxpath");
        genericStepDefs.clickElement("ejar.createcorporate.firstRow.button.byxpath");
        genericStepDefs.waitForSeconds(2);
        genericStepDefs.waitForElementNotPresent("ejar.generic.gridload.byxpath");
        genericStepDefs.waitForSeconds(2);
        genericStepDefs.clickAction("ejar.createcorporate.approve.action.byxpath");
        genericStepDefs.setValue(StringHelper.getRandomStringOfSize(10), "ejar.createcorporate.corporatecoded.field.byxpath");
        genericStepDefs.setRandomStringInElement("ejar.createcorporate.comment.input.byxpath", "5", "UI Automation Comment");
        genericStepDefs.clickElement("ejar.corporateapprovedialog.approve.action.byxpath");
    }

    @And("^create leasing quotation for the corporate name stored in variable: (.*)")
    public void createLeasingQuotationForCorp(String variableName) throws IOException, InterruptedException{
        genericStepDefs.navigateToUrl(PropManager.getInstance().getProperty("ejar.environment.url") + "/app/rental/corporates/leasing-quotations");
        genericStepDefs.clickElement("ejar.leasingquotation.createnew.byxpath");
        selectOptionByTextInKendoWithClickOnEmptyWithStoredValueStepDefs("ejar.leasingquotation.corporate.field.byxpath",variableName);
        genericStepDefs.clickElement("ejar.leasingquotation.next1.button.byxpath");
        selectOptionByTextInKendoStepDefs("eja.leasingquotation.category.field.byxpath","Automation Small Sedan,Automation Small Sedan");
        selectOptionByTextInKendoStepDefs("eja.leasingquotation.model.field.byxpath","Automation Accent,Automation Accent");
        genericStepDefs.selectOptionsInDropDownFieldByTextStepDef("eja.leasingquotation.years.field.byxpath","2020,2020");
        genericStepDefs.setValueInField("eja.leasingquotation.numberofvehicles.field.byxpath","1");
        selectOptionByTextInKendoStepDefs("eja.leasingquotation.duration.field.byxpath","12,12");
        genericStepDefs.clickElement("eja.leasingquotation.calculator.button.byxpath");
        genericStepDefs.waitForElementPresentHere("eja.leasingquotation.calculatedPrice.input.byxpath",120);
        genericStepDefs.clickElement("eja.leasingquotation.save.button.byxpath");
        genericStepDefs.clickElement("eja.leasingquotation.next2.field.byxpath");
        genericStepDefs.clickElement("eja.leasingquotation.addform.button.byxpath");
        genericStepDefs.clickElement("ejar.createsparepart.yes.confirm.button.byxpath");
        filterResultsInViewBasedOnColumnNameValueStoredInVariable("Corporate,الشركة", "automationCorporateName");
        genericStepDefs.clickActionWithXpath("(//kendo-grid-list//td//a[@class='quotationNo'])[1]");
        genericStepDefs.clickElement("ejar.leasingquotation.otheroperations.button.byxpath");
        genericStepDefs.clickElement("ejar.leasingquotation.activate.button.byxpath");
        genericStepDefs.clickElement("ejar.generic.yes.action.byxpath");
    }

    @And("^create corporate agreement with name stored in variable: (.*)")
    public void createAgreementForCorporate(String variableName) throws IOException, InterruptedException{
        genericStepDefs.navigateToUrl(PropManager.getInstance().getProperty("ejar.environment.url") + "/app/crm/corporates");
        genericStepDefs.filterResultsInViewBasedOnColumnNameMethod(genericStepDefs.returnStringBasedOnLanguage("Name,الاسم".trim()), ScenarioContextSingleton.getInstance().getContextValue(variableName));
        genericStepDefs.waitForSeconds(2);
        genericStepDefs.waitForElementNotPresent("ejar.generic.gridload.byxpath");
        genericStepDefs.clickAction("ejar.createcorporate.agreement.button.byxpath");
        genericStepDefs.waitForSeconds(2);
        genericStepDefs.waitForElementNotPresent("ejar.generic.gridload.byxpath");
        genericStepDefs.setValue("1","ejar.createcorporate.agreement.firstYear.field.byxpath");
        genericStepDefs.setValue("2","ejar.createcorporate.agreement.secondYear.field.byxpath");
        genericStepDefs.setValue("3","ejar.createcorporate.agreement.thirdYear.field.byxpath");
        genericStepDefs.setValue("4","ejar.createcorporate.agreement.forthYear.field.byxpath");
        genericStepDefs.setValue("5","ejar.createcorporate.agreement.fifthYear.field.byxpath");
        genericStepDefs.waitForSeconds(0.5);
        genericStepDefs.uploadFileWithPathToElement("ejar.createcorporate.agreement.upload.field.byxpath","//uploadFiles//logo_high.png");
        genericStepDefs.clickElement("ejar.createcorporate.agreement.save.button.byxpath");
    }


    @And("^store contract number from customer rating dialog into variable: (.*)")
    public void getContractNumberFromRatingDialog(String variableName) {
        Element element = new Element("ejar.contract.ratingDialog.message.byxpath");
        String ratingDialogMessage = element.getWebElement().innerText();
        List<String> matcherList = new RegxHelper().getRegxMatchList("\"(.*?)\"", 1, ratingDialogMessage);
        ScenarioContextSingleton.getInstance().setContextValue(variableName, matcherList.get(0));
    }

    @And("^verify form page: (.*) fields, field label: (.*), field editable: (.*), field required: (.*)")
    public void verifyFormPageFields(String formName, String fieldLabel, String isEditable, String isRequired) {
        ejarPages.checkElementPresentWithSoftAssertion(formName + ".fields.labels" + ".byxpath", "//" + "//label[text()='" + fieldLabel + "']//" + fieldLabel, 2);
        boolean expectedRequired = Boolean.parseBoolean(isRequired);
        ejarPages.checkElementsIsRequired(formName + ".fields.labels" + ".byxpath", "//" + formName + "//label[text()='" + fieldLabel + "']" + fieldLabel, expectedRequired);
    }

    @And("^verify form page labels and text:")
    public void verifyFormPageText(DataTable elementsDataTable) {
        List<Map<String, String>> elements = elementsDataTable.asMaps(String.class, String.class);
        StringBuilder htmlTable = new StringBuilder("<table border='1' style='width:100%; border-collapse: collapse;'>");
        htmlTable.append("<tr><th>Text</th><th>Tag Type</th></tr>");
        for (Map<String, String> elementData : elements) {
            String textString = genericStepDefs.getOptionBasedOnLang(elementData.get("Text"));
            textString=textString.replace("^^",",");
            String tagType = elementData.get("TagType");
            boolean actualTextIsFound = ejarPages.checkElementPresentWithSoftAssertion(textString + ".byxpath", "//" + tagType + "[normalize-space()=\"" + textString.trim() + "\"]", 2);
            htmlTable.append("<tr style='background-color: lightgreen;'>");
            String cellStyle = actualTextIsFound ? "style='background-color: lightgreen;'" : "style='background-color: red;'";
            htmlTable.append("<td ").append(cellStyle).append(">").append(textString).append("</td>");
            htmlTable.append("<td ").append(cellStyle).append(">").append(tagType).append("</td>");
            htmlTable.append("</tr>");
        }
        htmlTable.append("</table>");
        if (ExtentCucumberAdapter.getCurrentStep() != null) {
            ExtentCucumberAdapter.getCurrentStep().info(htmlTable.toString());
        }
    }

    /**
     * Verifies form page fields with their editable and required statuses using DataTable input
     * Implements data-driven testing approach for form field validation
     *
     * @param elementsDataTable - Contains field configuration with columns:
     *                          - fieldEditableXpath: Property key for editable field locator
     *                          - fieldReadXpath: Property key for read-only field locator
     *                          - isEditable: Boolean indicating if field should be editable
     *                          - isRequired: Boolean indicating if field is required (only checked when editable)
     */
    @And("^verify form page fields, field editable and required statuses2:")
    public void verifyFormPageFieldsVersionTwo(DataTable elementsDataTable) {
        List<Map<String, String>> elements = elementsDataTable.asMaps(String.class, String.class);

        // Create HTML table builder for reporting results
        HtmlTableBuilderForSoftAssertions tableBuilder = new HtmlTableBuilderForSoftAssertions().startTable().addHeaderRow("fieldXpathName", "fieldXpath", "isEditable", "isRequired");

        // Process each field validation entry
        for (Map<String, String> elementData : elements) {
            FieldValidationResult result = processFieldValidation(elementData);
            addValidationResultToTable(tableBuilder, result);
        }

        // Generate and attach final report
        String htmlReport = tableBuilder.build();
        if (ExtentCucumberAdapter.getCurrentStep() != null) {
            ExtentCucumberAdapter.getCurrentStep().info(htmlReport);
        }
    }

    /**
     * Processes validation for a single field entry
     *
     * @param elementData - Map containing field configuration data
     * @return FieldValidationResult containing validation outcomes
     */
    private FieldValidationResult processFieldValidation(Map<String, String> elementData) {
        FieldValidationResult result = new FieldValidationResult();

        String fieldEditableName = elementData.get("fieldEditableXpath");
        String fieldReadableName = elementData.get("fieldReadXpath");
        String fieldEditableXpath = PropManager.getInstance().getProperty(fieldEditableName);
        String fieldReadableXpath = PropManager.getInstance().getProperty(fieldReadableName);

        boolean expectedEditable = Boolean.parseBoolean(elementData.get("isEditable"));
        boolean expectedRequired = Boolean.parseBoolean(elementData.get("isRequired"));

        result.setFieldName(expectedEditable ? fieldEditableName : fieldReadableName);
        result.setXpath(expectedEditable ? fieldEditableXpath : fieldReadableXpath);

        // Validate field editable status
        boolean editableCheckResults = validateFieldEditableStatus(expectedEditable, fieldEditableName, fieldEditableXpath, fieldReadableName, fieldReadableXpath);

        // Validate field required status (only applicable for editable fields)
        boolean requiredCheckResults = validateFieldRequiredStatus(expectedEditable, expectedRequired, fieldEditableName, fieldEditableXpath);

        result.setEditableValid(editableCheckResults);
        result.setRequiredValid(requiredCheckResults);
        result.setBackgroundColor(determineRowColor(editableCheckResults, requiredCheckResults));

        return result;
    }

    /**
     * Validates if a field exists in the expected editable/read-only state
     * Checks presence of editable element and absence of read-only element (or vice versa)
     *
     * @param expectedEditable   - Whether field is expected to be editable
     * @param fieldEditableName  - Property name for editable field
     * @param fieldEditableXpath - Xpath for editable field
     * @param fieldReadableName  - Property name for read-only field
     * @param fieldReadableXpath - Xpath for read-only field
     * @return true if field editable state matches expectation, false otherwise
     */
    private boolean validateFieldEditableStatus(boolean expectedEditable, String fieldEditableName, String fieldEditableXpath, String fieldReadableName, String fieldReadableXpath) {
        boolean actualIsPresent, actualIsNotPresent;

        if (expectedEditable) {
            // For editable fields, check editable element exists and read-only doesn't
            actualIsPresent = ejarPages.checkElementPresentWithSoftAssertion(fieldEditableName, fieldEditableXpath, 2);
            actualIsNotPresent = ejarPages.checkElementNotPresentWithSoftAssertion(fieldReadableName, fieldReadableXpath, 2);

            // Additional check for disabled attribute if element still exists
            if (!actualIsNotPresent) {
                Element element = new Element(fieldReadableName, fieldReadableXpath);
                Locator loc = element.getWebElementWithoutAssertion(1);
                actualIsNotPresent = loc != null && loc.getAttribute("disabled") != null;
            }
            return actualIsPresent && actualIsNotPresent;
        } else {
            // For read-only fields, check read-only element exists and editable doesn't
            actualIsPresent = ejarPages.checkElementPresentWithSoftAssertion(fieldReadableName, fieldReadableXpath, 2);
            actualIsNotPresent = ejarPages.checkElementNotPresentWithSoftAssertion(fieldEditableName, fieldEditableXpath, 2);
            return actualIsPresent && actualIsNotPresent;
        }
    }

    /**
     * Validates required status of a field based on its editable state
     * Required validation only applies to editable fields
     *
     * @param expectedEditable   - Whether field is expected to be editable
     * @param expectedRequired   - Whether field is expected to be required
     * @param fieldEditableName  - Property name for editable field
     * @param fieldEditableXpath - Xpath for editable field
     * @return true if required status matches expectation, false otherwise
     */
    private boolean validateFieldRequiredStatus(boolean expectedEditable, boolean expectedRequired, String fieldEditableName, String fieldEditableXpath) {
        if (expectedEditable) {
            // Required validation only applies to editable fields
            return ejarPages.checkElementsIsRequired(fieldEditableName, fieldEditableXpath, expectedRequired);
        }
        // For read-only fields, required validation is ignored
        return true;
    }

    /**
     * Determines background color for HTML table row based on validation results
     * Green for pass, red for fail
     *
     * @param editableValid - Whether editable validation passed
     * @param requiredValid - Whether required validation passed
     * @return CSS background color value
     */
    private String determineRowColor(boolean editableValid, boolean requiredValid) {
        return (editableValid && requiredValid) ? "lightgreen" : "red";
    }

    /**
     * Adds a field validation result to the HTML table
     *
     * @param tableBuilder - HtmlTableBuilder instance to add row to
     * @param result       - FieldValidationResult containing validation data
     */
    private void addValidationResultToTable(HtmlTableBuilderForSoftAssertions tableBuilder, FieldValidationResult result) {
        tableBuilder.addDataRow(result.getBackgroundColor(), result.getFieldName(), result.getXpath(), String.valueOf(result.isEditableValid()), String.valueOf(result.isRequiredValid()));
    }

//    @And("^verify form page fields, field label and is editable and is required:")
    public void verifyFormPageFields2(DataTable elementsDataTable) {
        List<Map<String, String>> elements = elementsDataTable.asMaps(String.class, String.class);
        StringBuilder htmlTable = new StringBuilder("<table border='1' style='width:100%; border-collapse: collapse;'>");
        htmlTable.append("<tr><th>formName</th><th>fieldLabel</th><th>isEditable</th><th>isRequired</th></tr>");

        for (Map<String, String> elementData : elements) {
            String formName = elementData.get("formName");
            String fieldLabel = elementData.get("fieldLabel");
            boolean expectedEditable = Boolean.parseBoolean(elementData.get("isEditable"));
            boolean expectedRequired = Boolean.parseBoolean(elementData.get("isRequired"));

            boolean isPresent = ejarPages.checkElementPresentWithSoftAssertion(formName + "." + fieldLabel + ".field.label" + ".byxpath", "//label[text()='" + fieldLabel + "']", 2);
            boolean isRequiredActualResult = false;
            boolean editableCheckResutlsAgainstExpected = false;

            if (isPresent) {
                isRequiredActualResult = ejarPages.checkElementsIsRequired(formName + "." + fieldLabel + ".field.label" + ".byxpath", "//" + formName + "//label[text()='" + fieldLabel + "']", expectedRequired);
                String elementPath = returnPathOfElementBasedOnEditableOrNot(formName, fieldLabel, expectedEditable);
                editableCheckResutlsAgainstExpected = ejarPages.checkElementsIsEditableAgainstExpectedStatus(formName, formName + "." + fieldLabel + ".field.label" + ".byxpath", elementPath, expectedEditable);
            }

            boolean allPassed = isPresent && isRequiredActualResult && editableCheckResutlsAgainstExpected;

            if (allPassed) {
                htmlTable.append("<tr style='background-color: lightgreen;'>");
                htmlTable.append("<td>").append(formName).append("</td>");
                htmlTable.append("<td>").append(fieldLabel).append("</td>");
                htmlTable.append("<td>").append(expectedEditable).append("</td>");
                htmlTable.append("<td>").append(expectedRequired).append("</td>");
                htmlTable.append("</tr>");
            } else {
                htmlTable.append("<tr>");
                htmlTable.append("<td>").append(formName).append("</td>");
                htmlTable.append("<td>").append(fieldLabel).append("</td>");
                if (isPresent) {
                    String isEditableCellStyle = editableCheckResutlsAgainstExpected ? "style='background-color: lightgreen;'" : "style='background-color: red;'";
                    htmlTable.append("<td ").append(isEditableCellStyle).append(">").append(expectedEditable).append("</td>");

                    String isRequiredCellStyle = isRequiredActualResult ? "style='background-color: lightgreen;'" : "style='background-color: red;'";
                    htmlTable.append("<td ").append(isRequiredCellStyle).append(">").append(expectedRequired).append("</td>");


                } else {
                    htmlTable.append("<td style='background-color: red;'>Not Found</td>");
                    htmlTable.append("<td style='background-color: red;'>Not Found</td>");
                }
                htmlTable.append("</tr>");
            }
        }
        htmlTable.append("</table>");
        ExtentCucumberAdapter.getCurrentStep().info(htmlTable.toString());
    }

//###################################
//###################################
//########## NEW FUNCTIONS ##########
//###################################
//###################################
@And("^verify form page fields, field editable and required statuses:")
public void verifyUnifiedFieldStatus(DataTable elementsDataTable) {
    List<Map<String, String>> elements = elementsDataTable.asMaps(String.class, String.class);

    // Create HTML table builder for reporting results with the new single column header
    HtmlTableBuilderForSoftAssertions tableBuilder = new HtmlTableBuilderForSoftAssertions()
            .startTable()
            .addHeaderRow("Field Property Key","Field Xpath", "isEditable", "isRequired");
    for (int i = 0; i < elements.size(); i++) {
        Map<String, String> elementData = elements.get(i);

        //Calculate which row we are on
        int rowNum = i + 1;

        //[Row 1]
        TestData.getInstance().getThreadSharedMethods().get().setFeatureName(" [Row " + rowNum + "]");

        // 3. Run the validation
        FieldValidationResult result = processUnifiedFieldValidation(elementData);
        addValidationResultToTable(tableBuilder, result);
    }

    // Generate and attach final report to Extent Report
    String htmlReport = tableBuilder.build();
    if (ExtentCucumberAdapter.getCurrentStep() != null) {
        ExtentCucumberAdapter.getCurrentStep().info(htmlReport);
    }
}

    /**
     * Orchestrates validation for a single field using a single XPath property.
     * * @param elementData - Map containing "fieldXpath", "isEditable", and "isRequired"
     * @return FieldValidationResult containing the outcome of the checks
     */
    private FieldValidationResult processUnifiedFieldValidation(Map<String, String> elementData) {
        FieldValidationResult result = new FieldValidationResult();

        // Retrieve data from the DataTable
        String fieldPropertyName = elementData.get("fieldXpath");
        String resolvedXpath = PropManager.getInstance().getProperty(fieldPropertyName);

        boolean expectedEditable = Boolean.parseBoolean(elementData.get("isEditable"));
        boolean expectedRequired = Boolean.parseBoolean(elementData.get("isRequired"));

        result.setFieldName(fieldPropertyName);
        result.setXpath(resolvedXpath);
        boolean actualIsPresent;
        actualIsPresent=ejarPages.checkElementPresentWithSoftAssertion(fieldPropertyName,resolvedXpath,1);
        if(!actualIsPresent){
            result.setEditableValid(false);
            result.setRequiredValid(false);
            result.setBackgroundColor("#FFCCCC");
            return result;
        }

        // 1. Validate if the field is correctly Editable or Read-Only based on 'expectedEditable'
        boolean editableCheckResults = checkUnifiedFieldState(expectedEditable, fieldPropertyName, resolvedXpath);

        // 2. Validate if the field is Required (logic only triggers if the field is expected to be editable)
        boolean requiredCheckResults = checkUnifiedFieldRequirement(expectedEditable, expectedRequired, fieldPropertyName, resolvedXpath);

        result.setEditableValid(editableCheckResults);
        result.setRequiredValid(requiredCheckResults);
        result.setBackgroundColor(determineRowColor(editableCheckResults, requiredCheckResults));

        return result;
    }

    /**
     * Validates the state of the element.
     * If expectedEditable is true: Element must be NOT be disabled/readonly.
     * If expectedEditable is false: Element must be disabled/readonly.
     */
    private boolean checkUnifiedFieldState(boolean expectedEditable, String fieldName, String fieldXpath) {
        return ejarPages.checkElementEditStatuseWithSoftAssertion(fieldName, fieldXpath, expectedEditable,2);
    }

    /**
     * Validates the required status of the field.
     * Logic is only applied if the field is expected to be in an editable state.
     */
    private boolean checkUnifiedFieldRequirement(boolean expectedEditable, boolean expectedRequired, String fieldName, String fieldXpath) {
        if (expectedEditable) {
            // Perform the standard requirement check
            return ejarPages.checkElementsIsRequired(fieldName, fieldXpath, expectedRequired);
        }
        // If the field is read-only, we skip requirement validation and return true
        return true;
    }

//    @And("^verify form page fields, field editable and required statuses:")
//    public void verifyFormPageFieldsVersionTwo(DataTable elementsDataTable) {
//        List<Map<String, String>> elements = elementsDataTable.asMaps(String.class, String.class);
//        StringBuilder htmlTable = new StringBuilder("<table border='1' style='width:100%; border-collapse: collapse;'>");
//        htmlTable.append("<tr><th>fieldXpathName</th><th>fieldXpath</th><th>isEditable</th><th>isRequired</th></tr>");
//
//        for (Map<String, String> elementData : elements) {
//            String fieldEditableName = elementData.get("fieldEditableXpath");
//            String fieldReadableName = elementData.get("fieldReadXpath");
//            String fieldEditableXpath = PropManager.getInstance().getProperty(fieldEditableName);
//            String fieldReadableXpath = PropManager.getInstance().getProperty(fieldReadableName);
//            boolean expectedEditable = Boolean.parseBoolean(elementData.get("isEditable"));
//            boolean expectedRequired = Boolean.parseBoolean(elementData.get("isRequired"));
//            boolean requiredCheckResultsAgainstExpected = false;
//            boolean editableCheckResultsAgainstExpected = false;
//            boolean actualIsPresent = false;
//            boolean actualIsNotPresent = false;
//            htmlTable.append("<tr style='background-color: lightgreen;'>");
//            htmlTable.append("<td>").append(expectedEditable ? fieldEditableName : fieldReadableName).append("</td>");
//            htmlTable.append("<td>").append(expectedEditable ? fieldEditableXpath : fieldReadableXpath).append("</td>");
//            if (expectedEditable) {
//                actualIsPresent = ejarPages.checkElementPresentWithSoftAssertion(fieldEditableName, fieldEditableXpath, 2);
//                actualIsNotPresent = ejarPages.checkElementNotPresentWithSoftAssertion(fieldReadableName, fieldReadableXpath, 2);
//                if (!actualIsNotPresent) {
//                    Element element = new Element(fieldReadableName, fieldReadableXpath);
//                    actualIsNotPresent = element.getWebElementWithoutAssertion(1).getAttribute("disabled") != null;
//                }
//                editableCheckResultsAgainstExpected = actualIsPresent && actualIsNotPresent;
//                requiredCheckResultsAgainstExpected = ejarPages.checkElementsIsRequired(fieldEditableName, fieldEditableXpath, expectedRequired);
//            } else {
//                actualIsPresent = ejarPages.checkElementPresentWithSoftAssertion(fieldReadableName, fieldReadableXpath, 2);
//                actualIsNotPresent = ejarPages.checkElementNotPresentWithSoftAssertion(fieldEditableName, fieldEditableXpath, 2);
//                editableCheckResultsAgainstExpected = actualIsPresent && actualIsNotPresent;
//                requiredCheckResultsAgainstExpected = true;
//            }
//            if (editableCheckResultsAgainstExpected && requiredCheckResultsAgainstExpected) {
//                htmlTable.append("<td>").append(expectedEditable).append("</td>");
//                htmlTable.append("<td>").append(expectedRequired).append("</td>");
//
//            } else {
//                String isEditableCellStyle = editableCheckResultsAgainstExpected ? "style='background-color: lightgreen;'" : "style='background-color: red;'";
//                htmlTable.append("<td ").append(isEditableCellStyle).append(">").append(expectedEditable).append("</td>");
//                String isRequiredCellStyle = requiredCheckResultsAgainstExpected && editableCheckResultsAgainstExpected ? "style='background-color: lightgreen;'" : "style='background-color: red;'";
//                htmlTable.append("<td ").append(isRequiredCellStyle).append(">").append(expectedEditable ? expectedRequired : "Ignored in read mode").append("</td>");
//                htmlTable.append("</tr>");
//            }
//        }
//        htmlTable.append("</table>");
//        if (ExtentCucumberAdapter.getCurrentStep() != null) {
//            ExtentCucumberAdapter.getCurrentStep().info(htmlTable.toString());
//        }
//    }

    @Then("store ejar element value: (.*) and value name: (.*) and keep number only: (.*)$")
    public void storeEjarElementsValue(String elementName, String valueName, boolean numberOnly) {
        String value = new Element(elementName).getWebElement().innerText().replace("\u00A0", " ").trim();;
        if (numberOnly) value = value.replaceAll("(?!([+-]?([0-9]*[.])?[0-9]+)).", "").trim();
        if (value.endsWith(" B") && value.startsWith("B")) value = value.substring(0, value.length() - 2).trim();
        ScenarioContextSingleton.getInstance().setContextValue(valueName, value.trim());
        ScenarioContextSingleton.getInstance().setContextValue(valueName, value);
        System.out.println("Stored: "+value+" in the variable: "+valueName);
    }

    @Then("pay if there is remaining amount when close contract with card type: (.*)$")
    public void checkPaymentCloseContract(String optionText){
        genericStepDefs.waitForElementPresentHere("ejar.closecontract.paymentDetailsSection.li.byxpath",100);
        String remaining = new Element("ejar.closecontract.remaining.field.byxpath").getWebElement().innerText();

        double remainingDouble = Double.parseDouble(remaining.replace(",", ""));
        if ( remainingDouble > 0 ){
            clickOnElementIfExistsWithWait("ejar.closecontract.manualPayment.field.byxpath","2");
            genericStepDefs.selectOptionByTextInKendoWithoutWithoutTyping("ejar.closecontract.cardType.field.byxpath", genericStepDefs.getOptionBasedOnLang(optionText));
            genericStepDefs.setRandomNumberOfSize("ejar.closecontract.transactionNo.field.byxpath","10");
        }
    }

    @Then("set minimum odometer value into field: (.*) with wait for camera: (.*)$")
    public void setOdometer(String elementName,String waitTime) {
        genericStepDefs.waitForElementToBeVisibleWithoutAssertion("ejar.contract.imageSection.byxpath",Integer.parseInt(waitTime));
        int number = 0;
        genericStepDefs.simulateClickingOnKeyMethod(elementName, "99999999999999999999");
        Element error= new Element("ejar.closecontract.odometerError.div.byxpath");
        genericStepDefs.waitForElementToBeVisibleWithoutAssertion("ejar.closecontract.odometerError.div.byxpath", 5);
        if(!error.isElementPresentAfterWait(1)){
            genericStepDefs.simulateClickingOnKeyMethod(elementName, "99999999999999999999");
        }
        String remaining = new Element("ejar.closecontract.odometerError.div.byxpath").getWebElement().innerText();
        if (PropManager.getInstance().getProperty("execution.lang").equals("en")) {
            Pattern pattern = Pattern.compile("from\\s+(\\d+)");
            Matcher matcher = pattern.matcher(remaining);
            if (matcher.find()) {
                number = Integer.parseInt(matcher.group(1));
                System.out.println("The minimum odometer is " + number);
            }
        }
        else {
            Pattern pattern = Pattern.compile("من\\s+(\\d+)");
            Matcher matcher = pattern.matcher(remaining);
            if (matcher.find()) {
                number = Integer.parseInt(matcher.group(1));
                System.out.println("The minimum odometer is " + number);
            }
        }
        genericStepDefs.setValueInField(elementName, String.valueOf(number));
        ScenarioContextSingleton.getInstance().setContextValue("minimumOdometer",String.valueOf(number));
    }

    @Then("capture E-check Images if exist")
    public void captureImages(){
        Element element = new Element("ejar.contract.captureImage.byxpath");
        if (!element.isElementPresentAfterWait(3)) {
            System.out.println("No capture buttons found on the page.");
            return;
        }
        List<Locator> captureButtons = element.getWebElements(); // initial count only
        int total = captureButtons.size();

        if (total == 0) {
            System.out.println("There are no enabled capture buttons.");
            return;
        }
        System.out.println("Found " + total + " capture button(s). Clicking each...");
        for (int i = 0; i < total; i++) {
            try {
                element.getWebElements().get(0).click();
                System.out.println("Clicked capture button " + (i + 1) + " of " + total);
            } catch (Exception e) {
                System.out.println("Stopped at button " + (i + 1) + ": " + e.getMessage());
                break;
            }
        }
    }

    @Then("select available car card")
    public void selectCarCard(){
        genericStepDefs.clickOnActionIfExistStepDef("ejar.executeexistingbooking.warningModal.button.byxpath","20");
        genericStepDefs.waitForElementPresentHere("ejar.executeexistingbooking.carCards.span.byxpath",60);
        Element element = new Element("ejar.executeexistingbooking.carCards.span.byxpath");
        element.getLocatorFirst();
        element.clickElement();
        element.clickElement();
        element.clickElement();
    }

    @Then("select last available car card")
    public void selectLastCarCard(){
        genericStepDefs.waitForElementPresentHere("ejar.executeexistingbooking.carCardsLast.span.byxpath",30);
        genericStepDefs.waitForElementToBeVisibleWithoutAssertion("ejar.executeexistingbooking.warningModal.button.byxpath",5);
        genericStepDefs.clickOnActionIfExistStepDef("ejar.executeexistingbooking.warningModal.button.byxpath","5");
        Element element = new Element("ejar.executeexistingbooking.carCardsLast.span.byxpath");
        element.getLocatorFirst();
        element.clickElement();
        element.clickElement();
        element.clickElement();
    }

    @Then("change ejar branch: (.*) then navigate to: (.*)$")
    public void changeBranch(String branchValue,String URL){
        String branchName = genericStepDefs.getOptionBasedOnLang(PropManager.getInstance().getProperty(branchValue));
        genericStepDefs.clickElement("ejar.changebranch.div.byxpath");
        genericStepDefs.setValue(branchName,"ejar.changebranch.input.byxpath");
        Element element = new Element("ejar.changebranch.li.byxpath");
        genericStepDefs.clickOnActionXpathWithVariableMethod(element.getLocatorValue(),branchName);
        Element.waitForLoadingIconToBeNotPresentStatic();
        genericStepDefs.waitForElementPresentHere("ejar.changebranch.h1.byxpath",150);
        genericStepDefs.navigateToUrl(PropManager.getInstance().getProperty("ejar.environment.url") + URL.trim());

    }

    @Then("change ejar branch from stored variable: (.*) then navigate to: (.*)$")
    public void changeBranchFromStoredVariable(String branch,String URL){
        genericStepDefs.clickElement("ejar.changebranch.div.byxpath");
        genericStepDefs.setValue( ScenarioContextSingleton.getInstance().getContextValue(branch),"ejar.changebranch.input.byxpath");
        Element element = new Element("ejar.changebranch.li.byxpath");
        genericStepDefs.clickOnActionXpathWithVariableMethod(element.getLocatorValue(),ScenarioContextSingleton.getInstance().getContextValue(branch));
        Element.waitForLoadingIconToBeNotPresentStatic();
        genericStepDefs.waitForElementPresentHere("ejar.changebranch.h1.byxpath",150);
        genericStepDefs.navigateToUrl(PropManager.getInstance().getProperty("ejar.environment.url") + URL.trim());

    }
    @Then("click on element if exist: (.*) with wait: (.*)$")
    public void clickOnElementIfExistsWithWait(String elementName, String waitTime){
        Element element = new Element(elementName);
        if(element.isElementPresentAfterWait(Integer.parseInt(waitTime))) {
            Element.waitForLoadingIconToBeNotPresentStatic();
            element.clickElement();
        }
    }

    @Then("fill e-check form")
    public void fillEcheckForm(){
        genericStepDefs.clickOnActionIfExistStepDef("ejar.contract.caneraAccess.button.byxpath","30");
//        genericStepDefs.waitForElementPresentHere("ejar.contract.captureImagenotDisabled.byxpath",150);
        genericStepDefs.waitForElementPresentHere("ejar.contract.checklistSection.byxpath",150);
        setOdometer("ejar.closecontract.odometer.field.input.byxpath","100");
        genericStepDefs.clickOnElementMethod("ejar.closecontract.damageStatus.field.input.byxpath");

        captureImages();
    }

    @Then("handle separate echeck")
    public void handleSeperateEcheck() {
        Element element = new Element("ejar.closecontract.echeckpopup.div.byxpath");

        if(element.isElementPresentAfterWait(5)){
            genericStepDefs.waitForElementPresentHere("ejar.closecontract.contractnumber.a.byxpath", 60);
            storeEjarElementsValue("ejar.closecontract.contractnumber.a.byxpath","contractNo",false);
            genericStepDefs.clickOnElementMethod("ejar.closecontract.echeckpopup.button.byxpath");
            fillEcheckForm();
            genericStepDefs.clickOnElementMethod("ejar.generic.save.action.byxpath");
            genericStepDefs.clickOnElementMethod("ejar.generic.yes.action.byxpath");
            genericStepDefs.waitForElementPresentHere("ejar.closecontract.more.a.byxpath",60);
            setValueInField("ejar.closecontract.contractnumber.input.byxpath","contractNo");
            genericStepDefs.clickOnElementMethod("ejar.generic.search.action.byxpath");
            genericStepDefs.waitForElementPresentHere("ejar.closecontract.more.a.byxpath",80);
            genericStepDefs.clickOnElementMethod("ejar.closecontract.more.a.byxpath");
            genericStepDefs.clickOnElementMethod("ejar.closecontract.closeContract.a.byxpath");
        }
    }

    @Then("change free minutes to cancel value in country setting to: (.*)$")
    public void changeFreeMinutesToCancel(String minutes){
        String currentUrl = DriverFactory.getDriver().url();
        if(!currentUrl.contains("/ejar-settings/operational-countries"))
            openPageUsingUrl("/app/admin/ejar-settings/operational-countries");
        genericStepDefs.waitForElementPresentHere("ejar.countrysettingsaudi.countrysettings.i.byxpath",150);
        genericStepDefs.clickOnElementMethod("ejar.countrysettingsaudi.countrysettings.i.byxpath");
        genericStepDefs.waitForElementPresentHere("ejar.countrysettingsaudi.freeminutestocancel.input.byxpath",30);
        genericStepDefs.setValueIntoElementByValueMethod("ejar.countrysettingsaudi.freeminutestocancel.input.byxpath",minutes);
        genericStepDefs.clickOnElementMethod("ejar.countrysettings.save.button.byxpath");
        genericStepDefs.waitForElementPresentHere("ejar.countrysettingsaudi.savingdone.h1.byxpath",40);
    }

    @Then("store element from the attribute input in field: (.*) and variable name: (.*)$")
    public void storeElementFromInput(String elementName, String variableName){
        Element element = new Element(elementName);
        Page page = DriverFactory.getDriver();
        String inputValue = page.inputValue(element.getLocatorValue());
        if(inputValue==null || inputValue.isEmpty())
            ejarPages.assertActualExpected("The input value in the element"+elementName+" is empty");
        ScenarioContextSingleton.getInstance().setContextValue(variableName, inputValue);
    }

    @Then("compare expected from stored variable: (.*) with actual variable: (.*)$")
    public void compareExpectedWithActual(String expectedName, String actualName){
        String expected = ScenarioContextSingleton.getInstance().getContextValue(expectedName);
        String actual = ScenarioContextSingleton.getInstance().getContextValue(actualName);
        String message;
        if(expected.equals(actual)) {
            message = "The expected variable: " + expected + " is equal to the actual variable: " + actual;
            System.out.println(message);
        }
        else {
            message = "The expected variable: " + expected + " is Not equal to the actual variable: " + actual;
            ejarPages.assertActualExpected(message);

        }
    }

    @Then("^store date dynamically from the attribute input in field: (.*) and add days: (.*) with time: (.*) and variable name: (.*)$")
    public void storeDateAddDaysDynamically(String elementName,int days,String time,String variableName){
        storeElementFromInput(elementName, "DynamicDate");
        String dynamicDate = ScenarioContextSingleton.getInstance().getContextValue("DynamicDate");

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        LocalDateTime dateTime = LocalDateTime.parse(dynamicDate, formatter);
        LocalDateTime updatedDateTime = dateTime.plusDays(days).with(LocalTime.parse(time));

        LocalDateTime now = LocalDateTime.now();
        long daysFromNow = ChronoUnit.DAYS.between(now.toLocalDate(), updatedDateTime.toLocalDate());
        int daysCount = (int) daysFromNow;
        genericStepDefs.waitForElementNotPresentHere("ejar.editbooking.loading.div.byxpath");
        selectDateTimeInWithTimeValueEjarCalendarStepDefs(elementName, daysCount, time);

        String formattedFinalDate = updatedDateTime.format(formatter);
        ScenarioContextSingleton.getInstance().setContextValue(variableName, formattedFinalDate);
    }

    @Then("^select current date/time on element: (.*)$")
    public void selectCurrentDateTime(String element){
        genericStepDefs.clickElement(element);
        genericStepDefs.clickElement("ejar.generic.calendarToday.span.byxpath");
        genericStepDefs.clickElement("ejar.generic.calendarNow.button.byxpath");
        genericStepDefs.clickElement("ejar.generic.calendarSelect.button.byxpath");
    }

    @Then("^create offer on trip days with percentage: (.*) and the store offer name in variable: (.*)$")
    public void createOfferAndStore(String offerPercentage,String offerName){
        Element errorMessage= new Element("ejar.offers.errorFromDate.button.byxpath");
        String currentUrl = DriverFactory.getDriver().url();
        if(!currentUrl.contains("/app/rental/administration/offers"))
            openPageUsingUrl("/app/rental/administration/offers");
        genericStepDefs.clickOnLink("ejar.offers.createnewPublic.byxpath");
        setRandomStringInElementAndStoreInVariable("ejar.offers.name1.field.byxpath","5","UI Automation Offer",offerName);
        setValueInField("ejar.offers.name2.field.byxpath",offerName);
        selectCurrentDateTime("ejar.offers.fromDate.button.byxpath");
        if(errorMessage.isElementPresentAfterWait(1))
            selectCurrentDateTime("ejar.offers.fromDate.button.byxpath");
        genericStepDefs.clickOnLink("ejar.offers.next1.button.byxpath");
        genericStepDefs.clickOnLink("ejar.offers.firstoption.field.byxpath");
        genericStepDefs.clickOnLink("ejar.offers.location.link.byxpath");
        genericStepDefs.clickOnActionIfExistStepDef("ejar.offers.allBranchesIfNotSelected.label.byxpath","3");
        genericStepDefs.clickOnLink("ejar.offers.next2.button.byxpath");
        genericStepDefs.clickOnLink("ejar.definediscount.button.byxpath");
        genericStepDefs.setValueIntoElementByValueMethod("ejar.offers.tripdays.input.byxpath",offerPercentage);
        genericStepDefs.clickOnLink("ejar.offers.define.button.byxpath");
        genericStepDefs.clickOnLink("ejar.generic.save.action.byxpath");
        genericStepDefs.clickOnLink("ejar.generic.yes.action.byxpath");
        genericStepDefs.clickOnActionIfExistStepDef("ejar.offers.saveDuplicate.button.byxpath","50");
        genericStepDefs.waitForElementPresentHere("ejar.offers.createnewPublic.byxpath",100);
    }


    @Then("^create offer from ejar discount on trip days with percentage: (.*) and store promoCode in variable: (.*) the store offer name in variable: (.*)$")
    public void createOfferAndStoreWithPromoCode(String offerPercentage,String promoCode,String offerName){
        Element errorMessage= new Element("ejar.offers.errorFromDate.button.byxpath");
        String currentUrl = DriverFactory.getDriver().url();
        if(!currentUrl.contains("/app/rental/administration/offers"))
            openPageUsingUrl("/app/rental/administration/offers");
        genericStepDefs.clickOnLink("ejar.offers.createnew.specific.byxpath");
        setRandomStringInElementAndStoreInVariable("ejar.offers.name1.field.byxpath","5","UI Automation Offer",offerName);
        setValueInField("ejar.offers.name2.field.byxpath",offerName);
        selectCurrentDateTime("ejar.offers.fromDate.button.byxpath");
        if(errorMessage.isElementPresentAfterWait(1))
            selectCurrentDateTime("ejar.offers.fromDate.button.byxpath");
        genericStepDefs.clickOnLink("ejar.offers.next1.button.byxpath");
        genericStepDefs.clickOnLink("ejar.offers.firstoption.field.byxpath");
        genericStepDefs.clickOnLink("ejar.offers.location.link.byxpath");
        genericStepDefs.clickOnActionIfExistStepDef("ejar.offers.allBranchesIfNotSelected.label.byxpath","3");
        genericStepDefs.clickOnLink("ejar.offers.promocode.link.byxpath");
        genericStepDefs.clickOnLink("ejar.offers.promocodeEdit.button.byxpath");
        setRandomStringInElementAndStoreInVariable("ejar.offers.promocodeEdit.input.byxpath","4","",promoCode);
        genericStepDefs.clickOnLink("ejar.offers.next2.button.byxpath");
        genericStepDefs.clickOnLink("ejar.definediscount.button.byxpath");
        genericStepDefs.setValueIntoElementByValueMethod("ejar.offers.tripdays.input.byxpath",offerPercentage);
        genericStepDefs.clickOnLink("ejar.offers.define.button.byxpath");
        genericStepDefs.clickOnLink("ejar.generic.save.action.byxpath");
        genericStepDefs.clickOnLink("ejar.generic.yes.action.byxpath");
        genericStepDefs.clickOnActionIfExistStepDef("ejar.offers.saveDuplicate.button.byxpath","50");
        genericStepDefs.waitForElementPresentHere("ejar.offers.createnewPublic.byxpath",100);
    }


    @Then("^disable offer with the name stored in variable: (.*)$")
    public void disableOffer(String offerName){
        String currentUrl = DriverFactory.getDriver().url();
        if(!currentUrl.contains("/app/rental/administration/offers"))
            openPageUsingUrl("/app/rental/administration/offers");
        genericStepDefs.filterResultsInViewBasedOnColumnNameMethod(genericStepDefs.returnStringBasedOnLanguage("Name,الاسم".trim()), ScenarioContextSingleton.getInstance().getContextValue(offerName));
        genericStepDefs.clickElement("ejar.offers.deactivateOffer.button.byxpath");
        genericStepDefs.clickElement("ejar.generic.yes.action.byxpath");
    }

    @Then("^get the value of the first row of the table: (.*) using the header: (.*) then store in variable: (.*)")
    public void storeValueFromTableHeader(String tableLocator,String header,String variableName){
        Page page = DriverFactory.getDriver();
        Element element = new Element(tableLocator);
        String tableXpath = element.getLocatorValue();
        String headerXpath = tableXpath + "//th[normalize-space()='{$tableHeader}']";
        String colIndex = page.locator(headerXpath.replace("{$tableHeader}", genericStepDefs.getOptionBasedOnLang(header))).getAttribute("aria-colindex");
        String firstValueOfTheHeader = tableXpath +"//tr[@aria-rowindex='2']//td[@aria-colindex='"+colIndex + "']";
        String value = page.locator(firstValueOfTheHeader).innerText().trim();
        ScenarioContextSingleton.getInstance().setContextValue(variableName, value);
    }

    @Then("^compare expected value: (.*) with actual variable: (.*)$")
    public void compareExpectedWithActualValue(String expectedValue, String actualName){
        String actual = ScenarioContextSingleton.getInstance().getContextValue(actualName);
        String message;
        if(expectedValue.equals(actual)) {
            message = "The expected variable: " + expectedValue + " is equal to the actual variable: " + actual;
            System.out.println(message);
        }
        else {
            message = "The expected variable: " + expectedValue + " is NOT equal to the actual variable: " + actual;
            ejarPages.assertActualExpected(message);

        }
    }

    @Then("create new inquiry if it doesn't exist with the name: (.*)$")
    public void createNewInquiryIfNotExist(String inquiryIssueName){
        String currentUrl = DriverFactory.getDriver().url();
        if(!currentUrl.contains("/app/crm/administration/complaint-categories"))
            openPageUsingUrl("/app/crm/administration/complaint-categories");

        genericStepDefs.filterResultsInViewBasedOnColumnName("Name,الاسم","Branch,الفرع");
        Element editButton = new Element("ejar.InquiriesAndComplains.editBranch.a.byxpath");
        if(editButton.isElementPresentAfterWait(2)){
            System.out.println("There is an existing inquiry and complaint category");
            editButton.clickElement();
        }else{
            System.out.println("Creating a new inquiry and complaint category");
            genericStepDefs.clickElement("ejar.InquiriesAndComplains.createnew.button.byxpath");
            genericStepDefs.selectOptionsInDropDownFieldByTextStepDef("ejar.InquiriesAndComplains.type.field.byxpath","Suggestion,اقتراح");
            genericStepDefs.clickElement("ejar.InquiriesAndComplains.informativeMessage.field.byxpath");
            genericStepDefs.setRandomStringInElement("ejar.InquiriesAndComplains.messageEnglish.field.byxpath","10","UI Automation English Message ");
            genericStepDefs.setRandomStringInElement("ejar.InquiriesAndComplains.messageArabic.field.byxpath","10","UI Automation Arabic Message ");
        }
        genericStepDefs.setValueIntoElement(inquiryIssueName.split(",")[0],"ejar.InquiriesAndComplains.nameEnglish.field.byxpath");
        genericStepDefs.setValueIntoElement(inquiryIssueName.split(",")[1],"ejar.InquiriesAndComplains.nameArabic.field.byxpath");
        genericStepDefs.selectOptionsInDropDownFieldByTextStepDef("ejar.InquiriesAndComplains.Branch.field.byxpath","Optional,إختياري");
        genericStepDefs.selectOptionsInDropDownFieldByTextStepDef("ejar.InquiriesAndComplains.City.field.byxpath","Optional,إختياري");
        genericStepDefs.selectOptionsInDropDownFieldByTextStepDef("ejar.InquiriesAndComplains.BookingNumber.field.byxpath","Optional,إختياري");
        genericStepDefs.selectOptionsInDropDownFieldByTextStepDef("ejar.InquiriesAndComplains.ContractNumber.field.byxpath","Not Available ,غير متاح");
        genericStepDefs.clickElement("ejar.InquiriesAndComplains.save.button.byxpath");
        genericStepDefs.clickElement("ejar.generic.yes.action.byxpath");

    }

    @And("^check the checkbox of the element: (.*) in the settings of the country: (.*)$")
    public void checkCheckboxInCountrySettings(String element,String country){
        String currentUrl = DriverFactory.getDriver().url();
        if(!currentUrl.contains("/app/admin/ejar-settings/operational-countries"))
            openPageUsingUrl("/app/admin/ejar-settings/operational-countries");
        String chosenCountry = genericStepDefs.getOptionBasedOnLang(country.trim());
        Element countrySettingButton = new Element("ejar.countrySetting.a.byxpath","//tr[child::td[normalize-space()='"+ chosenCountry +"']]//a[child::i[@title='Settings' or @title='الإعدادات']]");
        countrySettingButton.clickElement();
        genericStepDefs.ensureCheckboxIsChecked(element);
        genericStepDefs.removeElementAttributeMethod("ejar.countrysettings.save.button.byxpath","disabled");
        genericStepDefs.clickOnElementMethod("ejar.countrysettings.save.button.byxpath");
        genericStepDefs.waitForElementPresentHere("ejar.countrysettingsaudi.savingdone.h1.byxpath",60);

    }


    @And("^create new assistance issue with initial string: (.*) and store in variable: (.*)$")
    public void createAssistanceIssue(String initialText,String varName){
        String currentUrl = DriverFactory.getDriver().url();
        if(!currentUrl.contains("/app/fleet-management/assistance-issues-list"))
            openPageUsingUrl("/app/fleet-management/assistance-issues-list");

        genericStepDefs.clickElement("ejar.AssistanceIssues.createnew.byxpath");
        setRandomStringInElementAndStoreInVariable("ejar.AssistanceIssues.name.english.field.byxpath","5",initialText,varName);
        setValueInField("ejar.AssistanceIssues.name.arabic.field.byxpath",varName);
        selectFirstOptionByInKendoStepDefs("ejar.AssistanceIssues.urgency.input.byxpath",1);
        genericStepDefs.ensureCheckboxIsChecked("ejar.AssistanceIssues.isSupportedBy.field.byxpath");
        genericStepDefs.setRandomStringInElement("ejar.AssistanceIssues.terminationMessage.english.input.byxpath","5","UI Automation Termination Message English ");
        genericStepDefs.setRandomStringInElement("ejar.AssistanceIssues.terminationMessage.arabic.input.byxpath","5","UI Automation Termination Message Arabic ");
        genericStepDefs.clickElement("ejar.generic.save.action.byxpath");
        genericStepDefs.clickElement("ejar.generic.yes.action.byxpath");
    }

    @And("^deactivate assistance issue with the name stored in variable: (.*)$")
    public void deactivateAssistanceIssue(String varName){
        String currentUrl = DriverFactory.getDriver().url();
        if(!currentUrl.contains("/app/fleet-management/assistance-issues-list"))
            openPageUsingUrl("/app/fleet-management/assistance-issues-list");

        filterResultsInViewBasedOnColumnNameValueStoredInVariable("Name,الاسم",varName);
        clickOnActionInViewRelatedToColumn("Deactivate,الغاء تفعيل",varName,"1");
        genericStepDefs.clickElement("ejar.generic.yes.action.byxpath");
        genericStepDefs.toVerifyElementPresent("ejar.AssistanceIssues.createnew.byxpath");

    }

    @And("^store the value of column: (.*) when there is no value in column: (.*) in the variable: (.*) on page: (.*)$")
    public void getColumnValueWhenAnotherColumnEmpty(String targetColumn,String unwantedColumn,String variableName,String link){
        String currentUrl = DriverFactory.getDriver().url();
        if(!currentUrl.contains(link))
            openPageUsingUrl(link);

        int targetColIndex = genericStepDefs.getColumnIndex(genericStepDefs.getOptionBasedOnLang(targetColumn));
        int emptyColIndex = genericStepDefs.getColumnIndex(genericStepDefs.getOptionBasedOnLang(unwantedColumn));
        String targetValue="";
        for(int i = 0 ; i < 5 ;i++){
            Element carWithNoAdditionalStatus=new Element("ejar.rowWithoutUnwantedStatus.td.byxpath",String.format("(//tbody//tr[not(normalize-space(td[@aria-colindex='%d']))]/td[@aria-colindex='%d'])[1]", emptyColIndex, targetColIndex));
            if(carWithNoAdditionalStatus.isElementPresentAfterWait(1)){
                targetValue =carWithNoAdditionalStatus.getWebElement().innerText().trim();
                System.out.println("Found Target Value :" + targetValue);
                break;
            }
            genericStepDefs.clickElement("ejar.generic.nextPageGrid.span.byxpath");
        }

        ScenarioContextSingleton.getInstance().setContextValue(variableName, targetValue);
    }

    @And("^change vehicle usage type to: (.*) and store variable: (.*) on page: (.*)$")
    public void changeVehicleUsageType(String usageType,String variableName,String navigationLink){
        getColumnValueWhenAnotherColumnEmpty("Plate Number,رقم اللوحة","Additional Statuses,الحالات الاضافية",variableName,navigationLink);
        filterResultsInViewBasedOnColumnNameValueStoredInVariable("Plate Number,رقم اللوحة",variableName);
        Element editButton = new Element("ejar.editVehicle.a.byxpath","//tr[child::td[normalize-space()='"+ScenarioContextSingleton.getInstance().getContextValue(variableName)+"']]//td//a[child::i[@title='Edit' or @title='تعديل']]");
        editButton.clickElement();
        genericStepDefs.waitForElementPresentHere("ejar.createvehicle.usagetype.field.byxpath",Integer.parseInt(PropManager.getInstance().getProperty("driver.element.wait")));
        selectOptionByTextInKendoWithoutTypingStepDefs("ejar.createvehicle.usagetype.field.byxpath",usageType);
        genericStepDefs.clickElement("ejar.vehicles.saveEditVehicle.button.byxpath");
        genericStepDefs.clickElement("ejar.generic.yes.action.byxpath");
    }

    @And("^create spare part cost with random name and store in the variable: (.*)$")
    public void createSparePart(String variableName){
        String currentUrl = DriverFactory.getDriver().url();
        if(!currentUrl.contains("/app/fleet-management/e-check/spare-parts"))
            openPageUsingUrl("/app/fleet-management/e-check/spare-parts");
        genericStepDefs.clickElement("ejar.createsparepart.createnew.byxpath");
        setRandomStringInElementAndStoreInVariable("ejar.createsparepart.name_en.field.byxpath","10","UI Automation Spare Part",variableName);
        setValueInField("ejar.createsparepart.name_ar.field.byxpath",variableName);
        genericStepDefs.clickElement("ejar.generic.save.action.byxpath");
        genericStepDefs.clickElement("ejar.generic.yes.action.byxpath");

    }

    @And("^deactivate spare part with the name stored in the variable: (.*)$")
    public void inactivateSparePart(String variableName){
        openPageUsingUrl("/app/fleet-management/e-check/spare-parts");
        filterResultsInViewBasedOnColumnNameValueStoredInVariable("Name,الاسم",variableName);
        genericStepDefs.clickElement("ejar.checkcreatesparepartlist.firstrow.button.byxpath");
        genericStepDefs.clickOnElementUsingJavaScriptExecutor("ejar.checkcreatesparepartlist.deactivate.button.byxpath");
        genericStepDefs.clickOnElementUsingJavaScriptExecutor("ejar.createsparepart.yes.confirm.button.byxpath");
        genericStepDefs.clickElement("ejar.createsparepart.cancel.button.byxpath");
        genericStepDefs.toVerifyElementPresent("ejar.createsparepart.createnew.byxpath");
    }

    @And("^create new wage with random name and store in the variable: (.*)$")
    public void createNewWage(String variableName){
        openPageUsingUrl("/app/fleet-management/e-check/wages");
        genericStepDefs.clickElement("ejar.wage.createnew.byxpath");
        setRandomStringInElementAndStoreInVariable("ejar.wage.name_en.field.byxpath","10","UI Automation Wage ",variableName);
        setValueInField("ejar.wage.name_ar.field.byxpath",variableName);
        genericStepDefs.clickElement("ejar.generic.save.action.byxpath");
        genericStepDefs.clickElement("ejar.generic.yes.action.byxpath");
    }

    @And("^deactivate wage with the name stored in the variable: (.*)$")
    public void inactivateWage(String variableName){
        openPageUsingUrl("/app/fleet-management/e-check/wages");

        filterResultsInViewBasedOnColumnNameValueStoredInVariable("Name,الاسم",variableName);
        genericStepDefs.clickElement("ejar.wage.firstRow.byxpath");
        genericStepDefs.clickElement("ejar.wage.deactivate.button.byxpath");
        genericStepDefs.clickElement("ejar.generic.yes.action.byxpath");
        genericStepDefs.waitForElementPresentHere("ejar.wage.cancel.button.byxpath",30);
    }

    @And("^change setting in the country: (.*) with the name: (.*) and the text field value: (.*)$")
    public void changeCountrySetting(String countryName,String settingName,String value){
        String currentUrl = DriverFactory.getDriver().url();
        if(!currentUrl.contains("/app/admin/ejar-settings/operational-countries"))
            openPageUsingUrl("/app/admin/ejar-settings/operational-countries");
        String chosenCountry = genericStepDefs.getOptionBasedOnLang(countryName.trim());
        Element countrySettingButton = new Element("ejar.countrySetting.a.byxpath","//tr[child::td[normalize-space()='"+ chosenCountry +"']]//a[child::i[@title='Settings' or @title='الإعدادات']]");
        countrySettingButton.clickElement();
        Element settingInput = new Element("ejar.settingInput.input.byxpath","//label[normalize-space()='"+genericStepDefs.getOptionBasedOnLang(settingName)+"']/parent::*/input");
        settingInput.setValueInElement(value);
        genericStepDefs.removeElementAttributeMethod("ejar.countrysettings.save.button.byxpath","disabled");
        genericStepDefs.clickOnElementMethod("ejar.countrysettings.save.button.byxpath");
        genericStepDefs.waitForElementPresentHere("ejar.countrysettingsaudi.savingdone.h1.byxpath",60);

    }
    @And("^fill odometer pop-up if exist: (.*)$")
    public void fillOdometerPopUp(String elementName){
    Element element = new Element(elementName);
    if(element.isElementPresentAfterWait(4)) {
        genericStepDefs.setValueInField(elementName, ScenarioContextSingleton.getInstance().getContextValue("minimumOdometer"));
        genericStepDefs.clickElement("ejar.closecontract.odometerPopUpSave.button.byxpath");
    }
    }

    @And("^ensure advanced search filters on the current branch$")
    public void selectCurrentBranchInAdvancedSearch(){
        storeEjarElementsValue("ejar.changebranch.currentBranch.span.byxpath","selectedBranch",false);
        genericStepDefs.clickElement("ejar.generic.advancedsearch.action.byxpath");
        genericStepDefs.clickElement("ejar.advancedsearch.pickupbranch.button.byxpath");
        genericStepDefs.waitForElementPresentHere("ejar.advancedsearch.pickupBranchSearch.input.byxpath",15);
        String current=ScenarioContextSingleton.getInstance().getContextValue("selectedBranch");
        genericStepDefs.ensureCheckboxIsCheckedWithXpath("//div[@id='mySidenav']//kendo-popup//input[contains(@type,'checkbox') and parent::kendo-checkbox[following-sibling::span[child::span[normalize-space()='"+current+"']]]]");
        genericStepDefs.clickElement("ejar.advancedsearch.filter.button.byxpath");
    }

//    Needs Revision on the select date
    @And("^complete lite customer from the execute booking form$")
    public void completeCustomerIfLiteWhenExecuteBooking() throws IOException, InterruptedException {
    Element liteModal = new Element("ejar.executeexistingbooking.executeLiteCustomerModal.button.byxpath");
        if(liteModal.isElementPresentAfterWait(3)){
        genericStepDefs.clickElement("ejar.executeexistingbooking.executeLiteSkip.button.byxpath");
        genericStepDefs.waitForElementPresentHere("ejar.executeexistingbooking.next1.button.byxpath",100);
        genericStepDefs.waitForElementPresentHere("ejar.executeexistingbooking.newCustomerButton.button.byxpath",10);
        genericStepDefs.clickElement("ejar.executeexistingbooking.newCustomerButton.button.byxpath");
        genericStepDefs.clickElement("ejar.executeexistingbooking.executeLiteSkipIntegration.button.byxpath");
        genericStepDefs.selectOptionsInDropDownFieldByTextStepDef("ejar.createcustomer.nationality.field.byxpath","Saudi,سعودي");
        genericStepDefs.selectOptionsInDropDownFieldByTextStepDef("ejar.createcustomer.gender.field.byxpath","Male,ذكر");
        genericStepDefs.setValueInField("ejar.createcustomer.primaryphone.field.byxpath","515552222");
        genericStepDefs.setRandomEmailText("ejar.createcustomer.emailLite.field.byxpath");
        genericStepDefs.clickElement("ejar.createcustomer.documents.adddocuments.byxpath");
        genericStepDefs.selectOptionsInDropDownFieldByTextStepDef("ejar.createcustomer.document.documenttype.field.byxpath","Identity ,الهوية");
        genericStepDefs.setRandomNumberOfSize("ejar.identity.field.options.number.byxpath","10");
        selectDateInEjarCalendarWithArrowStepDefs("ejar.identity.field.expirydate.input.byxpath",100);
        genericStepDefs.uploadFileWithPathToElement("ejar.identity.field.options.attachment.byxpath","//uploadFiles//logo_high.png");
        genericStepDefs.clickElement("ejar.createcustomer.document.documenttype.add.field.byxpath");
        genericStepDefs.clickElement("ejar.createcustomer.documents.adddocuments.byxpath");
        genericStepDefs.selectOptionsInDropDownFieldByTextStepDef("ejar.createcustomer.document.documenttype.field.byxpath","Driver License,رخصة قيادة");
        genericStepDefs.setRandomNumberOfSize("ejar.identity.field.options.number.byxpath","10");
        selectDateInEjarCalendarWithArrowStepDefs("ejar.identity.field.options.expirydate.input.byxpath",100);
        genericStepDefs.uploadFileWithPathToElement("ejar.identity.field.options.attachment.byxpath","//uploadFiles//logo_high.png");
        genericStepDefs.clickElement("ejar.createcustomer.document.documenttype.add.field.byxpath");
        genericStepDefs.clickElement("ejar.executeexistingbooking.saveLite.button.byxpath");
        }
    }

    @And("^ensure checkbox is enabled if checkbox exist: (.*)$")
    public void enableCheckBoxIfExist(String element){
        Element checkbox = new Element(element);
        if(checkbox.isElementPresentAfterWait(2)){
            genericStepDefs.ensureCheckboxIsChecked(element);
            System.out.println("Checked an active offer");
        }
        else {
            System.out.println("There is no active offer at the moment");
        }
    }
}
