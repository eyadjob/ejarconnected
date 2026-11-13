package eyad.com.yelo.apisecuritychecker.service;

import com.aventstack.extentreports.ExtentTest;
import com.aventstack.extentreports.model.Report;
import com.aventstack.extentreports.model.Test;
import eyad.com.yelo.apisecuritychecker.business.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.File;
import java.util.List;

@Service
public class SendEmailHandler {


    private String customReportFolder;
    private String copyPath;
    private String testName;

    @Autowired
    CheckerService checkerService;

    public static String getHtmlFileName(String path) {
        File targetDir = new File(path);
        String file2 = null;
        String[] entries = targetDir.list();
        if (entries != null)
            for (String file : entries) {
                if (new File(targetDir.getAbsolutePath() + "\\" + file).isDirectory()) {
                    file2 = getHtmlFileName(targetDir.getAbsolutePath() + "\\" + file);
                } else {
                    if (file.endsWith(".html")) {
                        return file;
                    }
                }
            }
        return file2;
    }

    public void sendAlertEmail() {

        new Thread(() -> {
            String emailContent = PropManager.getInstance().getProperty("alert.email.body").replaceAll("alertMessageVariable", "Environment \"" + PropManager.getInstance().getProperty("ejar.environment.url") + "\"" + " Is Down!, For Around " + checkerService.environmentDownTimeCounter + " Minutes!") + PropManager.getInstance().getProperty("alert.email.footer");
            new EmailHandler().sendReportEmail("Environment is Down Alert Email! " + DateHelper.getCurrentDatePlusDays(0, "YYYY-MM-dd HH:mm:ss"), emailContent, "alert.email.to");
        }).start();

    }

    public void SendAggregatedReport(String executionName) {
//        this.copyPath = PropManager.getInstance().getProperty("execution.reports.backup.folder") + "\\" + DateHelper.getCurrentDatePlusDays(0) + "\\" + executionName + " " + DateHelper.getCurrentDatePlusDays(0, "YYYY-MM-dd HH:mm").replace(":", "-");
        this.copyPath = "Any Path";
        this.customReportFolder = System.getProperty("user.dir") + "\\" + PropManager.getInstance().getProperty("custom.report.folder");
        this.testName = executionName;

    }

    public String getResultEmailHeader() {
        return PropManager.getInstance().getProperty("report.email.header");
    }

    public String addResultRecord(ReportDataHandler reportDataHandler, String testString) {
        StringBuilder resultBodyString = new StringBuilder();
        resultBodyString.append("<tr>\n" +
                "   <th>Full Name: </th>\n" +
                "   <td>\n" +
                "      <a href='" + copyPath + "\\" + reportDataHandler.getReportFileName() + "'>" + reportDataHandler.getFeatureName() + "</a>\n" +
                "<span> - </span>" +
                "      <a href='" + copyPath + "'>" + "report folder" + "</a>\n" +
                "   </td>\n" +
                "</tr>\n" +
                "<tr>\n" +
                " <th>Status: </th>\n");
        if (reportDataHandler.isAllPass()) {
            resultBodyString.append("<td>test total: " + reportDataHandler.getTestCountInScenario() + ", " +
                    " <span class=\"passed\">" + "All passed</span>");
        } else if (reportDataHandler.isAllFail()) {
            resultBodyString.append("<td>test total: " + reportDataHandler.getTestCountInScenario() + ", " +
                    " <span class=\"failed\">" + "All Failed</span>");
        } else {
            resultBodyString.append("<td>test total: " + reportDataHandler.getTestCountInScenario() + "," +
                    " <span class=\"passed\">" + reportDataHandler.getPassCount() + " passed</span>,\n" +
                    "<span class=\"failed\">" + reportDataHandler.getFailCount() + " failed, ");
        }
        resultBodyString.append("</tr>\n" +
                "<tr>\n" +
                "<th>Start / End / Elapsed: </th>\n" +
                "<td>" + DateHelper.getDateInFormat(reportDataHandler.getStartTime(), "yyyy-MM-dd HH:mm:ss") +
                "<span style=\"color:red\"> / </span>" + DateHelper.getDateInFormat(reportDataHandler.getEndTime(), "yyyy-MM-dd HH:mm:ss") +
                " <span style=\"color:red\"> / </span>" + reportDataHandler.getElapsedTime() + "\n" +
                "</td></td>\n" +
                "</tr>");

        resultBodyString.append("<br><br>");

        return resultBodyString.toString();
    }

    public void appendLangToFeatureNameInReport(ExtentTest testResult) {
        List<Test> featureList = testResult.getExtent().getReport().getTestList();
        for (Test test : featureList) {
            if (!test.getName().contains("- en") && !test.getName().contains("- ar"))
                test.setName(test.getName() + " - " + PropManager.getInstance().getProperty("execution.lang"));
        }
    }

