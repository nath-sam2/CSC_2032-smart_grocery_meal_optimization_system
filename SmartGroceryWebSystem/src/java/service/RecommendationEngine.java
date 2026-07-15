/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import dao.MealPlannerDAO;
import dao.MealPlanDetailDAO;
import dao.UserDietaryRestrictionDAO;
import dao.NutritionFactsDAO;
import dao.RecipeIngredientDAO;
import dao.RecipeDAO;
import dao.ShoppingListDAO;
import dao.ShoppingListItemDAO;

import model.DietaryRestriction;
import model.Ingredient;
import model.MealPlanner;
import model.MealPlanDetail;
import model.NutritionFacts;
import model.Recipe;
import model.ShoppingList;
import model.ShoppingListItem;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;


public class RecommendationEngine {


    private RecipeDAO recipeDAO;
    private NutritionFactsDAO nutritionDAO;
    private MealPlannerDAO mealPlannerDAO;
    private MealPlanDetailDAO mealPlanDetailDAO;
    private ShoppingListDAO shoppingListDAO;
    private ShoppingListItemDAO shoppingListItemDAO;
    private RecipeIngredientDAO recipeIngredientDAO;



    public RecommendationEngine(){


        recipeDAO = new RecipeDAO();

        nutritionDAO = new NutritionFactsDAO();

        recipeIngredientDAO = new RecipeIngredientDAO();

        mealPlannerDAO = new MealPlannerDAO();

        mealPlanDetailDAO = new MealPlanDetailDAO();

        shoppingListDAO = new ShoppingListDAO();

        shoppingListItemDAO = new ShoppingListItemDAO();

    }




    /*
        Check if recipe contains an ingredient keyword
    */
    private boolean containsIngredient(
            Recipe recipe,
            String keyword){



        List<Ingredient> ingredients =
                recipeIngredientDAO
                .getIngredientsByRecipeId(
                        recipe.getRecipeId()
                );



        for(Ingredient ingredient : ingredients){


            if(ingredient.getName()
                    .toLowerCase()
                    .contains(
                    keyword.toLowerCase())){


                return true;

            }

        }


        return false;

    }






    /*
        Main recommendation process
    */
    public List<Recipe> recommendRecipes(int userId){



        // Get all recipes

        List<Recipe> recipes =
                recipeDAO.getAllRecipes();




        // Remove recipes based on restrictions

        recipes =
                filterByDietaryRestrictions(
                        recipes,
                        userId
                );




        // Sort using NutriScore

        recipes =
                sortByNutriScore(
                        recipes
                );




        // Future inventory integration

        recipes =
                prioritizeByExpiry(
                        recipes
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



        List<Recipe> result =
                new ArrayList<>();




        for(Recipe recipe : recipes){


            boolean allowed = true;



            for(DietaryRestriction restriction : restrictions){



                String type =
                        restriction.getRestrictionName();




                if(type.equalsIgnoreCase("Vegetarian")){


                    if(containsIngredient(recipe,"chicken")
                    || containsIngredient(recipe,"beef")
                    || containsIngredient(recipe,"pork")
                    || containsIngredient(recipe,"fish")){


                        allowed=false;

                    }

                }




                else if(type.equalsIgnoreCase("Gluten-Free")){


                    if(containsIngredient(recipe,"wheat")
                    || containsIngredient(recipe,"bread")
                    || containsIngredient(recipe,"flour")
                    || containsIngredient(recipe,"pasta")){


                        allowed=false;

                    }

                }





                else if(type.equalsIgnoreCase("Nut Allergy")){


                    if(containsIngredient(recipe,"nut")
                    || containsIngredient(recipe,"peanut")
                    || containsIngredient(recipe,"almond")
                    || containsIngredient(recipe,"cashew")){


                        allowed=false;

                    }

                }





                else if(type.equalsIgnoreCase("Dairy-Free")){


                    if(containsIngredient(recipe,"milk")
                    || containsIngredient(recipe,"cheese")
                    || containsIngredient(recipe,"butter")){


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
                    || containsIngredient(recipe,"seafood")){


                        allowed=false;

                    }

                }



            }



            if(allowed){

                result.add(recipe);

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




    // Collect ingredients

    for(MealPlanDetail detail : details){



        List<Ingredient> ingredients =
                recipeIngredientDAO
                .getIngredientsByRecipeId(
                        detail.getRecipeId()
                );



        for(Ingredient ingredient : ingredients){



            ShoppingListItem item =
                    new ShoppingListItem();



            item.setShoppingListId(
                    shoppingList.getShoppingListId()
            );



            item.setIngredientId(
                    ingredient.getIngredientId()
            );



            /*
              Temporary quantity.
              Inventory integration with Member 1
              will calculate the real missing amount.
            */

            item.setQuantity(1);



            item.setUnit(
                    "unit"
            );



            item.setStatus(
                    "Pending"
            );



            shoppingListItemDAO
                    .insertShoppingListItem(item);



        }


    }



    return shoppingList;

}






    public List<Ingredient> getMissingIngredients(
            int mealPlanId){



        // Inventory integration later

        return new ArrayList<>();

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

    /*
     * TODO:
     * Inventory Integration (Member 1)
     *
     * Increase score if recipe uses ingredients
     * that expire within the next few days.
     */

    return score;
}
    
    public List<Recipe> prioritizeExpiringIngredients(List<Recipe> recipes) {

    /*
     * Member 1 Integration
     *
     * Future:
     * Read inventory
     * Find ingredients expiring soon
     * Move matching recipes higher
     */

    return recipes;
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