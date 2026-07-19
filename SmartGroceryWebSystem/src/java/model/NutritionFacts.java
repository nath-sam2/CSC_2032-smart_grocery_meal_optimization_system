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
    private int recipeId;
    private String servingSize;
    private int servingsPerContainer;
    private double calories;
    private double totalFat;
    private double saturatedFat;
    private double transFat;
    private double cholesterol;
    private double sodium;
    private double totalCarbohydrates;
    private double dietaryFiber;
    private double totalSugar;
    private double addedSugar;
    private double protein;
    private double vitaminA;
    private double vitaminC;
    private double vitaminD;
    private double calcium;
    private double iron;
    private double potassium;


    public NutritionFacts() {}

    public NutritionFacts(int nutritionId, int recipeId, String servingSize, int servingsPerContainer, double calories, double totalFat, double saturatedFat, double transFat, double cholesterol, double sodium, double totalCarbohydrates, double dietaryFiber, double totalSugar, double addedSugar, double protein, double vitaminA, double vitaminC, double vitaminD, double calcium, double iron, double potassium) {
        this.nutritionId = nutritionId;
        this.recipeId = recipeId;
        this.servingSize = servingSize;
        this.servingsPerContainer = servingsPerContainer;
        this.calories = calories;
        this.totalFat = totalFat;
        this.saturatedFat = saturatedFat;
        this.transFat = transFat;
        this.cholesterol = cholesterol;
        this.sodium = sodium;
        this.totalCarbohydrates = totalCarbohydrates;
        this.dietaryFiber = dietaryFiber;
        this.totalSugar = totalSugar;
        this.addedSugar = addedSugar;
        this.protein = protein;
        this.vitaminA = vitaminA;
        this.vitaminC = vitaminC;
        this.vitaminD = vitaminD;
        this.calcium = calcium;
        this.iron = iron;
        this.potassium = potassium;
    }
    

    public String getNutritionSummary() {
        return "Calories: " + calories + " kcal | Protein: " + protein + " g | Carbs: " + totalCarbohydrates + " g | Fat: " + totalFat + " g";
    }

    public double calculateCalories() {
        return (protein * 4) + (totalCarbohydrates * 4) + (totalFat * 9);
    }

    public int getRecipeId() {
        return recipeId;
    }

    public void setRecipeId(int recipeId) {
        this.recipeId = recipeId;
    }

    public int getServingsPerContainer() {
        return servingsPerContainer;
    }

    public void setServingsPerContainer(int servingsPerContainer) {
        this.servingsPerContainer = servingsPerContainer;
    }

    public double getSaturatedFat() {
        return saturatedFat;
    }

    public void setSaturatedFat(double saturatedFat) {
        this.saturatedFat = saturatedFat;
    }

    public double getTransFat() {
        return transFat;
    }

    public void setTransFat(double transFat) {
        this.transFat = transFat;
    }

    public double getCholesterol() {
        return cholesterol;
    }

    public void setCholesterol(double cholesterol) {
        this.cholesterol = cholesterol;
    }

    public double getTotalCarbohydrates() {
        return totalCarbohydrates;
    }

    public void setTotalCarbohydrates(double totalCarbohydrates) {
    if(totalCarbohydrates >= 0){
        this.totalCarbohydrates = totalCarbohydrates;
    }
}

    public double getTotalSugar() {
        return totalSugar;
    }

    public void setTotalSugar(double totalSugar) {
    if(totalSugar >= 0){
        this.totalSugar = totalSugar;
    }
}

    public double getAddedSugar() {
        return addedSugar;
    }

    public void setAddedSugar(double addedSugar) {
        this.addedSugar = addedSugar;
    }

    public double getVitaminA() {
        return vitaminA;
    }

    public void setVitaminA(double vitaminA) {
        this.vitaminA = vitaminA;
    }

    public double getVitaminC() {
        return vitaminC;
    }

    public void setVitaminC(double vitaminC) {
        this.vitaminC = vitaminC;
    }

    public double getVitaminD() {
        return vitaminD;
    }

    public void setVitaminD(double vitaminD) {
        this.vitaminD = vitaminD;
    }

    public double getCalcium() {
        return calcium;
    }

    public void setCalcium(double calcium) {
        this.calcium = calcium;
    }

    public double getIron() {
        return iron;
    }

    public void setIron(double iron) {
        this.iron = iron;
    }

    public double getPotassium() {
        return potassium;
    }

    public void setPotassium(double potassium) {
        this.potassium = potassium;
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
    if(protein >= 0){
        this.protein = protein;
    }
}

    public double getTotalFat() {
        return totalFat;
    }

    public void setTotalFat(double totalFat) {
    if(totalFat >= 0){
        this.totalFat = totalFat;
    }
}

    public double getDietaryFiber() {
        return dietaryFiber;
    }

    public void setDietaryFiber(double dietaryFiber) {
    if(dietaryFiber >= 0){
        this.dietaryFiber = dietaryFiber;
    }
}

    public double getSodium() {
        return sodium;
    }

    public void setSodium(double sodium) {
    if(sodium >= 0){
        this.sodium = sodium;
    }
}

    public String getServingSize() {
        return servingSize;
    }

    public void setServingSize(String servingSize) {

    if(servingSize != null && !servingSize.trim().isEmpty()){
        this.servingSize = servingSize;
    }
}

    @Override
    public String toString() {
        return getNutritionSummary();
    }
}
