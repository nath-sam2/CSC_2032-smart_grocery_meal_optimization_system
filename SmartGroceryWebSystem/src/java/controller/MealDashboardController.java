/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.InventoryDAO;
import dao.ShoppingListDAO;
import dao.MealPlannerDAO;
import service.RecommendationEngine;

import model.Product;
import model.Recipe;
import model.ShoppingList;
import model.MealPlanner;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/MealDashboardController")
public class MealDashboardController extends HttpServlet {

    RecommendationEngine recommendationEngine = new RecommendationEngine();
    InventoryDAO inventoryDAO = new InventoryDAO();
    ShoppingListDAO shoppingListDAO = new ShoppingListDAO();
    MealPlannerDAO mealPlannerDAO = new MealPlannerDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        Integer userId = util.SessionUtil.getLoggedInUserId(session);

        // Today's top recommendations (first 3 from the scored list)
        List<Recipe> allRecommendations = recommendationEngine.recommendRecipes(userId);
        List<Recipe> topRecommendations = allRecommendations.size() > 3
                ? allRecommendations.subList(0, 3)
                : allRecommendations;

        // Ingredients expiring soon
        List<Product> expiringItems = inventoryDAO.getExpiringItems(3);

        // Shopping list summary (most recent list)
        List<ShoppingList> shoppingLists = shoppingListDAO.getAllShoppingLists();
        ShoppingList latestList = shoppingLists.isEmpty()
                ? null
                : shoppingLists.get(shoppingLists.size() - 1);

        // Meal plan summary (most recent plan)
        List<MealPlanner> mealPlans = mealPlannerDAO.getMealPlansByUser(userId);
        MealPlanner latestMealPlan = mealPlans.isEmpty()
                ? null
                : mealPlans.get(mealPlans.size() - 1);

        request.setAttribute("userId", userId);
        request.setAttribute("topRecommendations", topRecommendations);
        request.setAttribute("expiringItems", expiringItems);
        request.setAttribute("latestShoppingList", latestList);
        request.setAttribute("latestMealPlan", latestMealPlan);
        request.setAttribute("mealPlanCount", mealPlans.size());

        request.getRequestDispatcher("mealplanner/mealDashboard.jsp").forward(request, response);
    }
}