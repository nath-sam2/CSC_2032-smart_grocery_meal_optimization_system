/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.DietaryRestrictionDAO;
import model.DietaryRestriction;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;


@WebServlet("/DietaryRestrictionController")
public class DietaryRestrictionController extends HttpServlet {


    private DietaryRestrictionDAO dao;


    @Override
    public void init() throws ServletException {

        dao = new DietaryRestrictionDAO();

    }



    // Display all restrictions and delete
    @Override
    protected void doGet(HttpServletRequest request,
                        HttpServletResponse response)
                        throws ServletException, IOException {


        String action = request.getParameter("action");


        if(action == null){
            action = "list";
        }



        if(action.equals("delete")){


            int restrictionId =
            Integer.parseInt(request.getParameter("id"));


            dao.deleteRestriction(restrictionId);


            response.sendRedirect(
            "DietaryRestrictionController");


        } 
        else {


            List<DietaryRestriction> restrictions =
            dao.getAllRestrictions();


            request.setAttribute(
            "restrictions",
            restrictions);



            request.getRequestDispatcher(
            "dietaryRestrictionList.jsp")
            .forward(request, response);

        }

    }





    // Add new restriction
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
                          throws ServletException, IOException {


        String restrictionName =
        request.getParameter("restrictionName");


        String description =
        request.getParameter("description");



        DietaryRestriction restriction =
        new DietaryRestriction();



        restriction.setRestrictionName(
        restrictionName);



        restriction.setDescription(
        description);



        dao.insertRestriction(restriction);



        response.sendRedirect(
        "DietaryRestrictionController");

    }

}