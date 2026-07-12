/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package test;

/**
 *
 * @author perer
 */
import dao.DietaryRestrictionDAO;
import dao.UserDietaryRestrictionDAO;
import model.DietaryRestriction;

import java.util.List;

public class DietaryRestrictionTest {
   public static void main(String[] args) {

        DietaryRestrictionDAO dao = new DietaryRestrictionDAO();

        if (dao.deleteRestriction(1)) {
            System.out.println("Restriction deleted successfully!");
        } else {
            System.out.println("Delete failed!");
        }

    }
}
