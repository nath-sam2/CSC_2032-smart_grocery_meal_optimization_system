package com.smartgrocery.service;

import com.smartgrocery.dao.NotificationDAO;
import com.smartgrocery.dao.InventoryDAO;
import com.smartgrocery.model.Inventory;
import com.smartgrocery.model.NotificationService;
import com.smartgrocery.model.Product;
import java.util.List;

public class NotificationAlertService 
{

    private NotificationDAO notifDAO   = new NotificationDAO();
    private InventoryDAO    invDAO     = new InventoryDAO();

    // Check low stock and send alerts
    public void sendLowStockAlert(int productId, String productName) 
    {
        Inventory inv = invDAO.getInventoryByProduct(productId);
        if (inv != null && inv.isLowStock()) {
            String msg = productName + " is running low! " +
                        "Stock: " + inv.getQuantity() +
                        " | Reorder: " + inv.getReorderLevel();
            notifDAO.insertNotification(productId, msg, "LOW_STOCK");
            System.out.println("LOW STOCK ALERT sent: " + msg);
        }
    }

    // Check expiry and send alerts
    public void sendExpiryAlert(int productId, String productName,
                                String expiryDate) {
        String msg = productName + " is expiring soon! " +
                    "Expiry: " + expiryDate;
        notifDAO.insertNotification(productId, msg, "EXPIRY");
        System.out.println("EXPIRY ALERT sent: " + msg);
    }

    // Get all notifications
    public List<NotificationService> getAllNotifications() 
    {
        return notifDAO.getAllNotifications();
    }

    // Get unread notifications
    public List<NotificationService> getUnreadNotifications()
    {
        return notifDAO.getUnreadNotifications();
    }

    // Mark notification as read
    public boolean markAsRead(int notifId) {
        return notifDAO.markAsRead(notifId);
    }

    // Auto check all inventory for low stock
    public void checkAllLowStock(List<Inventory> inventoryList,
                                  List<com.smartgrocery.model.Product> products) 
    {
        for (Inventory inv : inventoryList) {
            if (inv.isLowStock()) {
                String name = "Product " + inv.getProductId();
                for (Product p : products) {
                    if (p.getProductId() == inv.getProductId()) {
                        name = p.getName();
                        break;
                    }
                }
                String msg = name + " is running low! Stock: " +
                            inv.getQuantity();
                notifDAO.insertNotification(
                    inv.getProductId(), msg, "LOW_STOCK"
                );
                System.out.println("Alert: " + msg);
            }
        }
    }

    // Expose inventory data for Member 2
    public List<Product> getAvailableProducts() 
    {
        return invDAO.getExpiringItems(365);
    }

    public List<Product> getExpiringProducts(int days) 
    {
        return invDAO.getExpiringItems(days);
    }
}