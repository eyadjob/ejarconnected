package eyad.com.yelo.apisecuritychecker.business;

import java.net.URI;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.ArrayList;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;

/**
 * Sends email via Microsoft Graph API using OAuth2 client credentials flow.
 * <p>
 * Azure AD app registration must have application permission "Mail.Send" and admin consent granted.
 * The {@code fromUserIdOrUpn} in sendMail() is the user (or shared mailbox) that sends the email.
 * </p>
 * For production, set GRAPH_CLIENT_ID, GRAPH_CLIENT_SECRET, GRAPH_TENANT_ID as environment variables.
 */
public class MicrosoftGraphMailSender {

    private static final String TOKEN_URL_TEMPLATE = "https://login.microsoftonline.com/%s/oauth2/v2.0/token";
    private static final String SEND_MAIL_URL_TEMPLATE = "https://graph.microsoft.com/v1.0/users/%s/sendMail";
    private static final String SCOPE = "https://graph.microsoft.com/.default";
    private static final int MAX_RETRIES = 5;
    private static final long RETRY_DELAY_MS = 5000;

    private final String clientId;
    private final String clientSecret;
    private final String tenantId;
    private final HttpClient httpClient;

    public MicrosoftGraphMailSender(String clientId, String clientSecret, String tenantId) {
        this.clientId = clientId;
        this.clientSecret = clientSecret;
        this.tenantId = tenantId;
        this.httpClient = HttpClient.newBuilder()
                .connectTimeout(Duration.ofSeconds(30))
                .build();
    }

    /**
     * Get an access token using client credentials flow.
     */
    public String getAccessToken() throws Exception {
        String tokenUrl = String.format(TOKEN_URL_TEMPLATE, tenantId);
        String body = "grant_type=client_credentials"
                + "&client_id=" + URLEncoder.encode(clientId, StandardCharsets.UTF_8)
                + "&client_secret=" + URLEncoder.encode(clientSecret, StandardCharsets.UTF_8)
                + "&scope=" + URLEncoder.encode(SCOPE, StandardCharsets.UTF_8);

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(tokenUrl))
                .header("Content-Type", "application/x-www-form-urlencoded")
                .POST(HttpRequest.BodyPublishers.ofString(body))
                .timeout(Duration.ofSeconds(30))
                .build();

        HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString(StandardCharsets.UTF_8));

        if (response.statusCode() != 200) {
            throw new RuntimeException("Token request failed: " + response.statusCode() + " - " + response.body());
        }

        String responseBody = response.body();
        int start = responseBody.indexOf("\"access_token\":\"") + 16;
        int end = responseBody.indexOf("\"", start);
        if (start < 16 || end < 0) {
            throw new RuntimeException("Could not parse access_token from response");
        }
        return responseBody.substring(start, end).replace("\\u003d", "=").replace("\\/", "/");
    }

    /**
     * Send an email as the given user (user ID or userPrincipalName).
     *
     * @param fromUserIdOrUpn User ID or UPN of the mailbox to send from (e.g. user@domain.com)
     * @param toEmail         Recipient email address
     * @param subject         Email subject
     * @param body            Email body (plain text)
     */
    public void sendMail(String fromUserIdOrUpn, String toEmail, String subject, String body) throws Exception {
        sendMail(fromUserIdOrUpn, toEmail, subject, body, false);
    }

    /**
     * Send an email as the given user.
     *
     * @param fromUserIdOrUpn User ID or UPN of the mailbox to send from
     * @param toEmail         Recipient email address
     * @param subject         Email subject
     * @param body            Email body
     * @param bodyIsHtml      true if body is HTML, false for plain text
     */
    public void sendMail(String fromUserIdOrUpn, String toEmail, String subject, String body, boolean bodyIsHtml) throws Exception {
        List<String> toList = toEmail == null || toEmail.isBlank() ? new ArrayList<>() : List.of(toEmail.trim());
        sendMail(fromUserIdOrUpn, toList, new ArrayList<>(), subject, body, bodyIsHtml, new ArrayList<>());
    }

    /**
     * Send an email with multiple TO/BCC recipients and optional attachments (inline and file).
     *
     * @param fromUserIdOrUpn User ID or UPN of the mailbox to send from
     * @param toEmails        TO recipients (can be comma-separated string or list)
     * @param bccEmails       BCC recipients (can be empty)
     * @param subject         Email subject
     * @param htmlBody        HTML body content
     * @param attachments     Optional list of attachments (inline or file)
     */
    public void sendMailWithAttachments(String fromUserIdOrUpn, List<String> toEmails, List<String> bccEmails,
                                        String subject, String htmlBody, List<GraphAttachment> attachments) throws Exception {
        sendMail(fromUserIdOrUpn, toEmails, bccEmails, subject, htmlBody, true, attachments);
    }

    private void sendMail(String fromUserIdOrUpn, List<String> toEmails, List<String> bccEmails,
                         String subject, String body, boolean bodyIsHtml, List<GraphAttachment> attachments) throws Exception {
        Exception lastException = null;
        for (int attempt = 1; attempt <= MAX_RETRIES; attempt++) {
            try {
                doSendMail(fromUserIdOrUpn, toEmails, bccEmails, subject, body, bodyIsHtml, attachments);
                return; // success
            } catch (Exception e) {
                lastException = e;
                System.err.println("MicrosoftGraphMailSender: sendMail attempt " + attempt + "/" + MAX_RETRIES + " failed: " + e.getMessage());
                if (attempt < MAX_RETRIES) {
                    System.err.println("MicrosoftGraphMailSender: retrying in " + (RETRY_DELAY_MS / 1000) + " seconds...");
                    try {
                        Thread.sleep(RETRY_DELAY_MS);
                    } catch (InterruptedException ie) {
                        Thread.currentThread().interrupt();
                        throw e;
                    }
                }
            }
        }
        System.err.println("MicrosoftGraphMailSender: all " + MAX_RETRIES + " attempts failed");
        throw lastException;
    }

    private void doSendMail(String fromUserIdOrUpn, List<String> toEmails, List<String> bccEmails,
                           String subject, String body, boolean bodyIsHtml, List<GraphAttachment> attachments) throws Exception {
        String token = getAccessToken();
        String userSegment = fromUserIdOrUpn.contains("@")
                ? URLEncoder.encode(fromUserIdOrUpn, StandardCharsets.UTF_8).replace("+", "%20")
                : fromUserIdOrUpn;
        String sendMailUrl = String.format(SEND_MAIL_URL_TEMPLATE, userSegment);

        String contentType = bodyIsHtml ? "HTML" : "Text";
        String jsonBody = buildSendMailJsonWithRecipientsAndAttachments(toEmails, bccEmails, subject, body, contentType, attachments);

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(sendMailUrl))
                .header("Authorization", "Bearer " + token)
                .header("Content-Type", "application/json")
                .POST(HttpRequest.BodyPublishers.ofString(jsonBody, StandardCharsets.UTF_8))
                .timeout(Duration.ofSeconds(60))
                .build();

        HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString(StandardCharsets.UTF_8));

        if (response.statusCode() != 202 && response.statusCode() != 200) {
            throw new RuntimeException("Send mail failed: " + response.statusCode() + " - " + response.body());
        }
    }

    public static final class GraphAttachment {
        public final String name;
        public final String contentId;  // null for non-inline
        public final String contentType;
        public final String contentBase64;

        public GraphAttachment(String name, String contentType, String contentBase64) {
            this(name, null, contentType, contentBase64);
        }

        public GraphAttachment(String name, String contentId, String contentType, String contentBase64) {
            this.name = name;
            this.contentId = contentId;
            this.contentType = contentType == null ? "application/octet-stream" : contentType;
            this.contentBase64 = contentBase64;
        }
    }

    private static String escapeJson(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }

    private static String buildSendMailJson(String toEmail, String subject, String body, String contentType) {
        return buildSendMailJsonWithRecipientsAndAttachments(
                List.of(toEmail), new ArrayList<>(), subject, body, contentType, new ArrayList<>());
    }

    private static String buildSendMailJsonWithRecipientsAndAttachments(
            List<String> toEmails, List<String> bccEmails, String subject, String body, String contentType,
            List<GraphAttachment> attachments) {
        StringBuilder sb = new StringBuilder();
        sb.append("{\n  \"message\": {\n");
        sb.append("    \"subject\": \"").append(escapeJson(subject)).append("\",\n");
        sb.append("    \"body\": {\n      \"contentType\": \"").append(contentType).append("\",\n");
        sb.append("      \"content\": \"").append(escapeJson(body)).append("\"\n    },\n");
        sb.append("    \"toRecipients\": [\n");
        boolean firstTo = true;
        for (String e : toEmails) {
            String addr = e == null ? "" : e.trim();
            if (addr.isEmpty()) continue;
            if (!firstTo) sb.append(",\n");
            sb.append("      { \"emailAddress\": { \"address\": \"").append(escapeJson(addr)).append("\" } }");
            firstTo = false;
        }
        sb.append("\n    ]");
        if (bccEmails != null && !bccEmails.isEmpty()) {
            sb.append(",\n    \"bccRecipients\": [\n");
            boolean firstBcc = true;
            for (String e : bccEmails) {
                String addr = e == null ? "" : e.trim();
                if (addr.isEmpty()) continue;
                if (!firstBcc) sb.append(",\n");
                sb.append("      { \"emailAddress\": { \"address\": \"").append(escapeJson(addr)).append("\" } }");
                firstBcc = false;
            }
            sb.append("\n    ]");
        }
        if (attachments != null && !attachments.isEmpty()) {
            sb.append(",\n    \"attachments\": [\n");
            for (int i = 0; i < attachments.size(); i++) {
                GraphAttachment a = attachments.get(i);
                if (i > 0) sb.append(",\n");
                sb.append("      { \"@odata.type\": \"#microsoft.graph.fileAttachment\", ");
                sb.append("\"name\": \"").append(escapeJson(a.name)).append("\", ");
                sb.append("\"contentType\": \"").append(escapeJson(a.contentType)).append("\", ");
                sb.append("\"contentBytes\": \"").append(a.contentBase64 == null ? "" : a.contentBase64).append("\"");
                if (a.contentId != null && !a.contentId.isEmpty()) {
                    sb.append(", \"contentId\": \"").append(escapeJson(a.contentId)).append("\", \"isInline\": true");
                }
                sb.append(" }");
            }
            sb.append("\n    ]");
        }
        sb.append("\n  }\n}");
        return sb.toString();
    }

    /**
     * Test entry point. Configure sender user and recipient for your tenant.
     * In production, use environment variables for client id, secret, and tenant.
     */
    public static void main(String[] args) {
        String clientId = System.getenv("GRAPH_CLIENT_ID");
        String clientSecret = System.getenv("GRAPH_CLIENT_SECRET");
        String tenantId = System.getenv("GRAPH_TENANT_ID");

        if (clientId == null || clientId.isBlank()) {
            clientId = "7ac6e9eb-abc5-4eb6-8cbd-34f07e16ab9b";
            System.out.println("Using default CLIENT_ID (set GRAPH_CLIENT_ID to override)");
        }
        if (clientSecret == null || clientSecret.isBlank()) {
            clientSecret = "0J48Q~lMGWnJDsYzAKpXXHSkdQzFeXT2U8ZtlajJ";
            System.out.println("Using default CLIENT_SECRET (set GRAPH_CLIENT_SECRET to override)");
        }
        if (tenantId == null || tenantId.isBlank()) {
            tenantId = "5bbb3432-fada-46ae-9b16-ed4929b5d4b3";
            System.out.println("Using default AUTH_TENANT (set GRAPH_TENANT_ID to override)");
        }

        MicrosoftGraphMailSender sender = new MicrosoftGraphMailSender(clientId, clientSecret, tenantId);

        String fromUser = "e.mubarak@iyelo.com";
        String toEmail = "e.mubarak@iyelo.com";
        if (fromUser == null || fromUser.isBlank()) {
            System.out.println("Usage: MicrosoftGraphMailSender <fromUserUpnOrId> <toEmail>");
            System.out.println("Example: MicrosoftGraphMailSender user@yourdomain.com recipient@example.com");
            System.out.println("  fromUserUpnOrId = User Principal Name or Object ID of the mailbox that sends the email");
            System.out.println("  toEmail         = Recipient email address");
            return;
        }
        if (toEmail == null || toEmail.isBlank()) {
            System.out.println("Please provide recipient email as second argument.");
            return;
        }

        String subject = "Test from Microsoft Graph Mail Sender";
        String body = "This is a test email sent via Microsoft Graph API (Java).";

        try {
            System.out.println("Getting access token...");
            String token = sender.getAccessToken();
            System.out.println("Token obtained (length=" + token.length() + ")");

            System.out.println("Sending email from " + fromUser + " to " + toEmail + "...");
            sender.sendMail(fromUser, toEmail, subject, body);
            System.out.println("Email sent successfully.");
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
