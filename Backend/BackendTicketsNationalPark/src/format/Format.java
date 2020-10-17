/*
 * PROJECT: TICKETS NATIONAL PARK.
 * LUIS J. BRAVO ZUÑIGA.
 * FORMAT CLASS.
 */
package format;

import exception.MyException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import logicBusiness.Purchase;
import logicBusiness.Reservation;

public class Format {

    private static final String FORMAT_OUTPUT_PURCHASE
            = "id: %d%nid purchaser: %s%nfirst name: %s%n"
            + "last name: %s%nemail: %s%ntelephone: %s%n"
            + "quantity of tickets: %s%nreservation date: %s%n"
            + "total: $%3.2f%ncheck out: %s%n";

    private static final String FORMAT_OUTPUT_USER = "username: %s%npassword %s%n";

    private static final String FORMAT_OUTPUT_RESERVATION
            = "id: %s%ntickets available: %s%n"
            + "tickets sold: %s%nactive: %s%n";
    
    private static final String FORMAT_OUTPUT_LIST = "[%d]%n%s%n";
    
    private static final String NO_DATA_MESSAGE = "No data for show";

    private static final String YES = "YES";

    private static final String NO = "NO";

    private static final String ACTIVE = "A";

    private static final String INACTIVE = "I";

    private static final String FORMAT_DATE = "%s-%s-%s";
    
    private static final SimpleDateFormat FORMAT_DATE_SIMPLE = new SimpleDateFormat("dd-MM-yyyy"),
            FORMAT_DATE_COMPLETE = new SimpleDateFormat("dd-MM-yyyy hh:mm:ss");

    public static String GET_FORMAT_OUTPUT_PURCHASE() {
        return FORMAT_OUTPUT_PURCHASE;
    }

    public static String GET_FORMAT_OUTPUT_USER() {
        return FORMAT_OUTPUT_USER;
    }

    public static String GET_FORMAT_OUTPUT_RESERVATION() {
        return FORMAT_OUTPUT_RESERVATION;
    }

    public static final String FORMAT_BOOLEAN(boolean var) {
        return var ? YES : NO;
    }

    public static final String FORMAT_LIST_PURCHASE(List<Purchase> list) {
        StringBuilder l = new StringBuilder();
        if (list.isEmpty()) {
            l.append(NO_DATA_MESSAGE);
        } else {
            int i = 0;
            for (Purchase item : list) {
                l.append(String.format(FORMAT_OUTPUT_LIST, ++i, item.toString()));
            }
        }
        return l.toString();
    }
    
        public static final String FORMAT_LIST_RESERVARTION(List<Reservation> list) {
        StringBuilder l = new StringBuilder();
        if (list.isEmpty()) {
            l.append(NO_DATA_MESSAGE);
        } else {
            int i = 0;
            for (Reservation item : list) {
                l.append(String.format(FORMAT_OUTPUT_LIST, ++i, item.toString()));
            }
        }
        return l.toString();
    }

    public static final Date STRING_TO_DATE_SIMPLE(String date) {
        try {
            String arg = date.substring(0, date.length() - 4) + "20" + date.substring(date.length() - 2, date.length());
            return FORMAT_DATE_SIMPLE.parse(arg);
        } catch (ParseException ex) {
            MyException.SHOW_ERROR(ex.getMessage());
        }
        return null;
    }

    public static final Date STRING_TO_DATE_COMPLETE(String date) {
        try {
            String arg = date.substring(0, date.length() - 4) + "20" + date.substring(date.length() - 2, date.length());
            return FORMAT_DATE_COMPLETE.parse(arg);
        } catch (ParseException ex) {
            MyException.SHOW_ERROR(ex.getMessage());
        }
        return null;
    }
    
    public static final Date STRING_TO_DATE_SIMPLE(String day, String month, String year) {
        try {
            String arg = String.format(FORMAT_DATE, day, month, year);
            return FORMAT_DATE_SIMPLE.parse(arg);
        } catch (ParseException ex) {
            MyException.SHOW_ERROR(ex.getMessage());
        }
        return null;
    }

    public static final String DATE_SIMPLE_TO_STRING(Date date) {
        return FORMAT_DATE_SIMPLE.format(date);
    }

    public static final String DATE_COMPLETE_TO_STRING(Date date) {
        return FORMAT_DATE_COMPLETE.format(date);
    }

    public static final boolean GET_CHECK_OUT(String var) {
        return var.equals(INACTIVE);
    }

    public static final boolean GET_ACTIVE(String var) {
        return var.equals(ACTIVE);
    }

}
