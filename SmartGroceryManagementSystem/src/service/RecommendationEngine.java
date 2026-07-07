/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

/**
 *
 * @author perer
 */
import dao.DietaryRestrictionDAO;
import dao.NutritionFactsDAO;
import dao.RecipeDAO;
import model.NutritionFacts;
import model.Recipe;
import service.NutriScoreService;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

public class RecommendationEngine {
    private RecipeDAO recipeDAO;
    private NutritionFactsDAO nutritionDAO;
    private DietaryRestrictionDAO restrictionDAO;

    public RecommendationEngine() {
        recipeDAO = new RecipeDAO();
        nutritionDAO = new NutritionFactsDAO();
        restrictionDAO = new DietaryRestrictionDAO();
    }
    
    /**
     * Returns recommended recipes for a user.
     */
    public List<Recipe> recommendRecipes(int userId) {

        List<Recipe> recipes = recipeDAO.getAllRecipes();

        recipes = filterByDietaryRestrictions(recipes, userId);

        recipes = prioritizeByHealthScore(recipes);

        recipes = prioritizeByExpiry(recipes);

        return recipes;
    }

    /**
     * Filters recipes according to dietary restrictions.
     * (Temporary implementation until Member 1 integration.)
     */
    public List<Recipe> filterByDietaryRestrictions(List<Recipe> recipes, int userId) {

        // TODO:
        // Use UserDietaryRestrictionDAO after full integration.
        // Currently returns all recipes.

        return recipes;
    }

     /**
     * Sort recipes from healthiest to least healthy.
     */
    public List<Recipe> prioritizeByHealthScore(List<Recipe> recipes) {

        recipes.sort(new Comparator<Recipe>() {

            @Override
            public int compare(Recipe r1, Recipe r2) {

                NutritionFacts n1 = nutritionDAO.getNutritionFactsByRecipeId(r1.getRecipeId());

                NutritionFacts n2 = nutritionDAO.getNutritionFactsByRecipeId(r2.getRecipeId());

                int score1 = 0;
                int score2 = 0;

                if (n1 != null){
                    score1 = NutriScoreService.calculateNutriScoreValue(n1);
                }
                if (n2 != null){
                    score2 = NutriScoreService.calculateNutriScoreValue(n2);
                }
                // Lower Nutri-Score value = healthier recipe
                return Integer.compare(score1, score2);
            }
        });

        return recipes;
    }

    /**
     * Temporary expiry prioritization.
     * Will be connected to Member 1 inventory module.
     */
    public List<Recipe> prioritizeByExpiry(List<Recipe> recipes) {

        // TODO:
        // Read inventory expiry dates from Member 1.
        // Move recipes using expiring ingredients to the top.

        return recipes;
    }

    /**
     * Temporary shopping list generation.
     */
    public void generateShoppingList(int userId) {

        System.out.println("Shopping list generation will be implemented after inventory integration.");

    }
    
    public char getRecipeGrade(int recipeId) {

        NutritionFacts nutrition = nutritionDAO.getNutritionFactsByRecipeId(recipeId);

        return NutriScoreService.calculateNutriScore(nutrition, false);
    }
}
