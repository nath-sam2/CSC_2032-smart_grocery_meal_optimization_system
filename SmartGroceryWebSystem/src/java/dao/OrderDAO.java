package dao;

import model.Order;
import model.OrderItem;
import util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    // Insert order
    public boolean insertOrder(Order o) {
        String sql = "INSERT INTO orders (orderId, userId, " +
                     "totalAmount, status) VALUES (?,?,?,?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, o.getOrderId());
            ps.setInt(2, o.getUserId());
            ps.setDouble(3, o.getTotalAmount());
            ps.setString(4, o.getStatus());
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    // Insert order items
    public boolean insertOrderItem(int orderId, OrderItem item) {
        String sql = "INSERT INTO order_items (orderItemId, orderId, " +
                     "productId, quantity, price, subtotal) " +
                     "VALUES (?,?,?,?,?,?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, item.getOrderItemId());
            ps.setInt(2, orderId);
            ps.setInt(3, item.getProductId());
            ps.setInt(4, item.getQuantity());
            ps.setDouble(5, item.getPrice());
            ps.setDouble(6, item.getSubtotal());
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    // Get all orders
    public List<Order> getAllOrders() {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM orders";
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                list.add(new Order(
                    rs.getInt("orderId"),
                    rs.getInt("userId"),
                    rs.getDouble("totalAmount"),
                    rs.getString("status"),
                    rs.getDate("orderDate")
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // Get orders by userId
    public List<Order> getOrdersByUser(int userId) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE userId=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Order(
                    rs.getInt("orderId"),
                    rs.getInt("userId"),
                    rs.getDouble("totalAmount"),
                    rs.getString("status"),
                    rs.getDate("orderDate")
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // Update order status
    public boolean updateStatus(int orderId, String status) {
        String sql = "UPDATE orders SET status=? WHERE orderId=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    // Get order items by orderId
    public List<OrderItem> getOrderItems(int orderId) {
        List<OrderItem> list = new ArrayList<>();
        String sql = "SELECT * FROM order_items WHERE orderId=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new OrderItem(
                    rs.getInt("orderItemId"),
                    rs.getInt("productId"),
                    rs.getInt("quantity"),
                    rs.getDouble("price")
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
}