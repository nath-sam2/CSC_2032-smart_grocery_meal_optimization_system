/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.RecipeDAO;
import dao.NutritionFactsDAO;

import model.NutritionFacts;
import model.Recipe;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;


@WebServlet("/RecipeController")
public class RecipeController extends HttpServlet {


    RecipeDAO recipeDAO = new RecipeDAO();



    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        String action = request.getParameter("action");


        if(action == null){
            action = "list";
        }



        // ================= VIEW RECIPE DETAILS =================

        if(action.equals("view")){


            int recipeId;

            try {
                recipeId = Integer.parseInt(request.getParameter("id"));
            } catch (NumberFormatException e) {
                response.sendRedirect("RecipeController");
                return;
            }



            Recipe recipe = 
                    recipeDAO.getRecipeById(recipeId);



            if(recipe == null){

                response.sendRedirect("RecipeController");
                return;

            }



            // Get nutrition facts

            NutritionFactsDAO nutritionDAO =
                    new NutritionFactsDAO();



            NutritionFacts nutritionFacts =
                    nutritionDAO.getNutritionFactsByRecipeId(recipeId);



            request.setAttribute("recipe", recipe);

            request.setAttribute("nutritionFacts", nutritionFacts);



            RequestDispatcher rd =
                    request.getRequestDispatcher("/recipes/recipeDetails.jsp");


            rd.forward(request, response);


            return;   // IMPORTANT

        }





        // ================= OTHER ACTIONS =================


