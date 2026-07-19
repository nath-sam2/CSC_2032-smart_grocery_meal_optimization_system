package dao;

import model.NotificationService;
import util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NotificationDAO {

    // Insert notification
    public boolean insertNotification(int productId,
                                      String message, String type) {
        String sql = "INSERT INTO notifications (notifId, productId, " +
                     "message, type) VALUES (?,?,?,?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            // get count for id
            int id = getCount() + 1;
            ps.setInt(1, id);
            ps.setInt(2, productId);
            ps.setString(3, message);
            ps.setString(4, type);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    private int getCount() {
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(
                 "SELECT COUNT(*) FROM notifications")) {
            rs.next();
            return rs.getInt(1);
        } catch (Exception e) { return 0; }
    }

    // Get all notifications
    public List<NotificationService> getAllNotifications() {
        List<NotificationService> list = new ArrayList<>();
        String sql = "SELECT * FROM notifications ORDER BY timestamp DESC";
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                list.add(new NotificationService(
                    rs.getInt("notifId"),
                    rs.getString("message"),
                    rs.getString("type"),
                    rs.getTimestamp("timestamp")
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // Mark as read
    public boolean markAsRead(int notifId) {
        String sql = "UPDATE notifications SET isRead=true WHERE notifId=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, notifId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    // Get unread notifications
    public List<NotificationService> getUnreadNotifications() {
        List<NotificationService> list = new ArrayList<>();
        String sql = "SELECT * FROM notifications WHERE isRead=false";
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                list.add(new NotificationService(
                    rs.getInt("notifId"),
                    rs.getString("message"),
                    rs.getString("type"),
                    rs.getTimestamp("timestamp")
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
}