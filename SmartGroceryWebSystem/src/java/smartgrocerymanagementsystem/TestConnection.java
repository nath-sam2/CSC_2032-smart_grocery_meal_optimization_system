/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package smartgrocerymanagementsystem;

/**
 *
 * @author perer
 */
import java.sql.Connection;
import util.DBConnection;

public class TestConnection {
    public static void main(String[] args) {

        Connection connection = DBConnection.getConnection();

        if (connection != null) {
            System.out.println("Connection Successful!");
            DBConnection.closeConnection(connection);
        } else {
            System.out.println("Connection Failed!");
        }
    }
}
