package automation.framework.business;

import automation.framework.propmanager.PropManager;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.FileContent;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.gson.GsonFactory;
import com.google.api.services.drive.Drive;
import com.google.api.services.drive.DriveScopes;
import com.google.api.services.drive.model.File;
import com.google.api.services.drive.model.FileList;
import com.google.auth.http.HttpCredentialsAdapter;
import com.google.auth.oauth2.GoogleCredentials;
import com.google.auth.oauth2.ServiceAccountCredentials;
import lombok.extern.slf4j.Slf4j;

import java.io.BufferedWriter;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.GeneralSecurityException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Utility class for reading and uploading files to Google Drive using the Google Drive API v3.
 * <p>
 * Two authentication methods are supported:
 * <ol>
 *   <li><b>Service account</b> (recommended for automation): set {@code google.drive.service.account.key.file}
 *       to the JSON key file path. Share target Drive folders/files with the service account email.</li>
 *   <li><b>OAuth2 installed app</b>: set {@code google.drive.credentials.file} to the OAuth2 client secrets JSON.
 *       On first run the browser opens for consent and a token is stored in {@code google.drive.tokens.directory}.</li>
 * </ol>
 */
@Slf4j
public class GoogleDriveUtility {

    private static final String APPLICATION_NAME = "Google Drive Automation Utility";
    private static final GsonFactory JSON_FACTORY = GsonFactory.getDefaultInstance();
    private static final List<String> SCOPES = Collections.singletonList(DriveScopes.DRIVE);

    private final String accountEmail;
    private final String serviceAccountKeyFile;
    private final String credentialsFile;
    private final String tokensDirectory;

    private Drive driveService;

    /**
     * Constructs utility using credentials from {@code appProperties.properties}.
     */
    public GoogleDriveUtility() {
        this(
                PropManager.getInstance().getProperty("google.drive.account.email"),
                PropManager.getInstance().getProperty("google.drive.service.account.key.file"),
                PropManager.getInstance().getProperty("google.drive.credentials.file"),
                PropManager.getInstance().getProperty("google.drive.tokens.directory")
        );
    }

    /**
     * Constructs utility with explicit configuration.
     *
     * @param accountEmail          Google account email (for reference / logging)
     * @param serviceAccountKeyFile path to service-account JSON key file
     * @param credentialsFile       path to OAuth2 client secrets JSON file (alternative)
     * @param tokensDirectory       directory to store OAuth tokens
     */
    public GoogleDriveUtility(String accountEmail, String serviceAccountKeyFile,
                              String credentialsFile, String tokensDirectory) {
        this.accountEmail = nullToEmpty(accountEmail);
        this.serviceAccountKeyFile = nullToEmpty(serviceAccountKeyFile);
        this.credentialsFile = nullToEmpty(credentialsFile);
        this.tokensDirectory = isBlank(tokensDirectory)
                ? System.getProperty("user.dir") + "/tokens"
                : tokensDirectory;
    }

    /* ================================================================ */
    /*  Authentication & service setup                                   */
    /* ================================================================ */

    private Drive getDriveService() throws IOException, GeneralSecurityException {
        if (driveService != null) return driveService;

        final NetHttpTransport httpTransport = GoogleNetHttpTransport.newTrustedTransport();

        if (!isBlank(serviceAccountKeyFile) && fileExists(serviceAccountKeyFile)) {
            log.info("Authenticating Google Drive with service account key: {}", serviceAccountKeyFile);
            try (FileInputStream serviceAccountStream = new FileInputStream(serviceAccountKeyFile)) {
                GoogleCredentials credentials = ServiceAccountCredentials.fromStream(serviceAccountStream)
                        .createScoped(SCOPES);
                driveService = new Drive.Builder(httpTransport, JSON_FACTORY,
                        new HttpCredentialsAdapter(credentials))
                        .setApplicationName(APPLICATION_NAME)
                        .build();
            }
        } else if (!isBlank(credentialsFile) && fileExists(credentialsFile)) {
            log.info("Authenticating Google Drive with OAuth2 credentials: {}", credentialsFile);
            com.google.api.client.auth.oauth2.Credential credential = authorizeWithInstalledAppFlow(httpTransport);
            driveService = new Drive.Builder(httpTransport, JSON_FACTORY, credential)
                    .setApplicationName(APPLICATION_NAME)
                    .build();
        } else {
            throw new IllegalStateException(
                    "Google Drive authentication not configured. " +
                    "Set either google.drive.service.account.key.file or google.drive.credentials.file " +
                    "in appProperties.properties.");
        }
        return driveService;
    }

