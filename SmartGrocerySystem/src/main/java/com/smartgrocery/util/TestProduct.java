package com.smartgrocery.util;

import com.smartgrocery.service.ProductService;
import com.smartgrocery.model.Product;
import java.util.List;

public class TestProduct {
    public static void main(String[] args) {

        ProductService ps = new ProductService();

        // Add product test
        boolean added = ps.addProduct(
            "Rice 1kg", 320.0, 50, null, "1kg", 1
        );
        System.out.println("Product added: " + added);

        // Get all products
        List<Product> products = ps.getAllProducts();
        System.out.println("Total products: " + products.size());

        for (Product p : products) {
            System.out.println("- " + p.getName() +
                             " | Rs." + p.getPrice() +
                             " | Qty: " + p.getQuantity() +
                             " | Unit: " + p.getUnit());
        }
    }
}