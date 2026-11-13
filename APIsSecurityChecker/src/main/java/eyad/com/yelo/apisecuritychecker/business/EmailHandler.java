package eyad.com.yelo.apisecuritychecker.business;

import java.io.File;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Base64;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Sends the report emails through Microsoft Graph (client credentials flow), using the
 * same account and logic as the ejarautomation-playwright project, instead of the old
 * Gmail SMTP flow.
 */
public class EmailHandler {

    private static final String GRAPH_CLIENT_ID = PropManager.getInstance().getProperty("onedrive.client.id");
    private static final String GRAPH_CLIENT_SECRET = PropManager.getInstance().getProperty("onedrive.client.secret");
    // The email-sending app registration lives in this Azure AD tenant; used when
    // "onedrive.tenant.id" is not set in the properties files.
    private static final String DEFAULT_GRAPH_TENANT_ID = "5bbb3432-fada-46ae-9b16-ed4929b5d4b3";

    public static void main(String[] args) {
        EmailHandler emailHandler = new EmailHandler();
        emailHandler.sendReportEmail("Eyad Test Subject", "Eyad Test Body", "alert.email.to");
    }

    public void sendReportEmail(String emailSubject, String content) {
        sendViaGraph(emailSubject, content,
                parseEmailList(PropManager.getInstance().getProperty("security.report.email.to")),
                new ArrayList<>());
    }

    public void sendReportEmail(String emailSubject, String content, String sendEmailToProperty) {
        sendViaGraph(emailSubject, content,
                parseEmailList(PropManager.getInstance().getProperty(sendEmailToProperty)),
                new ArrayList<>());
    }

    private void sendViaGraph(String emailSubject, String content, List<String> toList, List<String> bccList) {
        if (content == null || content.trim().isEmpty()) {
            System.out.println("Error: Cannot send email with empty content.");
            return;
        }

        if (emailSubject == null || emailSubject.trim().isEmpty()) {
            emailSubject = "API Security Validation Report";
        }

        String fromUser = PropManager.getInstance().getProperty("email.user");
        if (fromUser == null || fromUser.isEmpty()) {
            System.out.println("Error: email.user is not configured properly.");
            return;
        }

        if (toList.isEmpty()) {
            System.out.println("Error: Recipient email address is not configured.");
            return;
        }

        content = content.replace("CurrentYearVariable", String.valueOf(java.time.Year.now().getValue()));
        List<MicrosoftGraphMailSender.GraphAttachment> attachments = buildInlineIconAttachments(content);

        try {
            MicrosoftGraphMailSender sender = new MicrosoftGraphMailSender(
                    resolveGraphCredential(GRAPH_CLIENT_ID),
                    resolveGraphCredential(GRAPH_CLIENT_SECRET),
                    resolveGraphCredential(resolveTenantId()));
            sender.sendMailWithAttachments(fromUser, toList, bccList, emailSubject, content, attachments);
            System.out.println("Message sent successfully to: " + String.join(", ", toList));
        } catch (Exception e) {
            System.out.println("Error sending email: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private static String resolveTenantId() {
        String tenantId = PropManager.getInstance().getProperty("onedrive.tenant.id");
        return (tenantId == null || tenantId.isEmpty()) ? DEFAULT_GRAPH_TENANT_ID : tenantId;
    }

    private static String resolveGraphCredential(String value) {
        return (value == null || value.trim().isEmpty()) ? null : value.trim();
    }

    private static List<String> parseEmailList(String value) {
        if (value == null || value.trim().isEmpty()) return new ArrayList<>();
        return Arrays.stream(value.split(","))
                .map(String::trim)
                .filter(s -> !s.isEmpty())
                .collect(Collectors.toList());
    }

    /** Prefer the branded file name {@code Yelo logo.png}; fall back to legacy names. */
    private static File resolveYeloLogoFile() {
        File dir = new File(System.getProperty("user.dir") + File.separator + "email html");
        String[] names = {"Yelo logo.png", "Yelo_logo.png", "yelo_logo.png"};
        for (String n : names) {
            File f = new File(dir, n);
            if (f.isFile()) {
                return f;
            }
        }
        return null;
    }

    /**
     * Inline attachments for the images the report HTML references through
     * {@code cid:} (the Yelo logo, plus the legacy footer icons when present).
     * Base64 data-URIs are blocked by Gmail/Outlook, so images are attached
     * with a matching contentId instead of being inlined.
     */
    private static List<MicrosoftGraphMailSender.GraphAttachment> buildInlineIconAttachments(String htmlBody) {
        String baseDir = System.getProperty("user.dir") + File.separator + "email html" + File.separator;
        List<MicrosoftGraphMailSender.GraphAttachment> list = new ArrayList<>();
        addInlineIfReferenced(list, htmlBody, baseDir + "email.svg", "email", "image/svg+xml");
        addInlineIfReferenced(list, htmlBody, baseDir + "mobile.svg", "mobile", "image/svg+xml");
        addInlineIfReferenced(list, htmlBody, baseDir + "location.svg", "location", "image/svg+xml");
        if (htmlBody != null && htmlBody.contains("cid:high-logo")) {
            File logoFile = resolveYeloLogoFile();
            if (logoFile != null) {
                addInlineIfExists(list, logoFile.getPath(), "high-logo", "image/png");
            }
        }
        return list;
    }

    private static void addInlineIfReferenced(List<MicrosoftGraphMailSender.GraphAttachment> list, String htmlBody,
                                              String filePath, String contentId, String contentType) {
        if (htmlBody == null || !htmlBody.contains("cid:" + contentId)) return;
        addInlineIfExists(list, filePath, contentId, contentType);
    }

    private static void addInlineIfExists(List<MicrosoftGraphMailSender.GraphAttachment> list, String filePath,
                                          String contentId, String contentType) {
        File f = new File(filePath);
        if (!f.exists()) return;
        try {
            byte[] bytes = Files.readAllBytes(f.toPath());
            String base64 = Base64.getEncoder().encodeToString(bytes);
            list.add(new MicrosoftGraphMailSender.GraphAttachment(f.getName(), contentId, contentType, base64));
        } catch (Exception ignored) {
        }
    }
}
