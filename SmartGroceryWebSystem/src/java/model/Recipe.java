/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author perer
 */
public class Recipe {
    private int recipeId;
    private String name;
    private String description;
    private String mealType;
    private String cuisine;
    private int cookingTime;
    private String difficulty;
    private int servings;
    private String imageUrl;

    public Recipe() {}
    
    public Recipe(int recipeId, String name, String description,
                  String mealType, String cuisine,
                  int cookingTime, String difficulty,
                  int servings) {

        this.recipeId = recipeId;
        this.name = name;
        this.description = description;
        this.mealType = mealType;
        this.cuisine = cuisine;
        this.cookingTime = cookingTime;
        this.difficulty = difficulty;
        this.servings = servings;
    }
    
    

    public void addRecipe() {
        System.out.println("Recipe added.");
    }

    public void updateRecipe() {
        System.out.println("Recipe updated.");
    }

    public void deleteRecipe() {
        System.out.println("Recipe deleted.");
    }

    public Recipe getRecipeById(int id) {
        return null;
    }

    public void getAllRecipes() {
        System.out.println("Displaying all recipes.");
    }

    

    public int getRecipeId() {
        return recipeId;
    }

    public void setRecipeId(int recipeId) {
        if(recipeId > 0){
            this.recipeId = recipeId;
        }
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        if(name != null && !name.isEmpty()){
            this.name = name;
        }
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getMealType() {
        return mealType;
    }

    public void setMealType(String mealType) {
        this.mealType = mealType;
    }

    public String getCuisine() {
        return cuisine;
    }

    public void setCuisine(String cuisine) {
        this.cuisine = cuisine;
    }

    public int getCookingTime() {
        return cookingTime;
    }

    public void setCookingTime(int cookingTime) {
        if(cookingTime >= 0){
            this.cookingTime = cookingTime;
        }
    }

    public String getDifficulty() {
        return difficulty;
    }

    public void setDifficulty(String difficulty) {
        this.difficulty = difficulty;
    }

    public int getServings() {
        return servings;
    }

    public void setServings(int servings) {
        if(servings > 0){
            this.servings = servings;
        }
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    @Override
    public String toString() {
        return "Recipe{" +
               "recipeId=" + recipeId +
               ", name='" + name + '\'' +
               ", description='" + description + '\'' +
               ", mealType='" + mealType + '\'' +
               ", cuisine='" + cuisine + '\'' +
               ", cookingTime=" + cookingTime +
               ", difficulty='" + difficulty + '\'' +
               ", servings=" + servings +
               ", imageUrl='" + imageUrl + '\'' +
               '}';
}
    
}