    private com.google.api.client.auth.oauth2.Credential authorizeWithInstalledAppFlow(NetHttpTransport httpTransport)
            throws IOException {
        // Load client secrets
        com.google.api.client.googleapis.auth.oauth2.GoogleClientSecrets clientSecrets =
                com.google.api.client.googleapis.auth.oauth2.GoogleClientSecrets.load(
                        JSON_FACTORY, new java.io.FileReader(credentialsFile));

        // Build flow and trigger user authorization request
        com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeFlow flow =
                new com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeFlow.Builder(
                        httpTransport, JSON_FACTORY, clientSecrets, SCOPES)
                        .setDataStoreFactory(
                                new com.google.api.client.util.store.FileDataStoreFactory(
                                        new java.io.File(tokensDirectory)))
                        .setAccessType("offline")
                        .build();

        com.google.api.client.extensions.jetty.auth.oauth2.LocalServerReceiver receiver =
                new com.google.api.client.extensions.jetty.auth.oauth2.LocalServerReceiver.Builder()
                        .setPort(8888)
                        .build();

        return new com.google.api.client.extensions.java6.auth.oauth2.AuthorizationCodeInstalledApp(
                flow, receiver).authorize("user");
    }

    /* ================================================================ */
    /*  Read / list files                                                */
    /* ================================================================ */

    /**
     * Lists file and folder names in the Google Drive root (My Drive).
     *
     * @return list of item names
     */
    public List<String> listRootFiles() throws Exception {
        return listFiles("'root' in parents and trashed = false");
    }

    /**
     * Lists file and folder names inside a specific folder.
     *
     * @param folderId Google Drive folder ID
     * @return list of item names
     */
    public List<String> listFilesInFolder(String folderId) throws Exception {
        return listFiles("'" + folderId + "' in parents and trashed = false");
    }

    /**
     * Lists Google Drive items matching a query.
     *
     * @param query Google Drive search query (e.g. {@code "name contains 'report'"})
     * @return list of file/folder names
     */
    public List<String> listFiles(String query) throws Exception {
        Drive service = getDriveService();
        List<File> files = new java.util.ArrayList<>();
        String pageToken = null;

        do {
            FileList result = service.files().list()
                    .setQ(query)
                    .setSpaces("drive")
                    .setFields("nextPageToken, files(id, name, mimeType, size)")
                    .setPageToken(pageToken)
                    .setPageSize(100)
                    .execute();

            List<File> pageFiles = result.getFiles();
            if (pageFiles != null) {
                files.addAll(pageFiles);
            }
            pageToken = result.getNextPageToken();
        } while (pageToken != null);

        log.info("Google Drive query [{}] returned {} items", query, files.size());
        return files.stream().map(File::getName).collect(Collectors.toList());
    }

    /**
     * Lists detailed file metadata matching a query.
     *
     * @param query Google Drive search query
     * @return list of {@link File} objects
     */
    public List<File> listFilesDetailed(String query) throws Exception {
        Drive service = getDriveService();
        List<File> files = new java.util.ArrayList<>();
        String pageToken = null;

        do {
            FileList result = service.files().list()
                    .setQ(query)
                    .setSpaces("drive")
                    .setFields("nextPageToken, files(id, name, mimeType, size, createdTime, modifiedTime)")
                    .setPageToken(pageToken)
                    .setPageSize(100)
                    .execute();

            if (result.getFiles() != null) {
                files.addAll(result.getFiles());
            }
            pageToken = result.getNextPageToken();
        } while (pageToken != null);

        return files;
    }

    /**
     * Finds a file by exact name.
     *
     * @param fileName exact file name
     * @return the first matching {@link File}, or {@code null} if not found
     */
    public File findFileByName(String fileName) throws Exception {
        String query = "name = '" + sanitizeQuery(fileName) + "' and trashed = false";
        List<File> files = listFilesDetailed(query);
        return files.isEmpty() ? null : files.get(0);
    }

    /* ================================================================ */
    /*  Upload                                                           */
    /* ================================================================ */

    /**
     * Uploads a local file to Google Drive root.
     * <p>
     * Example (Windows):
     * <pre>
     *   GoogleDriveUtility util = new GoogleDriveUtility();
     *   util.uploadFile("D:\\Reports\\daily.xlsx");
     * </pre>
     *
     * @param windowsFilePath full local file path
     * @return uploaded {@link File} metadata
     */
    public File uploadFile(String windowsFilePath) throws Exception {
        return uploadFile(windowsFilePath, null);
    }

