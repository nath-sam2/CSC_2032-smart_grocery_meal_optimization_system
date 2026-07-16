/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.ShoppingListDAO;
import dao.ShoppingListItemDAO;

import model.ShoppingList;
import model.ShoppingListItem;

import service.RecommendationEngine;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;


@WebServlet("/ShoppingListController")
public class ShoppingListController extends HttpServlet {


    ShoppingListDAO shoppingListDAO =
            new ShoppingListDAO();


    ShoppingListItemDAO itemDAO =
            new ShoppingListItemDAO();


    RecommendationEngine recommendationEngine =
            new RecommendationEngine();



    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {



        String action =
                request.getParameter("action");



        if(action == null){

            action = "list";

        }



        switch(action){



            // View shopping lists
            case "list":


                HttpSession session =
                        request.getSession();


                Integer userId =
                        (Integer)session.getAttribute("userId");



                if(userId == null){

                    response.sendRedirect("shoppingList.jsp");
                    return;

                }



                List<ShoppingList> lists =
                        shoppingListDAO
                        .getAllShoppingLists();



                request.setAttribute(
                        "shoppingLists",
                        lists
                );



                request.getRequestDispatcher(
                        "shoppingList.jsp"
                ).forward(request,response);



                break;




            // Generate from meal plan

            case "generate":



                int mealPlanId =
                        Integer.parseInt(
                        request.getParameter("mealPlanId"));



                ShoppingList list =
                        recommendationEngine
                        .generateShoppingListFromMealPlan(
                                mealPlanId
                        );



                response.sendRedirect(
                        "ShoppingListController?action=list"
                );


                break;





            // View items

            case "view":


                int shoppingListId =
                        Integer.parseInt(
                        request.getParameter("id")
                        );



                List<ShoppingListItem> items =
                        itemDAO
                        .getItemsByShoppingListId(
                                shoppingListId
                        );



                request.setAttribute(
                        "items",
                        items
                );


                request.getRequestDispatcher(
                        "shoppingList.jsp"
                ).forward(request,response);



                break;




            // Mark purchased

            case "purchase":


                int itemId =
                        Integer.parseInt(
                        request.getParameter("id")
                        );



                ShoppingListItem item =
                        itemDAO
                        .getShoppingListItemById(
                                itemId
                        );



                item.setStatus("Purchased");

                itemDAO.updateShoppingListItem(item);



                response.sendRedirect(
                        "ShoppingListController?action=list"
                );



                break;



        }

    }

}
