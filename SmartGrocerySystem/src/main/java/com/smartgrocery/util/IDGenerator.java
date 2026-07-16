package com.smartgrocery.util;

import java.sql.*;

public class IDGenerator {

    public static int generateId(String table) {
        String sql = "SELECT COUNT(*) FROM " + table;
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
}