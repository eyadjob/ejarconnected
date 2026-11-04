package automation.framework;

import automation.framework.business.RegxHelper;
import automation.framework.propmanager.PropManager;

import javax.mail.*;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import java.io.IOException;
import java.util.Properties;

public class EmailValidator {

    final String password = "Guess.241021";
    final String email = "bssqa.automation@iyelo.com";

    public EmailValidator(String email, String password) {
        //this.password = password;
        //this.email = email;

    }

    public static void main(String[] args) {

        //EmailValidator emailValidator = new EmailValidator("alwefaqbooking10@gmail.com", "thesame1");
//        emailValidator.getBookingReferenceFromCancellationEmail("alwefaq");
        //emailValidator.getRentalTotalFromLatestEmail("alwefaq");
        //emailValidator.getTotalCurrency("alwefaq");
    }

    public Properties configEmailProperties() {
        Properties props = new Properties();
        props.put("mail.smtp.host", PropManager.getInstance().getProperty("email.smtp.host"));
        props.put("mail.smtp.port", PropManager.getInstance().getProperty("email.smtp.port"));
        props.put("mail.smtp.auth", PropManager.getInstance().getProperty("email.smtp.auth"));
        props.put("mail.transport.protocol", "smtp");
        props.put("mail.smtp.starttls.required", "true");
        props.put("mail.smtp.ssl.enable", "true");
        props.put("mail.smtp.starttls.enable", "true");
        return props;
    }

