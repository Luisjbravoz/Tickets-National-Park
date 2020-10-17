/*
 * PROJECT: TICKETS NATIONAL PARK.
 * LUIS J. BRAVO ZUÑIGA.
 * MODEL CLASS.
 */
package model;

import accessData.ManagerPurchase;
import accessData.ManagerReservation;
import accessData.ManagerUser;
import format.Format;
import java.util.Date;
import java.util.List;
import logicBusiness.Purchase;
import logicBusiness.Reservation;

public class Model {

    private static Model INSTANCE = null;
    private String username;

    private boolean canPurchase(Date date, int quantity) {
        return ManagerReservation.getInstance().canPurchase(date.getTime(), quantity);
    }

    private Model() {
        this.username = null;
    }

    public static Model getInstance() {
        if (INSTANCE == null) {
            INSTANCE = new Model();
        }
        return INSTANCE;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public boolean check(String username, String password) {
        return ManagerUser.getInstance().check(username, password);
    }

    public boolean updateUser(String username, String password) {
        return ManagerUser.getInstance().update(username, password);
    }

    public boolean insertPurchase(Purchase object) {
        if (canPurchase(object.getReservationDate(), object.getQuantityTickets())) {
            return ManagerPurchase.getInstance().insert(object);
        }
        return false;
    }

    public boolean deletePurchase(int id) {
        return ManagerPurchase.getInstance().delete(id);
    }

    public List<Purchase> listPurchase() {
        return ManagerPurchase.getInstance().list();
    }
    
    public Purchase consultPurchase(int id) {
        return ManagerPurchase.getInstance().consult(id);
    }

    public int getIdPurchase() {
        return ManagerPurchase.getInstance().getIdPurchase();
    }

    public List<Reservation> listReservation() {
        return ManagerReservation.getInstance().list();
    }

    public int quantityTickets(String day, String month, String year) {
        return ManagerReservation.getInstance().QuantityTickets(
                (Format.STRING_TO_DATE_SIMPLE(day, month, year)).getTime());
    }

} // END CLASS
