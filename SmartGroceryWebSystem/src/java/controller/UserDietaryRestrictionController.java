/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.UserDietaryRestrictionDAO;
import model.UserDietaryRestriction;
import model.DietaryRestriction;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;


@WebServlet("/UserDietaryRestrictionController")
public class UserDietaryRestrictionController extends HttpServlet {


    private UserDietaryRestrictionDAO dao;


    @Override
    public void init() throws ServletException {

        dao = new UserDietaryRestrictionDAO();

    }



    // Display user restrictions and delete
    @Override
    protected void doGet(HttpServletRequest request,
                        HttpServletResponse response)
                        throws ServletException, IOException {


        String action = request.getParameter("action");


        if(action == null){
            action = "list";
        }



        if(action.equals("delete")){


            int userId =
            Integer.parseInt(
            request.getParameter("userId"));



            int restrictionId =
            Integer.parseInt(
            request.getParameter("restrictionId"));



            dao.removeUserRestriction(
            userId,
            restrictionId);



            response.sendRedirect(
            "UserDietaryRestrictionController?userId="
            + userId);



        }
        else {


            int userId =
            Integer.parseInt(
            request.getParameter("userId"));



            List<DietaryRestriction> restrictions =
            dao.getRestrictionsByUserId(userId);



            request.setAttribute(
            "restrictions",
            restrictions);



            request.setAttribute(
            "userId",
            userId);



            request.getRequestDispatcher(
            "userDietaryRestrictionList.jsp")
            .forward(request,response);

        }

    }




    // Add restriction to user
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
                          throws ServletException, IOException {



        int userId =
        Integer.parseInt(
        request.getParameter("userId"));



        int restrictionId =
        Integer.parseInt(
        request.getParameter("restrictionId"));



        UserDietaryRestriction userRestriction =
        new UserDietaryRestriction();



        userRestriction.setUserId(userId);



        userRestriction.setRestrictionId(
        restrictionId);



        dao.addUserRestriction(
        userRestriction);



        response.sendRedirect(
        "UserDietaryRestrictionController?userId="
        + userId);

    }


}