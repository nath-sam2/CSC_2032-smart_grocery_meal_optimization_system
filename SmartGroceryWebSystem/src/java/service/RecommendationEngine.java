/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

/**
 *
 * @author perer
 */
import dao.MealPlannerDAO;
import dao.MealPlanDetailDAO;
import dao.DietaryRestrictionDAO;
import dao.NutritionFactsDAO;
import dao.RecipeDAO;
import dao.ShoppingListDAO;
import dao.ShoppingListItemDAO;

import model.Ingredient;
import model.MealPlanner;
import model.MealPlanDetail;
import model.NutritionFacts;
import model.Recipe;
import model.ShoppingList;
import model.ShoppingListItem;
import service.NutriScoreService;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

public class RecommendationEngine {
    private RecipeDAO recipeDAO;
    private NutritionFactsDAO nutritionDAO;
    private DietaryRestrictionDAO restrictionDAO;
    private MealPlannerDAO mealPlannerDAO;
    private MealPlanDetailDAO mealPlanDetailDAO;
    private ShoppingListDAO shoppingListDAO;
    private ShoppingListItemDAO shoppingListItemDAO;

    public RecommendationEngine() {
        recipeDAO = new RecipeDAO();
        nutritionDAO = new NutritionFactsDAO();
        restrictionDAO = new DietaryRestrictionDAO();
        mealPlannerDAO = new MealPlannerDAO();
        mealPlanDetailDAO = new MealPlanDetailDAO();
        shoppingListDAO = new ShoppingListDAO();
        shoppingListItemDAO = new ShoppingListItemDAO();
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
    
    public MealPlanner generateWeeklyMealPlan(int userId){

        List<Recipe> recipes = recommendRecipes(userId);

        MealPlanner planner = new MealPlanner();

        planner.setUserId(userId);
        planner.setPlanName("Weekly Healthy Meal Plan");
        planner.setStartDate(LocalDate.now());
        planner.setEndDate(LocalDate.now().plusDays(6));

        mealPlannerDAO.insertMealPlan(planner);

        LocalDate day = LocalDate.now();

        String[] meals = { "Breakfast", "Lunch", "Dinner"};
        int recipeIndex = 0;

        for(int i=0;i<7;i++){

            for(String meal : meals){

                if(recipeIndex >= recipes.size())
                    recipeIndex = 0;

                MealPlanDetail detail = new MealPlanDetail();

                detail.setMealPlanId(planner.getMealPlanId());
                detail.setRecipeId(recipes.get(recipeIndex).getRecipeId());
                detail.setMealDate(day.plusDays(i));
                detail.setMealType(meal);

                mealPlanDetailDAO.insertMealPlanDetail(detail);

                planner.addRecipe(detail);

                recipeIndex++;
            }
        }
          return planner;

    }

    public ShoppingList createShoppingListFromMealPlan(int mealPlanId){

        MealPlanner planner =
                mealPlannerDAO.getMealPlansById(mealPlanId);

        if(planner==null)
            return null;

        ShoppingList list = new ShoppingList();

        list.setUserId(planner.getUserId());
        list.setCreatedDate(LocalDate.now());
        list.setStatus("Pending");

        shoppingListDAO.insertShoppingList(list);

        return list;

    }

   public List<Ingredient> getMissingIngredients(int mealPlanId){

        /*
            Later:
            Compare RecipeIngredient
            with Inventory module.
         */

        return new ArrayList<>();

    }

    public void compareInventory(int mealPlanId){

        System.out.println("Inventory comparison will be integrated later.");

    }
}
