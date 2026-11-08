package automation.framework.business;

import automation.framework.propmanager.PropManager;
import automation.framework.threadData.DriverFactory;
import automation.framework.threadData.TestData;
import com.aventstack.extentreports.ExtentTest;
import com.aventstack.extentreports.Status;
import com.aventstack.extentreports.model.Log;
import com.aventstack.extentreports.model.Report;
import com.aventstack.extentreports.model.Test;
import lombok.Getter;
import lombok.extern.slf4j.Slf4j;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import com.microsoft.playwright.Page;

import java.io.File;
import java.io.IOException;
import java.nio.file.*;
import java.nio.file.attribute.BasicFileAttributes;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Queue;
import java.time.Year;
import java.util.Objects;

@Slf4j
@Getter
public class SendAggregatedReport {

    private final String customReportFolder;
    private final String copyPath;
    private final String testName;
    private Map<String, String> environmentVariables;
    private final boolean isProductionRun;

    public SendAggregatedReport(String executionName) {
        this(executionName, (String) null);
    }

    /**
     * @param copyPathOverride non-blank path from {@code RunnerListener} when teardown runs off worker threads (parallel TestNG).
     */
    public SendAggregatedReport(String executionName, String copyPathOverride) {
        String fromThread = null;
        try {
            if (TestData.getInstance().getThreadSharedMethods().get() != null) {
                fromThread = TestData.getInstance().getThreadSharedMethods().get().getCopyPathForResults();
            }
        } catch (Exception ignored) {
            // keep null
        }
        if (copyPathOverride != null && !copyPathOverride.isBlank()) {
            this.copyPath = copyPathOverride;
        } else if (fromThread != null && !fromThread.isBlank()) {
            this.copyPath = fromThread;
        } else {
            this.copyPath = "";
        }
        this.customReportFolder = System.getProperty("user.dir") + "\\" + PropManager.getInstance().getProperty("custom.report.folder");
        this.testName = executionName;
        this.isProductionRun = executionName != null && executionName.contains("Production");
    }

    public SendAggregatedReport(String executionName, Map<String, String> environmentVariables) {
        this(executionName, (String) null);
        this.environmentVariables = environmentVariables;
    }



    public String getResultEmailHeader() {
        return PropManager.getInstance().getProperty("report.email.header");
    }

    public String addResultRecord(ReportDataHandler reportDataHandler, String testString) {
        return addResultRecord(reportDataHandler, testString, false);
    }

    private String addResultRecord(ReportDataHandler reportDataHandler, String testString, boolean isLastRow) {
        String reportLink = reportDataHandler.getReportFileName() != null
                ? (copyPath + "\\" + reportDataHandler.getReportFileName()).replace("\\", "/")
                : copyPath.replace("\\", "/");
        String startStr = reportDataHandler.getStartTime() != null
                ? DateHelper.getDateInFormat(reportDataHandler.getStartTime(), "HH:mm:ss")
                : (reportDataHandler.getStartTimeString() != null ? reportDataHandler.getStartTimeString() : "");
        String endStr = reportDataHandler.getEndTime() != null
                ? DateHelper.getDateInFormat(reportDataHandler.getEndTime(), "HH:mm:ss")
                : (reportDataHandler.getEndTimeString() != null ? reportDataHandler.getEndTimeString() : "");
        String statusPill;
        if (reportDataHandler.isAllPass()) {
            statusPill = "<span style=\"background-color: #c6f6d5; color: #22543d; font-size: 12px; font-weight: bold; padding: 4px 10px; border-radius: 12px;\">All passed (" + reportDataHandler.getTestCountInScenario() + ")</span>";
        } else if (reportDataHandler.isAllFail()) {
            statusPill = "<span style=\"background-color: #fed7d7; color: #742a2a; font-size: 12px; font-weight: bold; padding: 4px 10px; border-radius: 12px;\">All Failed (" + reportDataHandler.getTestCountInScenario() + ")</span>";
        } else {
            statusPill = "<span style=\"background-color: #feebc8; color: #7b341e; font-size: 12px; font-weight: bold; padding: 4px 10px; border-radius: 12px;\">" + reportDataHandler.getPassCount() + " Pass, " + reportDataHandler.getFailCount() + " Fail</span>";
        }
        String rowBorder = isLastRow ? "" : " border-bottom: 1px solid #edf2f7;";
        StringBuilder resultBodyString = new StringBuilder();
        resultBodyString.append("<tr>\n");
        resultBodyString.append("  <td align=\"left\" style=\"padding: 15px;").append(rowBorder).append("\">\n");
        resultBodyString.append("    <a href=\"file:///").append(reportLink).append("\" style=\"color: #3182ce; text-decoration: none; font-weight: bold; font-size: 15px; display: block; margin-bottom: 4px;\">").append(reportDataHandler.getFeatureName()).append("</a>\n");
        resultBodyString.append("    <span style=\"font-size: 11px; color: #a0aec0;\">Start: ").append(startStr).append(" | End: ").append(endStr).append("</span>\n");
        resultBodyString.append("  </td>\n");
        resultBodyString.append("  <td align=\"center\" style=\"padding: 15px;").append(rowBorder).append(" font-size: 13px; color: #718096; font-family: monospace;\">\n    ").append(reportDataHandler.getElapsedTime() != null ? reportDataHandler.getElapsedTime() : "").append("\n  </td>\n");
        resultBodyString.append("  <td align=\"right\" style=\"padding: 15px;").append(rowBorder).append("\">\n    ").append(statusPill).append("\n  </td>\n");
        resultBodyString.append("</tr>\n");
        return resultBodyString.toString();
    }

    public String addResultRecord(ReportDataHandler reportDataHandler) {
        return addResultRecord(reportDataHandler, null, false);
    }


    public void testCaseNamesAndRelatedStepsPrinter(Map<String, List<List<String>>> input) {
            input.entrySet().stream()
                .flatMap(entry ->
                        entry.getValue().stream()  // Stream of List<String>
                                .flatMap(List::stream) // Stream of String
                                .peek(value -> System.out.println(
                                        "Test Case name: " + entry.getKey() + ", Value: " + value
                                ))
                )
                .count();
    }


