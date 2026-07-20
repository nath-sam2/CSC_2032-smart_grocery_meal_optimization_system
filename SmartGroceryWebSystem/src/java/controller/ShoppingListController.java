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
    HttpSession session = request.getSession();
    Integer userId = (Integer)session.getAttribute("userId");
    if(userId == null){
        userId = 6;
    }

    List<ShoppingList> lists = shoppingListDAO.getAllShoppingLists();
    request.setAttribute("shoppingLists", lists);
    request.getRequestDispatcher("/shopping/shoppingList.jsp").forward(request,response);
    break;




            // Generate from meal plan

            case "generate":



                int mealPlanId;

                try {
                    mealPlanId = Integer.parseInt(
                        request.getParameter("mealPlanId"));
                } catch (NumberFormatException e) {
                    response.sendRedirect("ShoppingListController?action=list");
                    return;
                }



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


                int shoppingListId;

                try {
                    shoppingListId = Integer.parseInt(
                        request.getParameter("id")
                        );
                } catch (NumberFormatException e) {
                    response.sendRedirect("ShoppingListController?action=list");
                    return;
                }



                List<ShoppingListItem> items =
                        itemDAO
                        .getItemsByShoppingListId(
                                shoppingListId
                        );



                request.setAttribute(
                        "items",
                        items
                );


                request.getRequestDispatcher("/shopping/shoppingListItems.jsp").forward(request,response);



                break;




            // Mark purchased

            case "purchase":


                int itemId;

                try {
                    itemId = Integer.parseInt(
                        request.getParameter("id")
                        );
                } catch (NumberFormatException e) {
                    response.sendRedirect("ShoppingListController?action=list");
                    return;
                }



                ShoppingListItem item =
                        itemDAO
                        .getShoppingListItemById(
                                itemId
                        );

                if (item == null) {
                    response.sendRedirect("ShoppingListController?action=list");
                    return;
                }



                item.setStatus("Purchased");

                itemDAO.updateShoppingListItem(item);



                response.sendRedirect(
                        "ShoppingListController?action=list"
                );



                break;



        }

    }

}
