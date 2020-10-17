/*
 * PROJECT: TICKETS NATIONAL PARK.
 * LUIS J. BRAVO ZUÑIGA.
 * SERVICE RESERVATION CLASS.
 */
package accessData;

import exception.MyException;
import format.Format;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import logicBusiness.Reservation;
import oracle.jdbc.OracleTypes;

public class ManagerReservation {

    private static ManagerReservation INSTANCE = null;

    private static final String LIST_RESERVATION = "{?=call f_list_reservation()}",
            CAN_PURCHASE = "{?=call f_can_purchase(?,?)}",
            QUANTITY_TICKETS = "{?=call f_enough_for_sold(?)}";

    private ManagerReservation() {
    }

    private Reservation getReservation(ResultSet rs) {
        Reservation object = null;
        int i = 1;
        try {
            object = new Reservation(
                    Format.STRING_TO_DATE_SIMPLE(rs.getString(i++)),
                    rs.getInt(i++),
                    rs.getInt(i++),
                    Format.GET_ACTIVE(rs.getString(i++))
            );
        } catch (SQLException ex) {
            MyException.SHOW_ERROR(ex.getMessage());
        }
        return object;
    }

    public static ManagerReservation getInstance() {
        if (INSTANCE == null) {
            INSTANCE = new ManagerReservation();
        }
        return INSTANCE;
    }

    public List<Reservation> list() {
        List<Reservation> list = new ArrayList<>();
        ResultSet rs = null;
        CallableStatement pstmt = null;
        Connection conexion = ManagerConexionDB.getInstance().connect();
        try {
            pstmt = conexion.prepareCall(LIST_RESERVATION);
            pstmt.clearParameters();
            pstmt.registerOutParameter(1, OracleTypes.CURSOR);
            if (pstmt.execute()) {
                throw new MyException(MyException.GET_ERROR_OPERATION());
            } else {
                rs = (ResultSet) pstmt.getObject(1);
                while (rs.next()) {
                    list.add(getReservation(rs));
                }
                if (list.isEmpty()) {
                    throw new MyException(MyException.GET_ERROR_NO_DATA());
                }
            }
        } catch (SQLException | MyException ex) {
            MyException.SHOW_ERROR(ex.getMessage());
        } finally {
            try {
                if (pstmt != null) {
                    pstmt.close();
                }
                ManagerConexionDB.getInstance().disconnect();
            } catch (SQLException ex) {
                MyException.SHOW_ERROR(ex.getMessage());
            }
        }
        return list;
    }

    public boolean canPurchase(long id, int quantity_tickets) {
        short result = 0;
        CallableStatement pstmt = null;
        Connection conexion = ManagerConexionDB.getInstance().connect();
        try {
            pstmt = conexion.prepareCall(CAN_PURCHASE);
            pstmt.clearParameters();
            pstmt.registerOutParameter(1, OracleTypes.NUMBER);
            pstmt.setDate(2, new Date(id));
            pstmt.setInt(3, quantity_tickets);
            if (pstmt.execute()) {
                throw new MyException(MyException.GET_ERROR_OPERATION());
            } else {
                result = (short) pstmt.getBigDecimal(1).intValue();
            }
        } catch (SQLException | MyException ex) {
            MyException.SHOW_ERROR(ex.getMessage());
        } finally {
            try {
                if (pstmt != null) {
                    pstmt.close();
                }
                ManagerConexionDB.getInstance().disconnect();
            } catch (SQLException ex) {
                MyException.SHOW_ERROR(ex.getMessage());
            }
        }
        return result == 1;
    }

    public int QuantityTickets(long date) {
        int result = -1;
        CallableStatement pstmt = null;
        Connection conexion = ManagerConexionDB.getInstance().connect();
        try {
            pstmt = conexion.prepareCall(QUANTITY_TICKETS);
            pstmt.clearParameters();
            pstmt.registerOutParameter(1, OracleTypes.NUMBER);
            pstmt.setDate(2, new Date(date));
            if (pstmt.execute()) {
                throw new MyException(MyException.GET_ERROR_OPERATION());
            } else {
                result = (int) pstmt.getBigDecimal(1).intValue();
            }
        } catch (SQLException | MyException ex) {
            MyException.SHOW_ERROR(ex.getMessage());
        } finally {
            try {
                if (pstmt != null) {
                    pstmt.close();
                }
                ManagerConexionDB.getInstance().disconnect();
            } catch (SQLException ex) {
                MyException.SHOW_ERROR(ex.getMessage());
            }
        }
        return result;
    }

} //END CLASS
