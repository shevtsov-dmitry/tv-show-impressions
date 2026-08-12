package my.mood

import jakarta.enterprise.context.ApplicationScoped
import my.Jooq
import my.jooq.tables.pojos.Mood
import my.jooq.tables.references.MOOD
import org.jooq.DSLContext

@ApplicationScoped
class MoodRepository(
    private val jooq: Jooq
) {

    fun findAll(): List<Mood> =
        jooq.dsl
            .selectFrom(MOOD)
            .fetch { it.into(Mood::class.java) }


}