/*
 * PROJECT: TICKETS NATIONAL PARK.
 * LUIS J. BRAVO ZUÑIGA.
 * PURCHASE CLASS.
 */
package logicBusiness;

import exception.MyException;
import format.Format;
import java.util.Date;
import java.util.Objects;

public class Purchase implements Cloneable {

    private static double PRICE_TICKET = 3.75;
    private int id;
    private String idPurchaser;
    private String firstName;
    private String lastName;
    private String email;
    private String telephone;
    private int quantityTickets;
    private Date reservationDate;
    private double total;
    private boolean checkOut;

    public Purchase(int id, String idPurchaser, String firstName, String lastName,
            String email, String telephone, int quantityTickets, Date reservationDate,
            double total, boolean checkOut) {
        this.id = id;
        this.idPurchaser = idPurchaser;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.telephone = telephone;
        this.quantityTickets = quantityTickets;
        this.reservationDate = reservationDate;
        this.total = total;
        this.checkOut = checkOut;
    }

    public Purchase() {
        this.id = this.quantityTickets = -1;
        this.total = -1.0;
        this.firstName = this.lastName = this.idPurchaser = this.email = this.telephone = "";
        this.checkOut = false;
    }

    public int getId() {
        return id;
    }

    public String getIdPurchaser() {
        return idPurchaser;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public String getEmail() {
        return email;
    }

    public String getTelephone() {
        return telephone;
    }

    public int getQuantityTickets() {
        return quantityTickets;
    }

    public Date getReservationDate() {
        return reservationDate;
    }

    public double getTotal() {
        return total;
    }

    public boolean getCheckOut() {
        return checkOut;
    }

    public static double GET_PRICE_TICKET() {
        return PRICE_TICKET;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setIdPurchaser(String idPurchaser) {
        this.idPurchaser = idPurchaser;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public void setQuantityTickets(int quantityTickets) {
        this.quantityTickets = quantityTickets;
    }

    public void setReservationDate(Date reservationDate) {
        this.reservationDate = reservationDate;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public void setCheckOut(boolean checkOut) {
        this.checkOut = checkOut;
    }

    public static void SET_PRICE_TICKET(double PRICE_TICKET) {
        Purchase.PRICE_TICKET = PRICE_TICKET;
    }
    
    @Override
    public String toString() {
        return String.format(Format.GET_FORMAT_OUTPUT_PURCHASE(),
                getId(), getIdPurchaser(), getFirstName(), getLastName(),
                getEmail(), getTelephone(), getQuantityTickets(),
                Format.DATE_SIMPLE_TO_STRING(getReservationDate()),
                getTotal(), Format.FORMAT_BOOLEAN(getCheckOut()));
    }

    @Override
    public int hashCode() {
        return this.id
                + Objects.hashCode(this.idPurchaser)
                + Objects.hashCode(this.firstName)
                + Objects.hashCode(this.lastName)
                + Objects.hashCode(this.email)
                + Objects.hashCode(this.telephone)
                + this.quantityTickets
                + Objects.hashCode(this.reservationDate)
                + (int) (Double.doubleToLongBits(this.total) ^ (Double.doubleToLongBits(this.total) >>> 32))
                + (this.checkOut ? 1 : 0);
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        final Purchase object = (Purchase) obj;
        return this.hashCode() == object.hashCode();
    }

    @Override
    protected Object clone() {
        Object obj = null;
        try {
            obj = super.clone();
        } catch (CloneNotSupportedException ex) {
            MyException.SHOW_ERROR(ex.getMessage());
        }
        return obj;
    }

    public Purchase getClone() {
        return (Purchase) this.clone();
    }

} // END CLASS
