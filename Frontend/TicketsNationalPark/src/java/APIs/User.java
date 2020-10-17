/*
 * PROJECT: TICKETS NATIONAL PARK.
 * LUIS J. BRAVO ZÚÑIGA.
 * USER API.
 */
package APIs;

import exception.MyException;
import javax.ws.rs.Consumes;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.core.MediaType;
import validate.Check;
import model.Model;

@Path("user")
public class User {

    @PUT
    @Path("{username}/{password}/{password2}")
    @Consumes(MediaType.APPLICATION_JSON)
    public boolean update(@PathParam("username") String username, @PathParam("password") String password,  @PathParam("password2") String password2) {
        try {
            if(password.equals(password2)) {
                if(Check.VALIDATE_PASSWORD(password)) {
                    return Model.getInstance().updateUser(username, password);
                }
            }
        } catch (Exception ex) {
            MyException.SHOW_ERROR(ex.getMessage());
        }
        return false;
    }

}
