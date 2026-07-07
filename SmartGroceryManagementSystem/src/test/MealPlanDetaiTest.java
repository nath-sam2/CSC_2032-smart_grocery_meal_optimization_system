/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package test;

/**
 *
 * @author perer
 */
import model.MealPlanDetail;
import dao.MealPlanDetailDAO;
import model.MealPlanner;
import dao.MealPlannerDAO;

import java.time.LocalDate;
import java.util.List;

public class MealPlanDetaiTest {
    public static void main(String[] args) {

        MealPlanDetailDAO dao = new MealPlanDetailDAO();

        // INSERT
        MealPlanDetail detail = new MealPlanDetail();

        detail.setMealPlanId(2);
        detail.setRecipeId(5);
        detail.setMealDate(LocalDate.now());
        detail.setMealType("Lunch");

        dao.insertMealPlanDetail(detail);
        
        // GET ALL DETAILS
        List<MealPlanDetail> details = dao.getMealDetailsByPlanId(2);

        System.out.println("\nMeal Plan Details:");

        for (MealPlanDetail d : details) {
            System.out.println(d);
        }

        // GET BY ID
        MealPlanDetail meal = dao.getMealPlanDetailById(1);

        if (meal != null) {

            System.out.println("\nRetrieved:");
            System.out.println(meal);

           // UPDATE
            meal.setMealType("Dinner");
        
        }
    }
}
