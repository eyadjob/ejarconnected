package stepdefs.ejar.web;

import automation.framework.Element;
import automation.framework.business.ElementStatus;
import automation.framework.business.SoftAssertBean;
import automation.framework.propmanager.PropManager;
import automation.framework.threadData.TestData;
import com.aventstack.extentreports.Status;
import com.aventstack.extentreports.cucumber.adapter.ExtentCucumberAdapter;
import com.microsoft.playwright.Locator;
import org.testng.asserts.IAssert;
import org.testng.asserts.SoftAssert;
import stepdefs.generic.GenericPage;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class EjarPages extends GenericPage {

    public static final ThreadLocal<List<SoftAssertBean>> customerSoftAssertion = ThreadLocal.withInitial(ArrayList::new);
    private static final ThreadLocal<SoftAssert> softAssert = ThreadLocal.withInitial(SoftAssert::new);

    /**
     * Check if there are any soft assertion failures without clearing the ThreadLocal
     *
     * @return true if there are failures, false otherwise
     */
    public static boolean hasFailures() {
        return getFailuresCount() > 0;
    }

    /**
     * Gets the current number of soft assertion failures without clearing them.
     * Uses reflection to access the internal error map of TestNG's SoftAssert.
     *
     * @return The total number of failures.
     */
    public static int getFailuresCount() {
        SoftAssert sa = softAssert.get();
        if (sa == null) {
            return 0;
        }
        try {
            Field errorsField = SoftAssert.class.getDeclaredField("m_errors");
            errorsField.setAccessible(true);
            Map<AssertionError, IAssert<?>> errors = (Map<AssertionError, IAssert<?>>) errorsField.get(sa);
            int testNgFailures = errors.size();

            // Also count customerSoftAssertion
            int customFailures = 0;
            List<SoftAssertBean> assertions = customerSoftAssertion.get();
            if (assertions != null) {
                for (SoftAssertBean bean : assertions) {
                    if (!bean.getResults()) {
                        customFailures++;
                    }
                }
            }
            return testNgFailures + customFailures;
        } catch (Exception e) {
            // If reflection fails, log the error and fall back to a safe value.
            e.printStackTrace();
            return 0;
        }
    }

    /**
     * Call this method to assert all soft assertions and log failures to ExtentReports
     *
     * @return List of failure messages, empty if all assertions passed
     */
    public static List<String> assertAll() {
        List<String> failureMessages = new ArrayList<>();
        try {
            // Process customer soft assertions
            List<SoftAssertBean> assertions = customerSoftAssertion.get();
            if (assertions != null && !assertions.isEmpty()) {
                for (SoftAssertBean bean : assertions) {
                    if (!bean.getResults()) {
                        String message = bean.getMessage();
                        softAssert.get().fail(message);
                        failureMessages.add(message);
                    }
                }
            }

            // Collect all soft assertion failures from TestNG SoftAssert
            if (softAssert.get() != null) {
                try {
                    softAssert.get().assertAll();
                } catch (AssertionError e) {
                    // Extract failure messages from the assertion error
                    String errorMessage = e.getMessage();
                    if (errorMessage != null && !errorMessage.isEmpty()) {
                        // TestNG SoftAssert formats errors like:
                        // "The following asserts failed:\n1. message1\n2. message2"
                        String[] lines = errorMessage.split("\\r?\\n");
                        for (String line : lines) {
                            String trimmed = line.trim();
                            // Skip header lines and empty lines
                            if (trimmed.isEmpty() || trimmed.startsWith("The following") || trimmed.equals("null") || trimmed.matches("^\\d+\\.\\s*$")) {  // Skip numbered lines without content
                                continue;
                            }
                            // Extract message from numbered lines like "1. message" or just add the line
                            if (trimmed.matches("^\\d+\\.\\s+.+")) {
                                // Remove the number prefix (e.g., "1. " or "2. ")
                                String message = trimmed.replaceFirst("^\\d+\\.\\s+", "");
                                if (!message.isEmpty()) {
                                    failureMessages.add(message);
                                }
                            } else if (trimmed.length() > 0) {
                                failureMessages.add(trimmed);
                            }
                        }
                    }
                    // If we couldn't parse individual messages, use the full error message
                    if (failureMessages.isEmpty() && errorMessage != null && !errorMessage.trim().isEmpty()) {
                        failureMessages.add(errorMessage.trim());
                    }
                }
            }

            // Log failures to ExtentReports at the scenario level
            if (!failureMessages.isEmpty()) {
                StringBuilder failureReport = new StringBuilder();
                failureReport.append("<b style='color:red'>Soft Assertion Failures Detected:</b><br/><ul>");
                for (String failure : failureMessages) {
                    failureReport.append("<li>").append(failure).append("</li>");
                }
                failureReport.append("</ul>");

                // Try to log to current step first, if available
                if (ExtentCucumberAdapter.getCurrentStep() != null) {
                    try {
                        ExtentCucumberAdapter.getCurrentStep().log(Status.FAIL, failureReport.toString());
                    } catch (Exception e) {
                        // If logging to step fails, log error but continue
                        System.err.println("Failed to log to current step: " + e.getMessage());
                    }
                }

                // Always log to console for visibility
                System.err.println("========================================");
                System.err.println("SOFT ASSERTION FAILURES DETECTED (" + failureMessages.size() + "):");
                System.err.println("========================================");
                for (int i = 0; i < failureMessages.size(); i++) {
                    System.err.println((i + 1) + ". " + failureMessages.get(i));
                }
                System.err.println("========================================");
            }
        } finally {
            softAssert.remove();
            customerSoftAssertion.remove();
        }
        return failureMessages;
    }

    public void verifyFieldCountByTypeInViewStep(String viewName, int count) {

        Element element = new Element(viewName + "." + "." + count + ".byxpath", "//span[text()='" + viewName + "']//parent::div//parent::title-header//following-sibling::div//*[local-name()='input' or local-name()='kendo-dropdownlist' or local-name()='dropdowntreeviewmutiliselect']");
        element.verifyCountOfElement(element.getChildWebElementFromElement(ElementStatus.PRESENT), count);
    }

    public void checkElementsExpectedString(String elementName, String xpath, String expectedString) {
        Element element = new Element(elementName, xpath);
        expectedString = getPropertyTextValueBasedOnLanguage(expectedString.trim());
        element.verifyListOfStringMatch(element.getChildWebElementFromElement(ElementStatus.PRESENT), expectedString);
    }

    public void checkElementsExpectedStringWithSoftAssertion(String elementName, String xpath, String expectedString) {
        Element.waitForLoadingIconToBeNotPresentStatic();
        Element element = new Element(elementName, xpath);
        expectedString = getPropertyTextValueBasedOnLanguage(expectedString.trim());
        verifyListOfStringMatchWithSoftAssertion(element.getChildWebElementFromElement(ElementStatus.PRESENT), expectedString);
    }


    public void verifyListOfStringMatchWithSoftAssertion(List<Locator> webElements, String listOfString) {
        List<String> actualString = webElements.stream().filter(Locator::isVisible).map(e -> e.innerText().trim().replace("\u00A0", " ").replaceAll("\\s+", " ").trim()).collect(Collectors.toList());
        List<String> expectedString = Arrays.stream(listOfString.split(",")).map(e -> e.replace("^^", ",")).map(String::trim).collect(Collectors.toList());
        actualString = actualString.stream().filter(v -> !v.isEmpty()).collect(Collectors.toList());

        System.out.println("we are asserting list of string of actual: " + actualString + " against the following expected list of string:" + expectedString);

        int maxSize = Math.max(actualString.size(), expectedString.size());

        for (int i = 0; i < maxSize; i++) {
            try {
                String actual = actualString.get(i);
                String expected = expectedString.get(i);

                if (!actual.equals(expected)) {
                    softAssert.get().fail("Failed assertion of list of actual elements present: " + actualString + " against the following expected list of string:" + expectedString + buildConciseDiff(actualString, expectedString));
                    return;
                }
            } catch (IndexOutOfBoundsException e) {
                softAssert.get().fail("In out of bound exception!, Failed assertion of list of actual elements present: " + actualString + " against the following expected list of string:" + expectedString + buildConciseDiff(actualString, expectedString));
                break;
            }
        }
    }

    private String buildConciseDiff(List<String> actual, List<String> expected) {
        int n = actual.size(), m = expected.size();
        int[][] lcs = new int[n + 1][m + 1];
        for (int i = n - 1; i >= 0; i--)
            for (int j = m - 1; j >= 0; j--)
                lcs[i][j] = actual.get(i).equals(expected.get(j))
                        ? lcs[i + 1][j + 1] + 1
                        : Math.max(lcs[i + 1][j], lcs[i][j + 1]);

        List<String> extraInActual = new ArrayList<>();
        List<String> missingFromActual = new ArrayList<>();

        int i = 0, j = 0;
        while (i < n && j < m) {
            if (actual.get(i).equals(expected.get(j))) { i++; j++; }
            else if (lcs[i + 1][j] >= lcs[i][j + 1]) extraInActual.add(actual.get(i++));
            else missingFromActual.add(expected.get(j++));
        }
        while (i < n) extraInActual.add(actual.get(i++));
        while (j < m) missingFromActual.add(expected.get(j++));

        StringBuilder sb = new StringBuilder();
        sb.append("\nEXTRA [").append(String.join(", ", extraInActual)).append("]");
        sb.append("\nMISSING [").append(String.join(", ", missingFromActual)).append("]");
        return sb.toString();
    }


    public boolean checkElementsIsRequired(String elementName, String xpath, boolean expectedRequired) {
        boolean elementActualIsRequiredAsTag = false;
        boolean elementActualIsRequiredByTableHeader = false;
        boolean elementActualIsRequiredByClass = false;
        Element element = new Element(elementName, xpath);
        boolean elementActualIsRequiredByLabel = false;

        if (xpath.contains("@aria-colindex='")) {
            String colIndex = "";
            colIndex = xpath.split("@aria-colindex='")[1].split("'")[0];
            String tableHeaderXpath = xpath + "//preceding::table[last() and not(ancestor::vehicle-history-grid)]//th[@aria-colindex='" + colIndex + "']";

            Element headerElement = new Element(elementName, tableHeaderXpath);
            Locator webElementRequiredByHeader = headerElement.getWebElementWithoutAssertion(1);
            elementActualIsRequiredByTableHeader = webElementRequiredByHeader != null && webElementRequiredByHeader.getAttribute("class") != null && webElementRequiredByHeader.getAttribute("class").toLowerCase().contains("required");
        }

        Locator webElementRequiredByTag  = element.getWebElementWithoutAssertion(1);
        String labelXpath = xpath + "//preceding-sibling::label | "+xpath + "//preceding-sibling::*/label";
        element = new Element(elementName, labelXpath);
        Locator webElementRequiredByLabel = element.getWebElementWithoutAssertion(1);

        if ( expectedRequired && webElementRequiredByTag == null && webElementRequiredByLabel == null){
            String message = "Required status mismatch for element', in form " + elementName.split("\\.")[0] + " ,element name: " + elementName+ " ,expected: " + expectedRequired + " ,but actual was for required in class " + webElementRequiredByLabel + " ,and required as a tag: " + webElementRequiredByTag;
            softAssert.get().fail(message);
            return false;
        } else {
            elementActualIsRequiredByLabel = webElementRequiredByLabel != null && webElementRequiredByLabel.getAttribute("class") != null && webElementRequiredByLabel.getAttribute("class").toLowerCase().contains("required") ;
            elementActualIsRequiredAsTag = webElementRequiredByTag != null && webElementRequiredByTag.getAttribute("required") != null; ;
            String elementClass = (webElementRequiredByTag != null) ? webElementRequiredByTag.getAttribute("class") : null;
            elementActualIsRequiredByClass = elementClass != null && elementClass.toLowerCase().contains("required");
            if (expectedRequired && ( elementActualIsRequiredByLabel || elementActualIsRequiredAsTag || elementActualIsRequiredByTableHeader || elementActualIsRequiredByClass)){
                return true;
            } else if (!expectedRequired && (!elementActualIsRequiredByLabel && !elementActualIsRequiredAsTag && !elementActualIsRequiredByTableHeader && !elementActualIsRequiredByClass)) {
                return true;
            } else {
                String message = "Required status mismatch for element', in form " + elementName.split("\\.")[0] + " ,element name: " + elementName + " ,expected: " + expectedRequired + " ,but actual was for required in class " + elementActualIsRequiredByLabel + " ,and required as a tag: " + elementActualIsRequiredAsTag;
                softAssert.get().fail(message);
                return false;
            }
        }
    }

    public String getFieldLabelFromVerificationXpath(String fullXPath) {
        // Find the index of the start of the dynamic content
        String markerStart = "text()='";
        String markerEnd = "'";
        int startIndex = fullXPath.indexOf(markerStart) + markerStart.length();

        // The single Java line to get the value between the single quotes:
        return fullXPath.substring(startIndex, fullXPath.indexOf(markerEnd, startIndex));
    }

    public boolean checkElementsIsEditableAgainstExpectedStatus(String formName, String elementName, String elementXpath, boolean expectedIsEditable) {
        Element element = new Element(elementName, elementXpath);
        Locator webElement = element.getWebElementWithoutAssertion(2);
        String fieldLabel = getFieldLabelFromVerificationXpath(elementXpath);
        String InvertElementPath = EjarGenericStepDefs.returnPathOfElementBasedOnEditableOrNot(formName, fieldLabel, !expectedIsEditable);
        Element invertElement = new Element(elementName, InvertElementPath);
        Locator invertWebElement = invertElement.getWebElementWithoutAssertion(2);

        if (webElement == null && invertWebElement == null) {
            softAssert.get().assertTrue(false, "Editable status error for element',element was not found, element name:'" + elementName + " ,for both element xpath: " + elementXpath + " ,and xpath:" + InvertElementPath);
            return false;
        } else {
            if (invertWebElement != null) {
                String message = "Editable status mismatch for element', in form " + elementName.split("\\.")[0] + " ,element name: " + elementName.split("\\.")[1] + " ,expected: " + expectedIsEditable + " ,but actual was: " + !expectedIsEditable;
                softAssert.get().fail(message);
                return false;
            }
        }
        return true;
    }

    /**
     * Soft assertion version of verifyElementPresent
     * Checks if element is present and records a soft assertion failure if not found
     * Similar to checkElementsIsRequired method
     */
    public boolean checkElementPresentWithSoftAssertion(String elementName, int waitingPeriodInSeconds) {
        return checkElementPresentWithSoftAssertion(elementName, PropManager.getInstance().getProperty(elementName), 2);
    }

    /**
     * Soft assertion version of verifyElementPresent
     * Checks if element is present and records a soft assertion failure if not found
     * Similar to checkElementsIsRequired method
     */
    public boolean checkElementPresentWithSoftAssertion(String elementName, String xpath, int waitingPeriodInSeconds) {
        Element element = new Element(elementName, xpath);
        // Use checkElementPresent which returns boolean instead of throwing exception
        boolean elementActualIsPresent = element.checkElementPresent(ElementStatus.PRESENT, waitingPeriodInSeconds);
        if (!elementActualIsPresent) {
            String message = "Element not present: '" + elementName + "' with xpath: '" + xpath + "'";
            softAssert.get().fail(message);
        }
        return elementActualIsPresent;
    }

    public boolean checkElementNotPresentWithSoftAssertion(String elementName, String xpath, int waitPeriod) {
        Element element = new Element(elementName, xpath);
        boolean elementActualIsPresent = element.checkElementPresent(ElementStatus.PRESENT, waitPeriod);
        if (elementActualIsPresent) {
            String message = "Element was present and it was expected to be not present: '" + elementName + "' with xpath: '" + xpath + "'";
            softAssert.get().fail(message);
        }
        return !elementActualIsPresent;
    }

    public void checkElementsExpectedString(String elementName, String expectedString) {
        Element element = new Element(elementName);
        expectedString = getPropertyTextValueBasedOnLanguage(expectedString);
        element.verifyListOfStringMatch(element.getChildWebElementFromElement(ElementStatus.PRESENT), expectedString);

    }

    public void clickOnMenuLink(String menuName, String pageLink) {

        new Element("ejar.main.menu." + menuName + ".byxpath", "//ul[not(contains(@class,'menu__subnav'))]/li/a//span[text()='" + menuName + "']").clickElement();
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        new Element("ejar.menu.link." + menuName + ".byxpath", "(//li//a[@href='" + pageLink + "' and @role='menuitem'])[1]").clickElement();
    }

    public void clickOnMenuLink(String menuName, String subMenuName, String pageLink) {
        new Element("ejar.main.menu." + menuName + ".byxpath", "//ul[not(contains(@class,'menu__subnav'))]/li/a//span[text()='" + menuName + "']").clickElement();
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        new Element("ejar.sub.menu." + menuName + ".byxpath", "//nav[@aria-label='" + menuName + "']//span[text()='" + subMenuName + "']").clickElement();
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        new Element("ejar.menu.link." + menuName + ".byxpath", "(//li//a[@href='" + pageLink + "' and @role='menuitem'])[1]").clickElement();
    }

    public void verifyEjarReportStandardActions() {

    }

    /**
     * Soft assertion version of verifyElementPresent
     * Checks if element is present and records a soft assertion failure if not found
     * Similar to checkElementsIsRequired method
     */
    public boolean checkElementEditStatuseWithSoftAssertion(String elementName, String xpath,boolean expectedEditStatus, int waitingPeriodInSeconds) {

        Element element = new Element(elementName, xpath);
        //featureLoc has the row of the table that has an error.
        String featureLoc = TestData.getInstance().getThreadSharedMethods().get().getFeatureName();

        //if it was not a field and is not expected to be editable (readonly) return true
        if(!element.isField()) {
            if (!expectedEditStatus) {
                return true;
            } else {
                softAssert.get().fail(" " + featureLoc +"Element was Expected to be Editable but found it was Readonly: " + elementName + "' with xpath: '" + xpath + "'");
                return false;
            }
        }
        Locator loc = element.getWebElementWithoutAssertion(waitingPeriodInSeconds);
        String disabledAttributeActualIsPresent = loc != null ? loc.getAttribute("disabled") : null;
        String readOnlyAttributeActualIsPresent = loc != null ? loc.getAttribute("readonly") : null;
        String classAttributeContain = loc != null ? loc.getAttribute("class") : null;
        boolean hasDisabledClass = (classAttributeContain != null && (classAttributeContain.toLowerCase().contains("disabled") || classAttributeContain.toLowerCase().contains("view")));
        boolean isActuallyDisabled = (disabledAttributeActualIsPresent != null || readOnlyAttributeActualIsPresent != null || hasDisabledClass);

        if (expectedEditStatus && isActuallyDisabled) {
            String message = " " + featureLoc + " Element was expected to be Editable but actually was Readonly: '" + elementName + "' with xpath: '" + xpath + "'";
            softAssert.get().fail(message);
            return false;
        } else {
            if (!expectedEditStatus && !isActuallyDisabled) {
                String message = " " + featureLoc + " Element was expected to be Readonly but actually was Editable: '" + elementName + "' with xpath: '" + xpath + "'";
                softAssert.get().fail(message);
                return false;
            }
        }
        return true;
    }
    public void assertActualExpected( String message){
        softAssert.get().fail(message);
    }
}
