package automation.framework.threadData;


import automation.framework.propmanager.PropManager;
import lombok.Getter;

@Getter
public class SharedMethods {

    static String projectPath = System.getProperty("user.dir");
    String customReportWithoutFeaturePath;
    private String featureName;
    private String scenarioName;
    private final String sendReportTo;
    private String customReportFolder;
    private final String imagesTempFolder;
    private final String reportsBackupFolder;
    private String movFolder;
    private String testName;
    private String imagesFolder;
    private String copyPathForResults;

    private SharedMethods() {
        customReportWithoutFeaturePath = projectPath + "\\" + PropManager.getInstance().getProperty("custom.report.folder");
        this.sendReportTo = projectPath + "\\" + PropManager.getInstance().getProperty("email.sendReportTo");
        imagesTempFolder = projectPath + "\\" + PropManager.getInstance().getProperty("images.temp.folder") + "\\";
        reportsBackupFolder = PropManager.getInstance().getProperty("execution.reports.backup.folder");
    }

    public SharedMethods(String featureName, String scenarioName) {
        this();
        this.featureName = featureName;
        this.scenarioName = scenarioName;
    }

    public static String buildPathToFolder(String path) {
        return System.getProperty("user.dir").replace("\\", "\\") + "\\" + path + "\\";
    }

    public void setTestName(String testName) {
        this.testName = testName;
    }

    public void setCopyPathForResults(String copyPathForResults) {
        this.copyPathForResults = copyPathForResults;
    }


    /** Sanitizes a string for use in file paths (e.g. Windows disallows ':' in path segments). */
    private static String sanitizeForPath(String name) {
        if (name == null) return "";
        return name.trim().replace(":", "_").replace("*", "_").replace("?", "_")
                .replace("\"", "_").replace("<", "_").replace(">", "_").replace("|", "_");
    }
    public void setFeatureName(String featureName) {
        this.featureName = featureName;
        String pathSafeFeatureName = sanitizeForPath(featureName);
        movFolder = projectPath + "\\" + PropManager.getInstance().getProperty("custom.report.folder") + "\\" + pathSafeFeatureName + "\\videos";
        imagesFolder = projectPath + "\\" + PropManager.getInstance().getProperty("custom.report.folder") + "\\" + pathSafeFeatureName + "\\images";
        customReportFolder = projectPath + "\\" + PropManager.getInstance().getProperty("custom.report.folder") + "\\" + pathSafeFeatureName;
    }
    public void setScenarioName(String scenarioName) {
        this.scenarioName = scenarioName;
    }
}
