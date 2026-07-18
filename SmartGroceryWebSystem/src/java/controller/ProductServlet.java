package com.smartgrocery.controller;

import com.smartgrocery.model.Product;
import com.smartgrocery.service.ProductService;
import com.smartgrocery.service.InventoryService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/ProductServlet")
public class ProductServlet extends HttpServlet {

    private ProductService   productService   = new ProductService();
    private InventoryService inventoryService = new InventoryService();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("add".equals(action)) {

            String name     = request.getParameter("name");
            double price    = Double.parseDouble(
                              request.getParameter("price"));
            int quantity    = Integer.parseInt(
                              request.getParameter("quantity"));
            String unit     = request.getParameter("unit");
            String expiry   = request.getParameter("expiryDate");
            int categoryId  = Integer.parseInt(
                              request.getParameter("categoryId"));

            Date expiryDate = null;
            if (expiry != null && !expiry.isEmpty()) {
                try {
                    expiryDate = new SimpleDateFormat("yyyy-MM-dd")
                                     .parse(expiry);
                } catch (Exception e) { e.printStackTrace(); }
            }

            boolean added = productService.addProduct(
                name, price, quantity, expiryDate, unit, categoryId
            );

            if (added) {
                Product p = productService.searchProduct(name)
                                          .get(0);
                inventoryService.addInventory(
                    p.getProductId(), quantity, 5
                );
                request.setAttribute("success",
                    "Product added successfully!");
            } else {
                request.setAttribute("error", "Failed to add product!");
            }
            request.getRequestDispatcher("addProduct.jsp")
                   .forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            productService.deleteProduct(id);
            response.sendRedirect("products.jsp");
        }
    }
}