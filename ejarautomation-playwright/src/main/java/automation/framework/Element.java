package automation.framework;

import automation.framework.business.ElementStatus;
import automation.framework.propmanager.PropManager;
import automation.framework.threadData.DriverFactory;
import com.microsoft.playwright.Locator;
import com.microsoft.playwright.Page;
import com.microsoft.playwright.TimeoutError;
import com.microsoft.playwright.options.SelectOption;
import lombok.extern.slf4j.Slf4j;
import org.junit.Assert;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Random;
import java.util.stream.Collectors;

import static com.microsoft.playwright.options.WaitForSelectorState.VISIBLE;

/**
 * This class deals with web page elements using: id, xpath, className, css selector (Playwright).
 * Created By e.mubarak@iyelo.com
 */

@Slf4j
public class Element {

    private final String locatorName;
    private final int waitPeriodForElement = Integer.parseInt(PropManager.getInstance().getProperty("driver.element.wait"));
    private String locatorValue;

    public Element(String locatorName, String locatorValue) {
        this.locatorName = locatorName;
        this.locatorValue = locatorValue;
    }

    public Element(String locatorName) {
        this.locatorName = locatorName;
        String locatorValue = getLocatorValue(locatorName);
        if (locatorValue == null || locatorValue.isEmpty())
            Assert.fail("The locator name: " + locatorName + " ,seem wrong because the locator value was empty or null");
        this.locatorValue = locatorValue;
    }

    public static void waitForLoadingIconToBeNotPresentStatic(String projectType) {
        String oldLoadingElement = "";
        String newLoadingElement = "";
        switch (projectType) {
            case "ejar web":
                oldLoadingElement = "ejar.waitingicon.byxpath";
                newLoadingElement = "ejar.generic.gridload.byxpath";
                break;
            case "yelo web":
                oldLoadingElement = "yelo.waitingicon.byxpath";
                newLoadingElement = "yelo.waitingicon.byxpath";
                break;
        }

        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
        new Element(oldLoadingElement).waitForElementNotPresent();
        new Element(newLoadingElement).waitForElementNotPresent();
    }
    public static void waitForLoadingIconToBeNotPresentStatic() {
        waitForLoadingIconToBeNotPresentStatic(PropManager.getInstance().getProperty("execution.project.name"));
    }

    public String getLocatorName() {
        return locatorName;
    }

    public int getWaitPeriodForElement() {
        return waitPeriodForElement;
    }

    public String getLocatorValue() {
        return locatorValue;
    }

    public void setLocatorValue(String locatorValue) {
        this.locatorValue = locatorValue;
    }

    public void waitForLoadingIconToBeNotPresent() {
        String elementName = "";
        switch (PropManager.getInstance().getProperty("execution.project.name")) {
            case "ejar web":
                elementName = "ejar.waitingicon.byxpath";
                break;
            case "yelo web":
                elementName = "yelo.waitingicon.byxpath";
                break;
        }
        new Element(elementName).waitForElementNotPresent();
    }

    public void waitForLoadingIconToBeNotVisible() {
        String elementName = "";
        switch (PropManager.getInstance().getProperty("execution.project.name")) {
            case "ejar web":
                elementName = "ejar.waitingicon.byxpath";
                break;
            case "yelo web":
                elementName = "yelo.waitingicon.byxpath";
                break;
        }
        new Element(elementName).waitForElementNotVisible();
    }

    public void waitForElementNotPresent() {
        int i = 0;
        int elements = getLocator().count();
        while (elements != 0) {
            System.out.println("we are waiting for element to be not present: " + locatorName + " ,it found currently for: " + elements + " times");
            if (i >= waitPeriodForElement)
                Assert.fail("The element:" + locatorName + " ,with locator: " + locatorValue + " ,was still present on the page after waiting for: " + waitPeriodForElement);
            i++;
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            elements = getLocator().count();
        }
    }

    public void waitForElementNotVisible() {
        try {
            getLocatorFirst().waitFor(new Locator.WaitForOptions().setState(com.microsoft.playwright.options.WaitForSelectorState.HIDDEN).setTimeout(waitPeriodForElement * 1000.0));
        } catch (Exception e) {
            Assert.fail("The element:" + locatorName + " ,with locator: " + locatorValue + " ,was still visible on the page after waiting for: " + waitPeriodForElement);
        }
    }

