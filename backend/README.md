# TV Show Backend — Micronaut / Java 25

Migrated from the original Gleam backend to:

- Java 25
- Micronaut Framework 5.1.5
- Micronaut Serde
- Micronaut Data JPA + Hibernate
- Maven
- SQLite
- GraalVM Native Image
- Debian 13 runtime container

## Development

Use GraalVM CE/JDK 25:

```bash
java -version
mvn clean test
mvn mn:run
```

The server listens on `0.0.0.0:8080` by default.

Useful environment variables:

```text
HTTP_SERVER_HOST=0.0.0.0
HTTP_SERVER_PORT=8080
DATABASE_PATH=database.db
```

## Native executable

With GraalVM CE 25 installed:

```bash
mvn clean package -Dpackaging=native-image
```

The executable is:

```text
target/tv-show-backend
```

For SQLite, the Xerial driver has built-in GraalVM Native Image support. The build exports the target SQLite native library alongside the executable.

## Docker

Build the native executable first, then:

```bash
mvn clean package -Dpackaging=native-image
docker build -t tv-show-backend .
docker run --rm -p 8080:8080 -v "$PWD/data:/data" tv-show-backend
```

The SQLite database lives at `/data/database.db` in the container.

## API

The existing routes are preserved:

```text
GET  /api/genre/all
GET  /api/format/all
GET  /api/mood/all
GET  /api/expectation/all
GET  /api/impression/all
GET  /api/strength/all
GET  /api/annoyance/all
GET  /api/setting/all
POST /api/tv-show/add
GET  /api/user_account/all
```

The startup initializer creates the original SQLite schema and loads the original default values into an empty database. It does not re-seed an existing database.