    /**
     * Uploads a local file to a specific folder in Google Drive.
     *
     * @param windowsFilePath full local file path
     * @param folderId        Google Drive folder ID, or null/blank for root
     * @return uploaded {@link File} metadata
     */
    public File uploadFile(String windowsFilePath, String folderId) throws Exception {
        Drive service = getDriveService();
        Path localPath = Paths.get(windowsFilePath);
        java.io.File localFile = localPath.toFile();

        if (!localFile.exists()) {
            throw new RuntimeException("File not found: " + windowsFilePath);
        }

        String fileName = localPath.getFileName().toString();
        String mimeType = java.nio.file.Files.probeContentType(localPath);
        if (mimeType == null) {
            mimeType = "application/octet-stream";
        }

        File fileMetadata = new File();
        fileMetadata.setName(fileName);
        if (!isBlank(folderId)) {
            fileMetadata.setParents(Collections.singletonList(folderId));
        }

        FileContent mediaContent = new FileContent(mimeType, localFile);
        File uploadedFile = service.files().create(fileMetadata, mediaContent)
                .setFields("id, name, mimeType, size, webViewLink")
                .execute();

        log.info("Uploaded '{}' to Google Drive. File ID: {}, Size: {}",
                fileName, uploadedFile.getId(), uploadedFile.getSize());
        return uploadedFile;
    }

    /**
     * Uploads a file and replaces it if a file with the same name already exists.
     *
     * @param windowsFilePath full local file path
     * @param folderId        optional folder ID
     * @return uploaded {@link File} metadata
     */
    public File uploadFileReplacingExisting(String windowsFilePath, String folderId) throws Exception {
        String fileName = Paths.get(windowsFilePath).getFileName().toString();
        File existing = findFileByName(fileName);
        if (existing != null) {
            deleteFile(existing.getId());
            log.info("Deleted existing file '{}' (ID: {}) before re-upload", fileName, existing.getId());
        }
        return uploadFile(windowsFilePath, folderId);
    }

    /* ================================================================ */
    /*  Download / delete helpers                                        */
    /* ================================================================ */

    /**
     * Downloads a file from Google Drive to a local path.
     *
     * @param fileId            Google Drive file ID
     * @param localDownloadPath destination local path
     */
    public void downloadFile(String fileId, String localDownloadPath) throws Exception {
        Drive service = getDriveService();
        java.io.OutputStream out = new java.io.FileOutputStream(localDownloadPath);
        service.files().get(fileId).executeMediaAndDownloadTo(out);
        out.flush();
        out.close();
        log.info("Downloaded file ID {} to {}", fileId, localDownloadPath);
    }

    /**
     * Deletes a file or folder from Google Drive.
     *
     * @param fileId Google Drive file/folder ID
     */
    public void deleteFile(String fileId) throws Exception {
        Drive service = getDriveService();
        service.files().delete(fileId).execute();
        log.info("Deleted Google Drive file ID: {}", fileId);
    }

    /* ================================================================ */
    /*  Utility                                                          */
    /* ================================================================ */

    private static String sanitizeQuery(String value) {
        return value.replace("'", "\\'").replace("\\", "\\\\");
    }

    private static boolean fileExists(String path) {
        return new java.io.File(path).exists();
    }

    private static String nullToEmpty(String s) {
        return s == null ? "" : s;
    }

