package automation.framework.business;

import automation.framework.listener.RunnerListener;
import automation.framework.propmanager.PropManager;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

public class FolderCompressor {

    public static void compressFolder(String sourceDirPath, String output)  {
        Path sourceDir = Paths.get(sourceDirPath);
        Path outputPath = Paths.get(output).getParent();
            if (outputPath != null && !Files.exists(outputPath)) {
                try {
                    Files.createDirectories(outputPath);
                } catch (IOException e) {
                    throw new RuntimeException(e);
                }
            }


        try (ZipOutputStream zos = new ZipOutputStream(new FileOutputStream(output))) {
            Files.walk(sourceDir)
                    .filter(path -> !Files.isDirectory(path))
                    .forEach(path -> {
                        try {
                            String relativePath = sourceDir.relativize(path).toString();
                            // Convert path separators to forward slashes for ZIP standard
                            relativePath = relativePath.replace(File.separatorChar, '/');

                            zos.putNextEntry(new ZipEntry(relativePath));
                            Files.copy(path, zos);
                            zos.closeEntry();
                        } catch (IOException e) {
                            System.err.println("Error adding file to ZIP: " + path);
                            e.printStackTrace();
                        }
                    });
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        System.out.println("Successfully created ZIP file at: " + outputPath);
    }

    // Example usage
    public static void main(String[] args) {


//        try {
//            RunnerListener.testRunFinishedForRentalAgent("est");
//        } catch (IOException e) {
//            throw new RuntimeException(e);
//        }

    }
}