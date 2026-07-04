/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author perer
 */
public class Ingredient {
    private int ingredientId;
    private int productId;
    private String name;
    private String category;
    private String unit;

    public Ingredient() {}

    public Ingredient(int ingredientId, int productId, String name, String category, String unit) {

        this.ingredientId = ingredientId;
        this.productId = productId;
        this.name = name;
        this.category = category;
        this.unit = unit;
    }

    public void addIngredient() {
        System.out.println("Ingredient added.");
    }

    public void updateIngredient() {
        System.out.println("Ingredient updated.");
    }

    public void getAllIngredients() {
        System.out.println("Displaying all ingredients.");
    }

    public int getIngredientId() {
        return ingredientId;
    }

    public void setIngredientId(int ingredientId) {
        this.ingredientId = ingredientId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        if(name != null && !name.isEmpty()){
            this.name = name;
        }
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    @Override
    public String toString() {
        return "Ingredient{" +
               "ingredientId=" + ingredientId +
               ", productId=" + productId +
               ", name='" + name + '\'' +
               ", catrgory='" + category + '\'' +
               ", unit=" + unit +
               '}';
    }
}
