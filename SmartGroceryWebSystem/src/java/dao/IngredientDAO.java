/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author perer
 */
import model.Ingredient;
import model.RecipeIngredient;

import util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class IngredientDAO {
    public boolean insertIngredient(Ingredient ingredient){
        String sql = "INSERT INTO Ingredients(productId, name, category, unit) VALUES (?, ?, ?, ?)";
        
        try (
        Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)
    ) {

        stmt.setInt(1, ingredient.getProductId());
        stmt.setString(2, ingredient.getName());
        stmt.setString(3, ingredient.getCategory());
        stmt.setString(4, ingredient.getUnit());

        stmt.executeUpdate();

        return true;

    } catch (SQLException e) {

        e.printStackTrace();
        return false;
    }
    }
    
    public Ingredient getIngredientById(int ingredientId){
        String sql = "SELECT * FROM Ingredients WHERE ingredientId = ?";
                
        try (
        Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

        stmt.setInt(1, ingredientId);

        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {

            Ingredient ingredient = new Ingredient();

            ingredient.setIngredientId(rs.getInt("ingredientId"));
            ingredient.setProductId(rs.getInt("productId"));
            ingredient.setName(rs.getString("name"));
            ingredient.setCategory(rs.getString("category"));
            ingredient.setUnit(rs.getString("unit"));

            return ingredient;
        }

        } catch (SQLException e) {
          e.printStackTrace();
        }

        return null;
    }
    public List<Ingredient> getAllIngredients() {

    List<Ingredient> ingredients = new ArrayList<>();

    String sql = "SELECT * FROM Ingredients";

    try (
        Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery()
    ) {

        while (rs.next()) {

            Ingredient ingredient = new Ingredient();

            ingredient.setIngredientId(rs.getInt("ingredientId"));
            ingredient.setProductId(rs.getInt("productId"));
            ingredient.setName(rs.getString("name"));
            ingredient.setCategory(rs.getString("category"));
            ingredient.setUnit(rs.getString("unit"));

            ingredients.add(ingredient);
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return ingredients;
}
    public boolean updateIngredient(Ingredient ingredient) {

    String sql = "UPDATE Ingredients SET productId=?, name=?, category=?, unit=? WHERE ingredientId=?";

    try (
        Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)
    ) {

        stmt.setInt(1, ingredient.getProductId());
        stmt.setString(2, ingredient.getName());
        stmt.setString(3, ingredient.getCategory());
        stmt.setString(4, ingredient.getUnit());
        stmt.setInt(5, ingredient.getIngredientId());

        int rowsAffected = stmt.executeUpdate();

        return rowsAffected > 0;

    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}
    public boolean deleteIngredient(int ingredientId) {

    String sql = "DELETE FROM Ingredients WHERE ingredientId = ?";

    try (
        Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)
    ) {

        stmt.setInt(1, ingredientId);

        int rowsAffected = stmt.executeUpdate();

        return rowsAffected > 0;

    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}
    public static List<RecipeIngredient> getIngredientsByRecipe(int recipeId) {

    List<RecipeIngredient> ingredients = new ArrayList<>();

    String sql =
        "SELECT ri.recipeIngredientId, " +
        "ri.recipeId, " +
        "ri.ingredientId, " +
        "ri.quantity, " +
        "ri.unit, " +
        "i.name AS ingredientName " +
        "FROM recipeingredients ri " +
        "JOIN ingredients i " +
        "ON ri.ingredientId = i.ingredientId " +
        "WHERE ri.recipeId = ?";


    try (
        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement(sql)
    ) {

        ps.setInt(1, recipeId);

        ResultSet rs = ps.executeQuery();


        while(rs.next()) {

            RecipeIngredient ri = new RecipeIngredient();

            ri.setRecipeIngredientId(
                rs.getInt("recipeIngredientId")
            );

            ri.setRecipeId(
                rs.getInt("recipeId")
            );

            ri.setIngredientId(
                rs.getInt("ingredientId")
            );

            ri.setQuantity(
                rs.getDouble("quantity")
            );

            ri.setUnit(
                rs.getString("unit")
            );

            ri.setIngredientName(
                rs.getString("ingredientName")
            );


            ingredients.add(ri);
        }


    } catch(SQLException e) {
        e.printStackTrace();
    }


    return ingredients;
}
}