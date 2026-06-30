/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author perer
 */
public class NutritionFacts {
    private int nutritionId;
    private double calories;
    private double protein;
    private double carbohydrates;
    private double totalFat;
    private double dietaryFiber;
    private double sugar;
    private double sodium;
    private String servingSize;

    public NutritionFacts() {}

    public NutritionFacts(int nutritionId, double calories,
                          double protein, double carbohydrates,
                          double totalFat, double dietaryFiber,
                          double sugar, double sodium,
                          String servingSize) {

        this.nutritionId = nutritionId;
        this.calories = calories;
        this.protein = protein;
        this.carbohydrates = carbohydrates;
        this.totalFat = totalFat;
        this.dietaryFiber = dietaryFiber;
        this.sugar = sugar;
        this.sodium = sodium;
        this.servingSize = servingSize;
    }

    public String getNutritionSummary() {
        return "Calories: " + calories + " kcal | Protein: " + protein + " g | Carbs: " + carbohydrates + " g | Fat: " + totalFat + " g";
    }

    public double calculateCalories() {
        return (protein * 4) + (carbohydrates * 4) + (totalFat * 9);
    }

    public int getNutritionId() {
        return nutritionId;
    }

    public void setNutritionId(int nutritionId) {
        this.nutritionId = nutritionId;
    }

    public double getCalories() {
        return calories;
    }

    public void setCalories(double calories) {
        if(calories >= 0){
            this.calories = calories;
        }
    }

    public double getProtein() {
        return protein;
    }

    public void setProtein(double protein) {
        this.protein = protein;
    }

    public double getCarbohydrates() {
        return carbohydrates;
    }

    public void setCarbohydrates(double carbohydrates) {
        this.carbohydrates = carbohydrates;
    }

    public double getTotalFat() {
        return totalFat;
    }

    public void setTotalFat(double totalFat) {
        this.totalFat = totalFat;
    }

    public double getDietaryFiber() {
        return dietaryFiber;
    }

    public void setDietaryFiber(double dietaryFiber) {
        this.dietaryFiber = dietaryFiber;
    }

    public double getSugar() {
        return sugar;
    }

    public void setSugar(double sugar) {
        this.sugar = sugar;
    }

    public double getSodium() {
        return sodium;
    }

    public void setSodium(double sodium) {
        this.sodium = sodium;
    }

    public String getServingSize() {
        return servingSize;
    }

    public void setServingSize(String servingSize) {
        this.servingSize = servingSize;
    }

    @Override
    public String toString() {
        return getNutritionSummary();
    }
}
