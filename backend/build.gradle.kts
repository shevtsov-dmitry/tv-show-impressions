plugins {
    java
    id("io.quarkus")
    kotlin("jvm") version "2.4.0"
    kotlin("plugin.allopen") version "2.4.0"

    id("org.jooq.jooq-codegen-gradle") version "3.21.6"
}

repositories {
    mavenCentral()
    mavenLocal()
}

val quarkusPlatformGroupId: String by project
val quarkusPlatformArtifactId: String by project
val quarkusPlatformVersion: String by project

dependencies {
    implementation(enforcedPlatform(
        "${quarkusPlatformGroupId}:${quarkusPlatformArtifactId}:${quarkusPlatformVersion}"
    ))

    implementation("io.quarkus:quarkus-kotlin")

    implementation("io.quarkus:quarkus-rest")
    implementation("io.quarkus:quarkus-rest-jackson")

    implementation("io.quarkus:quarkus-arc")

    // PostgreSQL runtime connection
    implementation("io.quarkus:quarkus-jdbc-postgresql")

    // jOOQ runtime
    implementation("org.jooq:jooq:3.21.6")

    // PostgreSQL JDBC driver for jOOQ code generation
    jooqCodegen("org.postgresql:postgresql:42.7.7")

    testImplementation("io.quarkus:quarkus-junit")
    testImplementation("io.rest-assured:rest-assured")
}

val dbUrl = providers
    .environmentVariable("DB_URL")
    .orElse("jdbc:postgresql://localhost:5432/tv_show")

val dbUser = providers
    .environmentVariable("DB_USER")
    .orElse("postgres")

val dbPassword = providers
    .environmentVariable("DB_PASSWORD")
    .orElse("postgres")

jooq {
    configuration {
        jdbc {
            driver = "org.postgresql.Driver"
            url = dbUrl.get()
            user = dbUser.get()
            password = dbPassword.get()
        }

        generator {
            name = "org.jooq.codegen.KotlinGenerator"

            database {
                name = "org.jooq.meta.postgres.PostgresDatabase"
                inputSchema = "public"
                includes = ".*"

                excludes = """
                    flyway_schema_history
                """.trimIndent()
            }

            generate {
                isPojos = true
                isDaos = true

                isKotlinNotNullRecordAttributes = true
                isKotlinNotNullPojoAttributes = true
            }

            target {
                packageName = "my.jooq"
                directory = "build/generated-src/jooq"
            }
        }
    }
}

// jOOQ must run before Kotlin compilation
tasks.named("compileKotlin") {
    dependsOn(tasks.named("jooqCodegen"))
}

group = "my"
version = "1.0.0-SNAPSHOT"

java {
    sourceCompatibility = JavaVersion.VERSION_21
    targetCompatibility = JavaVersion.VERSION_21
}

allOpen {
    annotation("jakarta.ws.rs.Path")
    annotation("jakarta.enterprise.context.ApplicationScoped")
    annotation("jakarta.persistence.Entity")
    annotation("io.quarkus.test.junit.QuarkusTest")
}

kotlin {
    compilerOptions {
        jvmTarget.set(
            org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_21
        )
        javaParameters.set(true)
    }
}

tasks.withType<JavaCompile> {
    options.encoding = "UTF-8"
    options.compilerArgs.add("-parameters")
}