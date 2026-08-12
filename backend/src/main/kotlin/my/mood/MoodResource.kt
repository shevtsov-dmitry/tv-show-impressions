package my.mood

import jakarta.ws.rs.GET
import jakarta.ws.rs.Path
import jakarta.ws.rs.Produces
import jakarta.ws.rs.core.MediaType
import my.jooq.tables.pojos.Mood

@Path("/moods")
class MoodResource(
    val moodRepository: MoodRepository
) {

    @GET
    @Path("/all")
    @Produces(MediaType.APPLICATION_JSON)
    fun findAll(): List<Mood> =
        moodRepository.findAll()
}
