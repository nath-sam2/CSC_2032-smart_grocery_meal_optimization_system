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

import java.sql.Statement;
import java.sql.ResultSet;

public class MealPlannerDAO {
    public boolean insertMealPlan(MealPlanner mealPlan) {

    String sql = "INSERT INTO mealplans(userId, planName, startDate, endDate) VALUES(?,?,?,?)";

    try (
        Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
    ) {

        stmt.setInt(1, mealPlan.getUserId());
        stmt.setString(2, mealPlan.getPlanName());
        stmt.setDate(3, Date.valueOf(mealPlan.getStartDate()));
        stmt.setDate(4, Date.valueOf(mealPlan.getEndDate()));

        stmt.executeUpdate();

        ResultSet rs = stmt.getGeneratedKeys();

        if (rs.next()) {
            mealPlan.setMealPlanId(rs.getInt(1));
        }

        System.out.println("Meal Plan inserted successfully!");
        return true;

    } catch (SQLException e) {
        e.printStackTrace();
        System.out.println("Insert failed!");
    }

    return false;
}
    
    public boolean updateMealPlan(MealPlanner mealPlan){
        String sql = "UPDATE MealPlans SET userId=?, planName=?, startDate=?, endDate=? WHERE mealPlanId = ?";
        
        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setInt(1, mealPlan.getUserId());
            stmt.setString(2, mealPlan.getPlanName());
            stmt.setDate(3, Date.valueOf(mealPlan.getStartDate()));
            stmt.setDate(4, Date.valueOf(mealPlan.getEndDate()));
            stmt.setInt(5, mealPlan.getMealPlanId());

            stmt.executeUpdate();

            System.out.println("Meal Plan updated successfully!");
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Update failed!");
        }

        return false;
    }

    public boolean deleteMealPlan(int mealPlanId){
        String sql = "DELETE FROM MealPlans WHERE mealPlanId=?";

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setInt(1, mealPlanId);

            stmt.executeUpdate();

            System.out.println("Meal Plan deleted successfully!");
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Delete failed!");
        }
        return false;
    }

    public MealPlanner getMealPlansById(int mealPlanId){
        String sql = "SELECT * FROM MealPlans WHERE mealPlanId = ?";
        
        try (
        Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)
    ) {

        stmt.setInt(1, mealPlanId);

        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {

            MealPlanner mealPlan = new MealPlanner();

            mealPlan.setMealPlanId(rs.getInt("mealPlanId"));
            mealPlan.setUserId(rs.getInt("userId"));
            mealPlan.setPlanName(rs.getString("planName"));
            mealPlan.setStartDate(rs.getDate("startDate").toLocalDate());
            mealPlan.setEndDate(rs.getDate("endDate").toLocalDate());
            

            return mealPlan;
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }
            return null;
    }
    
    public List<MealPlanner> getMealPlansByUser(int userId){
        List<MealPlanner> mealPlans = new ArrayList<>();

        String sql = "SELECT * FROM MealPlans WHERE userId=?";

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setInt(1, userId);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {

                MealPlanner mealPlan = new MealPlanner();

                mealPlan.setMealPlanId(rs.getInt("mealPlanId"));
                mealPlan.setUserId(rs.getInt("userId"));
                mealPlan.setPlanName(rs.getString("planName"));
                mealPlan.setStartDate(rs.getDate("startDate").toLocalDate());
                mealPlan.setEndDate(rs.getDate("endDate").toLocalDate());

                mealPlans.add(mealPlan);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return mealPlans;
    }

    public List<MealPlanner> getWeeklyPlan(int userId){
        return getMealPlansByUser(userId); 
    }
}
