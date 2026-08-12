package my

import jakarta.enterprise.context.ApplicationScoped
import jakarta.inject.Inject
import org.jooq.DSLContext
import org.jooq.impl.DSL
import org.jooq.impl.DefaultConfiguration
import javax.sql.DataSource

@ApplicationScoped
class Jooq(
    dataSource: DataSource
) {
    val dsl: DSLContext = DSL.using(
        DefaultConfiguration()
            .set(dataSource)
    )
}