package automation.framework.threadData;

import automation.framework.propmanager.PropManager;
import com.microsoft.playwright.*;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;

import java.awt.*;
import java.util.HashMap;
import java.util.Map;

/**
 * Factory service for creating and getting Playwright Page (replaces WebDriver).
 *
 * @author e.mubarak@iyelo.com
 */

@Data
@Slf4j
public class DriverFactory {

    private static ThreadLocal<Page> page = new ThreadLocal<>();
    private static ThreadLocal<com.microsoft.playwright.Frame> currentFrame = new ThreadLocal<>();
    private static ThreadLocal<BrowserContext> browserContext = new ThreadLocal<>();
    private static ThreadLocal<Browser> browser = new ThreadLocal<>();
    private static ThreadLocal<Playwright> playwright = new ThreadLocal<>();
    private static ThreadLocal<String> recordVideoDir = new ThreadLocal<>();

    private DriverFactory() {
    }

    public static void setRecordVideoDir(String dir) {
        recordVideoDir.set(dir);
    }

    public static void clearRecordVideoDir() {
        recordVideoDir.remove();
    }

    /**
     * Create a new instance of the browser/page if not already created.
     *
     * @return Playwright Page object
     */
    private static Page createInstance() {
        String browserName = PropManager.getInstance().getProperty("execution.browser");
        java.awt.Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();
        boolean useProductionResolution = "true".equalsIgnoreCase(System.getProperty("execution.use.production.resolution"));
        String widthKey = useProductionResolution ? "screen.width.production" : "screen.width";
        String heightKey = useProductionResolution ? "screen.height.production" : "screen.height";
        int width = getScreenDimension(widthKey, (int) screenSize.getWidth());
        int height = getScreenDimension(heightKey, (int) screenSize.getHeight());
        boolean isHeadless = "true".equalsIgnoreCase(PropManager.getInstance().getProperty("execution.headless"));

        switch (PropManager.getInstance().getProperty("execution.application.type").toLowerCase()) {
            case "ejar web":
                browserName = (browserName != null) ? browserName : "chrome";
                Playwright p = Playwright.create();
                playwright.set(p);
                Browser.NewContextOptions contextOptions;
                switch (BrowserName.valueOf(browserName.toUpperCase())) {
                    case FIREFOX:
                        browser.set(p.firefox().launch(new BrowserType.LaunchOptions().setHeadless(isHeadless)));
                        contextOptions = new Browser.NewContextOptions()
                                .setViewportSize(width, height)
                                .setIgnoreHTTPSErrors(true);
                        break;
                    case CHROME:
                    default:
                        Map<String, Object> prefs = new HashMap<>();
                        prefs.put("credentials_enable_service", false);
                        prefs.put("profile.password_manager_enabled", false);
                        browser.set(p.chromium().launch(new BrowserType.LaunchOptions()
                                .setChannel("chrome")
                                .setHeadless(isHeadless)
                                .setArgs(java.util.Arrays.asList(
                                        "--disable-web-security",
                                        "--allow-running-insecure-content",
                                        "--disable-popup-blocking",
                                        "--remote-allow-origins=*",
                                        "--start-maximized",
                                        "--deny-permission-prompts"
                                ))));
                        contextOptions = new Browser.NewContextOptions()
                                .setViewportSize(null)
                                .setIgnoreHTTPSErrors(true)
                                .setPermissions(java.util.Arrays.asList());
                        break;
                }
                if (isRecordVideoEnabled()
                        && recordVideoDir.get() != null) {
                    contextOptions.setRecordVideoDir(java.nio.file.Paths.get(recordVideoDir.get()));
                    contextOptions.setRecordVideoSize(width, height);
                }
                BrowserContext context = browser.get().newContext(contextOptions);
                context.setDefaultTimeout(Integer.parseInt(PropManager.getInstance().getProperty("driver.element.wait")) * 1000);
                context.setDefaultNavigationTimeout(Integer.parseInt(PropManager.getInstance().getProperty("driver.element.wait")) * 1000);
                browserContext.set(context);
                Page newPage = context.newPage();
                newPage.setViewportSize(width, height);
                page.set(newPage);
                break;
        }
        return page.get();
    }

    /**
     * Get the existing Page or create a new one if null.
     *
     * @return Playwright Page object
     */
    public static Page getDriver() {
        if (page.get() == null) {
            log.info("Thread has no Playwright Page, creating new one");
            return createInstance();
        }
        return page.get();
    }

    public static Page getPageIfExists() {
        return page.get();
    }

    /**
     * Set the current page (e.g. when switching browser tabs).
     */
    public static void setCurrentPage(Page p) {
        page.set(p);
        currentFrame.set(null);
    }

    /**
     * Set the current frame (e.g. when switching to iframe). Pass null to clear.
     */
    public static void setCurrentFrame(com.microsoft.playwright.Frame frame) {
        currentFrame.set(frame);
    }

    /**
     * Get the current frame if we are inside an iframe, otherwise null.
     */
    public static com.microsoft.playwright.Frame getCurrentFrame() {
        return currentFrame.get();
    }

    /**
     * Get the current BrowserContext (for multi-context scenarios if needed).
     */
    public static BrowserContext getBrowserContext() {
        if (browserContext.get() == null) {
            getDriver();
        }
        return browserContext.get();
    }

    public static void destroyDriverObject() {
        try {
            currentFrame.set(null);
            if (page.get() != null) {
                page.get().close();
            }
            if (browserContext.get() != null) {
                browserContext.get().close();
            }
            if (browser.get() != null) {
                browser.get().close();
            }
            if (playwright.get() != null) {
                playwright.get().close();
            }
        } finally {
            page.set(null);
            currentFrame.set(null);
            browserContext.set(null);
            browser.set(null);
            playwright.set(null);
        }
    }

    private static boolean isRecordVideoEnabled() {
        try {
            if (TestData.getInstance().getThreadSharedMethods().get() != null) {
                String testName = TestData.getInstance().getThreadSharedMethods().get().getTestName();
                if (testName != null && testName.contains("Production")) {
                    return "true".equalsIgnoreCase(PropManager.getInstance().getProperty("recordVideo.Production"));
                }
            }
        } catch (Exception ignored) {
        }
        return "true".equalsIgnoreCase(PropManager.getInstance().getProperty("recordVideo"));
    }

    private enum BrowserName {
        FIREFOX,
        CHROME,
    }

    /**
     * Reads a screen dimension from a JVM system property first, then from the properties file.
     * Falls back to the machine's screen size if neither is set or the value is invalid.
     */
    private static int getScreenDimension(String key, int fallback) {
        String value = System.getProperty(key);
        if (value == null || value.trim().isEmpty()) {
            value = PropManager.getInstance().getProperty("execution." + key);
        }
        if (value == null || value.trim().isEmpty()) {
            return fallback;
        }
        try {
            return Integer.parseInt(value.trim());
        } catch (NumberFormatException e) {
            log.warn("Invalid screen dimension '{}={}', falling back to {}", key, value, fallback);
            return fallback;
        }
    }
}
