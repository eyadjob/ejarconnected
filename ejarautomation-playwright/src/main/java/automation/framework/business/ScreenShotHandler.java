package automation.framework.business;

import automation.framework.propmanager.PropManager;
import automation.framework.threadData.DriverFactory;
import com.aventstack.extentreports.MediaEntityBuilder;
import com.aventstack.extentreports.model.Media;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Date;

public class ScreenShotHandler {

    public static Media TakesScreenshot(String fileName) {
        Path path = Path.of(fileName + "_" + new Date().getTime() + ".png");
        DriverFactory.getDriver().screenshot(new com.microsoft.playwright.Page.ScreenshotOptions().setPath(path));
        File destinationFile = path.toFile();

        // Compute path relative to the customReports folder so the report stays portable
        // when the whole folder is moved or archived.
        String customReportFolder = System.getProperty("user.dir") + "\\" + PropManager.getInstance().getProperty("custom.report.folder");
        String absolutePath = destinationFile.getAbsolutePath();
        String reportPath;
        if (absolutePath.toLowerCase().startsWith(customReportFolder.toLowerCase() + "\\")) {
            reportPath = absolutePath.substring(customReportFolder.length() + 1).replace("\\", "/");
        } else {
            reportPath = absolutePath;
        }

        return MediaEntityBuilder.createScreenCaptureFromPath(reportPath).build();
    }

    public static void copyFileToImage(File sourceFile, File destinationFile) {
        try {
            Files.copy(sourceFile.toPath(), destinationFile.toPath());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
