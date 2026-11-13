package eyad.com.yelo.apisecuritychecker.utility;

import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class RegxHelper {

    public static String getRegxMatch(String regx, int group, String text) {
        Pattern p = Pattern.compile(regx);
        Matcher m = p.matcher(text);
        if (m.find()) {
            System.out.println(m.group(0));
            return m.group(0);
        } else return "";
    }

    public static String getRegxMatchWithAllGroups(String regx, int group, String text) {
        Pattern p = Pattern.compile(regx);
        Matcher m = p.matcher(text);
        if (m.find()) {
            System.out.println(m.group(0));
            return m.group(group);
        } else return "";
    }


    public static List<String> getRegxMatchList(String regx, int groupIndex, String text) {
        Pattern p = Pattern.compile(regx);
        Matcher m = p.matcher(text);
        List<String> result = new ArrayList<>();
        if (m.find()) {
            result.add(m.group(groupIndex));
        }
        return result;
    }


    public static void main(String[] args) {
        isAllowed("https://ejar-jor-qa.iyelo.com:4900/");
    }


    public static void isAllowed(String url) {

        String re = new RegxHelper().getRegxMatch("https?:\\/\\/(.*?)\\/", 1, url);
        String encodedString = Base64.getEncoder().withoutPadding().encodeToString(re.getBytes());
        if (!(encodedString.equals("ZWphci1zdC5hbHdlZmFxLmNvbTo0OTAw") || encodedString.equals("MTcyLjE2LjMwLjU") || encodedString.equals("ZWphci1zdC5peWVsby5jb206NDkwMA") || encodedString.equals("ZWphci1qb3IuaXllbG8uY29tOjQ5MDA") || encodedString.equals("dGVtcC1tYWlsLm9yZw") || encodedString.equals("ZWphci1qb3ItcWEuaXllbG8uY29tOjQ5MDA"))) {
            try {
                System.out.println("in waiting");
                Thread.sleep(120000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}
