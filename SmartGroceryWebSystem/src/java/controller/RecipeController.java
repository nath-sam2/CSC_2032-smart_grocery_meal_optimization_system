/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.RecipeDAO;
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

        if (action == null) {
            action = "list";
        }


        switch(action) {

            case "delete":

                int deleteId = Integer.parseInt(request.getParameter("id"));

                recipeDAO.deleteRecipe(deleteId);

                response.sendRedirect("RecipeController");
                break;


            case "edit":

                int editId = Integer.parseInt(request.getParameter("id"));

                Recipe recipe = recipeDAO.getRecipeById(editId);

                request.setAttribute("recipe", recipe);

                RequestDispatcher editPage =
                        request.getRequestDispatcher("editRecipe.jsp");

                editPage.forward(request,response);

                break;


            default:

                List<Recipe> recipes = recipeDAO.getAllRecipes();

                request.setAttribute("recipes", recipes);

                RequestDispatcher rd =
                        request.getRequestDispatcher("recipeList.jsp");

                rd.forward(request,response);

                break;
        }

    }



    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        String action = request.getParameter("action");


        if(action.equals("insert")) {


            Recipe recipe = new Recipe();


            recipe.setName(request.getParameter("name"));
            recipe.setDescription(request.getParameter("description"));
            recipe.setMealType(request.getParameter("mealType"));
            recipe.setCuisine(request.getParameter("cuisine"));
            recipe.setCookingTime(
                    Integer.parseInt(request.getParameter("cookingTime"))
            );
            recipe.setDifficulty(request.getParameter("difficulty"));
            recipe.setServings(
                    Integer.parseInt(request.getParameter("servings"))
            );


            recipeDAO.insertRecipe(recipe);


            response.sendRedirect("RecipeController");

        }



        else if(action.equals("update")) {


            Recipe recipe = new Recipe();


            recipe.setRecipeId(
                    Integer.parseInt(request.getParameter("recipeId"))
            );

            recipe.setName(request.getParameter("name"));
            recipe.setDescription(request.getParameter("description"));
            recipe.setMealType(request.getParameter("mealType"));
            recipe.setCuisine(request.getParameter("cuisine"));
            recipe.setCookingTime(
                    Integer.parseInt(request.getParameter("cookingTime"))
            );
            recipe.setDifficulty(request.getParameter("difficulty"));
            recipe.setServings(
                    Integer.parseInt(request.getParameter("servings"))
            );


            recipeDAO.updateRecipe(recipe);


            response.sendRedirect("RecipeController");

        }

    }
}