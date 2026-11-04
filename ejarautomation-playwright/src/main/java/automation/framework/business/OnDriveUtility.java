package automation.framework.business;

import automation.framework.propmanager.PropManager;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import lombok.extern.slf4j.Slf4j;

import java.io.IOException;
import java.net.URI;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * Utility class for uploading files to Microsoft OneDrive using the
 * Microsoft Graph API with OAuth2 client-credentials flow.
 * <p>
 * Required configuration in {@code appProperties.properties}:
 * <pre>
 *   onedrive.account.email=qualityautomationteamreports@qoad.com
 *   onedrive.client.id=your_azure_app_client_id
 *   onedrive.client.secret=your_azure_app_client_secret
 *   onedrive.tenant.id=your_azure_ad_tenant_id
 * </pre>
 * The Azure AD app must have {@code Files.ReadWrite.All} application permission
 * and admin consent must be granted.
 */
@Slf4j
public class OnDriveUtility {

    private static final String TOKEN_URL_TEMPLATE = "https://login.microsoftonline.com/%s/oauth2/v2.0/token";
    private static final String UPLOAD_URL_TEMPLATE = "https://graph.microsoft.com/v1.0/users/%s/drive/root:/%s:/content";
    private static final String CREATE_LINK_URL_TEMPLATE = "https://graph.microsoft.com/v1.0/users/%s/drive/items/%s/createLink";
    private static final String SCOPE = "https://graph.microsoft.com/.default";

    /**
     * Access level for uploaded OneDrive videos.
     */
    public enum AccessLevel {
        EVERYONE_EXCEPT_EXTERNAL_USERS,
        ANYONE_WITH_LINK;

        /**
         * Parses the property value. Defaults to {@link #EVERYONE_EXCEPT_EXTERNAL_USERS}
         * for any unrecognized value.
         */
        public static AccessLevel fromProperty(String value) {
            if (value == null) {
                return EVERYONE_EXCEPT_EXTERNAL_USERS;
            }
            String normalized = value.trim().toLowerCase();
            if (normalized.equals("anyone with the link") || normalized.equals("anonymous")) {
                return ANYONE_WITH_LINK;
            }
            // Default includes "Everyone except external users" and any invalid value.
            return EVERYONE_EXCEPT_EXTERNAL_USERS;
        }
    }

    private final String accountEmail;
    private final String clientId;
    private final String clientSecret;
    private final String tenantId;

    private final HttpClient httpClient;
    private String accessToken;

    /**
     * Constructs utility using credentials from {@code appProperties.properties}.
     */
    public OnDriveUtility() {
        PropManager props = PropManager.getInstance();
        this.accountEmail = nullToEmpty(props.getProperty("onedrive.account.email"));
        this.clientId = nullToEmpty(props.getProperty("onedrive.client.id"));
        this.clientSecret = nullToEmpty(props.getProperty("onedrive.client.secret"));
        this.tenantId = nullToEmpty(props.getProperty("onedrive.tenant.id"));
        this.httpClient = HttpClient.newBuilder()
                .connectTimeout(Duration.ofSeconds(30))
                .build();
    }

    /**
     * Constructs utility with explicit credentials.
     *
     * @param accountEmail target OneDrive account (user principal name)
     * @param clientId     Azure AD app client id
     * @param clientSecret Azure AD app client secret
     * @param tenantId     Azure AD tenant id
     */
    public OnDriveUtility(String accountEmail, String clientId, String clientSecret, String tenantId) {
        this.accountEmail = nullToEmpty(accountEmail);
        this.clientId = nullToEmpty(clientId);
        this.clientSecret = nullToEmpty(clientSecret);
        this.tenantId = nullToEmpty(tenantId);
        this.httpClient = HttpClient.newBuilder()
                .connectTimeout(Duration.ofSeconds(30))
                .build();
    }

    /**
     * Authenticates to Microsoft Graph using client-credentials flow and caches the access token.
     */
    public void authenticate() throws Exception {
        validateCredentials();

        String tokenUrl = String.format(TOKEN_URL_TEMPLATE, tenantId);
        String body = "grant_type=client_credentials"
                + "&client_id=" + URLEncoder.encode(clientId, StandardCharsets.UTF_8)
                + "&client_secret=" + URLEncoder.encode(clientSecret, StandardCharsets.UTF_8)
                + "&scope=" + URLEncoder.encode(SCOPE, StandardCharsets.UTF_8);

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(tokenUrl))
                .header("Content-Type", "application/x-www-form-urlencoded")
                .POST(HttpRequest.BodyPublishers.ofString(body, StandardCharsets.UTF_8))
                .timeout(Duration.ofSeconds(30))
                .build();

        HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString(StandardCharsets.UTF_8));

        if (response.statusCode() != 200) {
            throw new RuntimeException("Authentication failed: HTTP " + response.statusCode() + " - " + response.body());
        }

        JsonObject json = JsonParser.parseString(response.body()).getAsJsonObject();
        this.accessToken = json.get("access_token").getAsString();
        log.info("Authenticated to Microsoft Graph for OneDrive operations");
    }

    /**
     * Uploads a local file to the configured user's OneDrive root folder.
     *
     * @param localFilePath full local file path
     * @throws Exception if authentication or upload fails
     */
    public void uploadFile(String localFilePath) throws Exception {
        uploadFile(localFilePath, null);
    }

    /**
     * Uploads a local file to a specific folder in the configured user's OneDrive.
     *
     * @param localFilePath full local file path
     * @param targetFolder  OneDrive folder path (e.g. "Reports" or "Reports/2024"), or null/blank for root
     * @throws Exception if authentication or upload fails
     */
    public void uploadFile(String localFilePath, String targetFolder) throws Exception {
        uploadFileInternal(localFilePath, targetFolder);
    }

    /**
     * Uploads a local file to OneDrive and returns a shareable view link.
     * Defaults to {@link AccessLevel#EVERYONE_EXCEPT_EXTERNAL_USERS}.
     *
     * @param localFilePath full local file path
     * @param targetFolder  OneDrive folder path, or null/blank for root
     * @return a shareable web URL for the uploaded file
     * @throws Exception if authentication, upload, or link creation fails
     */
    public String uploadFileAndGetShareableLink(String localFilePath, String targetFolder) throws Exception {
        return uploadFileAndGetShareableLink(localFilePath, targetFolder, AccessLevel.EVERYONE_EXCEPT_EXTERNAL_USERS);
    }

    /**
     * Uploads a local file to OneDrive and returns a shareable view link with the requested access level.
     *
     * @param localFilePath full local file path
     * @param targetFolder  OneDrive folder path, or null/blank for root
     * @param accessLevel   desired sharing access level
     * @return a shareable web URL for the uploaded file
     * @throws Exception if authentication, upload, or link creation fails
     */
    public String uploadFileAndGetShareableLink(String localFilePath, String targetFolder, AccessLevel accessLevel) throws Exception {
        String itemId = uploadFileInternal(localFilePath, targetFolder);
        if (accessLevel == AccessLevel.ANYONE_WITH_LINK) {
            return createSharingLink(itemId, "anonymous");
        }
        grantEveryoneExceptExternalUsersAccess(itemId);
        return createSharingLink(itemId, "organization");
    }

    /**
     * Uploads a local file to OneDrive and returns the uploaded item id.
     *
     * @param localFilePath full local file path
     * @param targetFolder  OneDrive folder path, or null/blank for root
     * @return the OneDrive item id of the uploaded file
     * @throws Exception if authentication or upload fails
     */
    private String uploadFileInternal(String localFilePath, String targetFolder) throws Exception {
        if (accessToken == null || accessToken.isEmpty()) {
            authenticate();
        }

        Path path = Paths.get(localFilePath);
        if (!Files.exists(path)) {
            throw new RuntimeException("File not found: " + localFilePath);
        }

        String fileName = path.getFileName().toString();
        String remotePath = buildRemotePath(fileName, targetFolder);
        String encodedUpn = URLEncoder.encode(accountEmail, StandardCharsets.UTF_8).replace("+", "%20");
        String encodedRemotePath = URLEncoder.encode(remotePath, StandardCharsets.UTF_8).replace("+", "%20");
        String uploadUrl = String.format(UPLOAD_URL_TEMPLATE, encodedUpn, encodedRemotePath);

        String contentType = Files.probeContentType(path);
        if (contentType == null) {
            contentType = "application/octet-stream";
        }

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(uploadUrl))
                .header("Authorization", "Bearer " + accessToken)
                .header("Content-Type", contentType)
                .PUT(HttpRequest.BodyPublishers.ofFile(path))
                .timeout(Duration.ofSeconds(120))
                .build();

        HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString(StandardCharsets.UTF_8));

        if (response.statusCode() != 200 && response.statusCode() != 201) {
            throw new RuntimeException("Upload failed: HTTP " + response.statusCode() + " - " + response.body());
        }

        JsonObject json = JsonParser.parseString(response.body()).getAsJsonObject();
        String itemId = json.get("id").getAsString();
        log.info("Uploaded '{}' to OneDrive account '{}' path '{}' (itemId: {})", fileName, accountEmail, remotePath, itemId);
        return itemId;
    }

    /**
     * Creates a view sharing link with the given scope for the given OneDrive item.
     *
     * @param itemId the OneDrive item id
     * @param scope  link scope, e.g. "organization" or "anonymous"
     * @return the shareable web URL
     * @throws Exception if link creation fails
     */
    private String createSharingLink(String itemId, String scope) throws Exception {
        String encodedUpn = URLEncoder.encode(accountEmail, StandardCharsets.UTF_8).replace("+", "%20");
        String createLinkUrl = String.format(CREATE_LINK_URL_TEMPLATE, encodedUpn, itemId);

        String requestBody = "{\"type\":\"view\",\"scope\":\"" + scope + "\"}";

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(createLinkUrl))
                .header("Authorization", "Bearer " + accessToken)
                .header("Content-Type", "application/json")
                .POST(HttpRequest.BodyPublishers.ofString(requestBody, StandardCharsets.UTF_8))
                .timeout(Duration.ofSeconds(30))
                .build();

        HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString(StandardCharsets.UTF_8));

        if (response.statusCode() != 200 && response.statusCode() != 201) {
            throw new RuntimeException("Create sharing link failed: HTTP " + response.statusCode() + " - " + response.body());
        }

        JsonObject json = JsonParser.parseString(response.body()).getAsJsonObject();
        JsonObject link = json.getAsJsonObject("link");
        if (link == null || !link.has("webUrl")) {
            throw new RuntimeException("Create sharing link response did not contain link.webUrl: " + response.body());
        }
        String webUrl = link.get("webUrl").getAsString();
        String linkType = link.has("type") ? link.get("type").getAsString() : "unknown";
        String linkScope = link.has("scope") ? link.get("scope").getAsString() : "unknown";
        log.info("Created OneDrive sharing link for item {}: type={}, scope={}, url={}", itemId, linkType, linkScope, webUrl);
        return webUrl;
    }

    /**
     * Grants the tenant's built-in "Everyone except external users" SharePoint claim group
     * read access to the given drive item. This makes the file appear under
     * Manage Access &gt; Groups with "Everyone except external users" / "Can view".
     */
    private void grantEveryoneExceptExternalUsersAccess(String itemId) {
        try {
            if (tenantId == null || tenantId.isBlank()) {
                log.warn("Cannot grant Everyone-except-external-users access: tenant id is missing");
                return;
            }

            String encodedUpn = URLEncoder.encode(accountEmail, StandardCharsets.UTF_8).replace("+", "%20");
            String inviteUrl = String.format("https://graph.microsoft.com/v1.0/users/%s/drive/items/%s/invite", encodedUpn, itemId);

            // SharePoint claim principal for the built-in "Everyone except external users" group.
            String everyoneExceptExternalUsersClaim = "c:0-.f|rolemanager|spo-grid-all-users/" + tenantId;
            String requestBody = "{"
                    + "\"recipients\":[{\"alias\":\"" + everyoneExceptExternalUsersClaim + "\"}],"
                    + "\"roles\":[\"read\"],"
                    + "\"requireSignIn\":true,"
                    + "\"sendInvitation\":false"
                    + "}";

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(inviteUrl))
                    .header("Authorization", "Bearer " + accessToken)
                    .header("Content-Type", "application/json")
                    .POST(HttpRequest.BodyPublishers.ofString(requestBody, StandardCharsets.UTF_8))
                    .timeout(Duration.ofSeconds(30))
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString(StandardCharsets.UTF_8));

            if (response.statusCode() != 200 && response.statusCode() != 201) {
                log.warn("Grant Everyone-except-external-users access returned HTTP {}: {}", response.statusCode(), response.body());
                return;
            }

            log.info("Granted Everyone-except-external-users read access to item {}", itemId);
        } catch (Exception e) {
            log.warn("Failed to grant Everyone-except-external-users access to item {}: {}", itemId, e.getMessage());
        }
    }

    /* ================================================================ */
    /*  Old-video cleanup helpers                                        */
    /* ================================================================ */

    /**
     * Lightweight representation of a OneDrive drive item used by cleanup operations.
     */
    public static class DriveItem {
        public final String id;
        public final String name;
        public final String path;
        public final String mimeType;
        public final OffsetDateTime createdDateTime;

        public DriveItem(String id, String name, String path, String mimeType, OffsetDateTime createdDateTime) {
            this.id = id;
            this.name = name;
            this.path = path;
            this.mimeType = mimeType;
            this.createdDateTime = createdDateTime;
        }
    }

    private static final Set<String> VIDEO_EXTENSIONS = new HashSet<>(Arrays.asList(
            "webm", "mp4", "mov", "avi", "mkv", "flv", "wmv", "m4v", "3gp", "mpeg", "mpg"
    ));

    /**
     * Recursively finds video files under the given OneDrive folder that are older than
     * {@code olderThanDays} days.
     *
     * @param rootFolderPath OneDrive folder path, e.g. "AutomationVideos/Production"
     * @param olderThanDays  age threshold in days
     * @return list of drive items that are candidates for deletion
     * @throws Exception if authentication or Graph API calls fail
     */
    public List<DriveItem> findOldVideos(String rootFolderPath, int olderThanDays) throws Exception {
        if (accessToken == null || accessToken.isEmpty()) {
            authenticate();
        }
        OffsetDateTime cutoff = OffsetDateTime.now(ZoneOffset.UTC).minusDays(olderThanDays);
        List<DriveItem> result = new ArrayList<>();
        collectOldVideosRecursive(normalizeFolderPath(rootFolderPath), cutoff, result);
        return result;
    }

    private void collectOldVideosRecursive(String folderPath, OffsetDateTime cutoff, List<DriveItem> accumulator) throws Exception {
        String encodedUpn = URLEncoder.encode(accountEmail, StandardCharsets.UTF_8).replace("+", "%20");
        String encodedFolder = URLEncoder.encode(folderPath, StandardCharsets.UTF_8).replace("+", "%20");
        String listUrl = String.format("https://graph.microsoft.com/v1.0/users/%s/drive/root:/%s:/children", encodedUpn, encodedFolder);

        String nextLink = listUrl;
        while (nextLink != null) {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(nextLink))
                    .header("Authorization", "Bearer " + accessToken)
                    .GET()
                    .timeout(Duration.ofSeconds(60))
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString(StandardCharsets.UTF_8));

            if (response.statusCode() != 200) {
                throw new RuntimeException("Failed to list OneDrive folder '" + folderPath + "': HTTP " + response.statusCode() + " - " + response.body());
            }

            JsonObject json = JsonParser.parseString(response.body()).getAsJsonObject();
            if (json.has("value")) {
                for (com.google.gson.JsonElement element : json.getAsJsonArray("value")) {
                    JsonObject item = element.getAsJsonObject();
                    if (item.has("folder")) {
                        String childName = item.has("name") ? item.get("name").getAsString() : "";
                        if (!childName.isEmpty()) {
                            collectOldVideosRecursive(folderPath + "/" + childName, cutoff, accumulator);
                        }
                    } else if (isVideoFile(item)) {
                        OffsetDateTime created = parseCreatedDateTime(item);
                        if (created != null && created.isBefore(cutoff)) {
                            String id = item.has("id") ? item.get("id").getAsString() : "";
                            String name = item.has("name") ? item.get("name").getAsString() : "";
                            String parentPath = "";
                            if (item.has("parentReference")) {
                                JsonObject parentRef = item.getAsJsonObject("parentReference");
                                if (parentRef.has("path")) {
                                    parentPath = parentRef.get("path").getAsString();
                                }
                            }
                            String mimeType = "";
                            if (item.has("file") && item.getAsJsonObject("file").has("mimeType")) {
                                mimeType = item.getAsJsonObject("file").get("mimeType").getAsString();
                            }
                            accumulator.add(new DriveItem(id, name, parentPath, mimeType, created));
                        }
                    }
                }
            }
            nextLink = json.has("@odata.nextLink") ? json.get("@odata.nextLink").getAsString() : null;
        }
    }

    private String normalizeFolderPath(String folderPath) {
        if (folderPath == null || folderPath.trim().isEmpty()) {
            return "";
        }
        String normalized = folderPath.trim().replace("\\", "/");
        while (normalized.startsWith("/")) {
            normalized = normalized.substring(1);
        }
        while (normalized.endsWith("/")) {
            normalized = normalized.substring(0, normalized.length() - 1);
        }
        return normalized;
    }

    private boolean isVideoFile(JsonObject item) {
        JsonObject file = item.getAsJsonObject("file");
        if (file != null && file.has("mimeType")) {
            String mimeType = file.get("mimeType").getAsString();
            if (mimeType != null && mimeType.startsWith("video/")) {
                return true;
            }
        }
        String name = item.has("name") ? item.get("name").getAsString() : "";
        int lastDot = name.lastIndexOf('.');
        if (lastDot > 0 && lastDot < name.length() - 1) {
            String ext = name.substring(lastDot + 1).toLowerCase();
            return VIDEO_EXTENSIONS.contains(ext);
        }
        return false;
    }

    private OffsetDateTime parseCreatedDateTime(JsonObject item) {
        if (!item.has("createdDateTime")) {
            return null;
        }
        try {
            return OffsetDateTime.parse(item.get("createdDateTime").getAsString());
        } catch (Exception e) {
            log.warn("Could not parse OneDrive createdDateTime: {}", item.get("createdDateTime"));
            return null;
        }
    }

    /**
     * Deletes a OneDrive drive item by id.
     *
     * @param itemId the OneDrive item id
     * @return true if deletion succeeded
     * @throws Exception if authentication or the delete request fails
     */
    public boolean deleteItem(String itemId) throws Exception {
        if (accessToken == null || accessToken.isEmpty()) {
            authenticate();
        }
        if (itemId == null || itemId.isEmpty()) {
            throw new IllegalArgumentException("itemId cannot be null or empty");
        }

        String encodedUpn = URLEncoder.encode(accountEmail, StandardCharsets.UTF_8).replace("+", "%20");
        String deleteUrl = String.format("https://graph.microsoft.com/v1.0/users/%s/drive/items/%s", encodedUpn, itemId);

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(deleteUrl))
                .header("Authorization", "Bearer " + accessToken)
                .DELETE()
                .timeout(Duration.ofSeconds(60))
                .build();

        HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString(StandardCharsets.UTF_8));

        if (response.statusCode() != 204 && response.statusCode() != 200) {
            throw new RuntimeException("Failed to delete OneDrive item " + itemId + ": HTTP " + response.statusCode() + " - " + response.body());
        }
        log.info("Deleted OneDrive item: {}", itemId);
        return true;
    }

    private void validateCredentials() {
        if (accountEmail.isEmpty()) {
            throw new IllegalStateException("onedrive.account.email is missing in appProperties.properties");
        }
        if (clientId.isEmpty()) {
            throw new IllegalStateException("onedrive.client.id is missing in appProperties.properties");
        }
        if (clientSecret.isEmpty()) {
            throw new IllegalStateException("onedrive.client.secret is missing in appProperties.properties");
        }
        if (tenantId.isEmpty()) {
            throw new IllegalStateException("onedrive.tenant.id is missing in appProperties.properties");
        }
    }

    private static String buildRemotePath(String fileName, String targetFolder) {
        if (targetFolder == null || targetFolder.trim().isEmpty()) {
            return fileName;
        }
        String normalized = targetFolder.trim().replace("\\", "/");
        if (normalized.startsWith("/")) {
            normalized = normalized.substring(1);
        }
        if (normalized.endsWith("/")) {
            normalized = normalized.substring(0, normalized.length() - 1);
        }
        return normalized + "/" + fileName;
    }

    private static String nullToEmpty(String s) {
        return s == null ? "" : s;
    }

    /**
     * Entry point — authenticates to Microsoft Graph and uploads a test file to OneDrive.
     * <p>
     * Run via Maven:
     * {@code mvn compile exec:java -Dexec.mainClass="automation.framework.business.OnDriveUtility"}
     */
    public static void main(String[] args) {
        OnDriveUtility util = null;
        try {
            util = new OnDriveUtility();
            System.out.println("=== OneDrive Utility — Test Upload ===");
            System.out.println("Account: " + util.accountEmail);
            System.out.println("Authenticating to Microsoft Graph...");

            util.authenticate();
            System.out.println("Authentication successful.\n");

            String testFilePath = createTestFile();
            System.out.println("Uploading test file: " + testFilePath);
            AccessLevel accessLevel = AccessLevel.fromProperty(
                    PropManager.getInstance().getProperty("oneDriveVideoAccessLevel"));
            System.out.println("Configured access level: " + accessLevel);
            String oneDriveLink = util.uploadFileAndGetShareableLink(testFilePath, "AutomationUploads/Tests", accessLevel);
            System.out.println("Test upload completed successfully.");
            System.out.println("OneDrive shareable link: " + oneDriveLink);
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
            e.printStackTrace();
            System.exit(1);
        }
    }

    private static String createTestFile() throws IOException {
        Path tempDir = Paths.get(System.getProperty("user.dir"), "temp");
        if (!Files.exists(tempDir)) {
            Files.createDirectories(tempDir);
        }
        Path testFile = tempDir.resolve("OneDriveUploadTest.txt");
        String content = "OneDrive upload test - " + LocalDateTime.now();
        Files.write(testFile, content.getBytes(StandardCharsets.UTF_8));
        return testFile.toString();
    }
}
