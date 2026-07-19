/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import dao.InventoryDAO;
import dao.IngredientDAO;
import dao.MealPlannerDAO;
import dao.MealPlanDetailDAO;
import dao.UserDietaryRestrictionDAO;
import dao.NutritionFactsDAO;
import dao.RecipeIngredientDAO;
import dao.RecipeDAO;
import dao.ShoppingListDAO;
import dao.ShoppingListItemDAO;

import model.Inventory;
import model.RecipeIngredient;
import model.DietaryRestriction;
import model.Ingredient;
import model.MealPlanner;
import model.MealPlanDetail;
import model.NutritionFacts;
import model.Recipe;
import model.ShoppingList;
import model.ShoppingListItem;
import model.Product;

import java.util.HashSet;
import java.util.Set;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;



public class RecommendationEngine {


    private IngredientDAO ingredientDAO;
    public RecipeDAO recipeDAO;
    private NutritionFactsDAO nutritionDAO;
    private MealPlannerDAO mealPlannerDAO;
    private MealPlanDetailDAO mealPlanDetailDAO;
    private ShoppingListDAO shoppingListDAO;
    private ShoppingListItemDAO shoppingListItemDAO;
    private RecipeIngredientDAO recipeIngredientDAO;
    private InventoryDAO inventoryDAO;


    public RecommendationEngine(){


        ingredientDAO = new IngredientDAO();
        
        recipeDAO = new RecipeDAO();

        nutritionDAO = new NutritionFactsDAO();

        recipeIngredientDAO = new RecipeIngredientDAO();

        mealPlannerDAO = new MealPlannerDAO();

        mealPlanDetailDAO = new MealPlanDetailDAO();

        shoppingListDAO = new ShoppingListDAO();

        shoppingListItemDAO = new ShoppingListItemDAO();
        
        inventoryDAO = new InventoryDAO();

    }




    /*
        Check if recipe contains an ingredient keyword
    */
    private boolean containsIngredient(Recipe recipe, String keyword) {

    List<RecipeIngredient> ingredients =
            IngredientDAO.getIngredientsByRecipe(recipe.getRecipeId());

    for (RecipeIngredient ri : ingredients) {

        Ingredient ingredient =
                ingredientDAO.getIngredientById(ri.getIngredientId());

        if (ingredient != null) {

            String ingredientName =
                    ingredient.getName().toLowerCase();

            if (ingredientName.contains(keyword.toLowerCase())) {
                return true;
            }
        }
    }

    return false;
}






    /*
        Main recommendation process
    */
    public List<Recipe> recommendRecipes(int userId){

    List<Recipe> recipes = recipeDAO.getAllRecipes();

    // Dietary restrictions = hard exclusion, highest priority
    recipes = filterByDietaryRestrictions(recipes, userId);

    // Combined scoring: nutrition + inventory + expiry - missing
    recipes.sort((r1, r2) ->
            Double.compare(
                    calculateRecipeScore(r2),
                    calculateRecipeScore(r1)
            )
    );

    return recipes;
}






