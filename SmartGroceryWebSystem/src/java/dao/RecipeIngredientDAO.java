/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.RecipeIngredient;
import model.Ingredient;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class RecipeIngredientDAO {


    public List<Ingredient> getIngredientsByRecipeId(int recipeId) {

        List<Ingredient> ingredients = new ArrayList<>();


        String sql =
        "SELECT i.ingredientId, i.name, ri.quantity, ri.unit " +
        "FROM ingredients i " +
        "JOIN recipeingredients ri " +
        "ON i.ingredientId = ri.ingredientId " +
        "WHERE ri.recipeId = ?";


        try(
            Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)
        ){

            stmt.setInt(1, recipeId);


            ResultSet rs = stmt.executeQuery();


            while(rs.next()){


                RecipeIngredient ingredient = new RecipeIngredient();


                ingredient.setIngredientId(
                    rs.getInt("ingredientId")
                );


                


                ingredient.setQuantity(
                    rs.getDouble("quantity")
                );


                ingredient.setUnit(
                    rs.getString("unit")
                );


                

            }


        }catch (Exception e){

            e.printStackTrace();

        }


        return ingredients;

    }


}