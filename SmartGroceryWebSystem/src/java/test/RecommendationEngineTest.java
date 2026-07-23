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
List<Recipe> recipes = engine.recommendRecipes(6); // user 6 has Gluten intolerance

for (Recipe r : recipes) {
    System.out.println(r.getName());
}
    }
}
