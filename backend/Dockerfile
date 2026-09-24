# Runtime-only image: the application is a GraalVM native Linux executable.
FROM debian:13-slim

RUN useradd --system --create-home --uid 10001 app
WORKDIR /app

COPY target/tv-show-backend /app/tv-show-backend
RUN chmod +x /app/tv-show-backend && chown -R app:app /app

USER app
ENV HTTP_SERVER_HOST=0.0.0.0
ENV HTTP_SERVER_PORT=8080
ENV DATABASE_PATH=/data/database.db

RUN mkdir -p /data
VOLUME ["/data"]

EXPOSE 8080
ENTRYPOINT ["/app/tv-show-backend"]