    /*
        Filter recipes using user restrictions
    */
    public List<Recipe> filterByDietaryRestrictions(
            List<Recipe> recipes,
            int userId){



        UserDietaryRestrictionDAO userDAO =
                new UserDietaryRestrictionDAO();



        List<DietaryRestriction> restrictions =
                userDAO.getRestrictionsByUserId(userId);


        System.out.println("User ID = " + userId);
System.out.println("Restriction Count = " + restrictions.size());

for (DietaryRestriction restriction : restrictions) {
    System.out.println("Restriction -> " + restriction.getRestrictionName());
}

        List<Recipe> result =
                new ArrayList<>();




        for(Recipe recipe : recipes){


            boolean allowed = true;



            for(DietaryRestriction restriction : restrictions){



                String type =
                        restriction.getRestrictionName();




                if(type.toLowerCase().contains("vegetarian")){


                    if(containsIngredient(recipe,"chicken")
                    || containsIngredient(recipe,"beef")
                    || containsIngredient(recipe,"pork")
                    || containsIngredient(recipe,"fish")
                    || containsIngredient(recipe,"meat")
                    || containsIngredient(recipe,"shrimp")
                    || containsIngredient(recipe,"eggs")
                    || containsIngredient(recipe, "salmon")  
                    || containsIngredient(recipe, "tuna")    
                    || containsIngredient(recipe, "bacon")   
                    || containsIngredient(recipe, "ham")     
                    || containsIngredient(recipe, "turkey")  
                    || containsIngredient(recipe, "mutton")  
                    || containsIngredient(recipe, "prawn")
                    || containsIngredient(recipe, "breast")
                    || containsIngredient(recipe, "fillet")
                    || containsIngredient(recipe, "thigs")        ){


                        allowed=false;

                    }

                }




                else if(type.toLowerCase().contains("gluten")){


                    if(containsIngredient(recipe,"wheat")
                    || containsIngredient(recipe,"bread")
                    || containsIngredient(recipe,"flour")
                    || containsIngredient(recipe,"pasta")
                    || containsIngredient(recipe,"bun")
                    || containsIngredient(recipe,"crust")
                    || containsIngredient(recipe,"tortilla")
                    || containsIngredient(recipe,"dough")        ){


                        allowed=false;

                    }

                }





                else if(type.toLowerCase().contains("peanut")){


                    if(containsIngredient(recipe,"nut")
                    || containsIngredient(recipe,"peanut")
                    || containsIngredient(recipe,"almond")
                    || containsIngredient(recipe,"cashew")){


                        allowed=false;

                    }

                }





                else if(type.toLowerCase().contains("lactose")){


                    if(containsIngredient(recipe,"milk")
                    || containsIngredient(recipe,"cheese")
                    || containsIngredient(recipe,"butter")
                    || containsIngredient(recipe,"cream")
                    || containsIngredient(recipe,"feta")        ){


                        allowed=false;

                    }

                }





                else if(type.equalsIgnoreCase("Egg Allergy")){


                    if(containsIngredient(recipe,"egg")){


                        allowed=false;

                    }

                }





                else if(type.equalsIgnoreCase("Seafood Allergy")){


                    if(containsIngredient(recipe,"fish")
                    || containsIngredient(recipe,"shrimp")
                    || containsIngredient(recipe,"seafood")
                    || containsIngredient(recipe,"prawn")
                    || containsIngredient(recipe,"crab")
                    || containsIngredient(recipe, "salmon")  // FIXED: Catches Salmon Fillet
                    || containsIngredient(recipe, "tuna")    // FIXED: Catches Tuna Chunks
                    || containsIngredient(recipe, "lobster") // FIXED: Catches Lobster Tail
                    || containsIngredient(recipe, "squid")   // FIXED: Catches Squid Rings
                    || containsIngredient(recipe, "calamari")        ){


                        allowed=false;

                    }

                }



            }



            if (allowed) {
    System.out.println("ALLOWED : " + recipe.getName());
    result.add(recipe);
} else {
    System.out.println("BLOCKED : " + recipe.getName());
}


        }



        return result;

    }







    /*
        Sort recipes according to NutriScore
    */
    public List<Recipe> sortByNutriScore(
            List<Recipe> recipes){



        recipes.sort(
                new Comparator<Recipe>(){


            @Override
            public int compare(
                    Recipe r1,
                    Recipe r2){



                NutritionFacts n1 =
                nutritionDAO
                .getNutritionFactsByRecipeId(
                        r1.getRecipeId()
                );



                NutritionFacts n2 =
                nutritionDAO
                .getNutritionFactsByRecipeId(
                        r2.getRecipeId()
                );



                int score1 =
                        Integer.MAX_VALUE;



                int score2 =
                        Integer.MAX_VALUE;



                if(n1 != null){

                    score1 =
                    NutriScoreService
                    .calculateNutriScoreValue(n1);

                }



                if(n2 != null){

                    score2 =
                    NutriScoreService
                    .calculateNutriScoreValue(n2);

                }




                return Integer.compare(
                        score1,
                        score2
                );


            }


        });



        return recipes;

    }








    /*
        Inventory expiry integration point
    */
    public List<Recipe> prioritizeByExpiry(
            List<Recipe> recipes){


        /*
            Future:
            Connect Member 1 Inventory DAO

            Find ingredients close to expiry

            Move recipes using those ingredients
            to the top

        */


        return recipes;

    }







    /*
        Return NutriScore grade
    */
    public char getRecipeGrade(
            int recipeId){



        NutritionFacts nutrition =
        nutritionDAO
        .getNutritionFactsByRecipeId(
                recipeId
        );



        return NutriScoreService
                .calculateNutriScore(
                        nutrition,
                        false
                );

    }








