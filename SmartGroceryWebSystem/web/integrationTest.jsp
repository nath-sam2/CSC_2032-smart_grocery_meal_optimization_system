<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<%@page import="model.Product"%>
<%@page import="model.Inventory"%>
<%@page import="service.NotificationAlertService"%>
<%@page import="service.InventoryService"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
    <title>Integration Test</title>
    <style>
        body { font-family: Arial; background: #f0fdf4; padding: 30px; }
        h2 { color: #166534; }
        h3 { color: #1d4ed8; }
        table { width: 100%; border-collapse: collapse;
                background: white; border-radius: 10px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.08);
                margin-bottom: 24px; }
        th { background: #1d4ed8; color: white; padding: 12px; text-align: left; }
        td { padding: 12px; border-bottom: 1px solid #e5e7eb; }
        .ok  { color: #16a34a; font-weight: bold; }
        .err { color: #dc2626; font-weight: bold; }
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
        InventoryService is = new InventoryService();

        List<Product> available = ns.getAvailableProducts();
        List<Product> expiring  = ns.getExpiringProducts(7);
        List<Inventory> lowStock = is.getLowStockItems();
    %>

    <h2>🔗 Member 1 → Member 2 Integration Test</h2>

    <!-- Available Products -->
    <h3>✅ Available Products (Member 2 ලට provide කරනවා)</h3>
    <table>
        <thead>
            <tr><th>Product ID</th><th>Name</th><th>Price</th>
                <th>Quantity</th><th>Unit</th></tr>
        </thead>
        <tbody>
            <% if (available.isEmpty()) { %>
                <tr><td colspan="5" class="err">
                    No products available!
                </td></tr>
            <% } else {
                   for (Product p : available) { %>
                <tr>
                    <td><%= p.getProductId() %></td>
                    <td class="ok"><%= p.getName() %></td>
                    <td>Rs. <%= p.getPrice() %></td>
                    <td><%= p.getQuantity() %></td>
                    <td><%= p.getUnit() != null ? p.getUnit() : "-" %></td>
                </tr>
            <% } } %>
        </tbody>
    </table>

    <!-- Expiring Products -->
    <h3>⏰ Expiring Products within 7 days (Member 2 meal suggestions ලට)</h3>
    <table>
        <thead>
            <tr><th>Product ID</th><th>Name</th>
                <th>Expiry Date</th><th>Unit</th></tr>
        </thead>
        <tbody>
            <% if (expiring.isEmpty()) { %>
                <tr><td colspan="4">
                    No products expiring within 7 days
                </td></tr>
            <% } else {
                   for (Product p : expiring) { %>
                <tr>
                    <td><%= p.getProductId() %></td>
                    <td><%= p.getName() %></td>
                    <td style="color:#d97706;font-weight:bold">
                        <%= p.getExpiryDate() %>
                    </td>
                    <td><%= p.getUnit() != null ? p.getUnit() : "-" %></td>
                </tr>
            <% } } %>
        </tbody>
    </table>

    <!-- Low Stock -->
    <h3>⚠️ Low Stock Items (Member 2 shopping list ලට)</h3>
    <table>
        <thead>
            <tr><th>Product ID</th><th>Stock Qty</th>
                <th>Reorder Level</th><th>Status</th></tr>
        </thead>
        <tbody>
            <% if (lowStock.isEmpty()) { %>
                <tr><td colspan="4" class="ok">
                    ✅ All items in stock!
                </td></tr>
            <% } else {
                   for (Inventory i : lowStock) { %>
                <tr>
                    <td><%= i.getProductId() %></td>
                    <td style="color:#dc2626;font-weight:bold">
                        <%= i.getQuantity() %>
                    </td>
                    <td><%= i.getReorderLevel() %></td>
                    <td class="err">⚠️ Low Stock</td>
                </tr>
            <% } } %>
        </tbody>
    </table>

    <p><a href="dashboard.jsp">← Back to Dashboard</a></p>
</body>
</html>