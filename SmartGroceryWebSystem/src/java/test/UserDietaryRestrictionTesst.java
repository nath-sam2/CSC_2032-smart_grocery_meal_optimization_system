/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package test;

/**
 *
 * @author perer
 */
import dao.UserDietaryRestrictionsDAO;
import model.UserDietaryRestriction;

public class UserDietaryRestrictionTesst {
    public static void main(String[] args) {

        UserDietaryRestrictionsDAO dao = new UserDietaryRestrictionsDAO();

        if (dao.removeUserRestriction(1, 1)) {
            System.out.println("User restriction removed successfully!");
        } else {
            System.out.println("Delete failed!");
        }

    }
}
