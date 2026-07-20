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
                        "/recommendation/dietaryRestrictionList.jsp"
                )
                .forward(request,response);


                break;




            // Add restriction page
            case "add":


                request.getRequestDispatcher(
                        "/recommendation/addRestriction.jsp"
                )
                .forward(request,response);


                break;





            // Edit page
            case "edit":


                int editId;

                try {
                    editId = Integer.parseInt(
                        request.getParameter("id")
                    );
                } catch (NumberFormatException e) {
                    response.sendRedirect(request.getContextPath() + "/DietaryRestrictionController");
                    return;
                }


                DietaryRestriction restriction =
                        restrictionDAO.getRestrictionById(editId);

                if (restriction == null) {
                    response.sendRedirect(request.getContextPath() + "/DietaryRestrictionController");
                    return;
                }



                request.setAttribute(
                        "restriction",
                        restriction
                );



                request.getRequestDispatcher(
                        "/recommendation/editDietaryRestriction.jsp"
                )
                .forward(request,response);



                break;





            // Delete restriction

            case "delete":


                int deleteId;

                try {
                    deleteId = Integer.parseInt(
                        request.getParameter("id")
                    );
                } catch (NumberFormatException e) {
                    response.sendRedirect(request.getContextPath() + "/DietaryRestrictionController");
                    return;
                }


                restrictionDAO.deleteRestriction(deleteId);


                response.sendRedirect(
                        request.getContextPath() + "/DietaryRestrictionController"
                );


                break;




            // View user's restrictions

            case "userRestrictions":


                HttpSession session =
                        request.getSession();


                Integer userId = (Integer) session.getAttribute("userId");
                if (userId == null) {
                    userId = 6;
                }



                List<DietaryRestriction> userRestrictions =
                userRestrictionDAO.getRestrictionsByUserId(userId);



                request.setAttribute(
                        "userRestrictions",
                        userRestrictions
                );



                request.getRequestDispatcher(
                        "/recommendation/userRestrictionList.jsp"
                )
                .forward(request,response);



                break;


         // Add restriction to user page
    case "addUser": {


    List<DietaryRestriction> availableRestrictions =
            restrictionDAO.getAllRestrictions();



    request.setAttribute(
            "restrictions",
            availableRestrictions
    );



    request.getRequestDispatcher(
            "/recommendation/addUserRestriction.jsp"
    )
    .forward(request,response);



    break;
}       
        }

    }






    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {



        String action =
                request.getParameter("action");




        if(action.equals("insert")){


            String restrictionName = request.getParameter("restrictionName");

            if (restrictionName == null || restrictionName.trim().isEmpty()) {

                request.setAttribute("formError", "Restriction name is required.");

                request.getRequestDispatcher("/recommendation/addRestriction.jsp")
                        .forward(request, response);

                return;
            }


            DietaryRestriction restriction =
                    new DietaryRestriction();



            restriction.setRestrictionName(
                    restrictionName
            );


            restriction.setDescription(
                    request.getParameter("description")
            );



            restrictionDAO.insertRestriction(restriction);



            response.sendRedirect(
                    request.getContextPath() + "/DietaryRestrictionController"
            );


        }






        else if(action.equals("update")){


            int updateRestrictionId;

            try {
                updateRestrictionId = Integer.parseInt(request.getParameter("restrictionId"));
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/DietaryRestrictionController");
                return;
            }

            String restrictionName = request.getParameter("restrictionName");

            if (restrictionName == null || restrictionName.trim().isEmpty()) {

                DietaryRestriction attempted = new DietaryRestriction();
                attempted.setRestrictionId(updateRestrictionId);
                attempted.setRestrictionName(restrictionName);
                attempted.setDescription(request.getParameter("description"));

                request.setAttribute("restriction", attempted);
                request.setAttribute("formError", "Restriction name is required.");

                request.getRequestDispatcher("/recommendation/editDietaryRestriction.jsp")
                        .forward(request, response);

                return;
            }


            DietaryRestriction restriction =
                    new DietaryRestriction();


            restriction.setRestrictionId(updateRestrictionId);


            restriction.setRestrictionName(
                    restrictionName
            );



            restriction.setDescription(
                    request.getParameter("description")
            );



            restrictionDAO.updateRestriction(restriction);



            response.sendRedirect(
                    request.getContextPath() + "/DietaryRestrictionController"
            );

        }





        else if(action.equals("addUserRestriction")){


            HttpSession session =
                    request.getSession();



            Integer userId = (Integer) session.getAttribute("userId");
            if (userId == null) {
                userId = 6;
            }



            int restrictionId =
            Integer.parseInt(
            request.getParameter("restrictionId"));



            UserDietaryRestriction udr =
            new UserDietaryRestriction();



            udr.setUserId(userId);

            udr.setRestrictionId(restrictionId);



            userRestrictionDAO.addUserRestriction(udr);



            response.sendRedirect(
            request.getContextPath() + "/DietaryRestrictionController?action=userRestrictions"
            );

        }

        else if(action.equals("deleteUserRestriction")){


    HttpSession session =
            request.getSession();


    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        userId = 6;
    }


    int restrictionId =
            Integer.parseInt(
                    request.getParameter("restrictionId")
            );


    userRestrictionDAO.removeUserRestriction(
            userId,
            restrictionId
    );


    response.sendRedirect(
            request.getContextPath() + "/DietaryRestrictionController?action=userRestrictions"
    );

}
    }

}