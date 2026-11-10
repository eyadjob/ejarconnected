package automation.framework.business;

import automation.framework.propmanager.PropManager;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.*;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMultipart;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.*;
import java.util.stream.Collectors;

public class EmailHandler {

    private static final String GRAPH_CLIENT_ID = PropManager.getInstance().getProperty("onedrive.client.id");
    private static final String GRAPH_CLIENT_SECRET = PropManager.getInstance().getProperty("onedrive.client.secret");
    // The email-sending app registration lives in this Azure AD tenant.
    // OneDrive ROPC uses "consumers", so the tenant value is kept separate here.
    private static final String GRAPH_TENANT_ID = "5bbb3432-fada-46ae-9b16-ed4929b5d4b3";

    public static void main(String[] args) {
        EmailHandler emailHandler = new EmailHandler();
        emailHandler.sendReportEmail("Eyad Test Subject", "Eyad Test Body");
    }

    public Properties configEmailProperties() {
        Properties props = new Properties();
        props.put("mail.smtp.host", PropManager.getInstance().getProperty("email.smtp.host"));
        props.put("mail.smtp.port", PropManager.getInstance().getProperty("email.smtp.port"));
        props.put("mail.smtp.auth", PropManager.getInstance().getProperty("email.smtp.auth"));
        props.put("mail.smtp.socketFactory.port", "587");
        props.put("mail.smtp.socketFactory.class",
                "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");
        return props;
    }

