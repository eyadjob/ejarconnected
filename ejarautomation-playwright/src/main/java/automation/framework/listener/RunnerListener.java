package automation.framework.listener;

import automation.framework.business.DateHelper;
import automation.framework.business.FileHandler;
import automation.framework.business.ScenarioVideoTracker;
import automation.framework.business.SendAggregatedReport;
import automation.framework.propmanager.PropManager;
import automation.framework.threadData.SharedMethods;
import automation.framework.threadData.TestData;
import com.aventstack.extentreports.ExtentTest;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicReference;

public class RunnerListener {

    /**
     * {@link ExtentCucumberAdapter#getCurrentStep()} is thread-local; TestNG {@code @AfterClass} runs on the
     * main thread after parallel workers finish, so the step handle is often null there. Worker threads
     * update this ref from hooks so we can still flush/email the report.
     */
    private static final AtomicReference<ExtentTest> lastExtentTestForReporting = new AtomicReference<>();

    /**
     * Same path as {@link SharedMethods#setCopyPathForResults}; workers may have empty ThreadLocal copyPath.
     */
    private static volatile String runCopyPathBackup = "";

    public static void rememberExtentTestForReporting(ExtentTest t) {
        if (t != null && t.getExtent() != null) {
            lastExtentTestForReporting.set(t);
        }
    }

    public static String getRunCopyPathBackup() {
        return runCopyPathBackup != null ? runCopyPathBackup : "";
    }

    public static void testRunStarted(String testName) throws IOException {
        lastExtentTestForReporting.set(null);
        ScenarioVideoTracker.clear();
        FileHandler.deleteFilesInPath(TestData.getInstance().getThreadSharedMethods().get().getCustomReportWithoutFeaturePath());
        FileHandler.deleteFilesInPath(TestData.getInstance().getThreadSharedMethods().get().getCustomReportWithoutFeaturePath());
        TestData.getInstance().getThreadSharedMethods().get().setTestName(testName);
        String copyPath = PropManager.getInstance().getProperty("execution.reports.backup.folder") + "\\" + DateHelper.getCurrentDatePlusDays(0) + "\\" + testName + " " + DateHelper.getCurrentDatePlusDays(0, "YYYY-MM-dd HH:mm").replace(":", "-");
        TestData.getInstance().getThreadSharedMethods().get().setCopyPathForResults(copyPath);
        runCopyPathBackup = copyPath;
    }

    public static void testRunFinished(ExtentTest testReport, String executionName) throws IOException {
        ExtentTest effectiveReport = testReport != null ? testReport : lastExtentTestForReporting.get();
        if (effectiveReport != null) {
            SendAggregatedReport sendAggregatedReport = new SendAggregatedReport(executionName, getRunCopyPathBackup());
            sendAggregatedReport.extractResultsAndCopyToBackUpFolder(effectiveReport, executionName);
        } else {
            System.err.println("RunnerListener.testRunFinished: ExtentTest was null (e.g. parallel TestNG / @AfterClass on main thread). Skipping aggregated report and email.");
        }
        lastExtentTestForReporting.set(null);
        FileHandler.deleteFilesInPath(SharedMethods.buildPathToFolder(PropManager.getInstance().getProperty("custom.report.folder")));
        FileHandler.deleteFilesInPath(SharedMethods.buildPathToFolder(PropManager.getInstance().getProperty("images.temp.folder")));

        cleanupOldestReportBackupFolder();
    }

    private static void cleanupOldestReportBackupFolder() {
        List<String> deletedFolderPaths = new ArrayList<>();
        String errorMessage = null;
        int olderThanDays = 0;
        try {
            String daysProperty = PropManager.getInstance().getProperty("delete.oldest.report.on.desk.older.than.day");
            if (daysProperty != null && !daysProperty.trim().isEmpty()) {
                try {
                    olderThanDays = Integer.parseInt(daysProperty.trim());
                } catch (NumberFormatException e) {
                    System.err.println("RunnerListener.testRunFinished: invalid value for delete.oldest.report.on.desk.older.than.day: " + daysProperty);
                }
            }
            if (olderThanDays > 0) {
                String backupFolder = PropManager.getInstance().getProperty("execution.reports.backup.folder");
                deletedFolderPaths = FileHandler.deleteFoldersOlderThanDays(backupFolder, olderThanDays);
            }
        } catch (Exception e) {
            errorMessage = e.getMessage();
            System.err.println("RunnerListener.testRunFinished: failed to cleanup oldest report backup folders: " + errorMessage);
        }
        writeDesktopCleanupNote(deletedFolderPaths, olderThanDays, errorMessage);
    }

    private static void writeDesktopCleanupNote(List<String> deletedFolderPaths, int olderThanDays, String errorMessage) {
        String noteFileName = "Desktop_Report_Cleanup_Note.txt";
        String reportDirectoryPath = getRunCopyPathBackup();
        if (reportDirectoryPath == null || reportDirectoryPath.trim().isEmpty()) {
            reportDirectoryPath = System.getProperty("user.dir");
        }
        String noteFilePath = reportDirectoryPath + File.separator + noteFileName;

        StringBuilder note = new StringBuilder();
        note.append("Desktop Report Cleanup Note\n");
        note.append("============================\n");
        note.append("Execution time: ").append(DateHelper.getCurrentDatePlusDays(0, "YYYY-MM-dd HH:mm:ss")).append("\n");
        note.append("Scanned folder: ").append(PropManager.getInstance().getProperty("execution.reports.backup.folder")).append("\n");
        note.append("Age threshold: older than ").append(olderThanDays).append(" days\n");

        if (errorMessage != null) {
            note.append("\nERROR: ").append(errorMessage).append("\n");
        }

        if (olderThanDays < 1) {
            note.append("\nCleanup is disabled.\n");
            note.append("Set delete.oldest.report.on.desk.older.than.day to a positive number to enable it.\n");
        } else if (deletedFolderPaths.isEmpty()) {
            note.append("\nNo report folders older than ").append(olderThanDays).append(" days were found/deleted.\n");
        } else {
            note.append("\nDeleted folders count: ").append(deletedFolderPaths.size()).append("\n");
            note.append("\nDeleted folders:\n");
            for (int i = 0; i < deletedFolderPaths.size(); i++) {
                note.append(i + 1).append(". ").append(deletedFolderPaths.get(i)).append("\n");
            }
        }

        try {
            File noteFile = new File(noteFilePath);
            File parent = noteFile.getParentFile();
            if (parent != null && !parent.exists()) {
                parent.mkdirs();
            }
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(noteFile))) {
                writer.write(note.toString());
            }
            System.out.println("Desktop cleanup note written to: " + noteFile.getAbsolutePath());
        } catch (Exception writeEx) {
            System.err.println("Could not write desktop cleanup note to " + noteFilePath + ": " + writeEx.getMessage());
        }
    }

}
