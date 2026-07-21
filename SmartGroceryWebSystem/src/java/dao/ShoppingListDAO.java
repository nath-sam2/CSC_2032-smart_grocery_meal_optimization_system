/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author perer
 */
import model.ShoppingList;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class ShoppingListDAO {
    public boolean insertShoppingList(ShoppingList shoppingList) {

        String sql = "INSERT INTO shoppinglists(userId, createdDate, status) VALUES (?, ?, ?)";

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS)
        ) {

            stmt.setInt(1, shoppingList.getUserId());
            stmt.setDate(2, Date.valueOf(shoppingList.getCreatedDate()));
            stmt.setString(3, shoppingList.getStatus());

            stmt.executeUpdate();

            ResultSet rs = stmt.getGeneratedKeys();

            if (rs.next()) {
                shoppingList.setShoppingListId(rs.getInt(1));
            }

            System.out.println("Shopping List inserted successfully!");
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Insert failed!");
        }

        return false;
    }


    public ShoppingList getShoppingListById(int shoppingListId) {

        String sql = "SELECT * FROM ShoppingLists WHERE shoppingListId = ?";

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setInt(1, shoppingListId);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {

                ShoppingList shoppingList = new ShoppingList();

                shoppingList.setShoppingListId(rs.getInt("shoppingListId"));
                shoppingList.setUserId(rs.getInt("userId"));
                shoppingList.setCreatedDate(rs.getDate("createdDate").toLocalDate());
                shoppingList.setStatus(rs.getString("status"));

                return shoppingList;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public List<ShoppingList> getAllShoppingLists() {

        List<ShoppingList> shoppingLists = new ArrayList<>();

        String sql = "SELECT * FROM ShoppingLists";

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()
        ) {

            while (rs.next()) {

                ShoppingList shoppingList = new ShoppingList();

                shoppingList.setShoppingListId(rs.getInt("shoppingListId"));
                shoppingList.setUserId(rs.getInt("userId"));
                shoppingList.setCreatedDate(rs.getDate("createdDate").toLocalDate());
                shoppingList.setStatus(rs.getString("status"));

                shoppingLists.add(shoppingList);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return shoppingLists;
    }

    public boolean updateShoppingList(ShoppingList shoppingList) {

        String sql = "UPDATE ShoppingLists SET userId=?, createdDate=?, status=? WHERE shoppingListId=?";

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setInt(1, shoppingList.getUserId());
            stmt.setDate(2, Date.valueOf(shoppingList.getCreatedDate()));
            stmt.setString(3, shoppingList.getStatus());
            stmt.setInt(4, shoppingList.getShoppingListId());

            return stmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean deleteShoppingList(int shoppingListId) {

        String sql = "DELETE FROM ShoppingLists WHERE shoppingListId=?";

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setInt(1, shoppingListId);

            return stmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}