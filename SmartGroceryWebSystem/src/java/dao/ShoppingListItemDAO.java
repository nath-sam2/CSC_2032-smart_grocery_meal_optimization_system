/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author perer
 */
import model.ShoppingListItem;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ShoppingListItemDAO {
    public boolean insertShoppingListItem(ShoppingListItem item) {

        String sql = "INSERT INTO shoppinglistitems (shoppingListId, ingredientId, quantity, unit, status) VALUES (?, ?, ?, ?, ?)";

        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setInt(1, item.getShoppingListId());
            stmt.setInt(2, item.getIngredientId());
            stmt.setDouble(3, item.getQuantity());
            stmt.setString(4, item.getUnit());
            stmt.setString(5, item.getStatus());

            return stmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public ShoppingListItem getShoppingListItemById(int shoppingListItemId) {

        String sql = "SELECT * FROM shoppinglistitems WHERE shoppingListItemId = ?";

        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setInt(1, shoppingListItemId);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {

                ShoppingListItem item = new ShoppingListItem();

                item.setShoppingListItemId(rs.getInt("shoppingListItemId"));
                item.setShoppingListId(rs.getInt("shoppingListId"));
                item.setIngredientId(rs.getInt("ingredientId"));
                item.setQuantity(rs.getDouble("quantity"));
                item.setUnit(rs.getString("unit"));
                item.setStatus(rs.getString("status"));

                return item;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public List<ShoppingListItem> getAllShoppingListItems() {

        List<ShoppingListItem> items = new ArrayList<>();

        String sql = "SELECT * FROM shoppinglistitems";

        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery()
        ) {

            while (rs.next()) {

                ShoppingListItem item = new ShoppingListItem();

                item.setShoppingListItemId(rs.getInt("shoppingListItemId"));
                item.setShoppingListId(rs.getInt("shoppingListId"));
                item.setIngredientId(rs.getInt("ingredientId"));
                item.setQuantity(rs.getDouble("quantity"));
                item.setUnit(rs.getString("unit"));
                item.setStatus(rs.getString("status"));

                items.add(item);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return items;
    }

    public boolean updateShoppingListItem(ShoppingListItem item) {

        String sql = "UPDATE shoppinglistitems SET shoppingListId=?, ingredientId=?, quantity=?, unit=?, status=? WHERE shoppingListItemId=?";

        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setInt(1, item.getShoppingListId());
            stmt.setInt(2, item.getIngredientId());
            stmt.setDouble(3, item.getQuantity());
            stmt.setString(4, item.getUnit());
            stmt.setString(5, item.getStatus());
            stmt.setInt(6, item.getShoppingListItemId());

            return stmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean deleteShoppingListItem(int shoppingListItemId) {

        String sql = "DELETE FROM shoppinglistitems WHERE shoppingListItemId=?";

        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setInt(1, shoppingListItemId);

            return stmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public List<ShoppingListItem> getItemsByShoppingListId(int shoppingListId) {

    List<ShoppingListItem> items = new ArrayList<>();

    String sql = "SELECT * FROM shoppinglistitems WHERE shoppingListId=?";

    try (
        Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)
    ) {

        stmt.setInt(1, shoppingListId);

        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {

            ShoppingListItem item = new ShoppingListItem();

            item.setShoppingListItemId(
                rs.getInt("shoppingListItemId")
            );

            item.setShoppingListId(
                rs.getInt("shoppingListId")
            );

            item.setIngredientId(
                rs.getInt("ingredientId")
            );

            item.setQuantity(
                rs.getDouble("quantity")
            );

            item.setUnit(
                rs.getString("unit")
            );

            item.setStatus(
                rs.getString("status")
            );

            items.add(item);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return items;
}
}