    public void waitForElementNotPresent(int WaitingPeriod) {
        int i = 0;
        int elements = getLocator().count();
        while (elements != 0) {
            System.out.println("we are waiting for element to be not present: " + locatorName + " ,it found currently for: " + elements + " times");
            if (i >= WaitingPeriod)
                Assert.fail("The element:" + locatorName + " ,with locator: " + locatorValue + " ,was still present on the page after waiting for: " + WaitingPeriod);
            i++;
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            elements = getLocator().count();
        }
    }

    public void waitForElementNotPresent(int waitPeriod, String status) {
        System.out.println("we are waiting for element to be NOT present " + locatorName);
        try {
            if ("present".equalsIgnoreCase(status)) {
                getLocatorFirst().waitFor(new Locator.WaitForOptions().setState(com.microsoft.playwright.options.WaitForSelectorState.ATTACHED).setTimeout(waitPeriod * 1000.0));
            } else {
                getLocatorFirst().waitFor(new Locator.WaitForOptions().setState(VISIBLE).setTimeout(waitPeriod * 1000.0));
            }
        } catch (TimeoutError e) {
            return;
        }
        Assert.fail("the element: " + locatorName + " was still found after waiting: " + waitPeriod);
    }

    public Locator waitForElement(ElementStatus elementStatus, int waitTime) {
        System.out.println("Waiting for element: " + locatorName + " (max " + waitTime + "s)");
        Locator locator = getLocatorFirst();
        try {
            com.microsoft.playwright.options.WaitForSelectorState state = (elementStatus == ElementStatus.PRESENT || elementStatus == ElementStatus.VISIBLE)
                    ? com.microsoft.playwright.options.WaitForSelectorState.ATTACHED
                    : VISIBLE;
            locator.waitFor(new Locator.WaitForOptions()
                    .setState(state)
                    .setTimeout(waitTime * 1000.0));
            System.out.println("Element found: " + locatorName);
        } catch (TimeoutError e) {
            Assert.fail("The element: " + locatorName + " was not found after waiting: " + waitTime + " seconds");
        }
        return locator;
    }

    public Locator waitForElementWithAssertion(ElementStatus elementStatus, int waitTime) {
        System.out.println("Waiting for element: " + locatorName + " (max " + waitTime + "s)");
        Locator locator = getLocatorFirst();
        try {
            com.microsoft.playwright.options.WaitForSelectorState state = (elementStatus == ElementStatus.PRESENT || elementStatus == ElementStatus.VISIBLE)
                    ? com.microsoft.playwright.options.WaitForSelectorState.ATTACHED
                    : VISIBLE;
            locator.waitFor(new Locator.WaitForOptions()
                    .setState(state)
                    .setTimeout(waitTime * 1000.0));
            System.out.println("Element found: " + locatorName);
            return locator;
        } catch (TimeoutError e) {
            System.out.println("Element not found within " + waitTime + "s: " + locatorName);
            return null;
        }
    }

    public boolean checkElementPresent(ElementStatus elementStatus, int waitTime) {
        System.out.println("we are checking element to is present " + locatorName);
        try {
            if (elementStatus == ElementStatus.PRESENT) {
                getLocatorFirst().waitFor(new Locator.WaitForOptions().setState(com.microsoft.playwright.options.WaitForSelectorState.ATTACHED).setTimeout(waitTime * 1000.0));
            } else {
                getLocatorFirst().waitFor(new Locator.WaitForOptions().setState(VISIBLE).setTimeout(waitTime * 1000.0));
            }
        } catch (TimeoutError e) {
            return false;
        }
        return true;
    }

