package stepdefs.generic;

import automation.framework.Element;
import automation.framework.business.FileHandler;
import automation.framework.business.RegxHelper;
import automation.framework.business.ScenarioVideoTracker;
import com.microsoft.playwright.Page;
import com.microsoft.playwright.Video;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.text.SimpleDateFormat;
import java.util.Date;
import automation.framework.business.ScreenShotHandler;
import automation.framework.listener.DateHelper;
import automation.framework.listener.RunnerListener;
import automation.framework.propmanager.PropManager;
import automation.framework.threadData.DriverFactory;
import automation.framework.threadData.SharedMethods;
import automation.framework.threadData.TestData;
import com.aventstack.extentreports.ExtentTest;
import com.aventstack.extentreports.Status;
import com.aventstack.extentreports.cucumber.adapter.ExtentCucumberAdapter;
import com.aventstack.extentreports.model.Log;
import com.aventstack.extentreports.model.Test;
import io.cucumber.java.After;
import io.cucumber.java.AfterStep;
import io.cucumber.java.Before;
import io.cucumber.java.Scenario;
import stepdefs.ejar.web.EjarPages;


import java.io.IOException;
import java.util.Collections;
import java.util.List;


public class Hook {
    private final GenericStepDefs base = new GenericStepDefs();

    public Hook() {
    }

    /**
     * Steps under the scenario that owns {@code extentTest}'s current node (thread-correct under parallel TestNG).
     * Falls back to the legacy "last scenario in last feature" list when parent links are missing.
     */
    private static List<Test> stepsListForCurrentScenario(ExtentTest extentTest) {
        if (extentTest == null || extentTest.getModel() == null) {
            return legacyLastScenarioSteps(extentTest);
        }
        Test scenario = extentTest.getModel().getParent();
        if (scenario != null && scenario.getChildren() != null && !scenario.getChildren().isEmpty()) {
            return scenario.getChildren();
        }
        return legacyLastScenarioSteps(extentTest);
    }

    private static List<Test> legacyLastScenarioSteps(ExtentTest extentTest) {
        if (extentTest == null || extentTest.getExtent() == null || extentTest.getExtent().getReport() == null) {
            return Collections.emptyList();
        }
        List<Test> featureList = extentTest.getExtent().getReport().getTestList();
        if (featureList == null || featureList.isEmpty()) return Collections.emptyList();
        List<Test> scenariosList = featureList.get(featureList.size() - 1).getChildren();
        if (scenariosList == null || scenariosList.isEmpty()) return Collections.emptyList();
        List<Test> steps = scenariosList.get(scenariosList.size() - 1).getChildren();
        return steps != null ? steps : Collections.emptyList();
    }

    /**
     * Masks password values in step text (e.g. "password: thesame1" -> "password: ******").
     */
    private static String maskPasswords(String text) {
        if (text == null) return null;
        return text.replaceAll("(?i)(password\\s*[:=]\\s*)\\S+", "$1******");
    }

    public static void setTimeStampAndStatusForEachStep(ExtentTest extentTestResult) {
        if (extentTestResult != null) {
            List<Test> stepsList = stepsListForCurrentScenario(extentTestResult);
            // The step that just ran is at index size - 2, because the last one is the hook.
            if (stepsList.size() < 2) {
                return; // Not enough steps to process
            }
            Test stepToModify = stepsList.get(stepsList.size() - 2);
            if (stepToModify == null) return;

            // Mask passwords in step name
            String stepName = stepToModify.getName();
            if (stepName != null) {
                stepName = maskPasswords(stepName);
                stepToModify.setName(stepName);
            }

            // Handle soft assertion failure for the specific step
            if (stepName != null && stepName.contains("verify form page fields, field label and is editable and is required")) {
                boolean hasSoftAssertFailures = EjarPages.hasFailures();
                if (hasSoftAssertFailures) {
                    stepToModify.setStatus(Status.FAIL);
                }
            }

            // Add timestamp to the step name
            if (stepName != null && !stepName.contains("(second)")) {
                String timeColor = "#2C42FF";
                stepToModify.setName(stepName + " - <span style=\"color:" + timeColor + "\">" + DateHelper.getElapsedTimeInSeconds(stepToModify.getStartTime(), stepToModify.getEndTime()) + " (second)</span>");
            }
        }
    }

