/*
 * PROJECT: TICKETS NATIONAL PARK.
 * LUIS J. BRAVO ZUÑIGA.
 * RESERVATION CLASS.
 */
package logicBusiness;

import exception.MyException;
import format.Format;
import java.util.Date;
import java.util.Objects;

public class Reservation implements Cloneable {

    private Date id;
    private int available, sold;
    private boolean active;

    public Reservation(Date id, int available, int sold, boolean active) {
        this.id = id;
        this.available = available;
        this.sold = sold;
        this.active = active;
    }
    
    public Reservation(Date id, int available) {
        this.id = id;
        this.available = available;
        this.sold = 0;
        this.active = false;
    }

    public Reservation() {
        this.id = null;
        this.available = this.sold = -1;
        this.active = true;
    }

    public Date getId() {
        return id;
    }

    public int getAvailable() {
        return available;
    }

    public int getSold() {
        return sold;
    }

    public boolean getActive() {
        return active;
    }

    public void setId(Date id) {
        this.id = id;
    }

    public void setAvailable(int available) {
        this.available = available;
    }

    public void setSold(int sold) {
        this.sold = sold;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    @Override
    public String toString() {
        return String.format(Format.GET_FORMAT_OUTPUT_RESERVATION(),
                Format.DATE_SIMPLE_TO_STRING(getId()),
                getAvailable(), getSold(), Format.FORMAT_BOOLEAN(getActive()));
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(this.id)
                + this.available
                + this.sold
                + (this.active ? 1 : 0);
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        final Reservation object = (Reservation) obj;
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

    public Reservation getClone() {
        return (Reservation) this.clone();
    }

} // END CLASS

