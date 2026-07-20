package util;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * Runs once when the app starts up (server start / deploy) and makes sure
 * the database has all the columns the code expects. Right now that's just
 * "users.profilePhoto" (added for the profile-photo-upload feature) — if
 * it's missing, it gets added automatically so nobody has to open
 * phpMyAdmin / MySQL Workbench and run ALTER TABLE by hand.
 *
 * Safe to run every time the app starts: it only adds the column if it
 * isn't there already, so it won't touch anything on later restarts.
 */
@WebListener
public class SchemaInitializer implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        try (Connection con = DBConnection.getConnection()) {
            if (con == null) {
                System.out.println("SchemaInitializer: could not get a DB connection, skipping schema check.");
                return;
            }
            ensureColumnExists(con, "users", "profilePhoto", "VARCHAR(255) DEFAULT NULL");
        } catch (Exception e) {
            System.out.println("SchemaInitializer: schema check failed.");
            e.printStackTrace();
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Nothing to clean up
    }

    private void ensureColumnExists(Connection con, String table, String column, String columnDefinition) {
        try {
            DatabaseMetaData meta = con.getMetaData();
            boolean exists;
            try (ResultSet rs = meta.getColumns(con.getCatalog(), null, table, column)) {
                exists = rs.next();
            }

            if (!exists) {
                String sql = "ALTER TABLE " + table + " ADD COLUMN " + column + " " + columnDefinition;
                try (Statement st = con.createStatement()) {
                    st.executeUpdate(sql);
                    System.out.println("SchemaInitializer: added missing column " + table + "." + column);
                }
            }
        } catch (Exception e) {
            System.out.println("SchemaInitializer: could not verify/add " + table + "." + column);
            e.printStackTrace();
        }
    }
}
