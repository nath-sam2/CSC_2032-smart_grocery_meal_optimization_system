/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;



import dao.RecipeDAO;
import model.Recipe;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/RecipeController")
public class RecipeController extends HttpServlet {


    private RecipeDAO recipeDAO;


    @Override
    public void init() {

        recipeDAO = new RecipeDAO();

    }


    @Override
    protected void doGet(HttpServletRequest request, 
                        HttpServletResponse response)
                        throws ServletException, IOException {


        String action = request.getParameter("action");


        if(action == null){
            action = "list";
        }


        switch(action){

            case "list":

                getAllRecipes(request,response);

                break;


            default:

                getAllRecipes(request,response);

        }

    }



    private void getAllRecipes(HttpServletRequest request,
                               HttpServletResponse response)
                               throws ServletException, IOException {


        List<Recipe> recipes = recipeDAO.getAllRecipes();


        request.setAttribute("recipes", recipes);


        request.getRequestDispatcher("recipe-list.jsp")
               .forward(request,response);

    }

}