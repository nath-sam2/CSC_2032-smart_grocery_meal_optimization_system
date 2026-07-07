/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package test;

/**
 *
 * @author perer
 */
import dao.NutritionFactsDAO;
import model.NutritionFacts;
import model.Recipe;
import service.NutriScoreService;
import service.RecommendationEngine;

import java.util.List;

public class RecommendationEngineTest {
    public static void main(String[] args) {

        RecommendationEngine engine = new RecommendationEngine();
        NutritionFactsDAO nutritionDAO = new NutritionFactsDAO();

        List<Recipe> recipes = engine.recommendRecipes(1);

        System.out.println("========== RECOMMENDED RECIPES ==========\n");

        for (Recipe recipe : recipes) {

            NutritionFacts nutrition =
                    nutritionDAO.getNutritionFactsByRecipeId(recipe.getRecipeId());

            System.out.println("Recipe ID   : " + recipe.getRecipeId());
            System.out.println("Recipe Name : " + recipe.getName());

            if (nutrition != null) {

                int score = NutriScoreService.calculateNutriScoreValue(nutrition);
                char grade = NutriScoreService.calculateNutriScore(nutrition, false);

                System.out.println("NutriScore  : " + grade);
                System.out.println("Score       : " + score);
                System.out.println("Calories    : " + nutrition.getCalories());
                System.out.println("Protein     : " + nutrition.getProtein());
                System.out.println("Sugar       : " + nutrition.getTotalSugar());
                System.out.println("Sodium      : " + nutrition.getSodium());
            } else {

                System.out.println("No nutrition facts found.");
            }

            System.out.println("----------------------------------------");
        }
    }
}
