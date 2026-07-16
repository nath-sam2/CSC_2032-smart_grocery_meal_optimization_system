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
import service.RecommendationEngine;

import java.util.List;
public class RecommendationWorkflowTest {
    public static void main(String[] args) {

        RecommendationEngine engine = new RecommendationEngine();

        int userId = 1;

        System.out.println("============== STEP 1 ==============");
        System.out.println("Recommended Recipes");

        List<Recipe> recipes = engine.recommendRecipes(userId);

        for(Recipe recipe : recipes){

            System.out.println(recipe.getRecipeId()+ " - " + recipe.getName());

        }
        
        System.out.println("\n============== STEP 2 ==============");
        System.out.println("Generate Weekly Meal Plan");

        MealPlanner planner = engine.generateWeeklyMealPlan(userId);

        System.out.println(planner);

        System.out.println("\n============== STEP 3 ==============");
        System.out.println("Generate Shopping List");

        //ShoppingList shoppingList = engine.createShoppingListFromMealPlan(planner.getMealPlanId());//

        //System.out.println(shoppingList);//

        System.out.println("\n============== STEP 4 ==============");
        System.out.println("Inventory Check");

        engine.compareInventory(planner.getMealPlanId());

        System.out.println("\n============== DONE ==============");
    }
}
