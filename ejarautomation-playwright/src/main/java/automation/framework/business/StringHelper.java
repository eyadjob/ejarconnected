package automation.framework.business;

import java.util.Random;

public class StringHelper {

    public static String getRandomStringOfSize(int stringSize) {
        String AlphaNumericStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvxyz";
        StringBuilder s = new StringBuilder(stringSize);
        for (int i = 0; i < stringSize; i++) {
            int ch = (int) (AlphaNumericStr.length() * Math.random());
            s.append(AlphaNumericStr.charAt(ch));
        }
        return s.toString();

    }

    public static String getRandomEmail() {
        String AlphaNumericStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvxyz";
        StringBuilder s = new StringBuilder(20);
        for (int i = 0; i < 20; i++) {
            int ch = (int) (AlphaNumericStr.length() * Math.random());
            s.append(AlphaNumericStr.charAt(ch));
        }
        return "AutomationUIEmail" + s + "@iYelo.com";

    }

    public static String getRandomNumberOfSize(int numberSize) {
        int leftLimit = 48; // letter 'a'
        int rightLimit = 57; // letter 'z'
        Random random = new Random();

        String generatedString = random.ints(leftLimit, rightLimit + 1).limit(numberSize).collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append).toString();
        return generatedString;
    }

    public static String getRandomPlateNumber(String countryName) {

        Random r = new Random();
        String pNo = "";
        String alpha = "abcdefghijklmnopqrstuvwxyz";
        if (countryName.equals("saudi"))
            pNo = alpha.charAt(r.nextInt(26)) + " " + alpha.charAt(r.nextInt(26)) + " " + alpha.charAt(r.nextInt(26)) + " " + r.nextInt(3) + r.nextInt(2) + r.nextInt(7) + r.nextInt(6);
        return pNo;
    }

    public static StringBuilder StringBuilderReplaceAll(StringBuilder sb, String target, String replacement) {
        if (target == null || target.isEmpty()) {
            throw new IllegalArgumentException("Target string cannot be null or empty");
        }

        if (replacement == null) {
            replacement = "";
        }

        int index = sb.indexOf(target);
        int targetLength = target.length();

        while (index != -1) {
            sb.replace(index, index + targetLength, replacement);
            index = sb.indexOf(target, index + replacement.length());
        }

        return sb;
    }

}