        switch(action){



            case "delete":

    int deleteId;

    try {
        deleteId = Integer.parseInt(request.getParameter("id"));
    } catch (NumberFormatException e) {
        response.sendRedirect("RecipeController");
        return;
    }

    boolean deleted = recipeDAO.deleteRecipe(deleteId);

    if (!deleted) {
        response.sendRedirect("RecipeController?deleteError=true");
        return;
    }

    response.sendRedirect("RecipeController");

    return;



            case "edit":


                int editId;

    try {
        editId = Integer.parseInt(request.getParameter("id"));
    } catch (NumberFormatException e) {
        response.sendRedirect("RecipeController");
        return;
    }

    Recipe recipe =
            recipeDAO.getRecipeById(editId);

    if (recipe == null) {
        response.sendRedirect("RecipeController");
        return;
    }

                request.setAttribute("recipe", recipe);



                RequestDispatcher editPage =
                        request.getRequestDispatcher(
                                "/recipes/editRecipe.jsp"
                        );



                editPage.forward(request,response);


                return;


                case "create":

    RequestDispatcher createPage =
            request.getRequestDispatcher(
                    "/recipes/addRecipe.jsp"
            );

    createPage.forward(request,response);

    return;


            default:



                List<Recipe> recipes =
                        recipeDAO.getAllRecipes();



                request.setAttribute(
                        "recipes",
                        recipes
                );



                RequestDispatcher rd =
                        request.getRequestDispatcher(
                                "/recipes/recipeList.jsp"
                        );



                rd.forward(request,response);


                return;

        }

    }







    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {



        String action =
                request.getParameter("action");





        // ================= INSERT =================


        if(action.equals("insert")) {



            String recipeName = request.getParameter("name");
            String cookingTimeParam = request.getParameter("cookingTime");
            String servingsParam = request.getParameter("servings");

            java.util.List<String> errors = new java.util.ArrayList<>();

            if (recipeName == null || recipeName.trim().isEmpty()) {
                errors.add("Recipe name is required.");
            }

            int cookingTime = 0;
            int servings = 0;

            try {
                cookingTime = Integer.parseInt(cookingTimeParam);
                if (cookingTime <= 0) {
                    errors.add("Cooking time must be a positive number.");
                }
            } catch (NumberFormatException e) {
                errors.add("Cooking time must be a valid number.");
            }

            try {
                servings = Integer.parseInt(servingsParam);
                if (servings <= 0) {
                    errors.add("Servings must be a positive number.");
                }
            } catch (NumberFormatException e) {
                errors.add("Servings must be a valid number.");
            }

            if (!errors.isEmpty()) {

                request.setAttribute("formErrors", errors);

                request.getRequestDispatcher("/recipes/addRecipe.jsp")
                        .forward(request, response);

                return;
            }

            if (recipeName != null && recipeDAO.getRecipeByName(recipeName.trim()) != null) {

                request.setAttribute("duplicateNameError",
                        "A recipe named \"" + recipeName.trim() + "\" already exists. Please choose a different name.");

                request.getRequestDispatcher("/recipes/addRecipe.jsp")
                        .forward(request, response);

                return;
            }



            Recipe recipe = new Recipe();



            recipe.setName(
                    recipeName
            );


            recipe.setDescription(
                    request.getParameter("description")
            );


            recipe.setMealType(
                    request.getParameter("mealType")
            );


            recipe.setCuisine(
                    request.getParameter("cuisine")
            );


            recipe.setCookingTime(cookingTime);


            recipe.setDifficulty(
                    request.getParameter("difficulty")
            );


            recipe.setServings(servings);



            boolean insertOk = recipeDAO.insertRecipe(recipe);

            if (!insertOk) {
                java.util.List<String> saveErrors = new java.util.ArrayList<>();
                saveErrors.add("Could not save the recipe due to a server error. Please try again.");
                request.setAttribute("formErrors", saveErrors);
                request.getRequestDispatcher("/recipes/addRecipe.jsp").forward(request, response);
                return;
            }



            response.sendRedirect("RecipeController");

            return;

        }






        // ================= UPDATE =================


        else if(action.equals("update")) {



            int updateRecipeId;

            try {
                updateRecipeId = Integer.parseInt(request.getParameter("recipeId"));
            } catch (NumberFormatException e) {
                response.sendRedirect("RecipeController");
                return;
            }

            String recipeName = request.getParameter("name");
            String cookingTimeParam = request.getParameter("cookingTime");
            String servingsParam = request.getParameter("servings");

            java.util.List<String> errors = new java.util.ArrayList<>();

            if (recipeName == null || recipeName.trim().isEmpty()) {
                errors.add("Recipe name is required.");
            }

            int cookingTime = 0;
            int servings = 0;

            try {
                cookingTime = Integer.parseInt(cookingTimeParam);
                if (cookingTime <= 0) {
                    errors.add("Cooking time must be a positive number.");
                }
            } catch (NumberFormatException e) {
                errors.add("Cooking time must be a valid number.");
            }

            try {
                servings = Integer.parseInt(servingsParam);
                if (servings <= 0) {
                    errors.add("Servings must be a positive number.");
                }
            } catch (NumberFormatException e) {
                errors.add("Servings must be a valid number.");
            }

            if (!errors.isEmpty()) {

                // Redisplay the edit form with what the user submitted so far
                Recipe attempted = new Recipe();
                attempted.setRecipeId(updateRecipeId);
                attempted.setName(recipeName);
                attempted.setDescription(request.getParameter("description"));
                attempted.setMealType(request.getParameter("mealType"));
                attempted.setCuisine(request.getParameter("cuisine"));
                attempted.setDifficulty(request.getParameter("difficulty"));

                request.setAttribute("recipe", attempted);
                request.setAttribute("formErrors", errors);

                request.getRequestDispatcher("/recipes/editRecipe.jsp")
                        .forward(request, response);

                return;
            }



            Recipe recipe = new Recipe();



            recipe.setRecipeId(updateRecipeId);


            recipe.setName(
                    recipeName
            );


            recipe.setDescription(
                    request.getParameter("description")
            );


            recipe.setMealType(
                    request.getParameter("mealType")
            );


            recipe.setCuisine(
                    request.getParameter("cuisine")
            );


            recipe.setCookingTime(cookingTime);


            recipe.setDifficulty(
                    request.getParameter("difficulty")
            );


            recipe.setServings(servings);



            boolean updateOk = recipeDAO.updateRecipe(recipe);

            if (!updateOk) {
                request.setAttribute("recipe", recipe);
                java.util.List<String> saveErrors = new java.util.ArrayList<>();
                saveErrors.add("Could not save the recipe due to a server error. Please try again.");
                request.setAttribute("formErrors", saveErrors);
                request.getRequestDispatcher("/recipes/editRecipe.jsp").forward(request, response);
                return;
            }



            response.sendRedirect("RecipeController");

            return;

        }


    }

}