    public String buildTestResultsContent(ExtentTest extentTestResult, String reportFileName) {
        if (extentTestResult == null || extentTestResult.getExtent() == null) {
            log.warn("buildTestResultsContent: ExtentTest or Extent is null; returning empty summary.");
            return "";
        }
        RunResultsInformation runResultsInformation = generateRunResultsInformation(extentTestResult);
        Report report = extentTestResult.getExtent().getReport();
        List<Test> featureList = report.getTestList();

        StringBuilder content = new StringBuilder(getResultEmailHeader());
        for (int i = 0; i < featureList.size(); i++) {
            ReportDataHandler reportDataHandler = new ReportDataHandler(featureList.get(i).getName(), featureList.get(i).getStartTime(), featureList.get(i).getEndTime(), DateHelper.getElapsedTime(featureList.get(i).getStartTime(), featureList.get(i).getEndTime()), reportFileName);
            reportDataHandler.setTestCountInScenario(featureList.get(i).getChildren().size());
            if (featureList.get(i).getStatus().getName().equals("Pass")) {
                reportDataHandler.setAllPass(true);
                reportDataHandler.setPassCount(featureList.get(i).getChildren().size());
            } else {
                long passCount = featureList.get(i).getChildren().stream().filter(c -> c.getStatus().getName().equals("Pass")).count();
                if (passCount == 0) {
                    reportDataHandler.setAllFail(true);
                    reportDataHandler.setFailCount(featureList.get(i).getChildren().size());
                } else {
                    List<Test> scenarioList = featureList.get(i).getChildren();
                    for (int j = 0; j < scenarioList.size(); ++j) {
                        switch (scenarioList.get(j).getStatus().getName()) {
                            case "Pass":
                                reportDataHandler.setPassCount(reportDataHandler.getPassCount() + 1);
                                break;
                            case "Fail":
                                reportDataHandler.setFailCount(reportDataHandler.getFailCount() + 1);
                                break;
                            default:
                                reportDataHandler.setOtherCount(reportDataHandler.getOtherCount() + 1);
                        }
                    }
                    reportDataHandler.setAllPass(false);
                }
            }
            boolean isLastRow = (i == featureList.size() - 1);
            content.append(addResultRecord(reportDataHandler, "", isLastRow));
        }
        content.append(PropManager.getInstance().getProperty("report.email.footer").replace("{{currentYear}}", String.valueOf(Year.now().getValue())));
        String result = content.toString();
        result = result.replace("passedCount", String.valueOf(runResultsInformation.getScenarioPassCount()));
        result = result.replace("failedCount", String.valueOf(runResultsInformation.getScenarioFailCount()));
        return result;
    }


    public RunResultsInformation getTestScenariosCasesData(List<Test> featureList) {

        RunResultsInformation runResultsInformation = new RunResultsInformation();
        runResultsInformation.setFeatureCount(featureList.size());
        runResultsInformation.setTestCount(featureList.stream().map(Test::getChildren).mapToInt(List::size).sum());
        runResultsInformation.setScenarioFailCount(featureList.stream().map(Test::getChildren).flatMap(List::stream).filter(c -> c.getStatus().getName().equals("Fail")).count());
        runResultsInformation.setScenarioPassCount(featureList.stream().map(Test::getChildren).flatMap(List::stream).filter(c -> c.getStatus().getName().equals("Pass")).count());
        return runResultsInformation;
    }

    public RunResultsInformation getTestStepsDataFromReport(RunResultsInformation runResultsInformation, ExtentTest extentTestResult) {
        Map<Status, Long> grandchild = extentTestResult.getExtent().getReport().getStats().getGrandchild();
        long failCount = 0L;
        long passCount = 0L;
        if (grandchild != null) {
            Long f = grandchild.get(Status.FAIL);
            Long p = grandchild.get(Status.PASS);
            failCount = f != null ? f : 0L;
            passCount = p != null ? p : 0L;
        }
        runResultsInformation.setTestStepsPassCount(passCount);
        runResultsInformation.setTestStepsFailCount(failCount);
        return runResultsInformation;
    }

