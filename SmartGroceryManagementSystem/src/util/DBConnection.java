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
    // Database URL
    private static final String URL = "jdbc:mysql://localhost:3306/smart_grocery_system";

    // Database username
    private static final String USER = "root";

    // Database password
    private static final String PASSWORD = "";

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

        System.out.println("Database connected successfully!");

    } catch (Exception e) {

        System.out.println("DATABASE CONNECTION FAILED");
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
