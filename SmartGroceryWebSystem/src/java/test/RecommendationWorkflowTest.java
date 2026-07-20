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
import model.MealPlanner;
import model.Recipe;
import model.ShoppingList;
import model.Ingredient;
import service.RecommendationEngine;

import java.util.List;
import model.NutritionFacts;
public class RecommendationWorkflowTest {
    public static void main(String[] args) {
RecommendationEngine engine = new RecommendationEngine();
NutritionFactsDAO nutritionDAO = new NutritionFactsDAO();
NutritionFacts n = nutritionDAO.getNutritionFactsByRecipeId(6); // Quinoa Salad
System.out.println("Health Score: " + engine.calculateHealthScore(n));
    }
}