    public String buildTestResultsContent(ExtentTest extentTestResult, String reportFileName) {

        Report report = extentTestResult.getExtent().getReport();
        List<Test> featureList = report.getTestList();
        StringBuilder content = new StringBuilder(getResultEmailHeader());
        String testCasesString = "";
        for (int i = 0; i < featureList.size(); i++) {
            ReportDataHandler reportDataHandler = new ReportDataHandler(featureList.get(i).getName(), featureList.get(i).getStartTime(), featureList.get(i).getEndTime(), DateHelper.getElapsedTime(featureList.get(i).getStartTime(), featureList.get(i).getEndTime()), reportFileName);
            testCasesString = "";
            reportDataHandler.setTestCountInScenario(featureList.get(i).getChildren().size());
            if (featureList.get(i).getStatus().getName().equals("Pass")) {
                testCasesString += " <span class=\"passed\">" +
                        "All passed</span>";
                reportDataHandler.setAllPass(true);
                reportDataHandler.setPassCount(featureList.get(i).getChildren().size());
            } else {
                long passCount = featureList.get(i).getChildren().stream().filter(c -> c.getStatus().getName().equals("Pass")).count();
                if (passCount == 0) {
                    testCasesString += " <span class=\"failed\">" +
                            "All Failed</span>";
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
                    testCasesString += reportDataHandler.getPassCount() +
                            " passed</span>, <span class=\"failed\">" +
                            reportDataHandler.getFailCount() + " failed</span>";
                    reportDataHandler.setAllPass(false);
                }
            }
            content.append(addResultRecord(reportDataHandler, testCasesString));
            RunResultsInformation runResultsInformation = getTestCasesData(featureList);
            new PieChartGenerator().createPieChartForTestCasesStatus(runResultsInformation.getPassCount(), runResultsInformation.getFailCount(), "Test Cases Execution Summary");
            content = new StringBuilder(content.toString().replaceAll("testCasesTotal", String.valueOf(runResultsInformation.getTestCount())));
            content = new StringBuilder(content.toString().replaceAll("passedCount", String.valueOf(runResultsInformation.getPassCount())));
            content = new StringBuilder(content.toString().replaceAll("failedCount", String.valueOf(runResultsInformation.getFailCount())));
        }
        return content.append(PropManager.getInstance().getProperty("report.email.footer")).toString();
    }


    public RunResultsInformation getTestCasesData(List<Test> featureList) {

        RunResultsInformation runResultsInformation = new RunResultsInformation();
        runResultsInformation.setFeatureCount(featureList.size());
        runResultsInformation.setTestCount(featureList.stream().map(Test::getChildren).mapToInt(List::size).sum());
        runResultsInformation.setFailCount(featureList.stream().map(Test::getChildren).flatMap(List::stream).filter(c -> c.getStatus().getName().equals("Fail")).count());
        runResultsInformation.setPassCount(featureList.stream().map(Test::getChildren).flatMap(List::stream).filter(c -> c.getStatus().getName().equals("Pass")).count());
        return runResultsInformation;
    }


    public void extractResultsAndCopyToBackUpFolder(ExtentTest testResult, String executionName) {
        String newReportName = FileHandler.changeFileName(System.getProperty("user.dir") + "\\" + PropManager.getInstance().getProperty("extent.reporter.spark.out"), executionName + "-" + DateHelper.getCurrentDatePlusDays(0, "YYYY-MM-dd HH-mm") + ".html");
        String content = buildTestResultsContent(testResult, newReportName);

        try {
            File sourceDir = new File(customReportFolder);
            File targetDir = new File(copyPath);

            new FileHandler().copyDirectoryRecursively(sourceDir, targetDir);
            System.out.println("after copyDirectoryRecursively(sourceDir, targetDir); ");
        } catch (Exception e) {
            System.err.println("Error, Directory Not found: " + e.getMessage());
            e.getStackTrace();
        }
        try {
            FileHandler.deleteFilesInPath(customReportFolder);
        } catch (Exception e) {
            System.err.println("Error, deleting default reports : " + e.getMessage());
            e.getStackTrace();
        }
        EmailHandler emailHandler = new EmailHandler();

        emailHandler.sendReportEmail("Automation Test Report: " + testName.replace("TestRunner", "").replace("_", " ") + " - " + DateHelper.getCurrentDatePlusDays(0, "YYYY-MM-dd HH:mm:ss"), content);

    }

    public void changeMediaLocation(ExtentTest extentTestResult) {
        extentTestResult.getExtent().getReport().getTestList().forEach(testList -> testList.getChildren().forEach(scenario -> scenario.getChildren
                ().forEach(step -> step.getLogs().forEach(log -> {
                    if (log.getMedia() != null) {
                        log.getMedia().setPath(log.getMedia().getPath().replace(customReportFolder, copyPath));
                        if (step.getName().contains("Hook.afterStep")) {
                            step.setName("");
                        }
                    }
                }
        ))));
    }

}