    private static boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }

    /* ================================================================ */
    /*  OneDrive old-video cleanup (post-production run)                 */
    /* ================================================================ */

    /**
     * Cleans up Microsoft OneDrive production videos that are older than the configured
     * threshold and writes a note file in the given report directory.
     * <p>
     * This method is designed to run after a production test execution has finished,
     * reports have been generated, and the report email has been sent. Any error is
     * logged and swallowed so the regression test execution is never affected.
     *
     * @param reportDirectoryPath local report directory where the cleanup note will be written
     */
    public static void cleanupOldOneDriveProductionVideos(String reportDirectoryPath) {
        PropManager props = PropManager.getInstance();
        boolean enabled = "true".equalsIgnoreCase(props.getProperty("uploadVideoToOneDrive.Production"));
        if (!enabled) {
            log.info("OneDrive production video cleanup skipped: uploadVideoToOneDrive.Production is not enabled.");
            return;
        }

        String accountEmail = nullToEmpty(props.getProperty("onedrive.account.email"));
        String cleanupFolder = props.getProperty("onedrive.cleanup.videos.folder");
        if (isBlank(cleanupFolder)) {
            cleanupFolder = "AutomationVideos/Production";
        }
        String olderThanDaysProp = props.getProperty("onedrive.cleanup.videos.older.than.days");
        int olderThanDays = 30;
        if (!isBlank(olderThanDaysProp)) {
            try {
                olderThanDays = Integer.parseInt(olderThanDaysProp.trim());
                if (olderThanDays < 1) {
                    olderThanDays = 30;
                }
            } catch (NumberFormatException e) {
                log.warn("Invalid onedrive.cleanup.videos.older.than.days value '{}'; using default 30", olderThanDaysProp);
            }
        }

        String noteFileName = "OneDrive_Video_Cleanup_Note.txt";
        String noteFilePath = isBlank(reportDirectoryPath)
                ? noteFileName
                : reportDirectoryPath + java.io.File.separator + noteFileName;

        StringBuilder note = new StringBuilder();
        note.append("OneDrive Production Video Cleanup Note\n");
        note.append("=====================================\n");
        note.append("Execution time: ").append(DateHelper.getCurrentDatePlusDays(0, "YYYY-MM-dd HH:mm:ss")).append("\n");
        note.append("OneDrive account: ").append(accountEmail).append("\n");
        note.append("Scanned folder: ").append(cleanupFolder).append(" (recursive)\n");
        note.append("Age threshold: older than ").append(olderThanDays).append(" days\n");

        List<String> deletedNames = new ArrayList<>();
        try {
            OnDriveUtility onDrive = new OnDriveUtility();
            onDrive.authenticate();

            log.info("Scanning OneDrive folder '{}' for videos older than {} days...", cleanupFolder, olderThanDays);
            List<OnDriveUtility.DriveItem> oldVideos = onDrive.findOldVideos(cleanupFolder, olderThanDays);

            if (oldVideos.isEmpty()) {
                log.info("No OneDrive videos older than {} days found in '{}'.", olderThanDays, cleanupFolder);
            } else {
                log.info("Found {} OneDrive video(s) older than {} days in '{}'. Deleting...", oldVideos.size(), olderThanDays, cleanupFolder);
                for (OnDriveUtility.DriveItem item : oldVideos) {
                    try {
                        onDrive.deleteItem(item.id);
                        deletedNames.add(item.name + " (created: " + item.createdDateTime + ")");
                        log.info("Deleted old OneDrive video: {} (created: {})", item.name, item.createdDateTime);
                    } catch (Exception itemEx) {
                        log.warn("Failed to delete old OneDrive video {} ({}): {}", item.name, item.id, itemEx.getMessage());
                    }
                }
            }
        } catch (Exception e) {
            log.warn("OneDrive production video cleanup failed: {}", e.getMessage());
            note.append("\nERROR: ").append(e.getMessage()).append("\n");
        }

        note.append("\nDeleted videos count: ").append(deletedNames.size()).append("\n");
        if (deletedNames.isEmpty()) {
            note.append("No videos older than ").append(olderThanDays).append(" days were found/deleted.\n");
        } else {
            note.append("\nDeleted videos:\n");
            for (int i = 0; i < deletedNames.size(); i++) {
                note.append(i + 1).append(". ").append(deletedNames.get(i)).append("\n");
            }
        }

        try {
            java.io.File noteFile = new java.io.File(noteFilePath);
            java.io.File parent = noteFile.getParentFile();
            if (parent != null && !parent.exists()) {
                parent.mkdirs();
            }
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(noteFile))) {
                writer.write(note.toString());
            }
            log.info("OneDrive cleanup note written to: {}", noteFile.getAbsolutePath());
        } catch (Exception writeEx) {
            log.warn("Could not write OneDrive cleanup note to {}: {}", noteFilePath, writeEx.getMessage());
        }
    }

    /* ================================================================ */
    /*  Runnable entry point                                             */
    /* ================================================================ */

    /**
     * Entry point — lists the root contents of the configured Google Drive account.
     * <p>
     * Run via Maven:
     * {@code mvn compile exec:java -Dexec.mainClass="automation.framework.business.GoogleDriveUtility"}
     */
    public static void main(String[] args) {
        List<String> items = getRootContents();
        if (items.isEmpty()) {
            System.out.println("No items found.");
        }
    }

    /**
     * Connects to Google Drive and returns the list of file/folder names
     * in the root of the configured account.
     *
     * @return list of item names, or empty list on error
     */
    public static List<String> getRootContents() {
        System.out.println("=== Google Drive Utility — Listing Root Contents ===");
        GoogleDriveUtility util = null;
        try {
            util = new GoogleDriveUtility();
            System.out.println("Account : " + util.accountEmail);
            System.out.println("Key file: " + util.serviceAccountKeyFile);
            System.out.println("Fetching root contents...\n");

            List<String> items = util.listRootFiles();
            System.out.println("Items found: " + items.size());
            for (int i = 0; i < items.size(); i++) {
                System.out.println((i + 1) + ". " + items.get(i));
            }
            return items;
        } catch (IllegalStateException e) {
            System.err.println("Configuration error: " + e.getMessage());
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
            e.printStackTrace();
        } finally {
            // GoogleDriveUtility has no resources to close
        }
        return new ArrayList<>();
    }
}
