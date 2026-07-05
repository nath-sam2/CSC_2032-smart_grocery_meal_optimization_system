/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author perer
 */
import model.DietaryRestriction;
import model.UserDietaryRestriction;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDietaryRestrictionsDAO {
    public boolean addUserRestriction(UserDietaryRestriction userRestriction) {

    String sql = "INSERT INTO UserDietaryRestrictions(userId, restrictionId) VALUES (?, ?)";

    try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)
    ) {

        stmt.setInt(1, userRestriction.getUserId());
        stmt.setInt(2, userRestriction.getRestrictionId());

        return stmt.executeUpdate() > 0;

    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}
    public boolean removeUserRestriction(int userId, int restrictionId) {

    String sql = "DELETE FROM UserDietaryRestrictions WHERE userId=? AND restrictionId=?";

    try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)
    ) {

        stmt.setInt(1, userId);
        stmt.setInt(2, restrictionId);

        return stmt.executeUpdate() > 0;

    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}
    public List<DietaryRestriction> getRestrictionsByUserId(int userId) {

    List<DietaryRestriction> restrictions = new ArrayList<>();

    String sql =
        "SELECT dr.* " +
        "FROM DietaryRestrictions dr " +
        "JOIN UserDietaryRestrictions udr " +
        "ON dr.restrictionId = udr.restrictionId " +
        "WHERE udr.userId = ?";

    try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)
    ) {

        stmt.setInt(1, userId);

        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {

            DietaryRestriction restriction = new DietaryRestriction();

            restriction.setRestrictionId(rs.getInt("restrictionId"));
            restriction.setRestrictionName(rs.getString("restrictionName"));
            restriction.setDescription(rs.getString("description"));

            restrictions.add(restriction);
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return restrictions;
}
    
}
