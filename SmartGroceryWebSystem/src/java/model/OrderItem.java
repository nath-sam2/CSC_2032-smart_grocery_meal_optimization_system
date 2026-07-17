package model;

public class OrderItem {

    private int orderItemId;
    private int productId;
    private int quantity;
    private double price;
    private double subtotal;

    public OrderItem(int orderItemId, int productId,
                     int quantity, double price) {
        this.orderItemId = orderItemId;
        this.productId   = productId;
        this.quantity    = quantity;
        this.price       = price;
        this.subtotal    = quantity * price;
    }

    public int getOrderItemId() 
        { return orderItemId; }
    public int getProductId()   
        { return productId; }
    public int getQuantity()    
        { return quantity; }
    public double getPrice()    
        { return price; }
    public double getSubtotal() 
        { return subtotal; }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
        this.subtotal = quantity * price;
    }
}