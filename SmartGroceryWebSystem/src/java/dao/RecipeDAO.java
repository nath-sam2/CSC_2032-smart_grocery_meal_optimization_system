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

    String sql = "INSERT INTO recipes(name, description, mealType, cuisine, cookingTime, difficulty, servings, imageUrl) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

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
        stmt.setString(8, recipe.getImageUrl());

        stmt.executeUpdate();

        return true;

    } catch (Exception e) {

        e.printStackTrace();
        return false;
    }
}
    public Recipe getRecipeById(int recipeId) {

    String sql = "SELECT * FROM recipes WHERE recipeId = ?";

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
            recipe.setImageUrl(rs.getString("imageUrl"));

            return recipe;
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return null;
}
    public Recipe getRecipeByName(String name) {

    String sql = "SELECT * FROM recipes WHERE LOWER(name) = LOWER(?)";

    try (
        Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)
    ) {

        stmt.setString(1, name);

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
            recipe.setImageUrl(rs.getString("imageUrl"));

            return recipe;
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return null;
}
    public List<Recipe> getAllRecipes() {

    List<Recipe> recipes = new ArrayList<>();

    String sql = "SELECT * FROM recipes";

    try (
        Connection conn = DBConnection.getConnection();
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
            recipe.setImageUrl(rs.getString("imageUrl"));

            recipes.add(recipe);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return recipes;
}
    public boolean updateRecipe(Recipe recipe) {

    String sql = "UPDATE recipes SET name=?, description=?, mealType=?, cuisine=?, cookingTime=?, difficulty=?, servings=?, imageUrl=? WHERE recipeId=?";

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
        stmt.setString(8, recipe.getImageUrl());
        stmt.setInt(9, recipe.getRecipeId());

        int rowsAffected = stmt.executeUpdate();

        return rowsAffected > 0;

    } catch (Exception e) {
        e.printStackTrace();
        return false;
    }
}
public boolean deleteRecipe(int recipeId) {

    String deleteMealPlanDetails = "DELETE FROM mealplandetails WHERE recipeId = ?";
    String deleteRecipeIngredients = "DELETE FROM recipeingredients WHERE recipeId = ?";
    String deleteRecipe = "DELETE FROM recipes WHERE recipeId = ?";

    try (Connection conn = DBConnection.getConnection()) {

        if (conn == null) {
            return false;
        }

        conn.setAutoCommit(false);

        try {

            try (PreparedStatement stmt1 = conn.prepareStatement(deleteMealPlanDetails)) {
                stmt1.setInt(1, recipeId);
                stmt1.executeUpdate();
            }

            try (PreparedStatement stmt2 = conn.prepareStatement(deleteRecipeIngredients)) {
                stmt2.setInt(1, recipeId);
                stmt2.executeUpdate();
            }

            int rowsAffected;

            try (PreparedStatement stmt3 = conn.prepareStatement(deleteRecipe)) {
                stmt3.setInt(1, recipeId);
                rowsAffected = stmt3.executeUpdate();
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