    public MimeMultipart addFileAttachmentToEmail(MimeMultipart mimeMultipart, MimeBodyPart messageBodyPart, String filePath) {
        try {
            messageBodyPart.setFileName(new File(filePath).getName());
            mimeMultipart.addBodyPart(messageBodyPart);
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
        return mimeMultipart;
    }

    public void sendReportEmail(String emailSubject, String content, String attachmentFilePath) {
        sendReportEmail(emailSubject, content, attachmentFilePath, null);
    }

    public void sendReportEmail(String emailSubject, String content, String attachmentFilePath,
                                List<MicrosoftGraphMailSender.GraphAttachment> extraAttachments) {
        String fromUser = PropManager.getInstance().getProperty("email.user");
        List<String> toList = parseEmailList(PropManager.getInstance().getProperty("email.sendReportTo"));
        List<String> bccList = parseEmailList(PropManager.getInstance().getProperty("email.sendReportTo.BCC"));
        content = prepareReportEmailHtmlWithLogo(content);
        List<MicrosoftGraphMailSender.GraphAttachment> attachments = buildAutomationReportInlineAttachments(content);
        if (extraAttachments != null) {
            attachments.addAll(extraAttachments);
        }
        try {
            byte[] fileBytes = Files.readAllBytes(new File(attachmentFilePath).toPath());
            String base64 = Base64.getEncoder().encodeToString(fileBytes);
            String contentType = "application/octet-stream";
            String name = new File(attachmentFilePath).getName();
            if (name.toLowerCase().endsWith(".pdf")) contentType = "application/pdf";
            attachments.add(new MicrosoftGraphMailSender.GraphAttachment(name, contentType, base64));
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            MicrosoftGraphMailSender sender = new MicrosoftGraphMailSender(
                    resolveGraphCredential(GRAPH_CLIENT_ID),
                    resolveGraphCredential(GRAPH_CLIENT_SECRET),
                    resolveGraphCredential(GRAPH_TENANT_ID));
            sender.sendMailWithAttachments(fromUser, toList, bccList, emailSubject, content, attachments);
            System.out.println("Message sent.");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void sendReportEmail(String emailSubject, String content) {
        sendReportEmail(emailSubject, content, (List<MicrosoftGraphMailSender.GraphAttachment>) null);
    }

    public void sendReportEmail(String emailSubject, String content,
                                List<MicrosoftGraphMailSender.GraphAttachment> extraAttachments) {
        String fromUser = PropManager.getInstance().getProperty("email.user");
        List<String> toList = parseEmailList(PropManager.getInstance().getProperty("email.sendReportTo"));
        List<String> bccList = parseEmailList(PropManager.getInstance().getProperty("email.sendReportTo.BCC"));
        content = prepareReportEmailHtmlWithLogo(content);
        List<MicrosoftGraphMailSender.GraphAttachment> attachments = buildAutomationReportInlineAttachments(content);
        if (extraAttachments != null) {
            attachments.addAll(extraAttachments);
        }
        try {
            MicrosoftGraphMailSender sender = new MicrosoftGraphMailSender(
                    resolveGraphCredential(GRAPH_CLIENT_ID),
                    resolveGraphCredential(GRAPH_CLIENT_SECRET),
                    resolveGraphCredential(GRAPH_TENANT_ID));
            sender.sendMailWithAttachments(fromUser, toList, bccList, emailSubject, content, attachments);
            System.out.println("Message sent.");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void sendProductionReportEmail(String emailSubject, String content) {
        sendProductionReportEmail(emailSubject, content, (List<MicrosoftGraphMailSender.GraphAttachment>) null);
    }

    public void sendProductionReportEmail(String emailSubject, String content,
                                          List<MicrosoftGraphMailSender.GraphAttachment> extraAttachments) {
        String fromUser = PropManager.getInstance().getProperty("email.user");
        List<String> toList = parseEmailList(PropManager.getInstance().getProperty("email.sendProductionReportTo"));
        List<String> bccList = parseEmailList(PropManager.getInstance().getProperty("email.sendProductionReportTo.BCC"));
        content = prepareReportEmailHtmlWithLogo(content);
        List<MicrosoftGraphMailSender.GraphAttachment> attachments = buildAutomationReportInlineAttachments(content);
        if (extraAttachments != null) {
            attachments.addAll(extraAttachments);
        }
        try {
            MicrosoftGraphMailSender sender = new MicrosoftGraphMailSender(
                    resolveGraphCredential(GRAPH_CLIENT_ID),
                    resolveGraphCredential(GRAPH_CLIENT_SECRET),
                    resolveGraphCredential(GRAPH_TENANT_ID));
            sender.sendMailWithAttachments(fromUser, toList, bccList, emailSubject, content, attachments);
            System.out.println("Production report message sent.");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static String resolveGraphCredential(String value) {
        return (value == null || value.isBlank()) ? null : value.trim();
    }

    private static List<String> parseEmailList(String value) {
        if (value == null || value.isBlank()) return new ArrayList<>();
        return Arrays.stream(value.split(","))
                .map(String::trim)
                .filter(s -> !s.isEmpty())
                .collect(Collectors.toList());
    }

    /**
     * Inline attachments for the automation summary email: pie charts.
     * The logo is embedded directly in the HTML body (hosted URL or base64 data URI)
     * so it survives forwarding and works on Outlook mobile.
     */
    private static List<MicrosoftGraphMailSender.GraphAttachment> buildAutomationReportInlineAttachments(String htmlBody) {
        String baseDir = System.getProperty("user.dir");
        String chartDir = baseDir + File.separator + "chartTempFolder";
        List<MicrosoftGraphMailSender.GraphAttachment> list = new ArrayList<>();
        addInlineIfExists(list, chartDir + File.separator + RunResultsInformation.scenariosTestStatusPieChartName + ".png", "<testCasesStatusPieChart-icon>", "image/png");
        addInlineIfExists(list, chartDir + File.separator + RunResultsInformation.testStepsTestStatusPieChartName + ".png", "<testCasesStepsPieChart-icon>", "image/png");
        // Only add logo as inline attachment if HTML still references it (fallback when base64 embedding failed)
        if (htmlBody != null && htmlBody.contains("cid:high-logo")) {
            File logoFile = resolveReportLogoFile();
            if (logoFile != null) {
                try {
                    byte[] bytes = Files.readAllBytes(logoFile.toPath());
                    String base64 = Base64.getEncoder().encodeToString(bytes);
                    list.add(new MicrosoftGraphMailSender.GraphAttachment(logoFile.getName(), "high-logo", logoContentType(logoFile), base64));
                } catch (IOException e) {
                    System.err.println("EmailHandler: failed to read logo for inline attachment: " + e.getMessage());
                }
            }
        }
        return list;
    }

    /**
     * Resolves {@code src="cid:high-logo"} for the automation report:
     * 1. Uses {@code report.email.logo.url} if set (remote image - Outlook holds these behind
     *    the "show blocked content" prompt until the recipient allows images).
     * 2. Otherwise leaves {@code cid:high-logo} untouched so the logo travels with the message as
     *    an inline MIME part. Outlook ignores {@code data:} URIs entirely (broken image icon), so
     *    CID is the only variant that renders with no user interaction.
     */
    static String prepareReportEmailHtmlWithLogo(String htmlBody) {
        if (htmlBody == null || !htmlBody.contains("cid:high-logo")) {
            return htmlBody;
        }
        String hosted = PropManager.getInstance().getProperty("report.email.logo.url");
        if (hosted != null && !hosted.isBlank()) {
            return htmlBody.replace("src=\"cid:high-logo\"", "src=\"" + escapeHtmlAttr(hosted.trim()) + "\"");
        }
        return htmlBody;
    }

    private static String escapeHtmlAttr(String s) {
        return s.replace("&", "&amp;").replace("\"", "&quot;");
    }

    /** Yelo brand logo candidates shipped with the project; preferred over the legacy Qoad logo files. */
    private static final String[] YELO_LOGO_CANDIDATES = {
            "logos" + File.separator + "Yelo_logo_text_only.png",
            "logos" + File.separator + "Yelo_logo_text_only.webp",
            "logos" + File.separator + "yelo Logo - size reduced.jpg",
            "logos" + File.separator + "yelo Logo - Copy.jpg",
            "logos" + File.separator + "yelo Logo.jpg"
    };

    /** Prefer the Yelo logo; fall back to the legacy Qoad logo files. */
    private static File resolveReportLogoFile() {
        for (String candidate : YELO_LOGO_CANDIDATES) {
            File yeloLogo = new File(System.getProperty("user.dir") + File.separator + candidate);
            if (yeloLogo.isFile()) {
                return yeloLogo;
            }
        }
        File explicitLogo = new File(System.getProperty("user.dir") + File.separator + "email html" + File.separator + "Qoad logo.png");
        if (explicitLogo.isFile()) {
            return explicitLogo;
        }
        File dir = new File(System.getProperty("user.dir") + File.separator + "email html");
        String[] names = {"Qoad logo.png", "Qoad_logo.png", "qoad_logo.png"};
        for (String n : names) {
            File f = new File(dir, n);
            if (f.isFile()) {
                return f;
            }
        }
        return null;
    }

    /** MIME type matching the logo extension so inline and base64 images render in every client. */
    private static String logoContentType(File logoFile) {
        String name = logoFile.getName().toLowerCase(Locale.ROOT);
        if (name.endsWith(".jpg") || name.endsWith(".jpeg")) {
            return "image/jpeg";
        }
        if (name.endsWith(".webp")) {
            return "image/webp";
        }
        if (name.endsWith(".svg")) {
            return "image/svg+xml";
        }
        return "image/png";
    }

    private static void addInlineIfExists(List<MicrosoftGraphMailSender.GraphAttachment> list, String filePath, String contentId, String contentType) {
        File f = new File(filePath);
        if (!f.exists()) return;
        try {
            byte[] bytes = Files.readAllBytes(f.toPath());
            String base64 = Base64.getEncoder().encodeToString(bytes);
            list.add(new MicrosoftGraphMailSender.GraphAttachment(f.getName(), contentId, contentType, base64));
        } catch (Exception ignored) {
        }
    }

    public MimeMultipart addYeloEmailImages(MimeMultipart multipart) throws MessagingException {
        File yeloLogo = resolveReportLogoFile();
        addMultiPartFile(multipart, yeloLogo != null ? yeloLogo.getPath() : System.getProperty("user.dir") + "\\" + "email html" + "\\Qoad logo.png", "<high-logo>");
        addMultiPartFile(multipart, System.getProperty("user.dir") + "\\" + "email html" + "\\website-icon.png", "<web-icon>");
        addMultiPartFile(multipart, System.getProperty("user.dir") + "\\" + "email html" + "\\email.svg", "<email>");
        addMultiPartFile(multipart, System.getProperty("user.dir") + "\\" + "email html" + "\\mobile.svg", "<mobile>");
        addMultiPartFile(multipart, System.getProperty("user.dir") + "\\" + "email html" + "\\location.svg", "<location>");
        addMultiPartFile(multipart, System.getProperty("user.dir") + "\\" + "email html" + "\\facebook-icon.png", "<facebook-icon>");
        addMultiPartFile(multipart, System.getProperty("user.dir") + "\\" + "email html" + "\\twitter-icon.png", "<twitter-icon>");
        addMultiPartFile(multipart, System.getProperty("user.dir") + "\\" + "email html" + "\\linkedin-icon.png", "<linkedin-icon>");
        addMultiPartFile(multipart, System.getProperty("user.dir") + "\\" + "chartTempFolder" + "\\"+RunResultsInformation.scenariosTestStatusPieChartName+".png", "<testCasesStatusPieChart-icon>");
        addMultiPartFile(multipart, System.getProperty("user.dir") + "\\" + "chartTempFolder" + "\\"+ RunResultsInformation.testStepsTestStatusPieChartName+".png", "<testCasesStepsPieChart-icon>");
        return multipart;
    }

    public MimeMultipart addMultiPartFile(MimeMultipart multipart, String filePath, String fileId) throws MessagingException {
        MimeBodyPart messageBodyPart = new MimeBodyPart();
        DataSource linkedInLogo = new FileDataSource(filePath);
        messageBodyPart.setDataHandler(new DataHandler(linkedInLogo));
        messageBodyPart.setHeader("Content-ID", fileId);
        multipart.addBodyPart(messageBodyPart);
        return multipart;
    }
}
