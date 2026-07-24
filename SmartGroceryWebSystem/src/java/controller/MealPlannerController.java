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

import service.RecommendationEngine;

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

int userId = util.SessionUtil.getLoggedInUserId(session);

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


                int planId;

                try {
                    planId = Integer.parseInt(
                        request.getParameter("id")
                    );
                } catch (NumberFormatException e) {
                    response.sendRedirect("MealPlannerController?action=list");
                    return;
                }



                MealPlanner plan =
                mealPlannerDAO.getMealPlansById(planId);

                if (plan == null) {
                    response.sendRedirect("MealPlannerController?action=list");
                    return;
                }



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


                int mealPlanId;

                try {
                    mealPlanId = Integer.parseInt(
                        request.getParameter("id")
                    );
                } catch (NumberFormatException e) {
                    response.sendRedirect("MealPlannerController?action=list");
                    return;
                }



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


                int detailId;

                try {
                    detailId = Integer.parseInt(
                        request.getParameter("id")
                    );
                } catch (NumberFormatException e) {
                    response.sendRedirect("MealPlannerController?action=list");
                    return;
                }


                mealDetailDAO.deleteMealPlanDetail(detailId);



                response.sendRedirect(
                "MealPlannerController?action=list"
                );


                break;


                case "quickAdd":

    int quickAddRecipeId;

    try {
        quickAddRecipeId = Integer.parseInt(request.getParameter("recipeId"));
    } catch (NumberFormatException e) {
        response.sendRedirect("MealPlannerController?action=list");
        return;
    }

    HttpSession quickAddSession = request.getSession();

    int quickAddUserId = util.SessionUtil.getLoggedInUserId(quickAddSession);

    List<MealPlanner> existingPlans =
            mealPlannerDAO.getMealPlansByUser(quickAddUserId);

    MealPlanner targetPlan;

    if (!existingPlans.isEmpty()) {
        // Use the most recently created plan
        targetPlan = existingPlans.get(existingPlans.size() - 1);
    } else {
        // No plans yet — create one
        targetPlan = new MealPlanner();
        targetPlan.setUserId(quickAddUserId);
        targetPlan.setPlanName("My Meal Plan");
        targetPlan.setStartDate(LocalDate.now());
        targetPlan.setEndDate(LocalDate.now().plusDays(6));

        boolean planCreated = mealPlannerDAO.insertMealPlan(targetPlan);

        if (!planCreated || targetPlan.getMealPlanId() <= 0) {
            // Insert failed - don't attempt to attach a meal to a plan
            // that doesn't actually exist in the database.
            response.sendRedirect("MealPlannerController?action=list");
            return;
        }
    }

    Recipe quickAddRecipe = recipeDAO.getRecipeById(quickAddRecipeId);

    MealPlanDetail quickAddDetail = new MealPlanDetail();
    quickAddDetail.setMealPlanId(targetPlan.getMealPlanId());
    quickAddDetail.setRecipeId(quickAddRecipeId);
    quickAddDetail.setMealDate(LocalDate.now());
    quickAddDetail.setMealType(
            quickAddRecipe != null ? quickAddRecipe.getMealType() : "Lunch"
    );

    boolean mealAdded = mealDetailDAO.insertMealPlanDetail(quickAddDetail);

    String quickAddRedirect = "MealPlannerController?action=view&id=" + targetPlan.getMealPlanId();
    if (!mealAdded) {
        quickAddRedirect += "&added=0";
    }

    response.sendRedirect(quickAddRedirect);

    return;
    
    case "generate":

    HttpSession generateSession = request.getSession();

    int generateUserId = util.SessionUtil.getLoggedInUserId(generateSession);

    RecommendationEngine engine = new RecommendationEngine();

    MealPlanner generatedPlan =
            engine.generateWeeklyMealPlan(generateUserId);

    if (generatedPlan == null) {
        response.sendRedirect("MealPlannerController?action=list");
        return;
    }

    response.sendRedirect(
            "MealPlannerController?action=view&id=" + generatedPlan.getMealPlanId()
    );

    return;
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

int userId = util.SessionUtil.getLoggedInUserId(session);

MealPlanner mealPlan = new MealPlanner();
mealPlan.setUserId(userId);



            String planName = request.getParameter("planName");
            String startDateParam = request.getParameter("startDate");
            String endDateParam = request.getParameter("endDate");

            java.util.List<String> createPlanErrors = new java.util.ArrayList<>();

            if (planName == null || planName.trim().isEmpty()) {
                createPlanErrors.add("Plan name is required.");
            }

            if (startDateParam == null || startDateParam.isBlank()
                    || endDateParam == null || endDateParam.isBlank()) {
                createPlanErrors.add("Start date and end date are both required.");
            }

            LocalDate startDate = null;
            LocalDate endDate = null;

            if (startDateParam != null && !startDateParam.isBlank()
                    && endDateParam != null && !endDateParam.isBlank()) {

                try {
                    startDate = LocalDate.parse(startDateParam);
                    endDate = LocalDate.parse(endDateParam);

                    if (startDate.isAfter(endDate)) {
                        createPlanErrors.add("Start date must be on or before the end date.");
                    }

                } catch (java.time.format.DateTimeParseException e) {
                    createPlanErrors.add("Start date and end date must be valid dates.");
                }
            }

            if (!createPlanErrors.isEmpty()) {

                request.setAttribute("formErrors", createPlanErrors);
                request.setAttribute("planName", planName);
                request.setAttribute("startDate", startDateParam);
                request.setAttribute("endDate", endDateParam);

                request.getRequestDispatcher("/mealplanner/createMealPlan.jsp")
                        .forward(request, response);

                return;
            }

            mealPlan.setPlanName(
            planName
            );

            mealPlan.setStartDate(startDate);
            mealPlan.setEndDate(endDate);



            mealPlannerDAO.insertMealPlan(mealPlan);



            response.sendRedirect(
            "MealPlannerController?action=list"
            );


        }





        // Add recipe to meal plan

        else if(action.equals("addMeal")){


            MealPlanDetail detail =
            new MealPlanDetail();

            int addMealPlanId;
            int addRecipeId;
            LocalDate addMealDate;

            try {
                addMealPlanId = Integer.parseInt(request.getParameter("mealPlanId"));
                addRecipeId = Integer.parseInt(request.getParameter("recipeId"));
            } catch (NumberFormatException e) {
                response.sendRedirect("MealPlannerController?action=list");
                return;
            }

            try {
                addMealDate = LocalDate.parse(request.getParameter("mealDate"));
            } catch (java.time.format.DateTimeParseException e) {
                response.sendRedirect("MealPlannerController?action=addMeal&id=" + addMealPlanId);
                return;
            }



            detail.setMealPlanId(addMealPlanId);



            detail.setRecipeId(addRecipeId);



            detail.setMealType(
            request.getParameter("mealType")
            );



            detail.setMealDate(addMealDate);



            mealDetailDAO.insertMealPlanDetail(detail);



            response.sendRedirect(
            "MealPlannerController?action=view&id="
            +detail.getMealPlanId()
            );

        }


    }


}