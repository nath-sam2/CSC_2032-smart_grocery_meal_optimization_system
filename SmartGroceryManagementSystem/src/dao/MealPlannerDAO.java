/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author perer
 */
import model.MealPlanner;
import model.MealPlanDetail;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
public class MealPlannerDAO {
    public boolean insertMealPlan(MealPlanner mealPlan){
        String sql = "INSERT INTO MealPlans (userId, planName, startDate, endDate) VALUES (?, ?, ?, ?)";
        
        try (
        Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)
    ) {

        stmt.setInt(1, mealPlan.getUserId());
        stmt.setString(2, mealPlan.getPlanName());
        stmt.setDate(3, Date.valueOf(mealPlan.getStartDate()));
        stmt.setDate(4, Date.valueOf(mealPlan.getEndDate()));
        
        stmt.executeUpdate();

        return true;

    } catch (SQLException e) {

        e.printStackTrace();
        return false;
    }
    }
    
    public MealPlanner getMealPlannerById(int mealPlanId){
        String sql = "SELECT * FROM MealPlans WHERE mealPlanId = ?";
        
        try (
        Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)
    ) {

        stmt.setInt(1, mealPlanId);

        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {

            MealPlanner mealPlan = new MealPlanner();

            mealPlan.setMealPlanId(rs.getInt(mealPlanId));
            mealPlan.setUserId(rs.getInt("userId"));
            mealPlan.setPlanName(rs.getString("planName"));
            mealPlan.setStartDate(rs.getDate("startDate").toLocalDate());
            mealPlan.setEndDate(rs.getDate("EndDate").toLocalDate());
            

            return mealPlan;
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }
            return null;
    }
}
