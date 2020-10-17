/*
 * PROJECT: TICKETS NATIONAL PARK.
 * LUIS J. BRAVO ZUÑIGA.
 * USER CLASS.
 */
package logicBusiness;

import exception.MyException;
import format.Format;
import java.util.Objects;

public class User implements Cloneable {

    private String username;
    private String password;

    public User(String username, String password) {
        this.username = username;
        this.password = password;
    }

    public User() {
        this.username = this.password = null;
    }

    public String getUsername() {
        return username;
    }

    private String getPassword() {
        return password;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public String toString() {
        return String.format(Format.GET_FORMAT_OUTPUT_USER(), getUsername(), getPassword());
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        final User object = (User) obj;
        return this.hashCode() == object.hashCode();
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(this.username) + Objects.hashCode(this.password);
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

    public User getClone() {
        return (User) this.clone();
    }

} // END CLASS
