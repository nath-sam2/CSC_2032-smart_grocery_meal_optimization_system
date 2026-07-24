/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author perer
 */
import model.NutritionFacts;
import util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
public class NutritionFactsDAO {
    public boolean insertNutritionFacts(NutritionFacts nutrition) {

    String sql = "INSERT INTO nutritionfacts (recipeId, servingSize, servingsPerContainer, calories, totalFat, saturatedFat, transFat, cholesterol, sodium, totalCarbohydrates, dietaryFiber, totalSugar, addedSugar, protein, vitaminA, vitaminC, vitaminD, calcium, iron, potassium) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    try (
        Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)
    ) {

        stmt.setInt(1, nutrition.getRecipeId());
        stmt.setString(2, nutrition.getServingSize());
        stmt.setInt(3, nutrition.getServingsPerContainer());
        stmt.setDouble(4, nutrition.getCalories());
        stmt.setDouble(5, nutrition.getTotalFat());
        stmt.setDouble(6, nutrition.getSaturatedFat());
        stmt.setDouble(7, nutrition.getTransFat());
        stmt.setDouble(8, nutrition.getCholesterol());
        stmt.setDouble(9, nutrition.getSodium());
        stmt.setDouble(10, nutrition.getTotalCarbohydrates());
        stmt.setDouble(11, nutrition.getDietaryFiber());
        stmt.setDouble(12, nutrition.getTotalSugar());
        stmt.setDouble(13, nutrition.getAddedSugar());
        stmt.setDouble(14, nutrition.getProtein());
        stmt.setDouble(15, nutrition.getVitaminA());
        stmt.setDouble(16, nutrition.getVitaminC());
        stmt.setDouble(17, nutrition.getVitaminD());
        stmt.setDouble(18, nutrition.getCalcium());
        stmt.setDouble(19, nutrition.getIron());
        stmt.setDouble(20, nutrition.getPotassium());

        return stmt.executeUpdate() > 0;

    } catch (Exception e) {
        e.printStackTrace();
        return false;
    }
}
    public NutritionFacts getNutritionFactsById(int nutritionId) {

        String sql = "SELECT * FROM nutritionfacts WHERE nutritionId = ?";

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setInt(1, nutritionId);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {

                NutritionFacts nutrition = new NutritionFacts();

                nutrition.setNutritionId(rs.getInt("nutritionId"));
                nutrition.setRecipeId(rs.getInt("recipeId"));
                nutrition.setServingSize(rs.getString("servingSize"));
                nutrition.setServingsPerContainer(rs.getInt("servingsPerContainer"));
                nutrition.setCalories(rs.getDouble("calories"));
                nutrition.setTotalFat(rs.getDouble("totalFat"));
                nutrition.setSaturatedFat(rs.getDouble("saturatedFat"));
                nutrition.setTransFat(rs.getDouble("transFat"));
                nutrition.setCholesterol(rs.getDouble("cholesterol"));
                nutrition.setSodium(rs.getDouble("sodium"));
                nutrition.setTotalCarbohydrates(rs.getDouble("totalCarbohydrates"));
                nutrition.setDietaryFiber(rs.getDouble("dietaryFiber"));
                nutrition.setTotalSugar(rs.getDouble("totalSugar"));
                nutrition.setAddedSugar(rs.getDouble("addedSugar"));
                nutrition.setProtein(rs.getDouble("protein"));
                nutrition.setVitaminA(rs.getDouble("vitaminA"));
                nutrition.setVitaminC(rs.getDouble("vitaminC"));
                nutrition.setVitaminD(rs.getDouble("vitaminD"));
                nutrition.setCalcium(rs.getDouble("calcium"));
                nutrition.setIron(rs.getDouble("iron"));
                nutrition.setPotassium(rs.getDouble("potassium"));

                return nutrition;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public List<NutritionFacts> getAllNutritionFacts() {

        List<NutritionFacts> nutritionList = new ArrayList<>();

        String sql = "SELECT * FROM nutritionfacts";

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()
        ) {

            while (rs.next()) {

                NutritionFacts nutrition = new NutritionFacts();

                nutrition.setNutritionId(rs.getInt("nutritionId"));
                nutrition.setRecipeId(rs.getInt("recipeId"));
                nutrition.setServingSize(rs.getString("servingSize"));
                nutrition.setServingsPerContainer(rs.getInt("servingsPerContainer"));
                nutrition.setCalories(rs.getDouble("calories"));
                nutrition.setTotalFat(rs.getDouble("totalFat"));
                nutrition.setSaturatedFat(rs.getDouble("saturatedFat"));
                nutrition.setTransFat(rs.getDouble("transFat"));
                nutrition.setCholesterol(rs.getDouble("cholesterol"));
                nutrition.setSodium(rs.getDouble("sodium"));
                nutrition.setTotalCarbohydrates(rs.getDouble("totalCarbohydrates"));
                nutrition.setDietaryFiber(rs.getDouble("dietaryFiber"));
                nutrition.setTotalSugar(rs.getDouble("totalSugar"));
                nutrition.setAddedSugar(rs.getDouble("addedSugar"));
                nutrition.setProtein(rs.getDouble("protein"));
                nutrition.setVitaminA(rs.getDouble("vitaminA"));
                nutrition.setVitaminC(rs.getDouble("vitaminC"));
                nutrition.setVitaminD(rs.getDouble("vitaminD"));
                nutrition.setCalcium(rs.getDouble("calcium"));
                nutrition.setIron(rs.getDouble("iron"));
                nutrition.setPotassium(rs.getDouble("potassium"));

                nutritionList.add(nutrition);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return nutritionList;
    }

    public boolean updateNutritionFacts(NutritionFacts nutrition) {

        String sql = "UPDATE nutritionfacts SET recipeId=?, servingSize=?, servingsPerContainer=?, calories=?, totalFat=?, saturatedFat=?, transFat=?, cholesterol=?, sodium=?, totalCarbohydrates=?, dietaryFiber=?, totalSugar=?, addedSugar=?, protein=?, vitaminA=?, vitaminC=?, vitaminD=?, calcium=?, iron=?, potassium=? WHERE nutritionId=?";

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setInt(1, nutrition.getRecipeId());
            stmt.setString(2, nutrition.getServingSize());
            stmt.setInt(3, nutrition.getServingsPerContainer());
            stmt.setDouble(4, nutrition.getCalories());
            stmt.setDouble(5, nutrition.getTotalFat());
            stmt.setDouble(6, nutrition.getSaturatedFat());
            stmt.setDouble(7, nutrition.getTransFat());
            stmt.setDouble(8, nutrition.getCholesterol());
            stmt.setDouble(9, nutrition.getSodium());
            stmt.setDouble(10, nutrition.getTotalCarbohydrates());
            stmt.setDouble(11, nutrition.getDietaryFiber());
            stmt.setDouble(12, nutrition.getTotalSugar());
            stmt.setDouble(13, nutrition.getAddedSugar());
            stmt.setDouble(14, nutrition.getProtein());
            stmt.setDouble(15, nutrition.getVitaminA());
            stmt.setDouble(16, nutrition.getVitaminC());
            stmt.setDouble(17, nutrition.getVitaminD());
            stmt.setDouble(18, nutrition.getCalcium());
            stmt.setDouble(19, nutrition.getIron());
            stmt.setDouble(20, nutrition.getPotassium());
            stmt.setInt(21, nutrition.getNutritionId());

            return stmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean deleteNutritionFacts(int nutritionId) {

        String sql = "DELETE FROM nutritionfacts WHERE nutritionId = ?";

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setInt(1, nutritionId);

            return stmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public NutritionFacts getNutritionFactsByRecipeId(int recipeId) {

    String sql = "SELECT * FROM nutritionfacts WHERE recipeId = ?";

    try (
        Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)
    ) {

        stmt.setInt(1, recipeId);

        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {

            NutritionFacts nutrition = new NutritionFacts();

            nutrition.setNutritionId(rs.getInt("nutritionId"));
            nutrition.setRecipeId(rs.getInt("recipeId"));
            nutrition.setServingSize(rs.getString("servingSize"));
            nutrition.setServingsPerContainer(rs.getInt("servingsPerContainer"));
            nutrition.setCalories(rs.getDouble("calories"));
            nutrition.setTotalFat(rs.getDouble("totalFat"));
            nutrition.setSaturatedFat(rs.getDouble("saturatedFat"));
            nutrition.setTransFat(rs.getDouble("transFat"));
            nutrition.setCholesterol(rs.getDouble("cholesterol"));
            nutrition.setSodium(rs.getDouble("sodium"));
            nutrition.setTotalCarbohydrates(rs.getDouble("totalCarbohydrates"));
            nutrition.setDietaryFiber(rs.getDouble("dietaryFiber"));
            nutrition.setTotalSugar(rs.getDouble("totalSugar"));
            nutrition.setAddedSugar(rs.getDouble("addedSugar"));
            nutrition.setProtein(rs.getDouble("protein"));
            nutrition.setVitaminA(rs.getDouble("vitaminA"));
            nutrition.setVitaminC(rs.getDouble("vitaminC"));
            nutrition.setVitaminD(rs.getDouble("vitaminD"));
            nutrition.setCalcium(rs.getDouble("calcium"));
            nutrition.setIron(rs.getDouble("iron"));
            nutrition.setPotassium(rs.getDouble("potassium"));

            return nutrition;
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return null;
    }
    public NutritionFacts getNutritionByRecipeId(int recipeId) {

    NutritionFacts nutrition = null;

    String sql = "SELECT * FROM nutritionfacts WHERE recipeId = ?";


    try {

        Connection con = DBConnection.getConnection();

        PreparedStatement ps = con.prepareStatement(sql);

        ps.setInt(1, recipeId);


        ResultSet rs = ps.executeQuery();


        if(rs.next()) {

            nutrition = new NutritionFacts();


            nutrition.setNutritionId(
                    rs.getInt("nutritionId")
            );


            nutrition.setRecipeId(
                    rs.getInt("recipeId")
            );


            nutrition.setServingSize(
                    rs.getString("servingSize")
            );


            nutrition.setServingsPerContainer(
                    rs.getInt("servingsPerContainer")
            );


            nutrition.setCalories(
                    rs.getDouble("calories")
            );


            nutrition.setTotalFat(
                    rs.getDouble("totalFat")
            );


            nutrition.setSaturatedFat(
                    rs.getDouble("saturatedFat")
            );


            nutrition.setTransFat(
                    rs.getDouble("transFat")
            );


            nutrition.setCholesterol(
                    rs.getDouble("cholesterol")
            );


            nutrition.setSodium(
                    rs.getDouble("sodium")
            );


            nutrition.setTotalCarbohydrates(
                    rs.getDouble("totalCarbohydrates")
            );


            nutrition.setDietaryFiber(
                    rs.getDouble("dietaryFiber")
            );


            nutrition.setTotalSugar(
                    rs.getDouble("totalSugar")
            );


            nutrition.setAddedSugar(
                    rs.getDouble("addedSugar")
            );


            nutrition.setProtein(
                    rs.getDouble("protein")
            );


            nutrition.setVitaminA(
                    rs.getDouble("vitaminA")
            );


            nutrition.setVitaminC(
                    rs.getDouble("vitaminC")
            );


            nutrition.setVitaminD(
                    rs.getDouble("vitaminD")
            );


            nutrition.setCalcium(
                    rs.getDouble("calcium")
            );


            nutrition.setIron(
                    rs.getDouble("iron")
            );


            nutrition.setPotassium(
                    rs.getDouble("potassium")
            );

        }


    } catch(Exception e) {

        e.printStackTrace();

    }


    return nutrition;
}
}