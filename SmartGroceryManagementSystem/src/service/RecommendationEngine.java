/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

/**
 *
 * @author perer
 */
import java.util.List;

public class RecommendationEngine {
    public List<Recipe> recommendRecipes(int userId){}

    public List<Recipe> filterByDietaryRestrictions(List<Recipe> recipes, int userId){}

    public List<Recipe> prioritizeByExpiry(List<Recipe> recipes){}

    public int calculateHealthScore(Recipe recipe){}

    public ShoppingList generateShoppingList(int userId){}
}
