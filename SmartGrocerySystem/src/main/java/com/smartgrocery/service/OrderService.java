package com.smartgrocery.service;

import com.smartgrocery.dao.OrderDAO;
import com.smartgrocery.dao.CartDAO;
import com.smartgrocery.model.Order;
import com.smartgrocery.model.OrderItem;
import com.smartgrocery.model.CartItem;
import com.smartgrocery.util.IDGenerator;
import java.util.Date;
import java.util.List;

public class OrderService {

    private OrderDAO orderDAO = new OrderDAO();
    private CartDAO cartDAO   = new CartDAO();

    // Place order from cart
    public boolean placeOrder(int userId, List<CartItem> cartItems) {
        // Calculate total
        double total = 0;
        for (CartItem ci : cartItems) {
            total += ci.getSubtotal();
        }

        // Create order
        int orderId = IDGenerator.generateId("orders");
        Order order = new Order(orderId, userId, total,
                                "PENDING", new Date());

        // Save order
        boolean saved = orderDAO.insertOrder(order);
        if (!saved) return false;

        // Save order items
        int itemCount = IDGenerator.generateId("order_items");
        for (CartItem ci : cartItems) {
            OrderItem oi = new OrderItem(
                itemCount++,
                ci.getProductId(),
                ci.getQuantity(),
                ci.getPrice()
            );
            orderDAO.insertOrderItem(orderId, oi);
        }

        // Clear cart
        cartDAO.clearCart(userId);

        return true;
    }

    // Get all orders
    public List<Order> getAllOrders() {
        return orderDAO.getAllOrders();
    }

    // Get orders by user
    public List<Order> getOrdersByUser(int userId) {
        return orderDAO.getOrdersByUser(userId);
    }

    // Update order status
    public boolean updateStatus(int orderId, String status) {
        return orderDAO.updateStatus(orderId, status);
    }

    // Get order items
    public List<OrderItem> getOrderItems(int orderId) {
        return orderDAO.getOrderItems(orderId);
    }
}