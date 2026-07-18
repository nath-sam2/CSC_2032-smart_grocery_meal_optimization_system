/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.RecipeDAO;
import dao.NutritionFactsDAO;
import dao.RecipeIngredientDAO;

import model.NutritionFacts;
import model.Recipe;
import model.Ingredient;

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


            int recipeId = Integer.parseInt(
                    request.getParameter("id")
            );



            Recipe recipe = 
                    recipeDAO.getRecipeById(recipeId);



            if(recipe == null){

                response.sendRedirect("RecipeController");
                return;

            }



            // Get ingredients

            RecipeIngredientDAO recipeIngredientDAO =
                    new RecipeIngredientDAO();



            List<Ingredient> ingredients =
                    recipeIngredientDAO.getIngredientsByRecipeId(recipeId);



            // Get nutrition facts

            NutritionFactsDAO nutritionDAO =
                    new NutritionFactsDAO();



            NutritionFacts nutritionFacts =
                    nutritionDAO.getNutritionFactsById(recipeId);



            request.setAttribute("recipe", recipe);

            request.setAttribute("ingredients", ingredients);

            request.setAttribute("nutritionFacts", nutritionFacts);



            RequestDispatcher rd =
                    request.getRequestDispatcher("/recipes/recipeDetails.jsp");


            rd.forward(request, response);


            return;   // IMPORTANT

        }





        // ================= OTHER ACTIONS =================


        switch(action){



            case "delete":


                int deleteId =
                        Integer.parseInt(
                                request.getParameter("id")
                        );


                recipeDAO.deleteRecipe(deleteId);


                response.sendRedirect("RecipeController");

                return;




            case "edit":


                int editId =
                        Integer.parseInt(
                                request.getParameter("id")
                        );



                Recipe recipe =
                        recipeDAO.getRecipeById(editId);



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



            Recipe recipe = new Recipe();



            recipe.setName(
                    request.getParameter("name")
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


            recipe.setCookingTime(
                    Integer.parseInt(
                            request.getParameter("cookingTime")
                    )
            );


            recipe.setDifficulty(
                    request.getParameter("difficulty")
            );


            recipe.setServings(
                    Integer.parseInt(
                            request.getParameter("servings")
                    )
            );



            recipeDAO.insertRecipe(recipe);



            response.sendRedirect("RecipeController");

            return;

        }






        // ================= UPDATE =================


        else if(action.equals("update")) {



            Recipe recipe = new Recipe();



            recipe.setRecipeId(
                    Integer.parseInt(
                            request.getParameter("recipeId")
                    )
            );



            recipe.setName(
                    request.getParameter("name")
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



            recipe.setCookingTime(
                    Integer.parseInt(
                            request.getParameter("cookingTime")
                    )
            );



            recipe.setDifficulty(
                    request.getParameter("difficulty")
            );



            recipe.setServings(
                    Integer.parseInt(
                            request.getParameter("servings")
                    )
            );



            recipeDAO.updateRecipe(recipe);



            response.sendRedirect("RecipeController");

            return;

        }


    }

}