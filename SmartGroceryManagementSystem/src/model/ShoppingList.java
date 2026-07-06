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

public class ShoppingList {
    private int shoppingListId;
    private int userId;
    private LocalDate createdDate;
    private String status;

    public ShoppingList() {
    }

    public ShoppingList(int shoppingListId, int userId, LocalDate createdDate, String status) {
        this.shoppingListId = shoppingListId;
        this.userId = userId;
        this.createdDate = createdDate;
        this.status = status;
    }

    public int getShoppingListId() {
        return shoppingListId;
    }

    public void setShoppingListId(int shoppingListId) {
        this.shoppingListId = shoppingListId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public LocalDate getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(LocalDate createdDate) {
        this.createdDate = createdDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        if (status != null && !status.isEmpty()) {
            this.status = status;
        }
    }

    @Override
    public String toString() {
        return "ShoppingList{" + "shoppingListId=" + shoppingListId + ", userId=" + userId + ", createdDate=" + createdDate + ", status='" + status + '\'' + '}';
    }
}
