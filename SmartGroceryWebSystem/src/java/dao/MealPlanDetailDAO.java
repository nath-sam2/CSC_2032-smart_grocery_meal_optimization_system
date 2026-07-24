/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author perer
 */
import model.MealPlanDetail;
import util.DBConnection;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class MealPlanDetailDAO {
    public boolean insertMealPlanDetail(MealPlanDetail detail) {

        String sql = "INSERT INTO mealplandetails (mealPlanId, recipeId, mealType, mealDate) VALUES (?, ?, ?, ?)";

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setInt(1, detail.getMealPlanId());
            stmt.setInt(2, detail.getRecipeId());
            stmt.setString(3, detail.getMealType());
            stmt.setDate(4, Date.valueOf(detail.getMealDate()));

            if(mealExists(
        detail.getMealPlanId(),
        detail.getMealType(),
        detail.getMealDate()
)){

    System.out.println("Meal already exists for this date!");
    return false;

}

            int rows = stmt.executeUpdate();

            if (rows > 0) {
                System.out.println("Meal Plan Detail inserted successfully!");
                return true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        System.out.println("Insert failed!");
        return false;
    }

    public boolean updateMealPlanDetail(MealPlanDetail detail) {

        String sql = "UPDATE mealplandetails SET mealPlanId=?, recipeId=?, mealDate=?, mealType=? WHERE mealPlanDetailId=?";

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setInt(1, detail.getMealPlanId());
            stmt.setInt(2, detail.getRecipeId());
            stmt.setDate(3, Date.valueOf(detail.getMealDate()));
            stmt.setString(4, detail.getMealType());
            stmt.setInt(5, detail.getMealPlanDetailId());

            int rows = stmt.executeUpdate();

            if (rows > 0) {
                System.out.println("Meal Plan Detail updated successfully!");
                return true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        System.out.println("Update failed!");
        return false;
    }

    public boolean deleteMealPlanDetail(int mealPlanDetailId) {

        String sql = "DELETE FROM mealplandetails WHERE mealPlanDetailId=?";

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setInt(1, mealPlanDetailId);

            int rows = stmt.executeUpdate();

            if (rows > 0) {
                System.out.println("Meal Plan Detail deleted successfully!");
                return true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        System.out.println("Delete failed!");
        return false;
    }


    public MealPlanDetail getMealPlanDetailById(int mealPlanDetailId) {

        String sql = "SELECT * FROM mealplandetails WHERE mealPlanDetailId=?";

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setInt(1, mealPlanDetailId);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {

                MealPlanDetail detail = new MealPlanDetail();

                detail.setMealPlanDetailId(rs.getInt("mealPlanDetailId"));
                detail.setMealPlanId(rs.getInt("mealPlanId"));
                detail.setRecipeId(rs.getInt("recipeId"));
                detail.setMealDate(rs.getDate("mealDate").toLocalDate());
                detail.setMealType(rs.getString("mealType"));

                return detail;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    
    public List<MealPlanDetail> getMealDetailsByPlanId(int mealPlanId) {

        List<MealPlanDetail> details = new ArrayList<>();

        String sql = "SELECT * FROM mealplandetails WHERE mealPlanId=?";

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setInt(1, mealPlanId);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {

                MealPlanDetail detail = new MealPlanDetail();

                detail.setMealPlanDetailId(rs.getInt("mealPlanDetailId"));
                detail.setMealPlanId(rs.getInt("mealPlanId"));
                detail.setRecipeId(rs.getInt("recipeId"));
                detail.setMealDate(rs.getDate("mealDate").toLocalDate());
                detail.setMealType(rs.getString("mealType"));

                details.add(detail);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return details;
    }

    public boolean mealExists(int mealPlanId, String mealType, LocalDate mealDate){

    String sql =
    "SELECT * FROM mealplandetails WHERE mealPlanId=? AND mealType=? AND mealDate=?";


    try(
        Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)
    ){

        stmt.setInt(1, mealPlanId);
        stmt.setString(2, mealType);
        stmt.setDate(3, Date.valueOf(mealDate));


        ResultSet rs = stmt.executeQuery();


        return rs.next();


    }catch (Exception e){

        e.printStackTrace();

    }


    return false;

}
}