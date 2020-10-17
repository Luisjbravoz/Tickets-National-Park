/*
 * PROJECT: TICKETS NATIONAL PARK.
 * LUIS J. BRAVO ZÚÑIGA.
 * RESERVATION API.
 */
package APIs;

import java.util.List;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import model.Model;

@Path("reservation")
public class Reservation {

    @GET
    @Produces(javax.ws.rs.core.MediaType.APPLICATION_JSON)
    public List<logicBusiness.Reservation> listReservation() {
        return Model.getInstance().listReservation();
    }

    @GET
    @Path("{day}/{month}/{year}")
    @Produces({MediaType.APPLICATION_JSON})
    public String quantityTickets(@PathParam("day") int day,
            @PathParam("month") int month, @PathParam("year") int year) {
        return String.valueOf(
                Model.getInstance().quantityTickets(
                        String.valueOf(day), String.valueOf(month + 1), String.valueOf(year)));
    }

}
