package service;

import dao.OrderDAO;
import dao.CartDAO;
import dao.InventoryDAO;
import model.Order;
import model.OrderItem;
import model.CartItem;
import model.Inventory;
import util.IDGenerator;
import java.util.Date;
import java.util.List;

public class OrderService {

    private OrderDAO orderDAO = new OrderDAO();
    private CartDAO cartDAO   = new CartDAO();
    private InventoryDAO invDAO       = new InventoryDAO();
    private NotificationAlertService notifService =new NotificationAlertService();

    
    public boolean placeOrder(int userId, List<CartItem> cartItems) {
        
        double total = 0;
        for (CartItem ci : cartItems) {
            total += ci.getSubtotal();
        }

        
        int orderId = IDGenerator.generateId("orders");
        Order order = new Order(orderId, userId, total,"PENDING", new Date());

      
        boolean saved = orderDAO.insertOrder(order);
        if (!saved) return false;

        int itemCount = IDGenerator.generateId("order_items");
        for (CartItem ci : cartItems) {
            OrderItem oi = new OrderItem(
                itemCount++,
                ci.getProductId(),
                ci.getQuantity(),
                ci.getPrice()
            );
            orderDAO.insertOrderItem(orderId, oi);
   

        Inventory inv = invDAO.getInventoryByProduct(ci.getProductId());
            if (inv != null) {
                    int newQty = inv.getQuantity() - ci.getQuantity();
                    invDAO.updateStock(ci.getProductId(), newQty);

        Inventory updated = invDAO.getInventoryByProduct(ci.getProductId());
            if (updated != null && updated.isLowStock()) {
                    notifService.sendLowStockAlert(
                    ci.getProductId(),
                    "Product " + ci.getProductId());
            }
        }
    }
        cartDAO.clearCart(userId);
        System.out.println("Order placed! ID: " + orderId +" | Total: Rs." + total);

        return true;
    }

    
    public List<Order> getAllOrders() {
        return orderDAO.getAllOrders();
    }

    public List<Order> getOrdersByUser(int userId) {
        return orderDAO.getOrdersByUser(userId);
    }

    public boolean updateStatus(int orderId, String status) {
        return orderDAO.updateStatus(orderId, status);
    }

    public List<OrderItem> getOrderItems(int orderId) {
        return orderDAO.getOrderItems(orderId);
    }
}