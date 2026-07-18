/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.InventoryDAO;
import dao.ShoppingListDAO;
import service.RecommendationEngine;

import model.Product;
import model.Recipe;
import model.ShoppingList;

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

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            userId = 6;
        }

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

        request.setAttribute("userId", userId);
        request.setAttribute("topRecommendations", topRecommendations);
        request.setAttribute("expiringItems", expiringItems);
        request.setAttribute("latestShoppingList", latestList);

        request.getRequestDispatcher("mealplanner/mealDashboard.jsp").forward(request, response);
    }
}