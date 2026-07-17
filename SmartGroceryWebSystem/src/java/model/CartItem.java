package model;

public class CartItem {

    private int cartItemId;
    private int productId;
    private int quantity;
    private double price;

    public CartItem(int cartItemId, int productId,
                    int quantity, double price) {
        this.cartItemId = cartItemId;
        this.productId  = productId;
        this.quantity   = quantity;
        this.price      = price;
    }

    public int getCartItemId() 
        { return cartItemId; }
    public int getProductId()  
        { return productId; }
    public int getQuantity()   
        { return quantity; }
    public double getPrice()   
        { return price; }

    public void setQuantity(int quantity) 
        { this.quantity = quantity; }
    public void setPrice(double price)    
        { this.price = price; }

    public double getSubtotal() {
        return quantity * price;
    }
}