/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author perer
 */
import java.time.LocalDate;

public class MealPlanDetail {
    private int mealPlanDetailId;
    private int mealPlanId;
    private int recipeId;
    private LocalDate mealDate;
    private String mealType;

    public MealPlanDetail() {
    }

    public MealPlanDetail(int mealPlanDetailId, int mealPlanId, int recipeId,
                          LocalDate mealDate, String mealType) {

        this.mealPlanDetailId = mealPlanDetailId;
        this.mealPlanId = mealPlanId;
        this.recipeId = recipeId;
        this.mealDate = mealDate;
        this.mealType = mealType;
    }
    
    /**
     * Returns recipe information.
     * (Will later be connected to RecipeDAO.)
     */
    public String getRecipeDetails() {
        return "Recipe ID: " + recipeId;
    }

    /**
     * Updates the meal assigned to this plan.
     */
    public void updateMeal(int recipeId, String mealType, LocalDate mealDate) {
        this.recipeId = recipeId;
        this.mealType = mealType;
        this.mealDate = mealDate;
    }

    public int getMealPlanDetailId() {
        return mealPlanDetailId;
    }
    
    public void setMealPlanDetailId(int mealPlanDetailId) {
        this.mealPlanDetailId = mealPlanDetailId;
    }

    public int getMealPlanId() {
        return mealPlanId;
    }

    public void setMealPlanId(int mealPlanId) {
        this.mealPlanId = mealPlanId;
    }

    public int getRecipeId() {
        return recipeId;
    }

    public void setRecipeId(int recipeId) {
        this.recipeId = recipeId;
    }
    
    public LocalDate getMealDate() {
        return mealDate;
    }

    public void setMealDate(LocalDate mealDate) {
        this.mealDate = mealDate;
    }

    public String getMealType() {
        return mealType;
    }

    public void setMealType(String mealType) {
        this.mealType = mealType;
    }
    
    @Override
    public String toString() {
        return "MealPlanDetail{" + "mealPlanDetailId=" + mealPlanDetailId + ", mealPlanId=" + mealPlanId + ", recipeId=" + recipeId +
                ", mealDate=" + mealDate + ", mealType='" + mealType + '\'' + '}';
    }
}
