package com.smartgrocery.service;

import com.smartgrocery.dao.CartDAO;
import com.smartgrocery.model.CartItem;
import java.util.List;

public class CartService {

    private CartDAO cartDAO = new CartDAO();

    public boolean addToCart(int cartId, int productId,
                             int quantity, double price) {
        return cartDAO.addItem(cartId, productId, quantity, price);
    }

    public List<CartItem> getCartItems(int userId) {
        return cartDAO.getCartItems(userId);
    }

    public boolean removeFromCart(int cartItemId) {
        return cartDAO.removeItem(cartItemId);
    }

    public boolean updateQuantity(int cartItemId, int newQty) {
        return cartDAO.updateQty(cartItemId, newQty);
    }

    public boolean clearCart(int userId) {
        return cartDAO.clearCart(userId);
    }

    public double getCartTotal(List<CartItem> items) {
        double total = 0;
        for (CartItem i : items) {
            total += i.getSubtotal();
        }
        return total;
    }
}