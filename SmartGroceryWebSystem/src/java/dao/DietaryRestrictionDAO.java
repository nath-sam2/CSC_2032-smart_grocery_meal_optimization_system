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
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DietaryRestrictionDAO {
    public boolean insertRestriction(DietaryRestriction restriction){
        String sql = "INSERT INTO dietaryrestrictions (restrictionName, description) VALUES (?, ?)";
        
        try(
            Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)
            ){
            stmt.setString(1, restriction.getRestrictionName());
            stmt.setString(2, restriction.getDescription());
            
            stmt.executeUpdate();
            
            return true;
        } catch (Exception e) {
            e.printStackTrace();;
            return false;
        }
    }
    public DietaryRestriction getRestrictionById(int restrictionId) {
         String sql = "SELECT * FROM dietaryrestrictions WHERE restrictionId = ?";
                
        try (
        Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

        stmt.setInt(1, restrictionId);

        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {

            DietaryRestriction restricrtion = new DietaryRestriction();

            restricrtion.setRestrictionId(rs.getInt("restrictionId"));
            restricrtion.setDescription(rs.getString("description"));
            restricrtion.setRestrictionName(rs.getString("restrictionName"));
            
            return restricrtion;
        }

        } catch (Exception e) {
          e.printStackTrace();
        }

        return null;
    }

    public List<DietaryRestriction> getAllRestrictions() {
        List<DietaryRestriction> restrictions = new ArrayList<>();

    String sql = "SELECT * FROM dietaryrestrictions";

    try (
        Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery()
    ) {

        while (rs.next()) {

            DietaryRestriction restriction = new DietaryRestriction();

            restriction.setRestrictionId(rs.getInt("restrictionId"));
            restriction.setRestrictionName(rs.getString("restrictionName"));
            restriction.setDescription(rs.getString("description"));
            

            restrictions.add(restriction);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
        return restrictions;
    }
    public boolean updateRestriction(DietaryRestriction restriction) {

    String sql = "UPDATE dietaryrestrictions SET restrictionName=?, description=? WHERE restrictionId=?";

    try (
        Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)
    ) {

        stmt.setString(1, restriction.getRestrictionName());
        stmt.setString(2, restriction.getDescription());
        stmt.setInt(3, restriction.getRestrictionId());

        int rowsAffected = stmt.executeUpdate();

        return rowsAffected > 0;

    } catch (Exception e) {
        e.printStackTrace();
        return false;
    }
   } 

    public boolean deleteRestriction(int restrictionId) {

    String deleteUserLinks = "DELETE FROM userdietaryrestrictions WHERE restrictionId = ?";
    String deleteRestrictionSql = "DELETE FROM dietaryrestrictions WHERE restrictionId = ?";

    try (Connection conn = DBConnection.getConnection()) {

        if (conn == null) {
            return false;
        }

        conn.setAutoCommit(false);

        try {

            try (PreparedStatement stmt1 = conn.prepareStatement(deleteUserLinks)) {
                stmt1.setInt(1, restrictionId);
                stmt1.executeUpdate();
            }

            int rowsAffected;

            try (PreparedStatement stmt2 = conn.prepareStatement(deleteRestrictionSql)) {
                stmt2.setInt(1, restrictionId);
                rowsAffected = stmt2.executeUpdate();
            }

            conn.commit();

            return rowsAffected > 0;

        } catch (Exception e) {
            conn.rollback();
            throw e;
        } finally {
            conn.setAutoCommit(true);
        }

    } catch (Exception e) {
        e.printStackTrace();
        return false;
    }
    }

}