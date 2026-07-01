/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author perer
 */
public class RecipeIngredient {
    private int recipeIngredientId;
    private int recipeId;
    private int ingredientId;
    private double quantity;
    private String unit;
    private boolean optional;

    public RecipeIngredient() {}

    public RecipeIngredient(int recipeIngredientId, int recipeId, int ingredientId, double quantity, String unit, boolean optional) {
        
        this.recipeIngredientId = recipeIngredientId;
        this.recipeId = recipeId;
        this.ingredientId = ingredientId;
        this.quantity = quantity;
        this.unit = unit;
        this.optional = optional;
    }

    public void updateQuantity(double quantity) {
        if(quantity > 0){
            this.quantity = quantity;
        }
    }

    public String getIngredientDetails() {
        return "Ingredient ID: " + ingredientId + ", Quantity: " + quantity + " " + unit;
    }

    public int getRecipeIngredientId() {
        return recipeIngredientId;
    }

    public void setRecipeIngredientId(int recipeIngredientId) {
        this.recipeIngredientId = recipeIngredientId;
    }

    public int getRecipeId() {
        return recipeId;
    }

    public void setRecipeId(int recipeId) {
        this.recipeId = recipeId;
    }

    public int getIngredientId() {
        return ingredientId;
    }

    public void setIngredientId(int ingredientId) {
        this.ingredientId = ingredientId;
    }

    public double getQuantity() {
        return quantity;
    }

    public void setQuantity(double quantity) {
        if(quantity > 0){
            this.quantity = quantity;
        }
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public boolean isOptional() {
        return optional;
    }

    public void setOptional(boolean optional) {
        this.optional = optional;
    }

    @Override
    public String toString() {
        return getIngredientDetails();
    }
}
