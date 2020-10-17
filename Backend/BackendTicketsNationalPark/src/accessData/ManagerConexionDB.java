/*
 * PROJECT: TICKETS NATIONAL PARK.
 * LUIS J. BRAVO ZUÑIGA.
 * SERVICE CONEXION DB CLASS.
 */
package accessData;

import exception.MyException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ManagerConexionDB {

    private static ManagerConexionDB INSTANCE = null;
    private Connection conexion = null;

    private ManagerConexionDB() {
    }

    public static ManagerConexionDB getInstance() {
        if (INSTANCE == null) {
            INSTANCE = new ManagerConexionDB();
        }
        return INSTANCE;
    }

    public Connection connect() {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conexion = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "admin_tickets", "admin1234");
        } catch (SQLException | ClassNotFoundException ex) {
            MyException.SHOW_ERROR(ex.getMessage());
        }
        return conexion;
    }

    public void disconnect() {
        try {
            if (!conexion.isClosed()) {
                conexion.close();
            }
        } catch (SQLException ex) {
            MyException.SHOW_ERROR(ex.getMessage());
        }
    }

} //END CLASS
