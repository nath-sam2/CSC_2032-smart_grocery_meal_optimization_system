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
import model.DietaryRestriction;

import java.util.List;

public class DietaryRestrictionTest {
    public static void main(String[] args) {

        DietaryRestrictionDAO dao = new DietaryRestrictionDAO();

        List<DietaryRestriction> restrictions = dao.getAllRestrictions();

        for (DietaryRestriction restriction : restrictions) {
            System.out.println(restriction);
        }


    }
}
