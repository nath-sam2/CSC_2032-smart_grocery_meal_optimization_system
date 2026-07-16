/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package test;

import model.Recipe;
import service.RecommendationEngine;

import java.util.ArrayList;
import java.util.List;

public class RecommendationEngineTest {

    public static void main(String[] args) {

        RecommendationEngine engine = new RecommendationEngine();

        // Populate recipes matching active database rows (IDs 17 to 23)
        List<Recipe> recipes = new ArrayList<>();

        Recipe r1 = new Recipe();
        r1.setRecipeId(17);
        r1.setName("Avocado Toast with Egg");

        Recipe r2 = new Recipe();
        r2.setRecipeId(18);
        r2.setName("Pancakes with Maple Syrup");

        Recipe r3 = new Recipe();
        r3.setRecipeId(19);
        r3.setName("Dhal Curry");

        Recipe r4 = new Recipe();
        r4.setRecipeId(20);
        r4.setName("Greek Salad");

        Recipe r5 = new Recipe();
        r5.setRecipeId(21);
        r5.setName("Beef Burgers with Fries");

        Recipe r6 = new Recipe();
        r6.setRecipeId(22);
        r6.setName("Shrimp Pad Thai");

        Recipe r7 = new Recipe();
        r7.setRecipeId(23);
        r7.setName("Vegetable Pasta");

        recipes.add(r1);
        recipes.add(r2);
        recipes.add(r3);
        recipes.add(r4);
        recipes.add(r5);
        recipes.add(r6);
        recipes.add(r7);

        // Test user 5 (Gluten Intolerance)
        int userId = 6;

        List<Recipe> filtered = engine.filterByDietaryRestrictions(
                recipes,
                userId
        );

        System.out.println("Filtered Recipes (Gluten-Free Options):");

        for(Recipe recipe : filtered){
            System.out.println(recipe.getName());
        }
    }
}
