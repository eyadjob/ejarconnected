package eyad.com.yelo.apisecuritychecker.business;

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

    public static String changeFileName(String filePath, String newFileName) {
        File currentFile = new File(filePath);
        File newFile = new File(System.getProperty("User.Directory"));
        if (!currentFile.renameTo(newFile))
            log.error("the renaming file: " + currentFile.getPath() + " to:" + newFileName + " was not successful");
        return newFile.getName();
    }

    public static void createFileIfNotFound(String filePath, String fileName) {
        if (new File(filePath + "\\" + fileName).exists()) {
        } else {
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
        if (!file.exists()) return "";
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

    public List<File> getFilesListInDirectory(String path) {
        List<File> files = new ArrayList<>();
        File file = new File(path);
        for (File fileInList : file.listFiles()) {
            if (fileInList.isDirectory()) files.addAll(getFilesListInDirectory(fileInList.getPath()));
            else files.add(fileInList);
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
            if (entries != null) for (String file : entries) {
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