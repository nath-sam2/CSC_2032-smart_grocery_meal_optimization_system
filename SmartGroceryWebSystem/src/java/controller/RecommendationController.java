/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;


import service.RecommendationEngine;
import model.Recipe;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;



@WebServlet("/RecommendationController")
public class RecommendationController extends HttpServlet {


    RecommendationEngine recommendationEngine =
            new RecommendationEngine();



    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {



        HttpSession session =
                request.getSession();



        /*
          Get logged user id
          (Member 1 login module will provide this)
        */

        Integer userId =
                (Integer) session.getAttribute("userId");



        /*
          Temporary testing user
          Remove after login integration
        */

        if(userId == null){

            userId = 6;

        }



        // Generate recommendations

        List<Recipe> recommendations =
                recommendationEngine.recommendRecipes(userId);



        request.setAttribute(
                "recommendations",
                recommendations
        );



        request.getRequestDispatcher(
                "recommendation.jsp"
        )
        .forward(request,response);



    }



}