    /*
        Generate weekly meal plan
    */
    public MealPlanner generateWeeklyMealPlan(
            int userId){



        List<Recipe> recipes =
                recommendRecipes(userId);


        if(recipes.isEmpty()){
        System.out.println("No suitable recipes found for user " + userId + " - cannot generate meal plan.");
        return null;
    }

        MealPlanner planner =
                new MealPlanner();



        planner.setUserId(userId);

        planner.setPlanName(
                "Weekly Healthy Meal Plan"
        );


        planner.setStartDate(
                LocalDate.now()
        );


        planner.setEndDate(
                LocalDate.now()
                .plusDays(6)
        );



        mealPlannerDAO.insertMealPlan(planner);



        LocalDate date =
                LocalDate.now();



        String meals[] =
        {
            "Breakfast",
            "Lunch",
            "Dinner"
        };



        int index=0;



        for(int i=0;i<7;i++){


            for(String meal:meals){



                if(index >= recipes.size()){

                    index=0;

                }



                MealPlanDetail detail =
                        new MealPlanDetail();



                detail.setMealPlanId(
                        planner.getMealPlanId()
                );



                detail.setRecipeId(
                        recipes.get(index)
                        .getRecipeId()
                );



                detail.setMealDate(
                        date.plusDays(i)
                );



                detail.setMealType(meal);



                mealPlanDetailDAO
                .insertMealPlanDetail(detail);



                planner.addRecipe(detail);



                index++;

            }


        }



        return planner;

    }






    /*
        Shopping list integration
    */
    public ShoppingList generateShoppingListFromMealPlan(int mealPlanId) {


    // Get meal plan
    MealPlanner planner =
            mealPlannerDAO.getMealPlansById(mealPlanId);


    if(planner == null){

        return null;

    }



    // Create new shopping list

    ShoppingList shoppingList =
            new ShoppingList();


    shoppingList.setUserId(
            planner.getUserId()
    );


    shoppingList.setCreatedDate(
            LocalDate.now()
    );


    shoppingList.setStatus(
            "Pending"
    );



    // Save shopping list

    shoppingListDAO.insertShoppingList(shoppingList);




    // Get recipes from meal plan

    List<MealPlanDetail> details =
            mealPlanDetailDAO
            .getMealDetailsByPlanId(mealPlanId);




    // Collect ingredients, combining duplicates across the whole meal plan

java.util.Map<Integer, ShoppingListItem> combined = new java.util.HashMap<>();

for(MealPlanDetail detail : details){

    List<Ingredient> missingIngredients =
            getMissingIngredientsForRecipe(
                    detail.getRecipeId()
            );

    for(Ingredient ingredient : missingIngredients){

        int id = ingredient.getIngredientId();

        if(combined.containsKey(id)){

            ShoppingListItem existing = combined.get(id);
            existing.setQuantity(existing.getQuantity() + 1);

        } else {

            ShoppingListItem item = new ShoppingListItem();

            item.setShoppingListId(shoppingList.getShoppingListId());
            item.setIngredientId(id);
            item.setQuantity(1);
            item.setUnit(ingredient.getUnit());
            item.setStatus("Pending");

            combined.put(id, item);
        }
    }
}

for(ShoppingListItem item : combined.values()){
    shoppingListItemDAO.insertShoppingListItem(item);
}


    return shoppingList;

}






    public boolean isIngredientAvailable(int ingredientId, double requiredQty) {

    Ingredient ingredient = ingredientDAO.getIngredientById(ingredientId);

    if (ingredient == null) {
        return false;
    }

    Inventory inventory = inventoryDAO.getInventoryByProduct(ingredient.getProductId());

    if (inventory == null) {
        return false;
    }

    return inventory.getQuantity() >= requiredQty;
}


public List<Ingredient> getMissingIngredientsForRecipe(int recipeId) {

    List<Ingredient> missing = new ArrayList<>();

    List<RecipeIngredient> required =
            IngredientDAO.getIngredientsByRecipe(recipeId);

    for (RecipeIngredient ri : required) {

        if (!isIngredientAvailable(ri.getIngredientId(), ri.getQuantity())) {

            Ingredient ingredient =
                    ingredientDAO.getIngredientById(ri.getIngredientId());

            if (ingredient != null) {
                missing.add(ingredient);
            }
        }
    }

    return missing;
}






    public void compareInventory(
            int mealPlanId){


        System.out.println(
        "Inventory integration pending"
        );


    }


    public List<Recipe> recommendWasteReducingRecipes(int userId) {

    List<Recipe> recipes = recommendRecipes(userId);

    recipes = prioritizeExpiringIngredients(recipes);

    recipes = sortRecommendations(recipes);

    return recipes;
}
    
