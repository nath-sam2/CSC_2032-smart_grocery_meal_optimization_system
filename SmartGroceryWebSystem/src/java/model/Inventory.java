package model;

public class Inventory {

    private int inventoryId;
    private int productId;
    private int quantity;
    private int reorderLevel;

    public Inventory(int inventoryId, int productId,
                     int quantity, int reorderLevel) {
        this.inventoryId  = inventoryId;
        this.productId    = productId;
        this.quantity     = quantity;
        this.reorderLevel = reorderLevel;
    }

    public int getInventoryId()  
        { return inventoryId; }
    public int getProductId()    
        { return productId; }
    public int getQuantity()     
        { return quantity; }
    public int getReorderLevel() 
        { return reorderLevel; }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    public void setReorderLevel(int reorderLevel) {
        this.reorderLevel = reorderLevel;
    }

    public void updateStock() {
        System.out.println("Stock updated: " + quantity);
    }

    public boolean isLowStock() {
        return quantity <= reorderLevel;
    }

    public void getExpiryData() {
        System.out.println("Getting expiry data...");
    }

    public void getInventoryStatus() {
        System.out.println("Stock: " + quantity +
                         " | Reorder: " + reorderLevel +
                         " | Low: " + isLowStock());
    }
}