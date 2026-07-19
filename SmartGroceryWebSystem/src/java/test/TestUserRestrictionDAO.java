/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package test;

import dao.UserDietaryRestrictionDAO;
import model.DietaryRestriction;

import java.util.List;


public class TestUserRestrictionDAO {


    public static void main(String[] args) {


        UserDietaryRestrictionDAO dao =
                new UserDietaryRestrictionDAO();



        List<DietaryRestriction> list =
                dao.getRestrictionsByUserId(1);



        for(DietaryRestriction r : list){

            System.out.println(
                r.getRestrictionName()
            );

        }

    }

}