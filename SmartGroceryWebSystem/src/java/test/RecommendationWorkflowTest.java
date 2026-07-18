/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package test;

/**
 *
 * @author perer
 */
import model.MealPlanner;
import model.Recipe;
import model.ShoppingList;
import model.Ingredient;
import service.RecommendationEngine;

import java.util.List;
public class RecommendationWorkflowTest {
    public static void main(String[] args) {
RecommendationEngine engine = new RecommendationEngine();

List<Recipe> recipes = engine.recommendRecipes(6);
System.out.println("Recipes returned with empty inventory: " + recipes.size());

for (Recipe r : recipes) {
    System.out.println(r.getName() + " -> score: " + engine.calculateRecipeScore(r));
}

List<Ingredient> missing = engine.getMissingIngredientsForRecipe(4);
System.out.println("Missing ingredients for recipe 4 (all should be missing): " + missing.size());
    }
}

