package eyad.com.yelo.apisecuritychecker.business;

import com.aventstack.extentreports.ExtentTest;
import com.aventstack.extentreports.model.Test;
import lombok.Getter;
import lombok.extern.slf4j.Slf4j;

import java.io.File;
import java.util.List;
import java.util.Map;

@Slf4j
@Getter
public class SendAggregatedReport {

    private final String customReportFolder;
    private final String copyPath;
    private final String testName;

    public SendAggregatedReport(String executionName) {
        this.copyPath = "Any Path";
        this.customReportFolder = System.getProperty("user.dir") + "\\" + PropManager.getInstance().getProperty("custom.report.folder");
        this.testName = executionName;
    }

    public static String getHtmlFileName(String path) {
        File targetDir = new File(path);
        String file2 = null;
        String[] entries = targetDir.list();
        if (entries != null) for (String file : entries) {
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

    public String getResultEmailHeader() {
        return PropManager.getInstance().getProperty("report.email.body");
    }

    public String addResultRecords(Map<String, String> apiResults) {
        StringBuilder resultBodyString = new StringBuilder();

        int rowIndex = 0;
        for (Map.Entry<String, String> api : apiResults.entrySet()) {
            try {
                String[] valueParts = api.getValue().split(",");
                if (valueParts.length >= 3 && valueParts[1].trim().equals("true")) {
                    boolean alt = rowIndex % 2 == 1;
                    String rowClass = alt ? " class=\"row-alt\" style=\"background-color:#f7f9fc;\"" : "";
                    String cellClass = alt ? "tbl-cell row-alt" : "tbl-cell";
                    String cellBg = alt ? "background-color:#f7f9fc; " : "";
                    String method = valueParts[0] == null ? "" : valueParts[0].trim();
                    String response = valueParts[2] == null ? "" : valueParts[2].trim();

                    resultBodyString.append("<tr").append(rowClass).append(">\n")
                            .append("<td class=\"").append(cellClass).append(" url-cell\" style=\"").append(cellBg)
                            .append("padding:9px 8px; border-bottom:1px solid #edf1f6; font-family:Consolas, Menlo, monospace; font-size:12px; color:#31435c; word-break:break-all; overflow-wrap:anywhere;\">")
                            .append("<span class=\"code-url\">").append(api.getKey() != null ? api.getKey() : "").append("</span>")
                            .append("</td>")
                            .append("<td align=\"center\" class=\"").append(cellClass).append("\" style=\"").append(cellBg)
                            .append("padding:9px 4px; text-align:center; border-bottom:1px solid #edf1f6;\">")
                            .append("<span style=\"display:inline-block; font-family:'Segoe UI', Arial, sans-serif; font-size:10px; font-weight:700; color:#ffffff; background-color:")
                            .append(methodPillColor(method))
                            .append("; border-radius:999px; padding:3px 8px; letter-spacing:0.3px;\">")
                            .append(method.toUpperCase())
                            .append("</span></td>")
                            .append("<td align=\"center\" class=\"").append(cellClass).append("\" style=\"").append(cellBg)
                            .append("padding:9px 8px; text-align:center; border-bottom:1px solid #edf1f6; font-family:'Segoe UI', Arial, sans-serif; font-size:12px; font-weight:600; color:")
                            .append(responseTextColor(response))
                            .append(";\">").append(response).append("</td>")
                            .append("</tr>\n");
                    rowIndex++;
                }
            } catch (Exception e) {
                log.warn("Error processing API result for key {}: {}", api.getKey(), e.getMessage());
            }
        }
        return resultBodyString.toString();
    }

    /** Method pill colors: GET green / POST blue / PUT amber / DELETE red. */
    private static String methodPillColor(String method) {
        switch (method == null ? "" : method.toUpperCase()) {
            case "GET": return "#188a4c";
            case "POST": return "#2470d8";
            case "PUT": return "#b97b12";
            case "DELETE": return "#d13434";
            default: return "#5b6b80";
        }
    }

    /** 5xx red / 4xx amber / 404 and everything else muted gray. */
    private static String responseTextColor(String response) {
        String r = response == null ? "" : response.trim();
        if (r.startsWith("5")) return "#d13434";
        if (r.startsWith("4") && !r.startsWith("404")) return "#b97b12";
        return "#5b6b80";
    }

    public String fillGeneralDateResults(Map<String, String> apiResults) {
        long withAuth = apiResults.entrySet().stream().filter(e -> e.getValue().split(",")[1].equals("false")).count();
        long withoutAuth = apiResults.entrySet().stream().filter(e -> e.getValue().split(",")[1].equals("true")).count();
        return "<table role=\"presentation\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr>" +
                statCard("stat-total", "#eef3fb", "#0f2d5c", "text-main", String.valueOf(apiResults.size()), "TOTAL APIS VALIDATED", "0 6px 0 0") +
                statCard("stat-ok", "#e9f7ef", "#188a4c", "", String.valueOf(withAuth), "WITH AUTHENTICATION", "0 3px") +
                statCard("stat-bad", "#fdecec", "#d13434", "", String.valueOf(withoutAuth), "WITHOUT REQUIRED AUTH", "0 0 0 6px") +
                "</tr></table>";
    }

    private static String statCard(String bgClass, String bgColor, String numberColor, String numberClass,
                                   String number, String label, String padding) {
        return "<td width=\"32%\" class=\"stat-stack\" style=\"padding:" + padding + ";\">" +
                "<table role=\"presentation\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr>" +
                "<td align=\"center\" class=\"" + bgClass + "\" style=\"background-color:" + bgColor + "; border-radius:14px; padding:16px 8px;\">" +
                "<div" + (numberClass.isEmpty() ? "" : " class=\"" + numberClass + "\"") + " style=\"font-family:'Segoe UI', Arial, sans-serif; font-size:26px; font-weight:700; color:" + numberColor + ";\">" + number + "</div>" +
                "<div class=\"text-muted\" style=\"font-family:'Segoe UI', Arial, sans-serif; font-size:11.5px; color:#5b6b80; padding-top:4px; letter-spacing:0.4px;\">" + label + "</div>" +
                "</td></tr></table></td>";
    }

    public void buildTestResultsContent(Map<String, String> apiResults) {
        if (apiResults == null || apiResults.isEmpty()) {
            log.warn("apiResults is null or empty. Cannot build email content.");
            return;
        }

        String emailHeader = getResultEmailHeader();
        if (emailHeader == null || emailHeader.isEmpty()) {
            log.error("Email header is null or empty. Cannot send email.");
            return;
        }

        String resultRecords = addResultRecords(apiResults);
        String generalData = fillGeneralDateResults(apiResults);
        String ejarUrl = PropManager.getInstance().getProperty("ejar.environment.url");
        String emailFooter = PropManager.getInstance().getProperty("report.email.footer");

        String content = emailHeader + resultRecords;
        if (ejarUrl != null && !ejarUrl.isEmpty()) {
            content = content.replaceAll(ejarUrl, "");
        }
        content = content.replace("GeneralDataVariable", generalData);
        content = content.replace("TimestampVariable", DateHelper.getCurrentDatePlusDays(0, "YYYY-MM-dd HH:mm:ss"));

        if (content == null || content.trim().isEmpty()) {
            log.error("Email content is empty after processing. Cannot send email.");
            return;
        }

        sendResultsEmail(content);
    }

    public void sendResultsEmail(String content) {
        if (content == null || content.trim().isEmpty()) {
            log.error("Cannot send email: content is null or empty.");
            return;
        }

        new Thread(() -> {
            try {
                String emailFooter = PropManager.getInstance().getProperty("report.email.footer");
                String emailContent = content;
                if (emailFooter != null && !emailFooter.isEmpty()) {
                    emailContent = content + emailFooter;
                }

                if (emailContent == null || emailContent.trim().isEmpty()) {
                    log.error("Final email content is empty. Email will not be sent.");
                    return;
                }

                String emailSubject = "APIs Automated Security Validation  " + DateHelper.getCurrentDatePlusDays(0, "YYYY-MM-dd HH:mm:ss");
                new EmailHandler().sendReportEmail(emailSubject, emailContent, "alert.email.to");
                log.info("Email sent successfully with subject: {}", emailSubject);
                System.out.println("emailContent to: " + emailContent);
            } catch (Exception e) {
                log.error("Error sending email: {}", e.getMessage(), e);
            }
        }).start();
    }

    public RunResultsInformation getTestCasesData(List<Test> featureList) {

        RunResultsInformation runResultsInformation = new RunResultsInformation();
        runResultsInformation.setFeatureCount(featureList.size());
        runResultsInformation.setTestCount(featureList.stream().map(Test::getChildren).mapToInt(List::size).sum());
        runResultsInformation.setFailCount(featureList.stream().map(Test::getChildren).flatMap(List::stream).filter(c -> c.getStatus().getName().equals("Fail")).count());
        runResultsInformation.setPassCount(featureList.stream().map(Test::getChildren).flatMap(List::stream).filter(c -> c.getStatus().getName().equals("Pass")).count());
        return runResultsInformation;
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
}