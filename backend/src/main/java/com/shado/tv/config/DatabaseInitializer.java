package com.shado.tv.config;

import io.micronaut.context.event.StartupEvent;
import io.micronaut.runtime.event.annotation.EventListener;
import jakarta.inject.Singleton;

import javax.sql.DataSource;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.regex.Pattern;

@Singleton
public class DatabaseInitializer {
    private static final Pattern STATEMENT_SEPARATOR = Pattern.compile(";\\s*(?:\\r?\\n|$)");

    private final DataSource dataSource;

    public DatabaseInitializer(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    @EventListener
    public void onStartup(StartupEvent ignored) {
        try (Connection connection = dataSource.getConnection()) {
            connection.setAutoCommit(false);
            executeScript(connection, "/schema.sql");
            if (isEmpty(connection, "genre")) {
                executeScript(connection, "/init-default-values.sql");
            }
            connection.commit();
        } catch (SQLException | IOException e) {
            throw new IllegalStateException("Failed to initialize SQLite database", e);
        }
    }

    private boolean isEmpty(Connection connection, String table) throws SQLException {
        try (Statement statement = connection.createStatement();
             ResultSet rs = statement.executeQuery("SELECT 1 FROM " + table + " LIMIT 1")) {
            return !rs.next();
        }
    }

    private void executeScript(Connection connection, String resource) throws IOException, SQLException {
        try (InputStream input = DatabaseInitializer.class.getResourceAsStream(resource)) {
            if (input == null) {
                throw new IOException("Missing classpath resource: " + resource);
            }
            String sql = new String(input.readAllBytes(), StandardCharsets.UTF_8);
            sql = sql.lines()
                    .filter(line -> !line.stripLeading().startsWith("--"))
                    .reduce((a, b) -> a + "\n" + b)
                    .orElse("");
            for (String raw : STATEMENT_SEPARATOR.split(sql)) {
                String statementSql = raw.trim();
                if (statementSql.isEmpty()) {
                    continue;
                }
                try (Statement statement = connection.createStatement()) {
                    statement.execute(statementSql);
                }
            }
        }
    }
}
