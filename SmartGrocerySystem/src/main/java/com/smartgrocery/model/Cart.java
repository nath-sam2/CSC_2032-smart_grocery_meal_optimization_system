package com.smartgrocery.model;

import java.util.ArrayList;
import java.util.List;

public class Cart {

    private int cartId;
    private int userId;
    private List<CartItem> items;

    public Cart(int cartId, int userId) {
        this.cartId = cartId;
        this.userId = userId;
        this.items  = new ArrayList<>();
    }

    public int getCartId()          
        { return cartId; }
    public int getUserId()          
        { return userId; }
    public List<CartItem> getItems()
        { return items; }

    public void addItem(CartItem item) {
        items.add(item);
        System.out.println("Item added to cart!");
    }

    public void removeItem(int cartItemId) {
        items.removeIf(i -> i.getCartItemId() == cartItemId);
        System.out.println("Item removed from cart!");
    }

    public void updateQty(int cartItemId, int newQty) {
        for (CartItem i : items) {
            if (i.getCartItemId() == cartItemId) {
                i.setQuantity(newQty);
            }
        }
    }

    public double getTotal() {
        double total = 0;
        for (CartItem i : items) {
            total += i.getSubtotal();
        }
        return total;
    }
}