    /**
     * Returns the Playwright selector string (e.g. xpath=..., css=...) for this element. Keeps XPath and other types.
     */
    public String getPlaywrightSelector() {
        System.out.println("Looking for Element " + this.locatorName + " ,and locator value is: " + locatorValue);
        if (this.locatorName.contains(".byxpath")) {
            return "xpath=" + locatorValue;
        } else if (this.locatorName.contains(".bycss")) {
            return "css=" + locatorValue;
        } else if (this.locatorName.contains(".bytext")) {
            return "text=" + locatorValue;
        } else if (this.locatorName.contains(".byid")) {
            return "#" + locatorValue;
        } else if (this.locatorName.contains(".bylinktext")) {
            return "text=" + locatorValue;
        } else if (this.locatorName.contains(".byclass")) {
            return "." + locatorValue.replace(" ", ".");
        } else if (this.locatorName.contains(".byname")) {
            return "[name=\"" + locatorValue + "\"]";
        } else {
            Assert.fail("Selector used for " + locatorName + " is not supported. (supported: xpath, name, css, id) ");
        }
        return null;
    }

    /**
     * Returns Playwright Locator for this element. Uses current frame if set (e.g. inside iframe).
     * May match multiple elements; use getLocatorFirst() when you need exactly one (e.g. for click/fill).
     */
    public Locator getLocator() {
        com.microsoft.playwright.Frame frame = DriverFactory.getCurrentFrame();
        if (frame != null) {
            return frame.locator(getPlaywrightSelector());
        }
        return DriverFactory.getDriver().locator(getPlaywrightSelector());
    }

    /**
     * Returns locator narrowed to the first matching element. Use for single-element actions (click, fill, wait)
     * when the selector may match multiple elements (avoids Playwright strict mode violation).
     */
    public Locator getLocatorFirst() {
        return getLocator().first();
    }

    public String getLocatorValue(String locatorName) {
        return PropManager.getInstance().getProperty(locatorName);
    }

    public Locator getWebElement() {
        if (waitForElement(ElementStatus.VISIBLE, waitPeriodForElement) != null) {
            return getLocatorFirst();
        }
        Assert.fail("The element " + locatorName + " with locator value " + locatorValue + " is not found, please check the selector");
        return null;
    }

    /**
     * Get Locator without throwing exceptions or assertions. Returns first locator if found, null otherwise.
     */
    public Locator getWebElementWithoutAssertion(int waitPeriodForElement) {
        try {
            boolean isPresent = checkElementPresent(ElementStatus.VISIBLE, waitPeriodForElement);
            if (isPresent) {
                return getLocatorFirst();
            }
            return null;
        } catch (Exception e) {
            return null;
        }
    }

    public List<Locator> getWebElements() {
        if (waitForElement(ElementStatus.VISIBLE, waitPeriodForElement) != null) {
            List<Locator> list = getLocator().all();
            if (list != null && !list.isEmpty()) return list;
        }
        Assert.fail("The element " + locatorName + " with locator value " + locatorValue + " is not found, please check the selector");
        return null;
    }


    public List<Locator> getWebElements(int waitPeriodForElement) {
        if (waitForElement(ElementStatus.VISIBLE, waitPeriodForElement) != null) {
            List<Locator> list = getLocator().all();
            if (list != null && !list.isEmpty()) return list;
        }
        return null;
    }

    public Locator getWebElement(ElementStatus status) {
        if (waitForElement(status, waitPeriodForElement) != null) {
            return getLocatorFirst();
        }
        Assert.fail("The element " + locatorName + " with locator value " + locatorValue + " is not found, please check the selector");
        return null;
    }

    public Element getElementAfterWait(ElementStatus elementStatus) {
        waitForElement(elementStatus, waitPeriodForElement);
        if (getLocator().count() > 0) return this; // count() on full locator to verify at least one match
        Assert.fail("The element " + locatorName + " with locator value " + locatorValue + " is not found, please check the selector");
        return null;
    }

    public List<Locator> getChildWebElementFromElement(ElementStatus elementStatus) {
        List<Locator> webElements = getElementAfterWait(elementStatus).getLocator().all();
        if (webElements == null || webElements.isEmpty()) {
            Assert.fail("No list of elements were found for element: " + locatorName + " with locator value " + locatorValue + " is not found, please check the selector");
        }
        return webElements;
    }

    public void verifyElementPresent() {
        this.getWebElement();
    }

    public void clickElement() {
        waitForLoadingIconToBeNotPresentStatic();
        Locator loc = this.getWebElement();
        System.out.println("Clicking On: " + locatorName + " With Locator value: " + locatorValue);
        try {
            loc.first().click(new Locator.ClickOptions().setForce(true));
        } catch (Exception error) {
            Assert.fail("Error clicking on element: " + error.getMessage());
        }
    }

