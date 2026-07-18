<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - Smart Grocery</title>
    <style>
        body { font-family: Arial; background: #f0fdf4; margin: 0; }
        .navbar { background: #16a34a; padding: 15px 30px;
                  display: flex; justify-content: space-between;
                  align-items: center; }
        .navbar h1 { color: white; margin: 0; font-size: 20px; }
        .navbar a  { color: white; text-decoration: none;
                     margin-left: 16px; font-size: 14px; }
        .content   { padding: 30px; }
        .welcome   { font-size: 22px; color: #166534; font-weight: bold; }
        .cards     { display: flex; gap: 20px; margin-top: 20px; }
        .card      { background: white; padding: 24px; border-radius: 10px;
                     box-shadow: 0 2px 8px rgba(0,0,0,0.08);
                     flex: 1; text-align: center; }
        .card h2   { color: #16a34a; font-size: 32px; margin: 0; }
        .card p    { color: #6b7280; margin: 8px 0 0; }
    </style>
</head>
<body>
    <%
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>
    <div class="navbar">
        <h1>🛒 Smart Grocery</h1>
        <div>
            <span style="color:white">Welcome, <%= user.getName() %>!</span>
            <a href="LogoutServlet">Logout</a>
        </div>
    </div>
    <div class="content">
        <div class="welcome">Dashboard</div>
        <div class="cards">
            <div class="card">
                <h2>🛒</h2>
                <p><a href="products.jsp">Shop Groceries</a></p>
            </div>
            <div class="card">
                <h2>📦</h2>
                <p><a href="orders.jsp">My Orders</a></p>
            </div>
            <div class="card">
                <h2>🛍️</h2>
                <p><a href="cart.jsp">My Cart</a></p>
            </div>
        </div>
    </div>
</body>
</html>