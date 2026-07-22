package dao;

import model.Product;
import util.DBConnection;
import util.IDGenerator;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    // Add new product
    public boolean insertProduct(Product p) {
        String sql = "INSERT INTO products (productId, name, price, " +
                     "quantity, expiryDate, unit, categoryId) VALUES (?,?,?,?,?,?,?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, p.getProductId());
            ps.setString(2, p.getName());
            ps.setDouble(3, p.getPrice());
            ps.setInt(4, p.getQuantity());
            ps.setDate(5, p.getExpiryDate() != null ?
                new java.sql.Date(p.getExpiryDate().getTime()) : null);
            ps.setString(6, p.getUnit());
            ps.setInt(7, p.getCategoryId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    // Get all products
    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products";
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                list.add(new Product(
                    rs.getInt("productId"),
                    rs.getString("name"),
                    rs.getDouble("price"),
                    rs.getInt("quantity"),
                    rs.getDate("expiryDate"),
                    rs.getString("unit"),
                    rs.getInt("categoryId"),
                    rs.getString("photo")
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // Get product by ID
    public Product getProductById(int productId) {
        String sql = "SELECT * FROM products WHERE productId=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Product(
                    rs.getInt("productId"),
                    rs.getString("name"),
                    rs.getDouble("price"),
                    rs.getInt("quantity"),
                    rs.getDate("expiryDate"),
                    rs.getString("unit"),
                    rs.getInt("categoryId"),
                    rs.getString("photo")
                );
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    // Update product
    public boolean updateProduct(Product p) {
        String sql = "UPDATE products SET name=?, price=?, quantity=?, " +
                     "unit=?, categoryId=? WHERE productId=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, p.getName());
            ps.setDouble(2, p.getPrice());
            ps.setInt(3, p.getQuantity());
            ps.setString(4, p.getUnit());
            ps.setInt(5, p.getCategoryId());
            ps.setInt(6, p.getProductId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    // Delete product
    public boolean deleteProduct(int productId) {
        String sql = "DELETE FROM products WHERE productId=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, productId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    // Search product by name
    public List<Product> searchProduct(String keyword) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE name LIKE ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(
                    rs.getInt("productId"),
                    rs.getString("name"),
                    rs.getDouble("price"),
                    rs.getInt("quantity"),
                    rs.getDate("expiryDate"),
                    rs.getString("unit"),
                    rs.getInt("categoryId"),
                    rs.getString("photo")
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
}