    public void clickAndIgnoreDetach() {
        Locator loc = this.getWebElement();
        try {
            // We set a short timeout because if it detaches, it happens instantly
            loc.first().click(new Locator.ClickOptions().setForce(true).setTimeout(5000));
        } catch (Exception error) {
            if (error.getMessage().contains("detached") || error.getMessage().contains("Target closed")) {
                System.out.println("Frame detached as expected after click.");
            } else {
                Assert.fail("Actual error during click: " + error.getMessage());
            }
        }
    }

    public void mouseOver() {
        Locator loc = this.getWebElement();
        System.out.println("Mouse over element: " + locatorName + " With Locator value: " + locatorValue);
        try {
            loc.hover();
        } catch (Exception error) {
            Assert.fail("The mouse over failed!, The element: " + error.getMessage());
        }
    }

    public void waitForElementVisibility(Locator loc) {
        loc.waitFor(new Locator.WaitForOptions().setState(VISIBLE).setTimeout(Integer.parseInt(PropManager.getInstance().getProperty("driver.element.wait")) * 1000.0));
    }

    public void waitForElementToBeClickable() {
        Locator loc = getWebElement();
        loc.waitFor(new Locator.WaitForOptions().setState(VISIBLE).setTimeout(waitPeriodForElement * 1000.0));
    }

    public Locator waitForElementUntilPresent(ElementStatus elementStatus, int waitTime) {
        System.out.println("we are waiting for element to be present " + locatorName);
        try {
            if (elementStatus == ElementStatus.PRESENT) {
                getLocatorFirst().waitFor(new Locator.WaitForOptions().setState(com.microsoft.playwright.options.WaitForSelectorState.ATTACHED).setTimeout(waitTime * 1000.0));
            } else {
                getLocatorFirst().waitFor(new Locator.WaitForOptions().setState(VISIBLE).setTimeout(waitTime * 1000.0));
            }
        } catch (TimeoutError e) {
            return null;
        }
        return getLocator().count() > 0 ? getLocatorFirst() : null;
    }

    public void setValueInElement(String Value) {
        Locator element = this.getWebElement();
        System.out.println("Setting value (" + Value + ") in element: " + locatorName + " ,with Locator value: " + locatorValue);
        waitForElementVisibility(element);
        element.clear();
        element.fill(Value);
    }

    public void clearElement() {
        Locator element = this.getWebElement();
        System.out.println("Clearing element: " + locatorName + " ,with Locator value: " + locatorValue);
        waitForElementVisibility(element);
        element.clear();
    }

    public void clickOnKey(String Key, int count) {
        Locator element = this.getWebElement();
        waitForElementVisibility(element);
        for (int i = 0; i < count; i++) {
            element.press(Key);
        }
    }

    public void setValueInElement(String Value, ElementStatus status) {
        Locator element = this.getWebElement(status);
        System.out.println("Setting value (" + Value + ") in element: " + locatorName + " ,with Locator value: " + locatorValue);
        waitForElementVisibility(element);
        element.clear();
        element.fill(Value);
    }

    public String getElementValue() {
        Locator element = this.getWebElement();
        System.out.println("Getting value from element: " + locatorName + " ,with Locator value: " + locatorValue);
        String value = element.innerText();
        if (value == null || value.isEmpty()) value = element.getAttribute("innerHTML");
        return value != null ? value : "";
    }

    public void verifyElementText(String textToVerify) {
        Locator element = this.getWebElement();
        System.out.println("We are asserting element text, the element: " + this.locatorName + " ,the text in element: " + element.innerText().trim() + " ,the text to verify:" + textToVerify);
        Assert.assertEquals(textToVerify.trim(), element.innerText().trim());
    }

    public void verifyElementContainsText(String textToVerify) {
        if (textToVerify.isEmpty())
            Assert.fail("The text to verify against was empty!, against element: " + this.getLocatorName());
        Locator element = this.getWebElement();
        System.out.println("We are asserting element contains text, the element: " + this.locatorName + " ,the text in element: " + element.innerText() + " ,the text to verify:" + textToVerify);
        Assert.assertTrue("The element: " + this.getLocatorName() + " , with text:" + element.innerText() + " ,didn't contains the intended text: " + textToVerify, element.innerText().contains(textToVerify));
    }

