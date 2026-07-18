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

public class RecommendationEngineTest {

    public static void main(String[] args) {

        RecommendationEngine engine = new RecommendationEngine();

List<Ingredient> missing = engine.getMissingIngredientsForRecipe(4); // Vegetable Fried Rice, recipeId=4

if (missing.isEmpty()) {
    System.out.println("All ingredients available.");
} else {
    for (Ingredient i : missing) {
        System.out.println("Missing: " + i.getName());
    }
}
    }
}
