/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author perer
 */
public class ShoppingListItem {
    private int shoppingListItemId;
    private int shoppingListId;
    private int ingredientId;
    private double quantity;
    private String unit;
    private String status;

    public ShoppingListItem() {
    }

    public ShoppingListItem(int shoppingListItemId, int shoppingListId,
                            int ingredientId, double quantity,
                            String unit, String status) {

        this.shoppingListItemId = shoppingListItemId;
        this.shoppingListId = shoppingListId;
        this.ingredientId = ingredientId;
        this.quantity = quantity;
        this.unit = unit;
        this.status = status;
    }

    public int getShoppingListItemId() {
        return shoppingListItemId;
    }

    public void setShoppingListItemId(int shoppingListItemId) {
        this.shoppingListItemId = shoppingListItemId;
    }

    public int getShoppingListId() {
        return shoppingListId;
    }

    public void setShoppingListId(int shoppingListId) {
        this.shoppingListId = shoppingListId;
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
        if (quantity > 0) {
            this.quantity = quantity;
        }
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "ShoppingListItem{" + "shoppingListItemId=" + shoppingListItemId + ", shoppingListId=" + shoppingListId + ", ingredientId=" + ingredientId + ", quantity=" + quantity +
                ", unit='" + unit + '\'' + ", status='" + status + '\'' + '}';
    }
}
