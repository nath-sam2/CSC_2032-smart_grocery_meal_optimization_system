package service;

import dao.InventoryDAO;
import model.Inventory;
import model.Product;
import util.IDGenerator;
import java.util.List;

public class InventoryService {

    private InventoryDAO inventoryDAO = new InventoryDAO();

    // Add inventory for new product
    public boolean addInventory(int productId,
                                int quantity, int reorderLevel) {
        int id = IDGenerator.generateId("inventory");
        Inventory inv = new Inventory(id, productId,
                                      quantity, reorderLevel);
        return inventoryDAO.insertInventory(inv);
    }

    // Get inventory by product
    public Inventory getInventoryByProduct(int productId) {
        return inventoryDAO.getInventoryByProduct(productId);
    }

    // Get all inventory
    public List<Inventory> getAllInventory() {
        return inventoryDAO.getAllInventory();
    }

    // Update stock after order placed
    public boolean updateStock(int productId, int newQty) {
        return inventoryDAO.updateStock(productId, newQty);
    }

    // Check if low stock
    public boolean isLowStock(int productId) {
        Inventory inv = inventoryDAO.getInventoryByProduct(productId);
        if (inv != null) {
            return inv.isLowStock();
        }
        return false;
    }

    // Get all low stock items
    public List<Inventory> getLowStockItems() {
        return inventoryDAO.getLowStockItems();
    }

    // Get expiring items within X days
    public List<Product> getExpiringItems(int days) {
        return inventoryDAO.getExpiringItems(days);
    }
}