package my

import jakarta.ws.rs.GET
import jakarta.ws.rs.Path

@Path("/hello")
class HelloResource {

    @GET
    fun hello() = "Hello from Kotlin"
}
