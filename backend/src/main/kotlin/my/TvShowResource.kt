package my

import jakarta.enterprise.context.ApplicationScoped
import jakarta.inject.Inject
import jakarta.ws.rs.GET
import jakarta.ws.rs.Path
import jakarta.ws.rs.Produces
import jakarta.ws.rs.core.MediaType
import my.jooq.tables.Genre
import my.jooq.tables.Mood
import my.jooq.tables.TvShow
import my.jooq.tables.references.MOOD

@Path("/tvshows")
class TvShowResource {


//    @GET
//    @Produces(MediaType.APPLICATION_JSON)
//    fun proxyAllMoods(): List<Mood> =



}