    public static void modifyLogMediaPath(ExtentTest extentTestResult) {
        if (extentTestResult == null || extentTestResult.getExtent() == null || extentTestResult.getExtent().getReport() == null) return;
        List<Test> stepsList = stepsListForCurrentScenario(extentTestResult);
        if (stepsList.isEmpty()) return;
        Test lastStep = stepsList.get(stepsList.size() - 1);
        if (lastStep == null || lastStep.getLogs() == null) return;
        String copyPath = "";
        try {
            if (TestData.getInstance().getThreadSharedMethods() != null && TestData.getInstance().getThreadSharedMethods().get() != null) {
                String cp = TestData.getInstance().getThreadSharedMethods().get().getCopyPathForResults();
                if (cp != null && !cp.isBlank()) copyPath = cp;
            }
        } catch (Exception ignored) {
        }
        // Parallel TestNG: worker threads have a fresh SharedMethods without copyPathForResults (set on the main
        // thread in RunnerListener.testRunStarted). Fall back to the cross-thread static so media paths aren't
        // rewritten to a broken relative path like "\<feature>\images\...png".
        if (copyPath.isBlank()) {
            copyPath = RunnerListener.getRunCopyPathBackup();
        }
        String replaceFrom = System.getProperty("user.dir") + "\\" + PropManager.getInstance().getProperty("custom.report.folder");
        try {
            for (Log log : lastStep.getLogs()) {
                if (log != null && log.getMedia() != null && log.getMedia().getPath() != null) {
                    if (!copyPath.isBlank()) {
                        String path = log.getMedia().getPath();
                        // Only rewrite if the path is absolute and under the customReports folder
                        String pathLower = path.toLowerCase();
                        String replaceFromLower = replaceFrom.toLowerCase();
                        if (pathLower.startsWith(replaceFromLower + "\\") || pathLower.startsWith(replaceFromLower + "/")) {
                            path = copyPath + path.substring(replaceFrom.length());
                        }
                        log.getMedia().setPath(path);
                    }
                    if (lastStep.getName() != null && lastStep.getName().contains("Hook.afterStep")) {
                        lastStep.setName("");
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("Hook.modifyLogMediaPath skipped: " + e.getMessage());
        }
    }

    public static void takeScreenShotDecision(ExtentTest extentTestResult) {
        synchronized (ExtentCucumberAdapter.class) {
            if (ExtentCucumberAdapter.getCurrentStep() == null) return;
            try {
                if (TestData.getInstance().getThreadSharedMethods() == null || TestData.getInstance().getThreadSharedMethods().get() == null) return;
            } catch (Exception e) {
                System.out.println("Hook.takeScreenShotDecision skipped (no SharedMethods): " + e.getMessage());
                return;
            }
            if (!ExtentCucumberAdapter.getCurrentStep().getStatus().getName().equals("Pass"))
                new GenericStepDefs().changeBrowserWindowZoomLevel(.5);
            if (PropManager.getInstance().getProperty("takeScreenShots").equals("true")) {
                if (PropManager.getInstance().getProperty("takeScreenShots.onFailOnly").equals("true")) {
                    boolean hasSoftAssertFailures = EjarPages.hasFailures();
                    if (ExtentCucumberAdapter.getCurrentStep().getStatus().getName().equals("Fail") || hasSoftAssertFailures) {
                        try {
                            modifyScreenShotZoomLevel(extentTestResult);
                            ExtentCucumberAdapter.addTestStepScreenCaptureFromPath(ScreenShotHandler.TakesScreenshot(TestData.getInstance().getThreadSharedMethods().get().getImagesFolder()).getPath());
                            modifyLogMediaPath(ExtentCucumberAdapter.getCurrentStep());
                            new GenericStepDefs().changeBrowserWindowZoomLevel(1);
                        } catch (IOException e) {
                            e.printStackTrace();
                        } catch (Exception e) {
                            System.out.println("Hook.takeScreenShotDecision (onFailOnly) skipped: " + e.getMessage());
                        }
                    }
                } else {
                    try {
                        modifyScreenShotZoomLevel(extentTestResult);
                        ExtentCucumberAdapter.getCurrentStep().log(ExtentCucumberAdapter.getCurrentStep().getStatus(), ScreenShotHandler.TakesScreenshot(TestData.getInstance().getThreadSharedMethods().get().getImagesFolder()));
                        modifyLogMediaPath(ExtentCucumberAdapter.getCurrentStep());
                        new GenericStepDefs().changeBrowserWindowZoomLevel(1);
                    } catch (Exception e) {
                        System.out.println("Hook.takeScreenShotDecision skipped: " + e.getMessage());
                    }
                }
            }
        }
    }

    public static void takeScreenShot(ExtentCucumberAdapter extentCucumberAdapter) {
        modifyScreenShotZoomLevel(ExtentCucumberAdapter.getCurrentStep());
        try {
            ExtentCucumberAdapter.addTestStepScreenCaptureFromPath(ScreenShotHandler.TakesScreenshot(TestData.getInstance().getThreadSharedMethods().get().getImagesFolder()).getPath());
            modifyLogMediaPath(ExtentCucumberAdapter.getCurrentStep());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void modifyScreenShotZoomLevel(ExtentTest extentTestResult) {
        if (extentTestResult == null || extentTestResult.getExtent() == null || extentTestResult.getExtent().getReport() == null) return;
        List<Test> stepsList = stepsListForCurrentScenario(extentTestResult);
        if (stepsList.isEmpty()) return;
        // Extent sometimes has only the current step (size 1); size-2 would be index -1.
        int idx = stepsList.size() >= 2 ? stepsList.size() - 2 : stepsList.size() - 1;
        Test priorStep = stepsList.get(idx);
        if (priorStep == null || priorStep.getStatus() == null) return;
        if (!priorStep.getStatus().getName().equals("Pass")) {
            new GenericStepDefs().changeBrowserWindowZoomLevel(.5);
        }
    }


    @AfterStep
    public static void afterStep(Scenario scenario) {
        try {
            new Element("ejar.waitingicon.byxpath").waitForElementNotVisible();
        } catch (AssertionError e) {
            System.out.println("AfterStep: loading icon wait skipped or timed out: " + e.getMessage());
        } catch (Throwable t) {
            System.out.println("AfterStep: loading icon wait skipped: " + t.getMessage());
        }
        try {
            ExtentTest currentStep = ExtentCucumberAdapter.getCurrentStep();
            setTimeStampAndStatusForEachStep(currentStep);
            takeScreenShotDecision(currentStep);
            RunnerListener.rememberExtentTestForReporting(currentStep);
        } catch (Throwable t) {
            System.out.println("AfterStep: report/screenshot logic skipped (do not fail scenario): " + t.getMessage());
            t.printStackTrace();
        }
    }

    public TestData fillSharedMethodsWithCurrentScenarioInfo(Scenario scenario) {
        String featureName = "Feature ";
        scenario.getId();
        RegxHelper regxHelper = new RegxHelper();
        String rawFeatureName = regxHelper.getRegxMatch(".+(\\/)(.*)(?=.feature)", 2, scenario.getId().replace("%20", " "));
        if (rawFeatureName != null) rawFeatureName = rawFeatureName.trim();
        featureName = rawFeatureName.replace("_", " ") + ".feature:" + scenario.getLine();
        TestData.getInstance().getThreadSharedMethods().get().setFeatureName(featureName);
        TestData.getInstance().getThreadSharedMethods().get().setScenarioName(SharedMethods.buildPathToFolder(scenario.getName()));
        return TestData.getInstance();
    }

    private boolean isRecordVideoEnabled() {
        try {
            String testName = TestData.getInstance().getThreadSharedMethods().get().getTestName();
            if (testName != null && testName.contains("Production")) {
                return "true".equalsIgnoreCase(PropManager.getInstance().getProperty("recordVideo.Production"));
            }
        } catch (Exception ignored) {
        }
        return "true".equalsIgnoreCase(PropManager.getInstance().getProperty("recordVideo"));
    }

    private boolean isRecordVideoOnFailOnly() {
        try {
            String testName = TestData.getInstance().getThreadSharedMethods().get().getTestName();
            if (testName != null && testName.contains("Production")) {
                return "true".equalsIgnoreCase(PropManager.getInstance().getProperty("recordVideo.onFailOnly.Production"));
            }
        } catch (Exception ignored) {
        }
        return "true".equalsIgnoreCase(PropManager.getInstance().getProperty("recordVideo.onFailOnly"));
    }

    @Before
    public void startVideoRecording(Scenario scenario) throws IOException {
        System.out.println("hook before scenaior");
        fillSharedMethodsWithCurrentScenarioInfo(scenario);
        FileHandler.deleteFilesInPath(TestData.getInstance().getThreadSharedMethods().get().getImagesTempFolder());
        if (isRecordVideoEnabled()) {
            String movFolder = TestData.getInstance().getThreadSharedMethods().get().getMovFolder();
            String safeScenario = scenario.getName()
                    .replaceAll("[\\\\/:*?\"<>|]", "_")
                    .replaceAll("\\s+", "_");
            if (safeScenario.length() > 100) {
                safeScenario = safeScenario.substring(0, 100);
            }
            String videoDir = movFolder + java.io.File.separator + safeScenario + "_" + System.currentTimeMillis();
            DriverFactory.setRecordVideoDir(videoDir);
        }
    }

    @After
    public void finishVideoRecording(Scenario scenario) throws IOException {
        System.out.println("we have entered the hooks after scenario method");

        // Assert all soft assertions and log failures to report
        try {
            java.util.List<String> softAssertFailures = EjarPages.assertAll();
            if (!softAssertFailures.isEmpty()) {
                if (scenario.getStatus().name().equalsIgnoreCase("passed")) {
                    System.out.println("Soft assertion failures detected: " + softAssertFailures.size());
                }
            }
        } catch (Exception e) {
            if (ExtentCucumberAdapter.getCurrentStep() != null) {
                ExtentCucumberAdapter.getCurrentStep().fail("Error processing soft assertions: " + e.getMessage());
            }
        }

        // Capture Playwright video reference before closing the browser
        Video video = null;
        Page pwPage = DriverFactory.getPageIfExists();
        if (pwPage != null) {
            video = pwPage.video();
        }

        // Scroll to top before closing so error messages at the top are captured in video
        if (isRecordVideoEnabled() && scenario.getStatus().name().equalsIgnoreCase("failed")) {
            try {
                Page scrollPage = DriverFactory.getPageIfExists();
                if (scrollPage != null) {
                    scrollPage.evaluate("window.scrollTo(0, 0)");
                    scrollPage.waitForTimeout(500); // brief pause for video frame capture
                }
            } catch (Exception e) {
                System.out.println("Scroll to top before video capture skipped: " + e.getMessage());
            }
        }

        RunnerListener.rememberExtentTestForReporting(ExtentCucumberAdapter.getCurrentStep());
        base.closeDriver();

        // Handle Playwright native video recording after page is closed
        String videoRelPath = null;
        if (isRecordVideoEnabled()) {
            boolean shouldKeepVideo = true;
            if (isRecordVideoOnFailOnly()) {
                if (scenario.getStatus().name().equalsIgnoreCase("passed")) {
                    shouldKeepVideo = false;
                }
            }

            if (video != null) {
                try {
                    Path src = video.path();
                    if (src != null && Files.exists(src)) {
                        if (shouldKeepVideo) {
                            Path destDir = Paths.get(TestData.getInstance().getThreadSharedMethods().get().getMovFolder());
                            Files.createDirectories(destDir);
                            String dateStr = new SimpleDateFormat("yyyy-MM-dd_HH-mm-ss").format(new Date());
                            String safeScenario = scenario.getName()
                                    .replaceAll("[\\\\/:*?\"<>|]", "_")
                                    .replaceAll("\\s+", "_");
                            if (safeScenario.length() > 100) {
                                safeScenario = safeScenario.substring(0, 100);
                            }
                            Path dest = destDir.resolve(safeScenario + "_" + dateStr + ".webm");
                            Files.move(src, dest, StandardCopyOption.REPLACE_EXISTING);
                            System.out.println("Playwright video saved: " + dest);
                            try {
                                Path customReportsPath = Paths.get(System.getProperty("user.dir"),
                                        PropManager.getInstance().getProperty("custom.report.folder"));
                                videoRelPath = customReportsPath.relativize(dest).toString().replace("\\", "/");
                            } catch (Exception e) {
                                System.err.println("Failed to compute video relative path: " + e.getMessage());
                            }
                        } else {
                            Files.deleteIfExists(src);
                            System.out.println("Playwright video deleted (onFailOnly=true and scenario passed)");
                        }
                        // Clean up the per-scenario temp directory if empty
                        if (src.getParent() != null) {
                            Files.deleteIfExists(src.getParent());
                        }
                    }
                } catch (Exception e) {
                    System.err.println("Failed to handle Playwright video: " + e.getMessage());
                    e.printStackTrace();
                }
            }

            // Register entry for every scenario so duplicate names keep correct order
            ScenarioVideoTracker.add(scenario.getName(), videoRelPath);

            // Clean up legacy temp image folder (no longer used for video frames)
            try {
                FileHandler.deleteFilesInPath(TestData.getInstance().getThreadSharedMethods().get().getImagesTempFolder());
            } catch (Exception e) {
                e.printStackTrace();
            }

            DriverFactory.clearRecordVideoDir();
        }
    }

    public void scrollMethod() {
        base.scrollToTheTopOfPage();
        base.scrollToBottomOfPage();
    }

    public void stopRecordingVideo(Scenario scenario) {
        // Legacy method – no longer used. Playwright native video recording is handled in finishVideoRecording().
    }

}
