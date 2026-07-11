package com.smartgrocery.model;

public class Inventory {

    private int inventoryId;
    private int productId;
    private int stockQty;
    private int reorderLevel;

    public Inventory(int inventoryId, int productId,
                     int stockQty, int reorderLevel) {
        this.inventoryId  = inventoryId;
        this.productId    = productId;
        this.stockQty     = stockQty;
        this.reorderLevel = reorderLevel;
    }

    public int getInventoryId()  
        { return inventoryId; }
    public int getProductId()    
        { return productId; }
    public int getStockQty()     
        { return stockQty; }
    public int getReorderLevel() 
        { return reorderLevel; }

    public void setStockQty(int stockQty) {
        this.stockQty = stockQty;
    }
    public void setReorderLevel(int reorderLevel) {
        this.reorderLevel = reorderLevel;
    }

    public void updateStock() {
        System.out.println("Stock updated: " + stockQty);
    }

    public boolean isLowStock() {
        return stockQty <= reorderLevel;
    }

    public void getExpiryData() {
        System.out.println("Getting expiry data...");
    }

    public void getInventoryStatus() {
        System.out.println("Stock: " + stockQty +
                         " | Reorder: " + reorderLevel +
                         " | Low: " + isLowStock());
    }
}