package com.smartgrocery.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Order {

    private int orderId;
    private int userId;
    private List<OrderItem> items;
    private double totalAmount;
    private String status;
    private Date orderDate;

    public Order(int orderId, int userId, double totalAmount,
                 String status, Date orderDate) {
        this.orderId     = orderId;
        this.userId      = userId;
        this.items       = new ArrayList<>();
        this.totalAmount = totalAmount;
        this.status      = status;
        this.orderDate   = orderDate;
    }

    public int getOrderId()          
        { return orderId; }
    public int getUserId()           
        { return userId; }
    public List<OrderItem> getItems()
        { return items; }
    public double getTotalAmount()   
        { return totalAmount; }
    public String getStatus()        
        { return status; }
    public Date getOrderDate()       
        { return orderDate; }

    public void setStatus(String status) 
        { this.status = status; }
    public void setItems(List<OrderItem> items) 
        { this.items = items; }

    public void placeOrder() {
        System.out.println("Order placed! ID: " + orderId);
    }
    public void updateStatus(String status) {
        this.status = status;
        System.out.println("Status updated: " + status);
    }
    public void getOrderHistory() {
        System.out.println("Order history for user: " + userId);
    }
}