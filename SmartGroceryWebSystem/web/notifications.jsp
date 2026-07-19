<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<%@page import="model.NotificationService"%>
<%@page import="service.NotificationAlertService"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
    <title>Notifications - Smart Grocery</title>
    <style>
        body { font-family: Arial; background: #f0fdf4; margin: 0; }
        .navbar { background: #16a34a; padding: 15px 30px;
                  display: flex; justify-content: space-between; }
        .navbar h1 { color: white; margin: 0; }
        .navbar a  { color: white; text-decoration: none; margin-left: 16px; }
        .content   { padding: 30px; }
        h2 { color: #166534; }
        .notif { background: white; padding: 16px 20px;
                 border-radius: 10px; margin-bottom: 12px;
                 box-shadow: 0 2px 8px rgba(0,0,0,0.06);
                 display: flex; align-items: center; gap: 16px; }
        .notif.LOW_STOCK { border-left: 4px solid #dc2626; }
        .notif.EXPIRY    { border-left: 4px solid #d97706; }
        .notif-icon { font-size: 24px; }
        .notif-msg  { flex: 1; font-size: 14px; color: #374151; }
        .notif-time { font-size: 12px; color: #9ca3af; }
        .badge-low    { background: #fee2e2; color: #991b1b;
                        padding: 2px 8px; border-radius: 20px; font-size: 11px; }
        .badge-expiry { background: #fef9c3; color: #92400e;
                        padding: 2px 8px; border-radius: 20px; font-size: 11px; }
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
        NotificationAlertService ns = new NotificationAlertService();
        List<NotificationService> notifs = ns.getAllNotifications();
    %>
    <div class="navbar">
        <h1>🛒 Smart Grocery</h1>
        <div>
            <a href="dashboard.jsp">Dashboard</a>
            <a href="inventory.jsp">Inventory</a>
            <a href="LogoutServlet">Logout</a>
        </div>
    </div>
    <div class="content">
        <h2>🔔 Notifications (<%= notifs.size() %>)</h2>
        <% if (notifs.isEmpty()) { %>
            <div class="empty">
                <h3>No notifications!</h3>
            </div>
        <% } else {
               for (NotificationService n : notifs) { %>
            <div class="notif <%= n.getType() %>">
                <div class="notif-icon">
                    <%= n.getType().equals("LOW_STOCK") ? "⚠️" : "⏰" %>
                </div>
                <div class="notif-msg">
                    <%= n.getMessage() %>
                    <br>
                    <% if (n.getType().equals("LOW_STOCK")) { %>
                        <span class="badge-low">Low Stock</span>
                    <% } else { %>
                        <span class="badge-expiry">Near Expiry</span>
                    <% } %>
                </div>
                <div class="notif-time"><%= n.getTimestamp() %></div>
            </div>
        <% } } %>
    </div>
</body>
</html>