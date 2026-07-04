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

        NutritionFacts nutrition = new NutritionFacts();

        nutrition.setRecipeId(2); 
        nutrition.setServingSize("100g");
        nutrition.setServingsPerContainer(2);
        nutrition.setCalories(250);
        nutrition.setTotalFat(8.5);
        nutrition.setSaturatedFat(2.5);
        nutrition.setTransFat(0.0);
        nutrition.setCholesterol(15);
        nutrition.setSodium(350);
        nutrition.setTotalCarbohydrates(30);
        nutrition.setDietaryFiber(5);
        nutrition.setTotalSugar(8);
        nutrition.setAddedSugar(2);
        nutrition.setProtein(12);
        nutrition.setVitaminA(10);
        nutrition.setVitaminC(20);
        nutrition.setVitaminD(5);
        nutrition.setCalcium(15);
        nutrition.setIron(8);
        nutrition.setPotassium(250);

        NutritionFactsDAO dao = new NutritionFactsDAO();

        if (dao.insertNutritionFacts(nutrition)) {
            System.out.println("Nutrition facts inserted successfully!");
        } else {
            System.out.println("Insert failed!");
        }
    }
}

