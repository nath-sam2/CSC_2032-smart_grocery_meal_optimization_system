/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package test;

/**
 *
 * @author perer
 */
 import dao.NutritionFactsDAO;
import model.NutritionFacts;

public class NutritionFactsTest {

    public static void main(String[] args) {

        NutritionFactsDAO dao = new NutritionFactsDAO();

        NutritionFacts nutrition = dao.getNutritionFactsByRecipeId(1);

        if (nutrition != null) {
            System.out.println(nutrition);
        } else {
            System.out.println("No nutrition information found.");
        }
    }
}

