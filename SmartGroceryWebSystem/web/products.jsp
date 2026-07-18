<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.smartgrocery.model.User"%>
<%@page import="com.smartgrocery.model.Product"%>
<%@page import="com.smartgrocery.service.ProductService"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
    <title>Products - Smart Grocery</title>
    <style>
        body { font-family: Arial; background: #f0fdf4; margin: 0; }
        .navbar { background: #16a34a; padding: 15px 30px;
                  display: flex; justify-content: space-between; }
        .navbar h1 { color: white; margin: 0; font-size: 20px; }
        .navbar a  { color: white; text-decoration: none; margin-left: 16px; }
        .content   { padding: 30px; }
        h2 { color: #166534; }
        table { width: 100%; border-collapse: collapse;
                background: white; border-radius: 10px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.08); }
        th { background: #16a34a; color: white; padding: 12px; text-align: left; }
        td { padding: 12px; border-bottom: 1px solid #e5e7eb; }
        tr:hover td { background: #f0fdf4; }
        .btn { background: #16a34a; color: white; padding: 8px 14px;
               border: none; border-radius: 6px; cursor: pointer;
               text-decoration: none; font-size: 13px; }
        .btn-red { background: #dc2626; color: white; padding: 8px 14px;
                   border: none; border-radius: 6px; cursor: pointer; }
        .add-btn { background: #16a34a; color: white; padding: 10px 20px;
                   border: none; border-radius: 8px; cursor: pointer;
                   font-size: 15px; margin-bottom: 16px; }
    </style>
</head>
<body>
    <%
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        ProductService ps = new ProductService();
        List<Product> products = ps.getAllProducts();
    %>
    <div class="navbar">
        <h1>🛒 Smart Grocery</h1>
        <div>
            <a href="dashboard.jsp">Dashboard</a>
            <a href="cart.jsp">Cart</a>
            <a href="LogoutServlet">Logout</a>
        </div>
    </div>
    <div class="content">
        <h2>📦 Products</h2>
        <% if (user.getRole().equals("ADMIN")) { %>
            <a href="addProduct.jsp" class="btn">+ Add Product</a>
        <% } %>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Unit</th>
                    <th>Expiry</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% for (Product p : products) { %>
                <tr>
                    <td><%= p.getProductId() %></td>
                    <td><%= p.getName() %></td>
                    <td>Rs. <%= p.getPrice() %></td>
                    <td><%= p.getQuantity() %></td>
                    <td><%= p.getUnit() %></td>
                    <td><%= p.getExpiryDate() != null ?
                             p.getExpiryDate() : "-" %></td>
                    <td>
                        <a href="CartServlet?action=add&productId=
                           <%= p.getProductId() %>&price=
                           <%= p.getPrice() %>" class="btn">
                           Add to Cart
                        </a>
                        <% if (user.getRole().equals("ADMIN")) { %>
                            <a href="ProductServlet?action=delete&id=
                               <%= p.getProductId() %>" class="btn-red"
                               onclick="return confirm('Delete?')">
                               Delete
                            </a>
                        <% } %>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>