/*
 * PROJECT: TICKETS NATIONAL PARK.
 * LUIS J. BRAVO ZUÑIGA.
 * SERVICE PURCHASE CLASS.
 */
package accessData;

import exception.MyException;
import format.Format;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import logicBusiness.Purchase;
import oracle.jdbc.OracleTypes;

public class ManagerPurchase {

    private static ManagerPurchase INSTANCE = null;

    private static final String INSERT_PURCHASE = "{call p_insert_purchase(?,?,?,?,?,?,?,?)}",
            VERIFY_PURCHASE = "{call p_delete_purchase(?)}",
            CONSULT_PURCHASE = "{?=call f_consult_purchase(?)}",
            LIST_PURCHASE = "{?=call f_list_purchase()}",
            GET_ID_PURCHASE = "{?=call f_get_id_purchase()}";

    private ManagerPurchase() {
    }

    private Purchase getPurchase(ResultSet rs) {
        Purchase object = null;
        int i = 1;
        try {
            object = new Purchase(
                    rs.getInt(i++),
                    rs.getString(i++),
                    rs.getString(i++),
                    rs.getString(i++),
                    rs.getString(i++),
                    rs.getString(i++),
                    rs.getInt(i++),
                    Format.STRING_TO_DATE_SIMPLE(rs.getString(i++)),
                    rs.getDouble(i++),
                    Format.GET_CHECK_OUT(rs.getString(i++))
            );
        } catch (SQLException ex) {
            MyException.SHOW_ERROR(ex.getMessage());
        }
        return object;
    }

    public static ManagerPurchase getInstance() {
        if (INSTANCE == null) {
            INSTANCE = new ManagerPurchase();
        }
        return INSTANCE;
    }

    public boolean insert(Purchase object) {
        boolean result = false;
        CallableStatement pstmt = null;
        Connection conexion = ManagerConexionDB.getInstance().connect();
        try {
            pstmt = conexion.prepareCall(INSERT_PURCHASE);
            pstmt.clearParameters();
            pstmt.setString(1, object.getIdPurchaser());
            pstmt.setString(2, object.getFirstName());
            pstmt.setString(3, object.getLastName());
            pstmt.setString(4, object.getEmail());
            pstmt.setString(5, object.getTelephone());
            pstmt.setInt(6, object.getQuantityTickets());
            pstmt.setDate(7, new Date(object.getReservationDate().getTime()));
            pstmt.setDouble(8, object.getTotal());
            if (pstmt.execute()) {
                throw new MyException(MyException.GET_ERROR_OPERATION());
            } else {
                result = true;
            }
        } catch (MyException | SQLException ex) {
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

    public boolean delete(int id) {
        boolean result = false;
        PreparedStatement pstmt = null;
        Connection conexion = ManagerConexionDB.getInstance().connect();
        try {
            pstmt = conexion.prepareStatement(VERIFY_PURCHASE);
            pstmt.clearParameters();
            pstmt.setInt(1, id);
            if (pstmt.execute()) {
                throw new MyException(MyException.GET_ERROR_OPERATION());
            } else {
                result = true;
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

    public Purchase consult(int id) {
        Purchase result = null;
        ResultSet rs = null;
        CallableStatement pstmt = null;
        Connection conexion = ManagerConexionDB.getInstance().connect();
        try {
            pstmt = conexion.prepareCall(CONSULT_PURCHASE);
            pstmt.clearParameters();
            pstmt.registerOutParameter(1, OracleTypes.CURSOR);
            pstmt.setInt(2, id);
            if (pstmt.execute()) {
                throw new MyException(MyException.GET_ERROR_OPERATION());
            } else {
                rs = (ResultSet) pstmt.getObject(1);
                if (rs.next()) {
                    result = getPurchase(rs);
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
        return result;
    }

    public List<Purchase> list() {
        List<Purchase> list = new ArrayList<>();
        ResultSet rs = null;
        CallableStatement pstmt = null;
        Connection conexion = ManagerConexionDB.getInstance().connect();
        try {
            pstmt = conexion.prepareCall(LIST_PURCHASE);
            pstmt.clearParameters();
            pstmt.registerOutParameter(1, OracleTypes.CURSOR);
            if (pstmt.execute()) {
                throw new MyException(MyException.GET_ERROR_OPERATION());
            } else {
                rs = (ResultSet) pstmt.getObject(1);
                while (rs.next()) {
                    list.add(getPurchase(rs));
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

    public int getIdPurchase() {
        int result = -1;
        CallableStatement pstmt = null;
        Connection conexion = ManagerConexionDB.getInstance().connect();
        try {
            pstmt = conexion.prepareCall(GET_ID_PURCHASE);
            pstmt.clearParameters();
            pstmt.registerOutParameter(1, OracleTypes.NUMBER);
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