    public double calculateWasteReductionScore(Recipe recipe) {

    double score = 0;

    NutritionFacts nutrition =
            nutritionDAO.getNutritionFactsByRecipeId(
                    recipe.getRecipeId());

    if (nutrition != null) {

        char grade = NutriScoreService.calculateNutriScore(
                nutrition, false);

        switch (grade) {

            case 'A':
                score += 20;
                break;

            case 'B':
                score += 15;
                break;

            case 'C':
                score += 10;
                break;

            case 'D':
                score += 5;
                break;

            default:
                score += 0;
        }
    }

    List<Product> expiringProducts =
        inventoryDAO.getExpiringItems(3);

for (Product product : expiringProducts) {

    if (containsProduct(recipe, product.getProductId())) {

        score += 25;

    }

}

    return score;
}
    
    public List<Recipe> prioritizeExpiringIngredients(List<Recipe> recipes) {

    List<Product> expiringProducts =
            inventoryDAO.getExpiringItems(3);

    if (expiringProducts.isEmpty()) {
        return recipes;
    }

    Set<Integer> expiringProductIds = new HashSet<>();

    for (Product product : expiringProducts) {
        expiringProductIds.add(product.getProductId());
    }

    recipes.sort((r1, r2) -> {

        int score1 = countExpiringIngredients(r1, expiringProductIds);
        int score2 = countExpiringIngredients(r2, expiringProductIds);

        return Integer.compare(score2, score1);

    });

    return recipes;
}
    
    private int countExpiringIngredients(
        Recipe recipe,
        Set<Integer> expiringProductIds) {

    int count = 0;

    List<RecipeIngredient> ingredients =
            IngredientDAO.getIngredientsByRecipe(recipe.getRecipeId());

    for (RecipeIngredient ri : ingredients) {

        Ingredient ingredient =
                ingredientDAO.getIngredientById(
                        ri.getIngredientId());

        if (ingredient != null &&
                expiringProductIds.contains(
                        ingredient.getProductId())) {

            count++;
        }

    }

    return count;
}
    
    private boolean containsProduct(
        Recipe recipe,
        int productId) {

    List<RecipeIngredient> ingredients =
            IngredientDAO.getIngredientsByRecipe(recipe.getRecipeId());

    for (RecipeIngredient ri : ingredients) {

        Ingredient ingredient =
                ingredientDAO.getIngredientById(
                        ri.getIngredientId());

        if (ingredient != null &&
                ingredient.getProductId() == productId) {

            return true;

        }

    }

    return false;
}
 /*
    Combined recipe score:
    Nutrition + Inventory Match + Expiry Priority - Missing Ingredients
*/
public double calculateRecipeScore(Recipe recipe) {

    double score = 0;

    // Nutrition Score (reuses existing NutriScore grade -> points)
    NutritionFacts nutrition =
            nutritionDAO.getNutritionFactsByRecipeId(recipe.getRecipeId());

    if (nutrition != null) {

        char grade = NutriScoreService.calculateNutriScore(nutrition, false);

        switch (grade) {
            case 'A': score += 20; break;
            case 'B': score += 15; break;
            case 'C': score += 10; break;
            case 'D': score += 5;  break;
            default:  score += 0;
        }
    }

    List<RecipeIngredient> required =
            IngredientDAO.getIngredientsByRecipe(recipe.getRecipeId());

    List<Product> expiringProducts =
            inventoryDAO.getExpiringItems(3);

    Set<Integer> expiringProductIds = new HashSet<>();
    for (Product p : expiringProducts) {
        expiringProductIds.add(p.getProductId());
    }

    int totalIngredients = required.size();
    int availableCount = 0;
    int missingCount = 0;
    int expiringCount = 0;

    for (RecipeIngredient ri : required) {

        Ingredient ingredient =
                ingredientDAO.getIngredientById(ri.getIngredientId());

        if (ingredient == null) {
            continue;
        }

        if (isIngredientAvailable(ri.getIngredientId(), ri.getQuantity())) {
            availableCount++;
        } else {
            missingCount++;
        }

        if (expiringProductIds.contains(ingredient.getProductId())) {
            expiringCount++;
        }
    }

    // Inventory Match: up to 10 points based on % of ingredients on hand
    if (totalIngredients > 0) {
        score += ((double) availableCount / totalIngredients) * 10;
    }

    // Expiry Priority: 5 points per ingredient that's about to expire
    score += expiringCount * 5;

    // Missing Ingredients: penalty, 3 points per missing ingredient
    score -= missingCount * 3;

    return score;
}   
    public List<Recipe> sortRecommendations(List<Recipe> recipes) {

    recipes.sort((r1, r2) ->

            Double.compare(

                    calculateWasteReductionScore(r2),

                    calculateWasteReductionScore(r1)

            )

    );

    return recipes;
}
    
}