    public Properties configOutlookEmailProperties() {
        Properties props = new Properties();
        props.setProperty("mail.imaps.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        props.setProperty("mail.imaps.socketFactory.fallback", "false");
        props.setProperty("mail.imaps.port", "25");
        props.setProperty("mail.imaps.socketFactory.port", "25");
        return props;
    }

    public Session getConnectionSession() {
        Session session = null;
        try {
            session = Session.getDefaultInstance(this.configEmailProperties(), new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(email, password);
                }
            });
        } catch (Exception e) {
            System.out.println("We have exception in email session connecting: " + e.getMessage());
        }
        return session;
    }

    public Session getOutlookConnectionSession() {
        Session session = null;
        try {
            session = Session.getDefaultInstance(this.configOutlookEmailProperties(), new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(email, password);
                }
            });
        } catch (Exception e) {
            System.out.println("We have exception in email session connecting: " + e.getMessage());
        }
        return session;
    }

    public void closeEmailSession(Store store, Folder folder) {
        try {
            folder.close(true);
            store.close();
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }


    public MimeMultipart getMimeMultipart(Session session) {
        Message msg = new MimeMessage(session);
        MimeMultipart multipart = new MimeMultipart("related");
        return multipart;
    }

    public Folder getStoreFolder(String folderName) {
        Folder folder = null;
        try {
            folder = getGmailStore().getFolder(folderName);
            return folder;
        } catch (MessagingException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Store getGmailStore() {
        Store store = null;
        try {
            store = getConnectionSession().getStore("imaps");
            store.connect("Smtp.gmail.com", email, password);
            return store;
        } catch (MessagingException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Folder getOutlookStoreFolder(String folderName) {
        Folder folder = null;
        try {
            folder = getOutlookStore().getFolder(folderName);
            return folder;
        } catch (MessagingException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Store getOutlookStore() {
        Store store = null;
        try {
            store = getOutlookConnectionSession().getStore("imaps");
            store.connect("mail.iyelo.com", this.email, this.password);
            return store;
        } catch (MessagingException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Message[] getMessagesFromFolder() {
        Folder folder = getStoreFolder("INBOX");
        try {
            folder.open(Folder.READ_WRITE);
            Message[] messages = folder.getMessages();
            return messages;
        } catch (MessagingException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void deleteAllEmails(String email, String password) {
        try {
            Folder folder = getStoreFolder("INBOX");
            Message[] messages = getMessagesFromFolder();
            folder.copyMessages(messages, getStoreFolder("EYAD ARCHIVE"));
            for (Message m : messages) {
                m.setFlag(Flags.Flag.DELETED, true);
            }
            closeEmailSession(folder.getStore(), folder);
        } catch (MessagingException e) {
            System.out.println(e.getMessage());
        }
    }

    public Message getEmailBodyBySubject(String from) {
        Folder folder = null;
        try {
            folder = getStoreFolder("INBOX");
            folder.open(Folder.READ_ONLY);
            Message[] messages = folder.getMessages().clone();
            if (messages.length > 0) {
                for (int i = messages.length - 2; i < messages.length; i++) {
                    if (messages[i].getFrom()[0].toString().contains(from.toLowerCase())) {
                        System.out.println("the message was found with the intended subject and returning it");
                        return messages[i];
                    }
                }
            }
        } catch (MessagingException e) {
            System.out.println("there was an exception in getting getEmailBodyBySubject in the related gmail account from latest email");

            e.printStackTrace();
        }
        closeEmailSession(folder.getStore(), folder);
        return null;
    }

    public String getTotalCurrency(String from) {
        String finalCurrency = "no_value";
        String currency = "no_value";
        String bodyString = "";
        try {
            bodyString = getEmailBodyBySubject("alwefaq").getContent().toString();
            currency = new RegxHelper().getRegxMatch("(<b class=\"orangeText\">).+(<\\/b>)", 0, bodyString).replaceAll("([+-]?([0-9]*[.])?[0-9]+)", "");
            finalCurrency = new RegxHelper().getRegxMatch("(<. .+>)(.+)(<\\/.>)", 2, currency).replaceAll("\\s", " ").trim();
            System.out.println("the currency for the total price in the email was: " + finalCurrency);
            return finalCurrency;
        } catch (MessagingException | IOException e) {
            System.out.println("there was an exception in getting getRentalTotalFromLatestEmail in the related gmail account from latest email" + e.getMessage());
        }
        return finalCurrency;
    }

    public double getRentalTotalFromLatestEmail(String from) {

        double rentInEmail = -1;
        try {
            String bodyString = getEmailBodyBySender(from).getContent().toString();

            rentInEmail = Double.parseDouble(new RegxHelper().getRegxMatch("(<b class=\"orangeText\">).+(<\\/b>)", 0, bodyString).replaceAll("(?!([+-]?([0-9]*[.])?[0-9]+)).", ""));
            System.out.println("total of rent in email was : " + rentInEmail);
            return rentInEmail;
        } catch (MessagingException | IOException e) {
            System.out.println("there was an exception in getting getRentalTotalFromLatestEmail in the related gmail account from latest email");
            System.out.println(e.getMessage());
        }
        return rentInEmail;
    }

    public String getResetPasswordLink(String subject) {
        String resetPasswordLink = "";
        try {
            String bodyString = getEmailBodyBySubject2(subject).getContent().toString();
            resetPasswordLink = new RegxHelper().getRegxMatch("<a href=\"(.*ResetPassword.*)\" style.*>(.*)<\\/a>", 1, bodyString);
            System.out.println("The rest password link is: " + resetPasswordLink);
            return resetPasswordLink;
        } catch (MessagingException | IOException e) {
            System.out.println("there was an exception in getting getResetPasswordLink in the related gmail account from latest email");
            System.out.println(e.getMessage());
        }
        return resetPasswordLink;
    }

    public String getActivationCode(String subject) {
        String activationCode = "";
        String bodyString = "";
        try {
            bodyString = getEmailBodyBySubject2(subject).getContent().toString();
            activationCode = new RegxHelper().getRegxMatch("<span class=\"verificationCode\"><b>([0-9]{4})</b></span>", 1, bodyString);
        } catch (IOException | MessagingException e) {
            e.printStackTrace();
        }
        System.out.println("activationCode is: " + activationCode);
        return activationCode;
    }

    public String getBookingReferenceFromEmail(String from) {

        String bookingReference = "";
        try {
            String bodyString = getEmailBodyBySender(from).getContent().toString();
            bookingReference = new RegxHelper().getRegxMatch("(\\w.+)(|\\s*)(ﻣﻌﻠﻮﻣﺎﺕ ﺍﻟﺤﺠﺰ)", 1, bodyString).replaceAll("#", "").trim();
        } catch (IOException | MessagingException e) {
            e.printStackTrace();
        }
        return bookingReference;
    }

    public String getRefundAmountAfterCancel(String subject) {
        String refundAmount = "";
        try {
            String bodyString = getEmailBodyBySubject2(subject).getContent().toString();
            refundAmount = new RegxHelper().getRegxMatch("<a href=\"(.*ResetPassword.*)\" style.*>(.*)<\\/a>", 1, bodyString);
            System.out.println("Refund Amount is: " + refundAmount);
            return refundAmount;
        } catch (MessagingException | IOException e) {
            System.out.println("there was an exception in getting refund Amount in the related gmail account from latest email");
            System.out.println(e.getMessage());
        }
        return refundAmount;
    }

    public Message getEmailBodyBySender(String subject) {
        Folder folder = null;
        try {
            folder = getStoreFolder("INBOX");
            folder.open(Folder.READ_ONLY);
            Message[] messages = folder.getMessages().clone();
            if (messages.length > 0) {
                for (int i = messages.length - 2; i < messages.length; i++) {
                    if (messages[i].getFrom()[0].toString().contains(subject.toLowerCase())) {
                        System.out.println("the message was found with the intended subject and returning it");
                        return messages[i];
                    }
                }
            }
        } catch (MessagingException e) {
            System.out.println("there was an exception in getting getEmailBodyBySubject in the related gmail account from latest email");

            e.printStackTrace();
        }
        closeEmailSession(folder.getStore(), folder);
        System.out.println("No message was found");
        return null;
    }

    public Message getEmailBodyBySubject2(String subject) {
        Folder folder = null;
        try {
            folder = getOutlookStoreFolder("INBOX");
            folder.open(Folder.READ_ONLY);
            Message[] messages = folder.getMessages().clone();
            if (messages.length > 0) {
                for (int i = messages.length - 2; i < messages.length; i++) {
                    if (messages[i].getSubject().toLowerCase().toString().contains(subject.toLowerCase())) {
                        System.out.println("the message was found with the intended subject and returning it");
                        return messages[i];
                    }
                }
            }
        } catch (MessagingException e) {
            System.out.println("there was an exception in getting getEmailBodyBySubject in the related gmail account from latest email");

            e.printStackTrace();
        }
        closeEmailSession(folder.getStore(), folder);
        System.out.println("No message was found");
        return null;
    }

    public String getLatestEmailSubject(String subject, String email, String password) {
        Folder folder = null;
        try {
            folder = getStoreFolder("INBOX");
            folder.open(Folder.READ_ONLY);
            Message[] messages = folder.getMessages().clone();
            for (int i = messages.length - 2; i < messages.length; i++) {
                if (messages[i].getFrom()[0].toString().contains(subject.toLowerCase())) {
                    return messages[i].getSubject();
                }
            }
        } catch (MessagingException e) {
            System.out.println("there was an exception in getting getEmailBodyBySubject in the related gmail account from latest email");
            e.printStackTrace();
        }
        closeEmailSession(folder.getStore(), folder);
        return null;
    }

}
