/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.Recipe;
import service.RecommendationEngine;

import java.io.IOException;
import java.util.List;

@WebServlet("/FoodWasteController")
public class FoodWasteController extends HttpServlet {

    private RecommendationEngine recommendationEngine;

    @Override
    public void init() throws ServletException {
        recommendationEngine = new RecommendationEngine();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        /*
         * Temporary until Member 1 login integration.
         */
        int userId = 1;

        if (session != null && session.getAttribute("userId") != null) {
            userId = (Integer) session.getAttribute("userId");
        }

        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {

            case "list":

                List<Recipe> recipes =
                        recommendationEngine
                                .recommendWasteReducingRecipes(userId);

                request.setAttribute("recipes", recipes);

                request.getRequestDispatcher("foodWasteReduction.jsp")
                        .forward(request, response);

                break;

            default:

                response.sendRedirect("FoodWasteController?action=list");

                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);

    }
}
