/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package test;

import model.Recipe;
import model.Ingredient;
import service.RecommendationEngine;

import java.util.ArrayList;
import java.util.List;
import model.ShoppingList;

public class RecommendationEngineTest {

    public static void main(String[] args) {

        RecommendationEngine engine = new RecommendationEngine();

Recipe r4 = engine.recipeDAO.getRecipeById(4); // adjust if method name differs
Recipe r7 = engine.recipeDAO.getRecipeById(7);
Recipe r3 = engine.recipeDAO.getRecipeById(3);

System.out.println("Vegetable Fried Rice (broccoli, expires today): " + engine.calculateRecipeScore(r4));
System.out.println("Oatmeal with Fruits (milk, expires tomorrow): " + engine.calculateRecipeScore(r7));
System.out.println("Chicken Curry (chicken, expires in 5 days): " + engine.calculateRecipeScore(r3));
    }
}
