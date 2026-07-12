/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author perer
 */
import model.Recipe;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RecipeDAO {
    public boolean insertRecipe(Recipe recipe) {

    String sql = "INSERT INTO Recipes(name, description, mealType, cuisine, cookingTime, difficulty, servings) VALUES (?, ?, ?, ?, ?, ?, ?)";

    try (
        Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)
    ) {

        stmt.setString(1, recipe.getName());
        stmt.setString(2, recipe.getDescription());
        stmt.setString(3, recipe.getMealType());
        stmt.setString(4, recipe.getCuisine());
        stmt.setInt(5, recipe.getCookingTime());
        stmt.setString(6, recipe.getDifficulty());
        stmt.setInt(7, recipe.getServings());

        stmt.executeUpdate();

        return true;

    } catch (SQLException e) {

        e.printStackTrace();
        return false;
    }
}
    public Recipe getRecipeById(int recipeId) {

    String sql = "SELECT * FROM Recipes WHERE recipeId = ?";

    try (
        Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)
    ) {

        stmt.setInt(1, recipeId);

        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {

            Recipe recipe = new Recipe();

            recipe.setRecipeId(rs.getInt("recipeId"));
            recipe.setName(rs.getString("name"));
            recipe.setDescription(rs.getString("description"));
            recipe.setMealType(rs.getString("mealType"));
            recipe.setCuisine(rs.getString("cuisine"));
            recipe.setCookingTime(rs.getInt("cookingTime"));
            recipe.setDifficulty(rs.getString("difficulty"));
            recipe.setServings(rs.getInt("servings"));

            return recipe;
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return null;
}
    public List<Recipe> getAllRecipes() {
        
        System.out.println("NEW RECIPE DAO RUNNING");

    List<Recipe> recipes = new ArrayList<>();

    String sql = "SELECT * FROM Recipes";

    Connection conn = DBConnection.getConnection();

if(conn == null){
    System.out.println("RecipeDAO: Connection is NULL");
    return recipes;
}

try(
    PreparedStatement stmt = conn.prepareStatement(sql);
    ResultSet rs = stmt.executeQuery()
) {

        while (rs.next()) {

            Recipe recipe = new Recipe();

            recipe.setRecipeId(rs.getInt("recipeId"));
            recipe.setName(rs.getString("name"));
            recipe.setDescription(rs.getString("description"));
            recipe.setMealType(rs.getString("mealType"));
            recipe.setCuisine(rs.getString("cuisine"));
            recipe.setCookingTime(rs.getInt("cookingTime"));
            recipe.setDifficulty(rs.getString("difficulty"));
            recipe.setServings(rs.getInt("servings"));

            recipes.add(recipe);
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return recipes;
}
    public boolean updateRecipe(Recipe recipe) {

    String sql = "UPDATE Recipes SET name=?, description=?, mealType=?, cuisine=?, cookingTime=?, difficulty=?, servings=? WHERE recipeId=?";

    try (
        Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)
    ) {

        stmt.setString(1, recipe.getName());
        stmt.setString(2, recipe.getDescription());
        stmt.setString(3, recipe.getMealType());
        stmt.setString(4, recipe.getCuisine());
        stmt.setInt(5, recipe.getCookingTime());
        stmt.setString(6, recipe.getDifficulty());
        stmt.setInt(7, recipe.getServings());
        stmt.setInt(8, recipe.getRecipeId());

        int rowsAffected = stmt.executeUpdate();

        return rowsAffected > 0;

    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}
public boolean deleteRecipe(int recipeId) {

    String sql = "DELETE FROM Recipes WHERE recipeId = ?";

    try (
        Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)
    ) {

        stmt.setInt(1, recipeId);

        int rowsAffected = stmt.executeUpdate();

        return rowsAffected > 0;

    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}
}
