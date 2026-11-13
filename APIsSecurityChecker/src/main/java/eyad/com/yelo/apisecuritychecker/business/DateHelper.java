package eyad.com.yelo.apisecuritychecker.business;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

public class DateHelper {

    public static String getElapsedTime(Date startDate, Date endDate) {

        long difference_In_Time
                = endDate.getTime() - startDate.getTime();
        long difference_In_Seconds
                = (difference_In_Time
                / 1000)
                % 60;

        long difference_In_Minutes
                = (difference_In_Time
                / (1000 * 60))
                % 60;

        long difference_In_Hours
                = (difference_In_Time
                / (1000 * 60 * 60))
                % 24;

        long difference_In_Years
                = (difference_In_Time
                / (1000L * 60 * 60 * 24 * 365));

        long difference_In_Days
                = (difference_In_Time
                / (1000 * 60 * 60 * 24))
                % 365;
        System.out.println(
                difference_In_Years
                        + " years, "
                        + difference_In_Days
                        + " days, "
                        + difference_In_Hours
                        + " hours, "
                        + difference_In_Minutes
                        + " minutes, "
                        + difference_In_Seconds
                        + " seconds");

        return getNumberWithFormat(difference_In_Hours, "##.##")
                + ":" + getNumberWithFormat(difference_In_Minutes, "##") + ":" + getNumberWithFormat(difference_In_Seconds, "##");
    }

    public static String getElapsedTimeInSeconds(Date startDate, Date endDate) {
        long difference_In_Time = endDate.getTime() - startDate.getTime();
        double difference_In_Seconds = (difference_In_Time / (double) 1000) % 60;
        String result = getNumberWithFormat(difference_In_Seconds, "##.##");
        return result.equals("0") ? "0.00" : result;
    }

    public static String getCurrentDatePlusDays(int daysNum) {
        Date d = new Date();
        Calendar cal = Calendar.getInstance();
        cal.setTime(d);
        cal.add(Calendar.HOUR_OF_DAY, daysNum); //
        d = cal.getTime(); // returns new date
        String pattern = "YYYY-MM-dd";
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
        return simpleDateFormat.format(d);
    }

    public static String getCurrentDatePlusDays(int daysNum, String dateFormat) {
        Date d = new Date();
        Calendar cal = Calendar.getInstance();
        cal.setTime(d);
        cal.add(Calendar.DAY_OF_MONTH, daysNum); //
        d = cal.getTime();
        String pattern = dateFormat;
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
        return simpleDateFormat.format(d);
    }


    public static String getCurrentDatePlusDaysAndHours(int daysNum, int hoursNum, String dateFormat) {
        Date d = new Date();
        Calendar cal = Calendar.getInstance();
        cal.setTime(d);
        cal.add(Calendar.DAY_OF_MONTH, daysNum);
        cal.add(Calendar.HOUR_OF_DAY, hoursNum);
        d = cal.getTime();
        String pattern = dateFormat;
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
        return simpleDateFormat.format(d);
    }


    public static String getCurrentDatePlusDaysOrHoursOrMinutes(int daysNum, int hoursNum, int minutes, String dateFormat) {
        Date d = new Date();
        Calendar cal = Calendar.getInstance();
        cal.setTime(d);
        cal.add(Calendar.DAY_OF_MONTH, daysNum);
        cal.add(Calendar.HOUR_OF_DAY, hoursNum);
        cal.add(Calendar.MINUTE, minutes);
        d = cal.getTime();
        String pattern = dateFormat;
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
        return simpleDateFormat.format(d);
    }


    public static String getNumberWithFormat(long number, String pattern) {
        Locale locale = new Locale("en", "US");
        DecimalFormat decimalFormat = (DecimalFormat) NumberFormat.getNumberInstance(locale);
        decimalFormat.applyPattern(pattern);
        return decimalFormat.format(number);
    }

    public static String getNumberWithFormat(double number, String pattern) {
        Locale locale = new Locale("en", "US");
        DecimalFormat decimalFormat = (DecimalFormat) NumberFormat.getNumberInstance(locale);
        decimalFormat.applyPattern(pattern);
        return decimalFormat.format(number);
    }


    public static String getDateInFormat(Date date, String format) {
        return new SimpleDateFormat(format).format(date);
    }

    public static String getCurrentMonthName() {
        Date da = new Date();
        SimpleDateFormat format = new SimpleDateFormat("MMMM");
        String dateString = format.format(da);
        return da.toString();
    }

    public static String getNextMonthName() {
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("MMMM");
        String nextMonth = sdf.format(cal.getTime());
        return nextMonth;

    }

    public static String getNextMonthDate() {

        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DAY_OF_MONTH, 30);
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("MMMM-dd");
        String re = simpleDateFormat.format(cal.getTime());
        return re;
    }
}
