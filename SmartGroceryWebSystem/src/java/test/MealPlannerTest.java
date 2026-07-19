/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package test;

/**
 *
 * @author perer
 */
import model.MealPlanner;
import dao.MealPlannerDAO;

import java.time.LocalDate;
import java.util.List;

public class MealPlannerTest {
    public static void main(String[] args) {

        MealPlannerDAO dao = new MealPlannerDAO();

        // INSERT
        MealPlanner mealPlan = new MealPlanner();

        mealPlan.setUserId(1);
        mealPlan.setPlanName("Healthy Weekly Plan");
        mealPlan.setStartDate(LocalDate.now());
        mealPlan.setEndDate(LocalDate.now().plusDays(6));

        dao.insertMealPlan(mealPlan);

        // GET BY USER
        List<MealPlanner> plans = dao.getMealPlansByUser(1);

        System.out.println("\nMeal Plans");

        for (MealPlanner p : plans) {
            System.out.println(p);
        }

        // GET BY ID
        MealPlanner plan = dao.getMealPlansById(1);

        if (plan != null) {

            System.out.println("\nRetrieved:");
            System.out.println(plan);

            /*// UPDATE
            plan.setPlanName("Updated Healthy Plan");

            dao.updateMealPlan(plan);*/

            // DELETE (Uncomment to test)
           dao.deleteMealPlan(plan.getMealPlanId());
        }

    }
}
