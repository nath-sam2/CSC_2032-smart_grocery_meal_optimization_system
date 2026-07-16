package com.smartgrocery.model;

import java.util.Date;

public class Product {

    private int productId;
    private String name;
    private double price;
    private int quantity;
    private Date expiryDate;
    private String unit;
    private int categoryId;

    // Constructor
    public Product(int productId, String name, double price,
                   int quantity, Date expiryDate,
                   String unit, int categoryId) {
        this.productId  = productId;
        this.name       = name;
        this.price      = price;
        this.quantity   = quantity;
        this.expiryDate = expiryDate;
        this.unit       = unit;
        this.categoryId = categoryId;
    }

   
    public int getProductId()   
        { return productId; }
    public String getName()     
        { return name; }
    public double getPrice()    
        { return price; }
    public int getQuantity()    
        { return quantity; }
    public Date getExpiryDate() 
        { return expiryDate; }
    public String getUnit()     
        { return unit; }
    public int getCategoryId()  
        { return categoryId; }

    
    public void setName(String name)       
        { this.name = name; }
    public void setPrice(double price)     
        { this.price = price; }
    public void setQuantity(int quantity)  
        { this.quantity = quantity; }
    public void setUnit(String unit)       
        { this.unit = unit; }
    public void setCategoryId(int id)      
        { this.categoryId = id; }

    
    public void addProduct()    
        { System.out.println("Product added: " + name); }
    public void updateProduct() 
        { System.out.println("Product updated: " + name); }
    public void deleteProduct() 
        { System.out.println("Product deleted: " + name); }
    public void searchProduct() 
        { System.out.println("Searching: " + name); }
}