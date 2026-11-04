package automation.framework.business;

import javax.mail.*;
import javax.mail.internet.MimeMultipart;
import java.io.IOException;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class EmailExtractor {

    public void deleteAllEmails(String email, String password) {
        Folder folder = null;
        try {
            Store store = getGmailStore(email, password);
            folder = store.getFolder("INBOX");
            folder.open(Folder.READ_WRITE);

            Message[] messages = folder.getMessages();

            folder.copyMessages(messages, store.getFolder("EYAD ARCHIVE"));

            for (Message m : messages) {
                m.setFlag(Flags.Flag.DELETED, true);
            }

            closeEmailSession(store, folder);
        } catch (MessagingException e) {
            System.out.println(e.getMessage());
        }
    }


    public String getTotalCurrency(String email, String password) {
        String finalCurrency = "no_value";
        String currency = "no_value";
        String bodyString = "";
        try {
            bodyString = getEmailBodyBySender("Qoad", email, password).getContent().toString();

            System.out.println(bodyString);
            Pattern p = Pattern.compile("(<b class=\"orangeText\">).+(\\/b>)");
            Matcher m = p.matcher(bodyString);
            String num = "";
            System.out.println(bodyString);
            while (m.find()) {
                currency = m.group(0).replaceAll("([+-]?([0-9]*[.])?[0-9]+)", "");
            }

            Pattern p2 = Pattern.compile("(<. .+>)(.+)(<\\/.>)");
            Matcher cu = p2.matcher(currency);
            cu.find();
            finalCurrency = cu.group(2).replaceAll("\\s", " ");
            System.out.println("the currency for the total price in the email was : " + finalCurrency);
            return finalCurrency;
        } catch (MessagingException | IOException e) {
            System.out.println("there was an exception in getting getRentalTotalFromLatestEmail in the related gmail account from latest email");
            e.printStackTrace();
        }
        return finalCurrency;
    }


    public Message getEmailBodyBySender(String subject, String email, String password) {
        String bodyString = "";
        Store store = getGmailStore(email, password);
        Folder folder = null;
        try {


            folder = store.getFolder("INBOX");
            folder.open(Folder.READ_ONLY);

            Message[] messages = folder.getMessages().clone();


            if (messages.length > 0) {
                for (int i = messages.length - 2; i < messages.length; i++) {
                    if (messages[i].getFrom()[0].toString().contains(subject.toLowerCase())) {
                        System.out.println("the messsage was found with the intended subject and returning it");
                        return messages[i];
                    }
                }
            }
        } catch (MessagingException e) {
            System.out.println("there was an exception in getting getEmailBodyBySubject in the related gmail account from latest email");

            e.printStackTrace();
        }
        closeEmailSession(store, folder);
        System.out.println("No message was found");
        return null;
    }


    public String getBookingReferenceAlwefaqEmail(String email, String password) {
        String num = "";

        String bodyString = null;
        try {
            bodyString = getEmailBodyBySender("Yelo", email, password).getContent().toString();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (MessagingException e) {
            e.printStackTrace();
        }

        Pattern p = Pattern.compile("(Booking Reference #|رقم الحجز)\\d+(<\\/b>)");
        Matcher m = p.matcher(bodyString);
        while (m.find()) {
            num = m.group(0).replaceAll("(?!([+-]?([0-9]*[.])?[0-9]+)).", "");
        }

        return num;
    }


    public String getBookingReferenceFromCancellationEmail(String email, String password) {
        String num = "";

        String bodyString = null;
        try {
            bodyString = getEmailBodyBySender("Yelo", email, password).getContent().toString();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (MessagingException e) {
            e.printStackTrace();
        }

        Pattern p = Pattern.compile("<b>(\\d.+)(معلومات الحجز)");
        Matcher m = p.matcher(bodyString);
        while (m.find()) {
            num = m.group(1).replaceAll("#", "").trim();
        }

        return num;
    }


    public String getActivationCode(String sender, String email, String password) {

        String num = "";

        String bodyString = null;
        try {
            bodyString = getEmailBodyBySender("Yelo", email, password).getContent().toString();
        } catch (IOException | MessagingException e) {
            e.printStackTrace();
        }
        System.out.println("email body is : " + bodyString);
        Pattern p = Pattern.compile("<span class=\"verificationCode\"><b>([0-9]{4})</b></span>");
        Matcher verificationCode = p.matcher(bodyString);


        while (verificationCode.find()) {
            return verificationCode.group(1);
        }

        System.out.println("we reached returning num");
        return num;
    }


    public String getResetPasswordLink(String sender, String email, String password) {
        String num = "";
        String bodyString = null;
        try {
            bodyString = getEmailBodyBySender(sender, email, password).getContent().toString();
        } catch (IOException | MessagingException e) {
            e.printStackTrace();
        }
        System.out.println("email body is : " + bodyString);
        Pattern p = Pattern.compile("<a href=\"(.+ResetPassword.+?)\"");
        Matcher forgetPassowrdLink = p.matcher(bodyString != null ? bodyString : "");

        while (forgetPassowrdLink.find()) {
            return forgetPassowrdLink.group(1);
        }
        System.out.println("we reached returning num and we shouldn't reach it!");
        return num;
    }


    public String getEmailBodyFromPayEmail(String email, String password) {
        String num = "";
        String bodyString = null;
        try {
            bodyString = ((MimeMultipart) getEmailBodyBySender("payfort", email, password).getContent()).getBodyPart(0).getContent().toString();
        } catch (IOException | MessagingException e) {
            e.printStackTrace();
        }
        return bodyString;
    }


    public void closeEmailSession(Store store, Folder folder) {
        try {
            folder.close(true);
            store.close();
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }


    public int getEmailsCount(String email, String password) {
        Store store = getGmailStore(email, password);
        Folder folder = null;
        try {
            folder = store.getFolder("INBOX");
            folder.open(Folder.READ_ONLY);
            int count = folder.getMessages().length;
            closeEmailSession(store, folder);
            return count;
        } catch (MessagingException e) {
            System.out.println("there was an exception in getting emails size in the related gmail account");
            closeEmailSession(store, folder);
            e.printStackTrace();
        }
        return -2;
    }


    public double getRentalTotalFromLatestEmail(String email, String password) {

        double rentInEmail = -1;
        try {
            Folder folder = null;
            Store store = getGmailStore(email, password);
            folder = store.getFolder("INBOX");
            folder.open(Folder.READ_ONLY);

            Message[] messages = folder.getMessages().clone();


            String bodyString = messages[messages.length - 1].getContent().toString();
            closeEmailSession(store, folder);

            Pattern p = Pattern.compile("(<b class=\"orangeText\">).+(<\\/b>)");
            Matcher m = p.matcher("the email body was : " + bodyString);
            String num = "";
            while (m.find()) {
                num = m.group(0).replaceAll("(?!([+-]?([0-9]*[.])?[0-9]+)).", "");
            }


            rentInEmail = Double.parseDouble(num);
            System.out.println("total of rent in email was : " + rentInEmail);
            return rentInEmail;
        } catch (MessagingException | IOException e) {
            System.out.println("there was an exception in getting getRentalTotalFromLatestEmail in the related gmail account from latest email");
            System.out.println(e.getMessage());
        }
        return rentInEmail;
    }

    public String getLatestEmailSubject(String subject, String email, String password) {

        String bodyString = "";
        try {
            Folder folder = null;
            Store store = getGmailStore(email, password);
            folder = store.getFolder("INBOX");
            folder.open(Folder.READ_ONLY);

            Message[] messages = folder.getMessages().clone();


            for (int i = messages.length - 2; i < messages.length; i++) {
                if (messages[i].getFrom()[0].toString().contains(subject.toLowerCase())) {

                    return messages[i].getSubject();
                }
            }
            closeEmailSession(store, folder);
        } catch (MessagingException e) {
            System.out.println("there was an exception in getting getEmailBodyBySubject in the related gmail account from latest email");
            e.printStackTrace();
        }

        return null;
    }


    public Store getGmailStore(String email, String password) {

        Properties props = new Properties();
        props.put("mail.smtp.host", "Smtp.gmail.com");
        props.put("mail.smtp.port", "25");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        try {
            Session session = Session.getDefaultInstance(props,
                    new Authenticator() {
                        protected PasswordAuthentication getPasswordAuthentication() {
                            return new PasswordAuthentication(email, password);
                        }
                    });

            Store store = session.getStore("imaps");
            store.connect("Smtp.gmail.com", email, password);
            return store;
        } catch (Exception e) {
            System.out.println("we have an issue in getGmailStore ");
            System.out.println(e.getMessage());
        }

        return null;
    }
}
