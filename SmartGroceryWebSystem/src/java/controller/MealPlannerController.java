/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.MealPlannerDAO;
import dao.MealPlanDetailDAO;
import dao.RecipeDAO;

import model.MealPlanner;
import model.MealPlanDetail;
import model.Recipe;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;


@WebServlet("/MealPlannerController")
public class MealPlannerController extends HttpServlet {


    private MealPlannerDAO mealPlannerDAO;
    private MealPlanDetailDAO mealDetailDAO;
    private RecipeDAO recipeDAO;


    @Override
    public void init(){

        mealPlannerDAO = new MealPlannerDAO();
        mealDetailDAO = new MealPlanDetailDAO();
        recipeDAO = new RecipeDAO();

    }



    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {



        String action = request.getParameter("action");


        if(action == null){
            action = "list";
        }



        switch(action){


            // Show user's meal plans
            case "list":


                HttpSession session = request.getSession();

Integer userId = (Integer) session.getAttribute("userId");
if(userId == null){
    userId = 6;
}

List<MealPlanner> mealPlans = mealPlannerDAO.getMealPlansByUser(userId);


                request.setAttribute(
                        "mealPlans",
                        mealPlans
                );



                request.getRequestDispatcher(
                        "/mealplanner/mealPlanList.jsp"
                )
                .forward(request,response);



                break;



            // Create meal plan page
            case "create":


                request.getRequestDispatcher(
                        "/mealplanner/createMealPlan.jsp"
                )
                .forward(request,response);


                break;




            // View single meal plan

            case "view":


                int planId =
                Integer.parseInt(
                request.getParameter("id")
                );



                MealPlanner plan =
                mealPlannerDAO.getMealPlansById(planId);



                List<MealPlanDetail> details =
                mealDetailDAO.getMealDetailsByPlanId(planId);



                plan.setMealPlanDetails(details);



                request.setAttribute(
                        "mealPlan",
                        plan
                );



                request.getRequestDispatcher(
                        "/mealplanner/mealPlanView.jsp"
                )
                .forward(request,response);



                break;




            // Add meal page

            case "addMeal":


                int mealPlanId =
                Integer.parseInt(
                request.getParameter("id")
                );



                List<Recipe> recipes =
                recipeDAO.getAllRecipes();



                request.setAttribute(
                        "recipes",
                        recipes
                );


                request.setAttribute(
                        "mealPlanId",
                        mealPlanId
                );



                request.getRequestDispatcher(
                        "/mealplanner/addMeal.jsp"
                )
                .forward(request,response);



                break;



            // Delete meal

            case "deleteMeal":


                int detailId =
                Integer.parseInt(
                request.getParameter("id")
                );


                mealDetailDAO.deleteMealPlanDetail(detailId);



                response.sendRedirect(
                "MealPlannerController?action=list"
                );


                break;


        }


    }






    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {



        String action =
        request.getParameter("action");





        // Create Meal Plan

        if(action.equals("createPlan")){


            HttpSession session = request.getSession();

Integer userId = (Integer) session.getAttribute("userId");
if(userId == null){
    userId = 6;
}

MealPlanner mealPlan = new MealPlanner();
mealPlan.setUserId(userId);



            mealPlan.setPlanName(
            request.getParameter("planName")
            );



            mealPlan.setStartDate(
            LocalDate.parse(
            request.getParameter("startDate"))
            );



            mealPlan.setEndDate(
            LocalDate.parse(
            request.getParameter("endDate"))
            );



            mealPlannerDAO.insertMealPlan(mealPlan);



            response.sendRedirect(
            "MealPlannerController?action=list"
            );


        }





        // Add recipe to meal plan

        else if(action.equals("addMeal")){


            MealPlanDetail detail =
            new MealPlanDetail();



            detail.setMealPlanId(
            Integer.parseInt(
            request.getParameter("mealPlanId"))
            );



            detail.setRecipeId(
            Integer.parseInt(
            request.getParameter("recipeId"))
            );



            detail.setMealType(
            request.getParameter("mealType")
            );



            detail.setMealDate(
            LocalDate.parse(
            request.getParameter("mealDate"))
            );



            mealDetailDAO.insertMealPlanDetail(detail);



            response.sendRedirect(
            "MealPlannerController?action=view&id="
            +detail.getMealPlanId()
            );

        }


    }


}
