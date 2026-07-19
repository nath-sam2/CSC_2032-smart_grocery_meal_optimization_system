package service;

import dao.ProductDAO;
import model.Product;
import util.IDGenerator;
import java.util.Date;
import java.util.List;

public class ProductService {

    private ProductDAO productDAO = new ProductDAO();

    public boolean addProduct(String name, double price,
                              int quantity, Date expiryDate,
                              String unit, int categoryId) {
        int id = IDGenerator.generateId("products");
        Product p = new Product(id, name, price,
                                quantity, expiryDate, unit, categoryId);
        return productDAO.insertProduct(p);
    }

    public List<Product> getAllProducts() {
        return productDAO.getAllProducts();
    }

    public Product getProductById(int productId) {
        return productDAO.getProductById(productId);
    }

    public boolean updateProduct(Product p) {
        return productDAO.updateProduct(p);
    }

    public boolean deleteProduct(int productId) {
        return productDAO.deleteProduct(productId);
    }

    public List<Product> searchProduct(String keyword) {
        return productDAO.searchProduct(keyword);
    }
}