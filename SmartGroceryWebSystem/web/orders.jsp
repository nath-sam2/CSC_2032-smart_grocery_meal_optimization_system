<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<%@page import="model.Order"%>
<%@page import="service.OrderService"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
    <title>Orders - Smart Grocery</title>
    <style>
        body { font-family: Arial; background: #f0fdf4; margin: 0; }
        .navbar { background: #16a34a; padding: 15px 30px;
                  display: flex; justify-content: space-between; }
        .navbar h1 { color: white; margin: 0; }
        .navbar a  { color: white; text-decoration: none; margin-left: 16px; }
        .content   { padding: 30px; }
        h2 { color: #166534; }
        table { width: 100%; border-collapse: collapse;
                background: white; border-radius: 10px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.08); }
        th { background: #16a34a; color: white; padding: 12px; text-align: left; }
        td { padding: 12px; border-bottom: 1px solid #e5e7eb; }
        .badge-pending    { background: #fef9c3; color: #92400e;
                            padding: 3px 10px; border-radius: 20px; font-size: 12px; }
        .badge-processing { background: #dbeafe; color: #1e40af;
                            padding: 3px 10px; border-radius: 20px; font-size: 12px; }
        .badge-delivered  { background: #dcfce7; color: #166534;
                            padding: 3px 10px; border-radius: 20px; font-size: 12px; }
        .badge-cancelled  { background: #fee2e2; color: #991b1b;
                            padding: 3px 10px; border-radius: 20px; font-size: 12px; }
        .empty { text-align: center; padding: 40px; color: #6b7280; }
    </style>
</head>
<body>
    <%
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        OrderService os = new OrderService();
        List<Order> orders;
        if (user.getRole().equals("ADMIN")) {
            orders = os.getAllOrders();
        } else {
            orders = os.getOrdersByUser(user.getUserId());
        }
    %>
    <div class="navbar">
        <h1>🛒 Smart Grocery</h1>
        <div>
            <a href="products.jsp">Shop</a>
            <a href="dashboard.jsp">Dashboard</a>
            <a href="LogoutServlet">Logout</a>
        </div>
    </div>
    <div class="content">
        <h2>🧾 My Orders</h2>
        <% if (orders.isEmpty()) { %>
            <div class="empty">
                <h3>No orders yet!</h3>
                <a href="products.jsp">Start Shopping</a>
            </div>
        <% } else { %>
        <table>
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Total</th>
                    <th>Status</th>
                    <th>Date</th>
                </tr>
            </thead>
            <tbody>
                <% for (Order o : orders) { %>
                <tr>
                    <td><%= o.getOrderId() %></td>
                    <td>Rs. <%= o.getTotalAmount() %></td>
                    <td>
                        <span class="badge-<%= o.getStatus().toLowerCase() %>">
                            <%= o.getStatus() %>
                        </span>
                    </td>
                    <td><%= o.getOrderDate() %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <% } %>
    </div>
</body>
</html>