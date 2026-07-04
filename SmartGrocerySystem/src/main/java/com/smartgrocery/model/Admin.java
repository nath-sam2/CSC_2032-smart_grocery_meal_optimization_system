package com.smartgrocery.model;

public class Admin extends User {

    private int adminId;

    public Admin(int adminId, String name,
                 String email, String password) {
        super(adminId, name, email, password, "ADMIN");
        this.adminId = adminId;
    }

    public int getAdminId() 
        { return adminId; }

    public void manageProducts() {
        System.out.println("Managing products...");
    }
    public void manageOrders() {
        System.out.println("Managing orders...");
    }
    public void viewReports() {
        System.out.println("Viewing reports...");
    }
}