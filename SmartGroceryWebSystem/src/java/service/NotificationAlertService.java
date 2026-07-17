package service;

import dao.NotificationDAO;
import dao.InventoryDAO;
import model.Inventory;
import model.NotificationService;
import model.Product;
import java.util.List;

public class NotificationAlertService 
{

    private NotificationDAO notifDAO   = new NotificationDAO();
    private InventoryDAO    invDAO     = new InventoryDAO();

  
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

    public void sendExpiryAlert(int productId, String productName,String expiryDate) {
        String msg = productName + " is expiring soon! " +
                    "Expiry: " + expiryDate;
        notifDAO.insertNotification(productId, msg, "EXPIRY");
        System.out.println("EXPIRY ALERT sent: " + msg);
    }

    public List<NotificationService> getAllNotifications() 
    {
        return notifDAO.getAllNotifications();
    }

    public List<NotificationService> getUnreadNotifications()
    {
        return notifDAO.getUnreadNotifications();
    }

    public boolean markAsRead(int notifId) {
        return notifDAO.markAsRead(notifId);
    }

    public void checkAllLowStock(List<Inventory> inventoryList,List<Product> products)
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

    public List<Product> getAvailableProducts() 
    {
        return invDAO.getExpiringItems(365);
    }

    public List<Product> getExpiringProducts(int days)
    {
        return invDAO.getExpiringItems(days);
    }
}