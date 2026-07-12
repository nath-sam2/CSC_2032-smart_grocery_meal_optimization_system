/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.DietaryRestrictionDAO;
import dao.UserDietaryRestrictionDAO;

import model.DietaryRestriction;
import model.UserDietaryRestriction;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;


@WebServlet("/DietaryRestrictionController")
public class DietaryRestrictionController extends HttpServlet {


    DietaryRestrictionDAO restrictionDAO = new DietaryRestrictionDAO();

    UserDietaryRestrictionDAO userRestrictionDAO =
            new UserDietaryRestrictionDAO();



    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        String action = request.getParameter("action");


        if(action == null){
            action = "list";
        }



        switch(action){


            // Display all available restrictions
            case "list":


                List<DietaryRestriction> restrictions =
                        restrictionDAO.getAllRestrictions();


                request.setAttribute(
                        "restrictions",
                        restrictions
                );


                request.getRequestDispatcher(
                        "dietaryRestrictionList.jsp"
                )
                .forward(request,response);


                break;




            // Add restriction page
            case "add":


                request.getRequestDispatcher(
                        "addDietaryRestriction.jsp"
                )
                .forward(request,response);


                break;





            // Edit page
            case "edit":


                int editId =
                Integer.parseInt(
                        request.getParameter("id")
                );


                DietaryRestriction restriction =
                        restrictionDAO.getRestrictionById(editId);



                request.setAttribute(
                        "restriction",
                        restriction
                );



                request.getRequestDispatcher(
                        "editDietaryRestriction.jsp"
                )
                .forward(request,response);



                break;





            // Delete restriction

            case "delete":


                int deleteId =
                Integer.parseInt(
                        request.getParameter("id")
                );


                restrictionDAO.deleteRestriction(deleteId);


                response.sendRedirect(
                        "DietaryRestrictionController"
                );


                break;




            // View user's restrictions

            case "userRestrictions":


                HttpSession session =
                        request.getSession();


                int userId =
                (int)session.getAttribute("userId");



                List<DietaryRestriction> userRestrictions =
                userRestrictionDAO.getRestrictionsByUserId(userId);



                request.setAttribute(
                        "userRestrictions",
                        userRestrictions
                );



                request.getRequestDispatcher(
                        "userRestrictionList.jsp"
                )
                .forward(request,response);



                break;


        }

    }






    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {



        String action =
                request.getParameter("action");




        if(action.equals("insert")){


            DietaryRestriction restriction =
                    new DietaryRestriction();



            restriction.setRestrictionName(
                    request.getParameter("restrictionName")
            );


            restriction.setDescription(
                    request.getParameter("description")
            );



            restrictionDAO.insertRestriction(restriction);



            response.sendRedirect(
                    "DietaryRestrictionController"
            );


        }






        else if(action.equals("update")){


            DietaryRestriction restriction =
                    new DietaryRestriction();



            restriction.setRestrictionId(
                Integer.parseInt(
                request.getParameter("restrictionId"))
            );



            restriction.setRestrictionName(
                    request.getParameter("restrictionName")
            );



            restriction.setDescription(
                    request.getParameter("description")
            );



            restrictionDAO.updateRestriction(restriction);



            response.sendRedirect(
                    "DietaryRestrictionController"
            );

        }





        else if(action.equals("addUserRestriction")){


            HttpSession session =
                    request.getSession();



            int userId =
            (int)session.getAttribute("userId");



            int restrictionId =
            Integer.parseInt(
            request.getParameter("restrictionId"));



            UserDietaryRestriction udr =
            new UserDietaryRestriction();



            udr.setUserId(userId);

            udr.setRestrictionId(restrictionId);



            userRestrictionDAO.addUserRestriction(udr);



            response.sendRedirect(
            "DietaryRestrictionController?action=userRestrictions"
            );

        }


    }

}