/*
 * PROJECT: TICKETS NATIONAL PARK.
 * LUIS J. BRAVO ZÚÑIGA.
 * PURCHASE API.
 */
package APIs;

import exception.MyException;
import java.util.List;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import model.Model;

@Path("purchase")
public class Purchase {

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    public String insert(logicBusiness.Purchase object) {
        try {
            object.setTotal(object.getQuantityTickets() * logicBusiness.Purchase.GET_PRICE_TICKET());
            if (Model.getInstance().insertPurchase(object)) {
                return String.valueOf(Model.getInstance().getIdPurchase());
            }
        } catch (Exception ex) {
            MyException.SHOW_ERROR(ex.getMessage());
        }
        return "-1";
    }

    @GET
    @Path("{id}")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public logicBusiness.Purchase consult(@PathParam("id") int id) {
        try {
            return Model.getInstance().consultPurchase(id);
        } catch (Exception ex) {
            MyException.SHOW_ERROR(ex.getMessage());
        }
        return null;
    }

    @GET
    @Produces(javax.ws.rs.core.MediaType.APPLICATION_JSON)
    public List<logicBusiness.Purchase> listPurchase() {
        try {
            return Model.getInstance().listPurchase();
        } catch (Exception ex) {
            MyException.SHOW_ERROR(ex.getMessage());
        }
        return null;
    }

    @DELETE
    @Path("{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    public boolean check(@PathParam("id") String id) {
        try {
            return Model.getInstance().deletePurchase(Integer.parseInt(id));
        } catch (NumberFormatException ex) {
            MyException.SHOW_ERROR(ex.getMessage());
        }
        return false;
    }

} //END CLASS