    public void verifyListOfStringMatch(List<Locator> webElements, String listOfString) {
        List<String> actualString = webElements.stream().map(e -> e.innerText().trim()).collect(Collectors.toList());
        List<String> expectedString = Arrays.stream(listOfString.split(",")).map(e -> e.replace("^^", ",")).map(String::trim).collect(Collectors.toList());
        actualString = actualString.stream().filter(v -> !v.isEmpty()).collect(Collectors.toList());
        System.out.println("we are asserting list of string of actual: " + actualString + " against the following expected list of string:" + expectedString);
        try {
            for (int i = 0; i < actualString.size(); i++) {
                Assert.assertEquals("Failed assertion of list of actual elements present: " + actualString + " against the following expected list of string:" + expectedString, expectedString.get(i), actualString.get(i));
            }
        } catch (IndexOutOfBoundsException e) {
            Assert.fail("In out of bound exception!, Failed assertion of list of actual elements present: " + actualString + " against the following expected list of string:" + expectedString);
        }
    }

    public void selectRandomValueInList(int startOption) {
        Locator element = this.getWebElement();
        Random randomOption = new Random();
        List<Locator> options = element.locator("option").all();
        startOption = 1;
        int endOption = options.size();
        int number = startOption + randomOption.nextInt(Math.max(1, endOption - startOption));
        element.selectOption(new SelectOption().setIndex(number - 1));
    }

    public void selectItemInListByValue(String Value) {
        Locator element = this.getWebElement();
        System.out.println("Selecting value (" + Value + " from drop down element: " + locatorName + " ,With Locator value: " + locatorValue);
        element.selectOption(Value);
    }

    public void selectItemInListByVisibleText(String value) {
        Locator element = this.getWebElement();
        System.out.println("selecting option by text (" + value + " in element: " + locatorName + " With Locator value: " + locatorValue);
        element.selectOption(new SelectOption().setLabel(value));
    }

    public void verifyDropDownFieldTextOptions(String optionsList) {
        Element.waitForLoadingIconToBeNotPresentStatic();
        List<String> expectedOptionList = Arrays.stream(optionsList.split(",")).collect(Collectors.toList());
        List<Locator> actualOptions = getWebElement().locator("option").all();
        Assert.assertEquals("The actual field options size: " + actualOptions.size() + " ,didn't match the expected: " + expectedOptionList.size(), expectedOptionList.size(), actualOptions.size());
        for (int i = 0; i < actualOptions.size(); i++) {
            Assert.assertEquals("The actual field options: " + actualOptions + " ,didn't match the expected options: " + optionsList, expectedOptionList.get(i).trim(), actualOptions.get(i).innerText().trim());
            Element.waitForLoadingIconToBeNotPresentStatic();
        }
    }

    public void selectOptionInDropDownFieldByText(String optionText) {
        getWebElement().selectOption(new SelectOption().setLabel(optionText));
    }

    public void selectOptionInDropDownFieldByValue(String optionValue) {
        getWebElement().selectOption(optionValue);
    }

    public void selectOptionInDropDownFieldByIndex(String optionIndex) {
        getWebElement().selectOption(new SelectOption().setIndex(Integer.parseInt(optionIndex)));
    }

    public void selectFirstOptionInDropDownField() {
        getWebElement().selectOption(new SelectOption().setIndex(0));
    }

    public void sendKeysInElement(String key) {
        Locator webElement = getWebElement();
        webElement.clear();
        webElement.pressSequentially(key);
    }

    public void sendKeysInElement(String key, Locator.PressSequentiallyOptions pressOptions) {
        Locator webElement = getWebElement();
        webElement.clear();
        webElement.pressSequentially(key, pressOptions);
    }

    public void sendKeysInElementWithoutClear(String key) {
        Locator webElement = getWebElement();
        webElement.pressSequentially(key);
    }

    public void modifyActionCssStyleToBeVisible(String elementClassAttribute) {
        DriverFactory.getDriver().evaluate("document.getElementsByClassName('" + elementClassAttribute + "').style='display'");
    }

