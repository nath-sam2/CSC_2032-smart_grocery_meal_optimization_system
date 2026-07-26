package util;

import java.sql.*;

public class IDGenerator {

    public static int generateId(String table) {
        // Use MAX(id) instead of COUNT(*), so IDs don't collide after a row
        // is deleted (COUNT(*) shrinks but existing max ID stays the same).
        String idColumn = getIdColumn(table);
        String sql = "SELECT COALESCE(MAX(" + idColumn + "), 0) FROM " + table;
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            rs.next();
            return rs.getInt(1) + 1;
        } catch (Exception e) {
            e.printStackTrace();
            return (int)(System.currentTimeMillis() % 10000);
        }
    }

    // Maps table name -> its primary key column name
    private static String getIdColumn(String table) {
        switch (table) {
            case "users": return "userId";
            case "categories": return "categoryId";
            case "products": return "productId";
            case "inventory": return "inventoryId";
            case "orders": return "orderId";
            case "order_items": return "orderItemId";
            default: return "id";
        }
    }
}