/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

/**
 *
 * @author perer
 */

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    // ---------------------------------------------------------------
    // Connection settings come from environment variables so the same
    // compiled code works both locally and on Render — no credentials
    // are hardcoded or committed to source control.
    //
    // Set these on Render (Dashboard -> your service -> Environment):
    //   DB_HOST      e.g. smart-grocery-db-smart-grocery-db.j.aivencloud.com
    //   DB_PORT      e.g. 12345   (Aiven gives you a specific port, not 3306)
    //   DB_NAME      e.g. defaultdb
    //   DB_USER      e.g. avnadmin
    //   DB_PASSWORD  your Aiven password
    //
    // If any of these aren't set (e.g. running locally in NetBeans against
    // your own MySQL), it falls back to the old localhost/root defaults.
    // ---------------------------------------------------------------

    private static final String HOST     = getEnvOrDefault("DB_HOST", "localhost");
    private static final String PORT     = getEnvOrDefault("DB_PORT", "3306");
    private static final String DATABASE = getEnvOrDefault("DB_NAME", "smart_grocery_system_unified");
    private static final String USER     = getEnvOrDefault("DB_USER", "root");
    private static final String PASSWORD = getEnvOrDefault("DB_PASSWORD", "");

    // Aiven requires SSL. useSSL/requireSSL keep this working against a
    // plain local MySQL too (they just won't enforce a cert locally).
    private static final String URL =
        "jdbc:mysql://" + HOST + ":" + PORT + "/" + DATABASE
        + "?useSSL=true&requireSSL=true&verifyServerCertificate=false";

    private static String getEnvOrDefault(String name, String defaultValue) {
        String value = System.getenv(name);
        return (value == null || value.isEmpty()) ? defaultValue : value;
    }

    // Method to establish connection
    public static Connection getConnection() {

        Connection connection = null;

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            connection = DriverManager.getConnection(
                URL,
                USER,
                PASSWORD
            );

            //System.out.println("Database connected successfully!");//

        } catch (Exception e) {

            System.out.println("Connection failed!");
            e.printStackTrace();

        }

        return connection;
    }

    // Method to close connection
    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
                System.out.println("Database connection closed.");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
