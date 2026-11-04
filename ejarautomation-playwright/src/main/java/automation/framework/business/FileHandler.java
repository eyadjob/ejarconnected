package automation.framework.business;

import automation.framework.propmanager.PropManager;
import lombok.extern.slf4j.Slf4j;


import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.List;

@Slf4j
public class FileHandler {

    /**
     * Renames the Spark HTML report under {@code custom.report.folder} (not thread-local), so it works from
     * TestNG {@code @AfterClass} and avoids unreliable {@link File#renameTo} on Windows when the file is open.
     */
    public static String changeFileName(String filePath, String newFileName) {
        File currentFile = new File(filePath);
        String customFolder = PropManager.getInstance().getProperty("custom.report.folder");
        File destDir = new File(System.getProperty("user.dir") + File.separator + customFolder);
        File newFile = new File(destDir, newFileName);
        try {
            Files.createDirectories(destDir.toPath());
            if (!currentFile.exists()) {
                log.error("changeFileName: Spark report not found (flush may be missing or path wrong): {}", currentFile.getAbsolutePath());
                return newFileName;
            }
            Files.move(currentFile.toPath(), newFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
            log.info("changeFileName: moved {} -> {}", currentFile.getName(), newFile.getAbsolutePath());
        } catch (IOException e) {
            log.warn("changeFileName: Files.move failed ({}), trying copy", e.getMessage());
            try {
                Files.copy(currentFile.toPath(), newFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
                log.info("changeFileName: copied {} -> {}", currentFile.getName(), newFile.getAbsolutePath());
            } catch (IOException e2) {
                log.error("changeFileName: could not move or copy {} to {}: {}", currentFile.getAbsolutePath(), newFile.getAbsolutePath(), e2.getMessage());
            }
        }
        return newFile.getName();
    }

    public static void createFileIfNotFound(String filePath, String fileName) {
        if (new File(filePath + "\\" + fileName).exists())
            return;
        else {
            File file = new File(filePath);
            if (!file.exists()) {
                file.mkdirs();
            }
            File textFile = new File(filePath + "\\" + fileName);
            try {
                textFile.createNewFile();
            } catch (IOException e) {
                System.out.println("we couldn't create the file: " + filePath + "\\" + fileName);
                e.printStackTrace();
            }
        }
    }


    public static String readFile(File file) {
        FileReader fr = null;
        if (!file.exists())
            return "";
        StringBuilder sb = new StringBuilder();
        try {
            fr = new FileReader(file);
            int i = 0;
            while ((i = fr.read()) != -1) {
                sb.append((char) i);
            }
            fr.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return sb.toString();
    }

    public static void deleteFilesInPath(String path) throws IOException {
        System.getProperty("user.dir");
        try {
            File file = new File(path);
            deleteDirectoryRecursion(file);
        } catch (Exception e) {
            System.err.println("Error, Directory Not found: " + e.getMessage());
        }
    }

    public static void deleteDirectoryRecursion(File file) throws IOException {
        if (file.isDirectory()) {
            File[] entries = file.listFiles();
            if (entries != null) {
                for (File entry : entries) {
                    deleteDirectoryRecursion(entry);
                }
            }
        }
        try {
            file.delete();
            } catch (Exception e) {
            System.out.println("Failure was caught at deleting the following file: " + file.getName());
        }
    }

    /**
     * Deletes every direct subfolder inside the given path whose last-modified time is older than the
     * specified number of days. Days must be a positive integer; values less than 1 disable deletion.
     * Safe to call with missing/invalid paths: logs and returns an empty list without throwing.
     *
     * @return list of absolute paths of deleted folders
     */
    public static List<String> deleteFoldersOlderThanDays(String path, int days) {
        List<String> deletedPaths = new ArrayList<>();
        if (path == null || path.trim().isEmpty()) {
            log.warn("deleteFoldersOlderThanDays: path is null or empty");
            return deletedPaths;
        }
        if (days < 1) {
            log.info("deleteFoldersOlderThanDays: disabled because days ({}) is less than 1", days);
            return deletedPaths;
        }
        File directory = new File(path);
        if (!directory.exists() || !directory.isDirectory()) {
            log.warn("deleteFoldersOlderThanDays: path does not exist or is not a directory: {}", path);
            return deletedPaths;
        }
        File[] subFolders = directory.listFiles(File::isDirectory);
        if (subFolders == null || subFolders.length == 0) {
            log.info("deleteFoldersOlderThanDays: no subfolders found in {}", path);
            return deletedPaths;
        }
        long cutoff = System.currentTimeMillis() - (days * 24L * 60 * 60 * 1000);
        for (File subFolder : subFolders) {
            if (subFolder.lastModified() < cutoff) {
                String deletedPath = subFolder.getAbsolutePath();
                try {
                    deleteDirectoryRecursion(subFolder);
                    deletedPaths.add(deletedPath);
                    log.info("deleteFoldersOlderThanDays: deleted folder older than {} days: {}", days, deletedPath);
                } catch (IOException e) {
                    log.error("deleteFoldersOlderThanDays: failed to delete folder {}: {}", deletedPath, e.getMessage());
                }
            }
        }
        return deletedPaths;
    }

    public List<File> getFilesListInDirectory(String path) {
        List<File> files = new ArrayList<>();
        File file = new File(path);
        for (File fileInList : file.listFiles()) {
            if (fileInList.isDirectory())
                files.addAll(getFilesListInDirectory(fileInList.getPath()));
            else
                files.add(fileInList);
        }
        return files;
    }

    public void copyDirectoryRecursively(File source, File target) throws Exception {
        if (source.isDirectory()) {
            if (!target.exists()) {
                Path path = Paths.get(target.getPath());
                Files.createDirectories(path);
            }
            String[] entries = source.list();
            if (entries != null)
                for (String file : entries) {
                    File srcFile = new File(source, file);
                    File destFile = new File(target, file);
                    copyDirectoryRecursively(srcFile, destFile);
                }
        } else {
            Files.copy(source.toPath(), target.toPath(), StandardCopyOption.REPLACE_EXISTING);
            System.out.println("File copied : " + target);
        }
    }


}