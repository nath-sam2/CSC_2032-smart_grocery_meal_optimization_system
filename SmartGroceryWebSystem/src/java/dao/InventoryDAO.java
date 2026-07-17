package dao;

import model.Inventory;
import model.Product;
import util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class InventoryDAO {

    public boolean insertInventory(Inventory inv) {
        String sql = "INSERT INTO inventory (inventoryId, productId, " +
                     "quantity, reorderLevel) VALUES (?,?,?,?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, inv.getInventoryId());
            ps.setInt(2, inv.getProductId());
            ps.setInt(3, inv.getQuantity());
            ps.setInt(4, inv.getReorderLevel());
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    public Inventory getInventoryByProduct(int productId) {
        String sql = "SELECT * FROM inventory WHERE productId=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Inventory(
                    rs.getInt("inventoryId"),
                    rs.getInt("productId"),
                    rs.getInt("quantity"),
                    rs.getInt("reorderLevel")
                );
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    public List<Inventory> getAllInventory() {
        List<Inventory> list = new ArrayList<>();
        String sql = "SELECT * FROM inventory";
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                list.add(new Inventory(
                    rs.getInt("inventoryId"),
                    rs.getInt("productId"),
                    rs.getInt("quantity"),
                    rs.getInt("reorderLevel")
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public boolean updateStock(int productId, int newQty) {
        String sql = "UPDATE inventory SET quantity=? WHERE productId=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, newQty);
            ps.setInt(2, productId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    public List<Inventory> getLowStockItems() {
        List<Inventory> list = new ArrayList<>();
        String sql = "SELECT * FROM inventory WHERE quantity <= reorderLevel";
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                list.add(new Inventory(
                    rs.getInt("inventoryId"),
                    rs.getInt("productId"),
                    rs.getInt("quantity"),
                    rs.getInt("reorderLevel")
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public List<Product> getExpiringItems(int days) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.* FROM products p " +
                     "JOIN inventory i ON p.productId = i.productId " +
                     "WHERE p.expiryDate IS NOT NULL " +
                     "AND p.expiryDate <= DATE_ADD(CURDATE(), INTERVAL ? DAY)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, days);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(
                    rs.getInt("productId"),
                    rs.getString("name"),
                    rs.getDouble("price"),
                    rs.getInt("quantity"),
                    rs.getDate("expiryDate"),
                    rs.getString("unit"),
                    rs.getInt("categoryId")
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
}