    public void moveAllFiles(Path sourcePath, Path targetPath) {
        // Validate parameters
        Objects.requireNonNull(sourcePath, "Source path cannot be null");
        Objects.requireNonNull(targetPath, "Target path cannot be null");

        if (!Files.exists(sourcePath) || !Files.isDirectory(sourcePath)) {
            throw new IllegalArgumentException("Source path must be an existing directory");
        }

        // Create target directory if it doesn't exist
        if (!Files.exists(targetPath)) {
            try {
                Files.createDirectories(targetPath);
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        } else if (!Files.isDirectory(targetPath)) {
            throw new IllegalArgumentException("Target path must be a directory");
        }

        // Walk the file tree and move files
        try {
            Files.walkFileTree(sourcePath, new SimpleFileVisitor<Path>() {
                @Override
                public FileVisitResult visitFile(Path file, BasicFileAttributes attrs) throws IOException {
                    // Skip if trying to move the target directory itself
                    if (file.startsWith(targetPath)) {
                        return FileVisitResult.CONTINUE;
                    }

                    Path targetFile = targetPath.resolve(sourcePath.relativize(file));

                    // Create parent directories if they don't exist
                    Files.createDirectories(targetFile.getParent());

                    // Move the file
                    try {
                        Files.move(file, targetFile, StandardCopyOption.REPLACE_EXISTING);
                        System.out.println("Moved: " + file + " to " + targetFile);
                    } catch (IOException e) {
                        System.err.println("Failed to move " + file + ": " + e.getMessage());
                        // Continue with other files even if one fails
                    }

                    return FileVisitResult.CONTINUE;
                }

                @Override
                public FileVisitResult postVisitDirectory(Path dir, IOException exc) throws IOException {
                    // Delete empty directories after moving their contents
                    if (!dir.equals(sourcePath) && Files.list(dir).count() == 0) {
                        try {
                            Files.delete(dir);
                            System.out.println("Deleted empty directory: " + dir);
                        } catch (IOException e) {
                            System.err.println("Failed to delete directory " + dir + ": " + e.getMessage());
                        }
                    }
                    return FileVisitResult.CONTINUE;
                }

                @Override
                public FileVisitResult visitFileFailed(Path file, IOException exc) throws IOException {
                    System.err.println("Error accessing file: " + file + ": " + exc.getMessage());
                    return FileVisitResult.CONTINUE;
                }
            });
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    public void extractResultsAndCopyToBackUpFolder(ExtentTest testResult, String executionName) {
        if (testResult == null) {
            log.warn("extractResultsAndCopyToBackUpFolder: ExtentTest is null; skipping report build and email.");
            return;
        }
        try {
            testResult.getExtent().flush();
        } catch (Exception e) {
            log.warn("Extent flush before archiving report: {}", e.getMessage());
        }

        String sparkRelative = PropManager.getInstance().getProperty("extent.reporter.spark.out").replace("\\", File.separator);
        String sparkPath = System.getProperty("user.dir") + File.separator + sparkRelative;
        String newReportName = FileHandler.changeFileName(sparkPath, executionName + "-" + DateHelper.getCurrentDatePlusDays(0, "YYYY-MM-dd HH-mm") + ".html");
        String renamedReportPath = customReportFolder + File.separator + newReportName;
        injectLogoIntoHtmlReport(renamedReportPath);
        injectVideoLinksIntoHtmlReport(renamedReportPath);

        if (isProductionRun && isUploadVideoToOneDriveEnabled()) {
            uploadProductionVideosToOneDrive();
        }

        String content;
        if (isProductionRun) {
            content = buildProductionTestResultsContent(testResult, newReportName);
        } else {
            content = buildTestResultsContent(testResult, newReportName);
        }

        if (copyPath == null || copyPath.isBlank()) {
            log.error("extractResultsAndCopyToBackUpFolder: copyPath is empty; set execution.reports.backup.folder (e.g. D:\\\\Generated_Build\\\\Reports). Skipping copy to backup.");
        } else {
            try {
                Files.createDirectories(Paths.get(copyPath));
            } catch (IOException e) {
                log.warn("Could not create backup directory {}: {}", copyPath, e.getMessage());
            }
        }

        try {
            File sourceDir = new File(customReportFolder);
            File targetDir = new File(copyPath);
            if (!sourceDir.exists()) {
                log.error("extractResultsAndCopyToBackUpFolder: source customReports folder missing: {}", sourceDir.getAbsolutePath());
            } else if (copyPath != null && !copyPath.isBlank()) {
                new FileHandler().copyDirectoryRecursively(sourceDir, targetDir);
                log.info("Copied report folder {} -> {}", sourceDir.getAbsolutePath(), targetDir.getAbsolutePath());
            }
        } catch (Exception e) {
            System.err.println("Error, Directory Not found: " + e.getMessage());
            e.printStackTrace();
        }
        try {
            FileHandler.deleteFilesInPath(customReportFolder);
        } catch (Exception e) {
            System.err.println("Error, deleting default reports : " + e.getMessage());
            e.getStackTrace();
        }
        EmailHandler emailHandler = new EmailHandler();
        String emailSubject;
        if (isProductionRun && testName.contains("Rental_Agent_Production")) {
            emailSubject = "Booking Pay Later Automated Regression Test - Production - " + DateHelper.getCurrentDatePlusDays(0, "YYYY-MM-dd HH:mm:ss");
        } else {
            emailSubject = "Automation Test Report: " + testName.replace("TestRunner", "").replace("_", " ") + " - " + DateHelper.getCurrentDatePlusDays(0, "YYYY-MM-dd HH:mm:ss");
        }
        List<MicrosoftGraphMailSender.GraphAttachment> videoAttachments = buildVideoAttachments();
        if (isProductionRun) {
            emailHandler.sendProductionReportEmail(emailSubject, content, videoAttachments);
        } else {
            emailHandler.sendReportEmail(emailSubject, content, videoAttachments);
        }

        // Post-run cleanup of old production videos uploaded to OneDrive.
        // Runs only when uploadVideoToOneDrive.Production=true and never affects test results.
        try {
            GoogleDriveUtility.cleanupOldOneDriveProductionVideos(copyPath);
        } catch (Exception cleanupEx) {
            log.warn("Post-run OneDrive old-video cleanup failed: {}", cleanupEx.getMessage());
        }

        log.info("after clearReportFolder()");
    }

    private void injectLogoIntoHtmlReport(String htmlFilePath) {
        try {
            File logoSource = resolveReportLogoFile();
            if (logoSource == null || !logoSource.exists()) {
                log.warn("Logo file not found for HTML report injection.");
                return;
            }

            File reportFile = new File(htmlFilePath);
            if (!reportFile.exists()) {
                log.warn("HTML report not found for logo injection: {}", htmlFilePath);
                return;
            }

            File logoDest = new File(reportFile.getParentFile(), "yelo_logo" + reportLogoExtension(logoSource));
            Files.copy(logoSource.toPath(), logoDest.toPath(), StandardCopyOption.REPLACE_EXISTING);

            Document doc = Jsoup.parse(reportFile, "UTF-8");
            Elements navRight = doc.select("ul.nav-right");
            if (!navRight.isEmpty()) {
                Element ul = navRight.first();
                // Remove "Grasshopper Report" badge
                for (Element li : ul.select("li")) {
                    if (li.text().contains("Grasshopper Report")) {
                        li.remove();
                        break;
                    }
                }
                Element li = new Element("li").addClass("m-r-10");
                Element img = new Element("img")
                        .attr("src", logoDest.getName())
                        .attr("alt", "Yelo Logo")
                        .attr("style", "height: 40px; width: auto; background: transparent;");
                li.appendChild(img);
                ul.appendChild(li);
                Files.write(reportFile.toPath(), doc.html().getBytes(java.nio.charset.StandardCharsets.UTF_8));
                log.info("Logo injected into HTML report: {}", htmlFilePath);
            } else {
                log.warn("ul.nav-right not found in HTML report; logo not injected.");
            }
        } catch (Exception e) {
            log.warn("Failed to inject logo into HTML report: {}", e.getMessage());
        }
    }

    /** Yelo brand logo candidates shipped with the project; preferred over the legacy Qoad logo files. */
    private static final String[] YELO_LOGO_CANDIDATES = {
            "logos" + File.separator + "Yelo_logo_text_only.png",
            "logos" + File.separator + "Yelo_logo_text_only.webp",
            "logos" + File.separator + "yelo Logo - size reduced.jpg",
            "logos" + File.separator + "yelo Logo - Copy.jpg",
            "logos" + File.separator + "yelo Logo.jpg"
    };

    /** Prefer the Yelo logo; fall back to the legacy Qoad logo files. */
    private File resolveReportLogoFile() {
        for (String candidate : YELO_LOGO_CANDIDATES) {
            File yeloLogo = new File(System.getProperty("user.dir") + File.separator + candidate);
            if (yeloLogo.isFile()) {
                return yeloLogo;
            }
        }
        File explicitLogo = new File(System.getProperty("user.dir") + File.separator + "email html" + File.separator + "Qoad logo.png");
        if (explicitLogo.isFile()) {
            return explicitLogo;
        }
        File dir = new File(System.getProperty("user.dir") + File.separator + "email html");
        String[] names = {"Qoad logo.png", "Qoad_logo.png", "qoad_logo.png"};
        for (String n : names) {
            File f = new File(dir, n);
            if (f.isFile()) {
                return f;
            }
        }
        return null;
    }

    /** Keeps the logo file extension (and therefore its MIME type) intact when copying it next to the report. */
    private String reportLogoExtension(File logoFile) {
        String name = logoFile.getName();
        int dot = name.lastIndexOf('.');
        return dot >= 0 ? name.substring(dot) : ".png";
    }

    private void injectVideoLinksIntoHtmlReport(String htmlFilePath) {
        try {
            File reportFile = new File(htmlFilePath);
            if (!reportFile.exists()) {
                log.warn("HTML report not found for video link injection: {}", htmlFilePath);
                return;
            }

            java.util.List<ScenarioVideoTracker.Entry> entries = ScenarioVideoTracker.getAll();
            if (entries.isEmpty()) {
                return;
            }

            Document doc = Jsoup.parse(reportFile, "UTF-8");
            boolean modified = false;
            int entryIndex = 0;

            // Main panel scenario nodes — match in order so duplicate names get correct videos
            Elements nodes = doc.select("div.node");
            for (Element node : nodes) {
                if (entryIndex >= entries.size()) {
                    break;
                }
                String text = node.text().trim();
                // Strip the status badge prefix (Pass, Fail, Skip, Warning)
                String scenarioName = text.replaceAll("^(Pass|Fail|Skip|Warning)\\s*", "").trim();

                // Advance to the next entry that matches this scenario name
                while (entryIndex < entries.size()) {
                    ScenarioVideoTracker.Entry entry = entries.get(entryIndex++);
                    if (entry.scenarioName.equals(scenarioName) && entry.videoPath != null) {
                        String encodedPath = entry.videoPath.replace(" ", "%20");
                        Element videoLink = new Element("a")
                                .attr("href", encodedPath)
                                .attr("target", "_blank")
                                .attr("style", "margin-left: 10px; font-size: 12px; color: #3182ce; text-decoration: underline;")
                                .text("[Video]");
                        node.appendChild(videoLink);
                        modified = true;
                        break;
                    }
                }
            }

            if (modified) {
                Files.write(reportFile.toPath(), doc.html().getBytes(java.nio.charset.StandardCharsets.UTF_8));
                log.info("Video links injected into HTML report: {}", htmlFilePath);
            }
        } catch (Exception e) {
            log.warn("Failed to inject video links into HTML report: {}", e.getMessage());
        }
    }

    public void changeMediaLocation(ExtentTest extentTestResult) {
        extentTestResult.getExtent().getReport().getTestList().forEach(testList -> testList.getChildren().forEach(scenario -> scenario.getChildren().forEach(step -> step.getLogs().forEach(log -> {
            if (log.getMedia() != null) {
                log.getMedia().setPath(log.getMedia().getPath().replace(customReportFolder, copyPath));
                if (step.getName().contains("Hook.afterStep")) {
                    step.setName("");
                }
            }
        }))));
    }

    private RunResultsInformation generateRunResultsInformation(ExtentTest extentTestResult) {
        Report report = extentTestResult.getExtent().getReport();
        List<Test> featureList = report.getTestList();
        RunResultsInformation runResultsInformation = getTestScenariosCasesData(featureList);
        runResultsInformation = getTestStepsDataFromReport(runResultsInformation, extentTestResult);
        new PieChartGenerator().createPieChartWithDate(runResultsInformation.getScenarioPassCount(), runResultsInformation.getScenarioFailCount(), "Test Scenarios Execution Summary", RunResultsInformation.scenariosTestStatusPieChartName);
        new PieChartGenerator().createPieChartWithDate(runResultsInformation.getTestStepsPassCount(), runResultsInformation.getTestStepsFailCount(), "Test Steps Execution Summary", RunResultsInformation.testStepsTestStatusPieChartName);
        return runResultsInformation;
    }

    public String buildProductionTestResultsContent(ExtentTest extentTestResult, String reportFileName) {
        if (extentTestResult == null || extentTestResult.getExtent() == null) {
            log.warn("buildProductionTestResultsContent: ExtentTest or Extent is null; returning empty summary.");
            return "";
        }
        RunResultsInformation runResultsInformation = generateRunResultsInformation(extentTestResult);
        Report report = extentTestResult.getExtent().getReport();
        List<Test> featureList = report.getTestList();

        StringBuilder content = new StringBuilder(buildProductionEmailHeader());
        Map<String, Queue<String>> oneDriveLinkMap = buildOneDriveLinkMap();
        for (Test feature : featureList) {
            for (Test scenario : feature.getChildren()) {
                content.append(buildProductionScenarioRow(scenario, oneDriveLinkMap));
                content.append(buildProductionStepsSection(scenario));
            }
        }
        content.append(buildProductionEmailFooter());

        String result = content.toString();
        result = result.replace("passedCount", String.valueOf(runResultsInformation.getScenarioPassCount()));
        result = result.replace("failedCount", String.valueOf(runResultsInformation.getScenarioFailCount()));
        return result;
    }

    private String buildProductionEmailHeader() {
        return "<!DOCTYPE html>\n" +
                "<html lang=\"en\">\n" +
                "<head>\n" +
                "    <meta charset=\"UTF-8\">\n" +
                "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n" +
                "    <title>Yelo Automation Test Report</title>\n" +
                "    <style>\n" +
                "        body { margin: 0; padding: 0; background-color: #f5f5f5; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }\n" +
                "        .wrapper { width: 100%; max-width: 900px; margin: 0 auto; background-color: #ffffff; }\n" +
                "        .header-section { background-color: #4D0970; padding: 18px 40px; text-align: center; }\n" +
                "        .summary-section { padding: 32px 40px; background-color: #ffffff; }\n" +
                "        .scenarios-section { padding: 0 40px 32px 40px; background-color: #ffffff; }\n" +
                "        .elapsed { font-size: 14px; color: #666666; font-weight: 500; font-family: 'Courier New', monospace; text-align: center; }\n" +
                "        .status-badge { display: inline-block; padding: 6px 16px; border-radius: 16px; font-size: 13px; font-weight: 600; }\n" +
                "        .step-row { padding: 8px 16px; font-size: 13px; }\n" +
                "        .step-num { display: inline-block; width: 22px; height: 22px; background-color: #f0f0f0; border-radius: 50%; text-align: center; line-height: 22px; font-size: 11px; font-weight: 600; color: #666666; }\n" +
                "        .step-dot { display: inline-block; width: 10px; height: 10px; border-radius: 50%; }\n" +
                "        .step-keyword { font-weight: 600; color: #555555; }\n" +
                "        .step-text { color: #444444; }\n" +
                "        .step-status { font-size: 11px; font-weight: 600; padding: 2px 10px; border-radius: 10px; }\n" +
                "        .footer-section { background-color: #4D0970; color: #ffffff; padding: 32px 40px; }\n" +

                "        @media only screen and (max-width: 600px) {\n" +
                "            .summary-section, .scenarios-section { padding: 24px 20px !important; }\n" +
                "            .header-section { padding: 18px 20px !important; }\n" +
                "            .footer-section { padding: 24px 20px !important; }\n" +
                "        }\n" +
                "    </style>\n" +
                "<base target=\"_blank\">\n" +
                "</head>\n" +
                "<body>\n" +
                "    <table role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" width=\"100%\" style=\"background-color: #f5f5f5;\">\n" +
                "        <tr>\n" +
                "            <td align=\"center\">\n" +
                "                <table role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" width=\"900\" style=\"max-width: 900px; background-color: #ffffff;\" class=\"wrapper\">\n" +
                "                    <!-- Header Section: logo and report title share one cell -->\n" +
                "                    <tr>\n" +
                "                        <td class=\"header-section\" style=\"background-color: #4D0970; padding: 18px 40px; text-align: center;\">\n" +
                "                            <img src=\"cid:high-logo\" alt=\"Yelo\" width=\"196\" style=\"display: block; margin: 0 auto 8px auto; max-width: 196px; width: 100%; height: auto; border: 0; outline: none; text-decoration: none; -ms-interpolation-mode: bicubic;\">\n" +
                "                            <h1 style=\"color: #ffffff; font-size: 28px; font-weight: 600; line-height: 1.2; margin: 0; letter-spacing: 0.5px;\">Automation Test Report</h1>\n" +
                "                        </td>\n" +
                "                    </tr>\n" +
                "                    <!-- Execution Summary -->\n" +
                "                    <tr>\n" +
                "                        <td class=\"summary-section\" style=\"padding: 32px 40px; background-color: #ffffff;\">\n" +
                "                            <div style=\"font-size: 20px; font-weight: 600; color: #333333; margin: 0 0 12px 0;\">Execution Summary</div>\n" +
                "                            <div style=\"height: 2px; background-color: #e0e0e0; margin: 0 0 24px 0;\"></div>\n" +
                "                            <table role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" width=\"100%\" style=\"border-collapse: collapse;\">\n" +
                "                                <tr>\n" +
                "                                    <td width=\"48%\" bgcolor=\"#f0f9f0\" style=\"background-color: #f0f9f0; border: 1px solid #c3e6c3; border-radius: 8px; padding: 0; text-align: center;\">\n" +
                "                                        <table role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" width=\"100%\" style=\"border-collapse: collapse;\">\n" +
                "                                            <tr>\n" +
                "                                                <td align=\"center\" bgcolor=\"#f0f9f0\" style=\"background-color: #f0f9f0; padding: 24px 24px 8px 24px; font-size: 16px; font-weight: 600; letter-spacing: 1px; color: #28a745; line-height: 1; mso-line-height-rule: exactly; text-align: center;\">PASS</td>\n" +
                "                                            </tr>\n" +
                "                                            <tr>\n" +
                "                                                <td align=\"center\" bgcolor=\"#f0f9f0\" style=\"background-color: #f0f9f0; padding: 0 24px 24px 24px; font-size: 48px; font-weight: 700; color: #28a745; line-height: 1; mso-line-height-rule: exactly; text-align: center;\">passedCount</td>\n" +
                "                                            </tr>\n" +
                "                                        </table>\n" +
                "                                    </td>\n" +
                "                                    <td width=\"4%\"></td>\n" +
                "                                    <td width=\"48%\" bgcolor=\"#fdf2f2\" style=\"background-color: #fdf2f2; border: 1px solid #f5c6c6; border-radius: 8px; padding: 0; text-align: center;\">\n" +
                "                                        <table role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" width=\"100%\" style=\"border-collapse: collapse;\">\n" +
                "                                            <tr>\n" +
                "                                                <td align=\"center\" bgcolor=\"#fdf2f2\" style=\"background-color: #fdf2f2; padding: 24px 24px 8px 24px; font-size: 16px; font-weight: 600; letter-spacing: 1px; color: #dc3545; line-height: 1; mso-line-height-rule: exactly; text-align: center;\">FAIL</td>\n" +
                "                                            </tr>\n" +
                "                                            <tr>\n" +
                "                                                <td align=\"center\" bgcolor=\"#fdf2f2\" style=\"background-color: #fdf2f2; padding: 0 24px 24px 24px; font-size: 48px; font-weight: 700; color: #dc3545; line-height: 1; mso-line-height-rule: exactly; text-align: center;\">failedCount</td>\n" +
                "                                            </tr>\n" +
                "                                        </table>\n" +
                "                                    </td>\n" +
                "                                </tr>\n" +
                "                            </table>\n" +
                "                        </td>\n" +
                "                    </tr>\n" +
                "                    <!-- Test Scenarios Details -->\n" +
                "                    <tr>\n" +
                "                        <td class=\"scenarios-section\" style=\"padding: 0 40px 32px 40px; background-color: #ffffff;\">\n" +
                "                            <div style=\"font-size: 20px; font-weight: 600; color: #333333; margin: 0 0 12px 0;\">Test Scenarios Details</div>\n" +
                "                            <div style=\"height: 2px; background-color: #e0e0e0; margin: 0 0 24px 0;\"></div>\n" +
                "                            <!-- Table Header -->\n" +
                "                            <table role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" width=\"100%\" style=\"border-bottom: 2px solid #e0e0e0;\">\n" +
                "                                <tr>\n" +
                "                                    <td style=\"padding: 12px 0; font-size: 13px; font-weight: 600; color: #888888; text-transform: uppercase; letter-spacing: 0.5px;\" width=\"60%\">FEATURE SCENARIO</td>\n" +
                "                                    <td style=\"padding: 12px 0; font-size: 13px; font-weight: 600; color: #888888; text-transform: uppercase; letter-spacing: 0.5px; text-align: center;\" width=\"20%\">ELAPSED</td>\n" +
                "                                    <td style=\"padding: 12px 0; font-size: 13px; font-weight: 600; color: #888888; text-transform: uppercase; letter-spacing: 0.5px; text-align: center;\" width=\"20%\">STATUS</td>\n" +
                "                                </tr>\n" +
                "                            </table>\n";
    }

    private String buildProductionScenarioRow(Test scenario, Map<String, Queue<String>> oneDriveLinkMap) {
        String startStr = scenario.getStartTime() != null
                ? DateHelper.getDateInFormat(scenario.getStartTime(), "HH:mm:ss")
                : "";
        String endStr = scenario.getEndTime() != null
                ? DateHelper.getDateInFormat(scenario.getEndTime(), "HH:mm:ss")
                : "";
        String elapsed = DateHelper.getElapsedTime(scenario.getStartTime(), scenario.getEndTime());
        String statusName = scenario.getStatus().getName();
        String badgeBg = statusName.equalsIgnoreCase("Pass") ? "#d4edda" : "#f8d7da";
        String badgeColor = statusName.equalsIgnoreCase("Pass") ? "#155724" : "#721c24";
        String badgeText = statusName.equalsIgnoreCase("Pass") ? "Passed" : "Failed";

        String oneDriveLink = null;
        if (oneDriveLinkMap != null) {
            Queue<String> links = oneDriveLinkMap.get(scenario.getName());
            if (links != null && !links.isEmpty()) {
                oneDriveLink = links.poll();
            }
        }

        StringBuilder sb = new StringBuilder();
        sb.append("                            <!-- Scenario -->\n");
        sb.append("                            <table role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" width=\"100%\" style=\"border-bottom: 1px solid #f0f0f0;\">\n");
        sb.append("                                <tr>\n");
        sb.append("                                    <td style=\"padding: 20px 0; vertical-align: middle;\" width=\"60%\">\n");
        sb.append("                                        <div class=\"scenario-name\" style=\"font-size: 16px; font-weight: 600; color: #2c7bbd; margin-bottom: 4px;\">").append(escapeHtml(scenario.getName())).append("</div>\n");
        if (oneDriveLink != null && !oneDriveLink.isBlank()) {
            sb.append("                                        <div style=\"margin-top: 6px;\"><a href=\"").append(escapeHtml(oneDriveLink)).append("\" target=\"_blank\" style=\"font-size: 12px; color: #3182ce; text-decoration: underline;\">[Video]</a></div>\n");
        }
        sb.append("                                        <div class=\"scenario-meta\" style=\"font-size: 12px; color: #999999;\">Start: ").append(startStr).append(" | End: ").append(endStr).append("</div>\n");
        sb.append("                                    </td>\n");
        sb.append("                                    <td class=\"elapsed\" style=\"font-size: 14px; color: #666666; font-weight: 500; font-family: 'Courier New', monospace; text-align: center; vertical-align: middle;\" width=\"20%\">").append(elapsed != null ? elapsed : "").append("</td>\n");
        sb.append("                                    <td style=\"padding: 20px 0; text-align: center; vertical-align: middle;\" width=\"20%\">\n");
        sb.append("                                        <span class=\"status-badge\" style=\"display: inline-block; vertical-align: middle; padding: 6px 16px; border-radius: 16px; font-size: 13px; font-weight: 600; background-color: ").append(badgeBg).append("; color: ").append(badgeColor).append(";\">").append(badgeText).append("</span>\n");
        sb.append("                                    </td>\n");
        sb.append("                                </tr>\n");
        sb.append("                            </table>\n");
        return sb.toString();
    }

    private String buildProductionStepsSection(Test scenario) {
        List<Test> allSteps = scenario.getChildren();
        List<Test> steps = new ArrayList<>();
        if (allSteps != null) {
            for (Test step : allSteps) {
                if (step.getName() != null && !step.getName().trim().isEmpty()) {
                    steps.add(step);
                }
            }
        }
        if (steps.isEmpty()) {
            return "";
        }

        int passedCount = 0;
        int failedCount = 0;
        int skippedCount = 0;
        for (Test step : steps) {
            String s = step.getStatus().getName();
            if (s.equalsIgnoreCase("Pass")) passedCount++;
            else if (s.equalsIgnoreCase("Fail")) failedCount++;
            else skippedCount++;
        }

        StringBuilder sb = new StringBuilder();
        sb.append("                            <!-- Steps -->\n");
        sb.append("                            <table role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" width=\"100%\">\n");
        sb.append("                                <tr>\n");
        sb.append("                                    <td style=\"padding: 12px 0 16px 0;\">\n");
        sb.append("                                        <table role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" width=\"100%\" style=\"border: 1px solid #e9ecef; border-radius: 6px;\">\n");
        sb.append("                                            <tr>\n");
        sb.append("                                                <td class=\"steps-header\" style=\"padding: 10px 16px; background-color: #f8f9fa; font-size: 12px; font-weight: 600; color: #555555; text-transform: uppercase; letter-spacing: 0.5px;\">\n");
        sb.append("                                                    Scenario Steps <span class=\"steps-count\" style=\"font-size: 11px; color: #888888; font-weight: 400; text-transform: none;\">").append(passedCount).append(" passed, ").append(failedCount).append(" failed, ").append(skippedCount).append(" skipped</span>\n");
        sb.append("                                                </td>\n");
        sb.append("                                            </tr>\n");
        sb.append("                                            <tr><td style=\"height: 1px; background-color: #e9ecef;\"></td></tr>\n");

        for (int i = 0; i < steps.size(); i++) {
            Test step = steps.get(i);
            String stepStatus = step.getStatus().getName();
            String dotColor;
            String statusBg;
            String statusColor;
            String statusText;

            if (stepStatus.equalsIgnoreCase("Pass")) {
                dotColor = "#28a745";
                statusBg = "#d4edda";
                statusColor = "#155724";
                statusText = "passed";
            } else if (stepStatus.equalsIgnoreCase("Fail")) {
                dotColor = "#dc3545";
                statusBg = "#f8d7da";
                statusColor = "#721c24";
                statusText = "failed";
            } else {
                dotColor = "#ffc107";
                statusBg = "#fff3cd";
                statusColor = "#856404";
                statusText = "skipped";
            }

            String stepName = maskPasswords(step.getName());
            String keyword = extractStepKeyword(stepName);
            String stepText = stepName;
            if (!keyword.isEmpty() && stepName.startsWith(keyword + " ")) {
                stepText = stepName.substring(keyword.length() + 1);
            } else if (!keyword.isEmpty() && stepName.startsWith(keyword)) {
                stepText = stepName.substring(keyword.length()).trim();
            }

            String borderBottom = (i < steps.size() - 1) ? " border-bottom: 1px solid #f5f5f5;" : "";

            sb.append("                                            <tr>\n");
            sb.append("                                                <td class=\"step-row\" style=\"padding: 8px 16px;").append(borderBottom).append(" font-size: 13px;\">\n");
            sb.append("                                                    <table role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" width=\"100%\">\n");
            sb.append("                                                        <tr>\n");
            sb.append("                                                            <td width=\"30\"><span class=\"step-num\" style=\"display: inline-block; width: 22px; height: 22px; background-color: #f0f0f0; border-radius: 50%; text-align: center; line-height: 22px; font-size: 11px; font-weight: 600; color: #666666;\">").append(i + 1).append("</span></td>\n");
            sb.append("                                                            <td width=\"20\"><span class=\"step-dot\" style=\"display: inline-block; width: 10px; height: 10px; border-radius: 50%; background-color: ").append(dotColor).append(";\"></span></td>\n");
            sb.append("                                                            <td style=\"direction: ltr; text-align: left;\"><span dir=\"ltr\" style=\"direction: ltr;\"><span class=\"step-keyword\" style=\"font-weight: 600; color: #555555;\">").append(escapeHtml(keyword)).append("</span> <span class=\"step-text\" style=\"color: #444444;\">").append(stepText).append("</span></span></td>\n");
            sb.append("                                                            <td width=\"60\" align=\"right\"><span class=\"step-status\" style=\"display: inline-block; vertical-align: middle; font-size: 11px; font-weight: 600; padding: 2px 10px; border-radius: 10px; background-color: ").append(statusBg).append("; color: ").append(statusColor).append(";\">").append(statusText).append("</span></td>\n");
            sb.append("                                                        </tr>\n");
            if (stepStatus.equalsIgnoreCase("Fail")) {
                String errorMessage = extractStepErrorMessage(step);
                if (errorMessage != null && !errorMessage.isEmpty()) {
                    sb.append("                                                        <tr>\n");
                    sb.append("                                                            <td width=\"30\"></td>\n");
                    sb.append("                                                            <td width=\"20\"></td>\n");
                    sb.append("                                                            <td colspan=\"2\" style=\"padding-top: 6px;\">\n");
                    sb.append("                                                                <div style=\"background-color: #fdf2f2; border: 1px solid #f5c6c6; border-radius: 4px; padding: 8px 12px; font-size: 12px; color: #721c24; font-family: 'Courier New', monospace; white-space: pre-wrap; word-break: break-word;\">").append(escapeHtml(errorMessage)).append("</div>\n");
                    sb.append("                                                            </td>\n");
                    sb.append("                                                        </tr>\n");
                }
            }
            sb.append("                                                    </table>\n");
            sb.append("                                                </td>\n");
            sb.append("                                            </tr>\n");
        }

        sb.append("                                        </table>\n");
        sb.append("                                    </td>\n");
        sb.append("                                </tr>\n");
        sb.append("                            </table>\n");
        return sb.toString();
    }

    private String buildProductionEmailFooter() {
        return "                        </td>\n" +
                "                    </tr>\n" +
                "                    <!-- Footer Section -->\n" +
                "                    <tr>\n" +
                "                        <td class=\"footer-section\" style=\"background-color: #4D0970; color: #ffffff; padding: 32px 40px;\">\n" +
                "                            <table role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" width=\"100%\">\n" +
                "                                <tr>\n" +
                "                                    <td style=\"font-size: 13px; line-height: 1.7; color: #c0c8d4;\" width=\"48%\" valign=\"top\">\n" +
                "                                        &copy; " + Year.now().getValue() + " Yelo is an innovator for the mobility industry, specialized in developing solutions and services to manage fleet and Rent a Car business.\n" +
                "                                    </td>\n" +
                "                                    <td width=\"4%\" style=\"background-color: #4D0970;\"></td>\n" +
                "                                    <td style=\"font-size: 13px; line-height: 1.7; color: #c0c8d4; text-align: right; direction: rtl;\" width=\"48%\" valign=\"top\">\n" +
                "                                        &copy; " + Year.now().getValue() + " Yelo &#x647;&#x64A; &#x634;&#x631;&#x643;&#x629; &#x645;&#x628;&#x62A;&#x643;&#x631;&#x629; &#x641;&#x64A; &#x635;&#x646;&#x627;&#x639;&#x629; &#x627;&#x644;&#x62A;&#x646;&#x642;&#x644;&#x60C; &#x645;&#x62A;&#x62E;&#x635;&#x635;&#x629; &#x641;&#x64A; &#x62A;&#x637;&#x648;&#x64A;&#x631; &#x627;&#x644;&#x62D;&#x644;&#x648;&#x644; &#x648;&#x627;&#x644;&#x62E;&#x62F;&#x645;&#x627;&#x62A; &#x644;&#x625;&#x62F;&#x627;&#x631;&#x629; &#x627;&#x644;&#x623;&#x633;&#x637;&#x648;&#x644; &#x648;&#x623;&#x639;&#x645;&#x627;&#x644; &#x62A;&#x623;&#x62C;&#x64A;&#x631; &#x627;&#x644;&#x633;&#x64A;&#x627;&#x631;&#x627;&#x62A;.\n" +
                "                                    </td>\n" +
                "                                </tr>\n" +
                "                            </table>\n" +
                "                            <table role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" width=\"100%\">\n" +
                "                                <tr>\n" +
                "                                    <td style=\"text-align: center; font-size: 12px; color: #a0aab8; padding-top: 16px; border-top: 1px solid #671980;\">\n" +
                "                                        &#9993; info@iyelo.com &nbsp;&nbsp;|&nbsp;&nbsp; &#9742; +966 11 2848 244 &nbsp;&nbsp;|&nbsp;&nbsp; &#128205; Saudi Arabia, Riyadh, Al Yasmeen, Al Ulaya.\n" +
                "                                    </td>\n" +
                "                                </tr>\n" +
                "                            </table>\n" +
                "                        </td>\n" +
                "                    </tr>\n" +
                "                </table>\n" +
                "            </td>\n" +
                "        </tr>\n" +
                "    </table>\n" +
                "</body>\n" +
                "</html>";
    }

    private String extractStepKeyword(String stepName) {
        if (stepName == null || stepName.isEmpty()) return "";
        String[] keywords = {"Given ", "When ", "Then ", "And ", "But "};
        for (String kw : keywords) {
            if (stepName.startsWith(kw)) {
                return kw.trim();
            }
        }
        return "";
    }

    private String getDotColor(String status) {
        if (status.equalsIgnoreCase("Pass")) return "#28a745";
        if (status.equalsIgnoreCase("Fail")) return "#dc3545";
        return "#ffc107";
    }

    private String escapeHtml(String text) {
        if (text == null) return "";
        return text.replace("&", "&amp;")
                   .replace("<", "&lt;")
                   .replace(">", "&gt;")
                   .replace("\"", "&quot;");
    }

    private String extractStepErrorMessage(Test step) {
        if (step == null || step.getLogs() == null) {
            return null;
        }
        StringBuilder errorMessage = new StringBuilder();
        for (Log log : step.getLogs()) {
            if (log != null && log.hasException() && log.getException() != null) {
                Throwable throwable = log.getException().getException();
                String message = throwable != null ? throwable.getMessage() : null;
                if (message != null && !message.trim().isEmpty()) {
                    if (errorMessage.length() > 0) {
                        errorMessage.append("\n");
                    }
                    errorMessage.append(message);
                }
            }
        }
        return errorMessage.length() > 0 ? errorMessage.toString() : null;
    }

    private String maskPasswords(String text) {
        if (text == null) return null;
        return text.replaceAll("(?i)(password\\s*[:=]\\s*)\\S+", "$1******");
    }

    private List<MicrosoftGraphMailSender.GraphAttachment> buildVideoAttachments() {
        boolean recordVideo;
        if (isProductionRun) {
            recordVideo = "true".equalsIgnoreCase(PropManager.getInstance().getProperty("recordVideo.Production"));
        } else {
            recordVideo = "true".equalsIgnoreCase(PropManager.getInstance().getProperty("recordVideo"));
        }
        if (!recordVideo) {
            log.info("Video recording is disabled; no video attachments will be added to the email.");
            return new ArrayList<>();
        }

        if (isProductionRun &&
                !"true".equalsIgnoreCase(PropManager.getInstance().getProperty("attachVideoToEmailReport.Production"))) {
            log.info("Video recording is enabled but attachVideoToEmailReport.Production is disabled; videos will be kept in the report directory but not attached to the email.");
            return new ArrayList<>();
        }

        List<MicrosoftGraphMailSender.GraphAttachment> videoAttachments = new ArrayList<>();
        String basePath;
        if (copyPath != null && !copyPath.isBlank()) {
            basePath = copyPath;
        } else {
            basePath = customReportFolder;
        }

        for (ScenarioVideoTracker.Entry entry : ScenarioVideoTracker.getAll()) {
            if (entry.videoPath == null || entry.videoPath.isBlank()) {
                continue;
            }
            String absolutePath = basePath + File.separator + entry.videoPath.replace("/", File.separator);
            File videoFile = new File(absolutePath);
            if (!videoFile.exists()) {
                videoFile = new File(customReportFolder + File.separator + entry.videoPath.replace("/", File.separator));
            }
            if (videoFile.exists()) {
                try {
                    byte[] bytes = Files.readAllBytes(videoFile.toPath());
                    String base64 = Base64.getEncoder().encodeToString(bytes);
                    String name = videoFile.getName();
                    videoAttachments.add(new MicrosoftGraphMailSender.GraphAttachment(name, "video/webm", base64));
                    log.info("Video attached to email: {} ({} bytes)", videoFile.getAbsolutePath(), bytes.length);
                } catch (IOException e) {
                    log.warn("Could not read video file for email attachment: {} - {}", videoFile.getAbsolutePath(), e.getMessage());
                }
            } else {
                log.warn("Video file not found for email attachment: {}", videoFile.getAbsolutePath());
            }
        }
        return videoAttachments;
    }

    private boolean isUploadVideoToOneDriveEnabled() {
        return "true".equalsIgnoreCase(PropManager.getInstance().getProperty("uploadVideoToOneDrive.Production"));
    }

    /**
     * Uploads recorded production videos to OneDrive and stores the shareable links
     * in the {@link ScenarioVideoTracker} entries for inclusion in the email body.
     */
    private void uploadProductionVideosToOneDrive() {
        boolean recordVideo = "true".equalsIgnoreCase(PropManager.getInstance().getProperty("recordVideo.Production"));
        if (!recordVideo) {
            log.info("uploadProductionVideosToOneDrive: video recording is disabled for production; nothing to upload.");
            return;
        }

        try {
            OnDriveUtility onDrive = new OnDriveUtility();
            onDrive.authenticate();

            String remoteFolder = "AutomationVideos/Production/" + sanitizeForPath(testName);
            List<ScenarioVideoTracker.Entry> entries = ScenarioVideoTracker.getAll();
            if (entries.isEmpty()) {
                log.info("uploadProductionVideosToOneDrive: no recorded videos to upload.");
                return;
            }

            for (ScenarioVideoTracker.Entry entry : entries) {
                if (entry.videoPath == null || entry.videoPath.isBlank()) {
                    continue;
                }

                String absolutePath = customReportFolder + File.separator + entry.videoPath.replace("/", File.separator);
                File videoFile = new File(absolutePath);
                if (!videoFile.exists()) {
                    log.warn("Video file not found for OneDrive upload: {}", absolutePath);
                    continue;
                }

                try {
                    OnDriveUtility.AccessLevel accessLevel = OnDriveUtility.AccessLevel.fromProperty(
                            PropManager.getInstance().getProperty("oneDriveVideoAccessLevel"));
                    String link = onDrive.uploadFileAndGetShareableLink(absolutePath, remoteFolder, accessLevel);
                    entry.oneDriveLink = link;
                    log.info("Uploaded scenario video to OneDrive ({}): {} -> {}", accessLevel, videoFile.getName(), link);
                } catch (Exception e) {
                    log.warn("Failed to upload video to OneDrive: {} - {}", videoFile.getName(), e.getMessage());
                }
            }
        } catch (Exception e) {
            log.warn("OneDrive video upload initialization failed: {}", e.getMessage());
        }
    }

    private Map<String, Queue<String>> buildOneDriveLinkMap() {
        Map<String, Queue<String>> map = new HashMap<>();
        for (ScenarioVideoTracker.Entry entry : ScenarioVideoTracker.getAll()) {
            if (entry.oneDriveLink != null && !entry.oneDriveLink.isBlank()) {
                map.computeIfAbsent(entry.scenarioName, k -> new LinkedList<>()).add(entry.oneDriveLink);
            }
        }
        return map;
    }

    private String sanitizeForPath(String name) {
        if (name == null || name.isBlank()) {
            return "Unknown";
        }
        return name.replaceAll("[\\\\/:*?\"<>|]", "_").replaceAll("\\s+", "_");
    }
}