    public void executeJsQuery(String jsQuery) {
        DriverFactory.getDriver().evaluate(jsQuery);
    }

    public void verifyCountOfElement(List<Locator> actualElements, int expectedCount) {
        Assert.assertEquals("The actual field count: " + actualElements.size() + " ,didn't match the expected: " + expectedCount + ",for element with name: " + this.getLocatorName() + " ,and locator value: " + this.getLocatorValue(), expectedCount, actualElements.size());
    }

    public void clickOnElementIfExist() {
        waitForLoadingIconToBeNotPresent();
        List<Locator> elements = getLocator().all();
        if (!elements.isEmpty()) {
            for (Locator webElement : elements) {
                try {
                    Thread.sleep(500);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                if (checkElementPresent(ElementStatus.VISIBLE, 1)) webElement.click();
            }
        }
        Element.waitForLoadingIconToBeNotPresentStatic();
    }

    public void clickOnElementIfExist(String elementName, String numberOfSeconds) {
        Element element = new Element(elementName);
        if (element.checkElementPresent(ElementStatus.VISIBLE, Integer.parseInt(numberOfSeconds))) {
            element.clickElement();
        }
        Element.waitForLoadingIconToBeNotPresentStatic();
    }

    public void dragElement(int xDistance, int yDistance) {
        Locator element = this.getWebElement();
        com.microsoft.playwright.options.BoundingBox box = element.boundingBox();
        if (box != null) {
            Page p = DriverFactory.getDriver();
            p.mouse().move(box.x + box.width / 2, box.y + box.height / 2);
            p.mouse().down();
            p.mouse().move(box.x + box.width / 2 + xDistance, box.y + box.height / 2 + yDistance);
            p.mouse().up();
        }
        System.out.println("We are dragging element, the element: " + this.locatorName + " ,xDistance: " + xDistance + " ,yDistance: " + yDistance);
    }

    public void validatetoolTip(Element toolTipElement) {
        Locator element = this.getWebElement();
        element.hover();
        toolTipElement.waitForElement(ElementStatus.VISIBLE, 250);
    }

    public boolean isLabel() {
        Locator element = this.getWebElement();
        Object result = element.evaluate("el => el.tagName");
        String tagName = result != null ? result.toString() : "";
        return tagName.equalsIgnoreCase("label");
    }

    public boolean isField() {
        Locator element = this.getWebElement();
        Object result = element.evaluate("el => el.tagName");
        String tagName = result != null ? result.toString() : "";
        ArrayList<String> fields = new ArrayList<>(List.of("input", "dropdown-list", "kendo-datepicker", "textarea", "select", "kendo-dropdownlist", "kendo-combobox", "kendo-searchbar", "kendo-datetimepicker", "button", "ejar-kendo-date-time-picker", "div", "kendo-multiselect", "select-employee", "kendo-taglist", "a", "angular-editor", "vehicle-tree", "kendo-checkbox","kendo-timepicker","angular-editor","vehicle-search-input"));
        return fields.contains(tagName.toLowerCase());
    }

    /** Press a single key (e.g. "Enter", "Backspace"). Use for keyboard keys. */
    public void sendKeysInElementKey(String keyName) {
        getWebElement().press(keyName);
    }

    public void scrollToElement() {
        Locator loc = this.getWebElement();
        System.out.println("Scrolling to element: " + locatorName);
        try {
            loc.scrollIntoViewIfNeeded();
        } catch (Exception e) {
            log.error("Failed to scroll to element: " + e.getMessage());
        }
    }


    public boolean isElementPresentAfterWait(int seconds) {
        try {
            // We use ATTACHED to check if it exists in the DOM (XPath found)
            // We multiply by 1000 because Playwright expects milliseconds
            getLocatorFirst().waitFor(new Locator.WaitForOptions()
                    .setState(com.microsoft.playwright.options.WaitForSelectorState.ATTACHED)
                    .setTimeout(seconds * 1000.0));
            return true;
        } catch (TimeoutError e) {
            System.out.println("Element " + locatorName + " not found after " + seconds + " seconds.");
            return false;
        } catch (Exception e) {
            log.error("An unexpected error occurred: " + e.getMessage());
            return false;
        }
    }

}
