<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.smartgrocery.model.User"%>
<%@page import="com.smartgrocery.model.Category"%>
<%@page import="com.smartgrocery.service.CategoryService"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Product - Smart Grocery</title>
    <style>
        body { font-family: Arial; background: #f0fdf4; margin: 0; }
        .navbar { background: #16a34a; padding: 15px 30px;
                  display: flex; justify-content: space-between; }
        .navbar h1 { color: white; margin: 0; }
        .navbar a  { color: white; text-decoration: none; margin-left: 16px; }
        .content   { padding: 30px; }
        .box { background: white; padding: 30px; border-radius: 12px;
               box-shadow: 0 2px 8px rgba(0,0,0,0.08); max-width: 500px; }
        h2 { color: #166534; }
        input, select { width: 100%; padding: 10px; margin: 8px 0;
                        border: 1px solid #ddd; border-radius: 6px;
                        box-sizing: border-box; }
        button { background: #16a34a; color: white; padding: 12px;
                 width: 100%; border: none; border-radius: 6px;
                 font-size: 15px; cursor: pointer; margin-top: 10px; }
        .error { color: red; font-size: 13px; }
        .success { color: green; font-size: 13px; }
    </style>
</head>
<body>
    <%
        User user = (User) session.getAttribute("user");
        if (user == null || !user.getRole().equals("ADMIN")) {
            response.sendRedirect("login.jsp");
            return;
        }
        CategoryService cs = new CategoryService();
        List<Category> categories = cs.getAllCategories();
        String error   = (String) request.getAttribute("error");
        String success = (String) request.getAttribute("success");
    %>
    <div class="navbar">
        <h1>🛒 Smart Grocery</h1>
        <div>
            <a href="products.jsp">Products</a>
            <a href="dashboard.jsp">Dashboard</a>
        </div>
    </div>
    <div class="content">
        <div class="box">
            <h2>➕ Add Product</h2>
            <% if (error != null) { %>
                <p class="error"><%= error %></p>
            <% } %>
            <% if (success != null) { %>
                <p class="success"><%= success %></p>
            <% } %>
            <form action="ProductServlet" method="post">
                <input type="hidden" name="action" value="add"/>
                <input type="text" name="name"
                       placeholder="Product Name" required/>
                <input type="number" name="price" step="0.01"
                       placeholder="Price (Rs.)" required/>
                <input type="number" name="quantity"
                       placeholder="Quantity" required/>
                <input type="text" name="unit"
                       placeholder="Unit (eg: 1kg, 500ml)"/>
                <input type="date" name="expiryDate"/>
                <select name="categoryId">
                    <option value="">Select Category</option>
                    <% for (Category c : categories) { %>
                        <option value="<%= c.getCategoryId() %>">
                            <%= c.getName() %>
                        </option>
                    <% } %>
                </select>
                <button type="submit">Add Product</button>
            </form>
        </div>
    </div>
</body>
</html>