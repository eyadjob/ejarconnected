package automation.framework.listener;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

public class DateHelper {
    public DateHelper() {
    }

    public static String getElapsedTime(Date startDate, Date endDate) {
        long difference_In_Time = endDate.getTime() - startDate.getTime();
        long difference_In_Seconds = difference_In_Time / 1000L % 60L;
        long difference_In_Minutes = difference_In_Time / 60000L % 60L;
        long difference_In_Hours = difference_In_Time / 3600000L % 24L;
        long difference_In_Years = difference_In_Time / 31536000000L;
        long difference_In_Days = difference_In_Time / 86400000L % 365L;
        System.out.println(difference_In_Years + " years, " + difference_In_Days + " days, " + difference_In_Hours + " hours, " + difference_In_Minutes + " minutes, " + difference_In_Seconds + " seconds");
        return getNumberWithFormat(difference_In_Hours, "##.##") + ":" + getNumberWithFormat(difference_In_Minutes, "##") + ":" + getNumberWithFormat(difference_In_Seconds, "##");
    }

    public static String getElapsedTimeInSeconds(Date startDate, Date endDate) {
        long difference_In_Time = endDate.getTime() - startDate.getTime();
        double difference_In_Seconds = (double)difference_In_Time / 1000.0D % 60.0D;
        String result = getNumberWithFormat(difference_In_Seconds, "##.##");
        return result.equals("0") ? "0.00" : result;
    }

    public static String getCurrentDatePlusDays(int daysNum) {
        Date d = new Date();
        Calendar cal = Calendar.getInstance();
        cal.setTime(d);
        cal.add(Calendar.DAY_OF_MONTH, daysNum);
        d = cal.getTime();
        String pattern = "YYYY-MM-dd";
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
        return simpleDateFormat.format(d);
    }

    public static String getCurrentDatePlusDays(int daysNum, String dateFormat) {
        Date d = new Date();
        Calendar cal = Calendar.getInstance();
        cal.setTime(d);
        cal.add(Calendar.DAY_OF_MONTH, daysNum);
        d = cal.getTime();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(dateFormat);
        return simpleDateFormat.format(d);
    }

    public static String getCurrentDatePlusDaysAndHours(int daysNum, int hoursNum, String dateFormat) {
        Date d = new Date();
        Calendar cal = Calendar.getInstance();
        cal.setTime(d);
        cal.add(5, daysNum);
        cal.add(11, hoursNum);
        d = cal.getTime();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(dateFormat);
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
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(dateFormat);
        return simpleDateFormat.format(d);
    }

    public static String getNumberWithFormat(long number, String pattern) {
        Locale locale = new Locale("en", "US");
        DecimalFormat decimalFormat = (DecimalFormat)NumberFormat.getNumberInstance(locale);
        decimalFormat.applyPattern(pattern);
        return decimalFormat.format(number);
    }

    public static String getNumberWithFormat(double number, String pattern) {
        Locale locale = new Locale("en", "US");
        DecimalFormat decimalFormat = (DecimalFormat)NumberFormat.getNumberInstance(locale);
        decimalFormat.applyPattern(pattern);
        return decimalFormat.format(number);
    }

    public static String getDateInFormat(Date date, String format) {
        return (new SimpleDateFormat(format)).format(date);
    }

    public static String getCurrentMonthName() {
        Date da = new Date();
        SimpleDateFormat format = new SimpleDateFormat("MMMM");
        format.format(da);
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
        cal.add(5, 30);
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("MMMM-dd");
        String re = simpleDateFormat.format(cal.getTime());
        return re;
    }
}
