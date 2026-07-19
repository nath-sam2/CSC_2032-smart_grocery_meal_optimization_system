<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<%@page import="model.Inventory"%>
<%@page import="model.Product"%>
<%@page import="service.InventoryService"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
    <title>Inventory - Smart Grocery</title>
    <style>
        body { font-family: Arial; background: #f0fdf4; margin: 0; }
        .navbar { background: #16a34a; padding: 15px 30px;
                  display: flex; justify-content: space-between; }
        .navbar h1 { color: white; margin: 0; }
        .navbar a  { color: white; text-decoration: none; margin-left: 16px; }
        .content   { padding: 30px; }
        h2 { color: #166534; }
        .stats { display: flex; gap: 20px; margin-bottom: 24px; }
        .stat-card { background: white; padding: 20px; border-radius: 10px;
                     box-shadow: 0 2px 8px rgba(0,0,0,0.08); flex: 1;
                     text-align: center; }
        .stat-card h2 { color: #16a34a; font-size: 32px; margin: 0; }
        .stat-card p  { color: #6b7280; margin: 8px 0 0; }
        .stat-card.red h2 { color: #dc2626; }
        .stat-card.amber h2 { color: #d97706; }
        table { width: 100%; border-collapse: collapse;
                background: white; border-radius: 10px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.08);
                margin-bottom: 24px; }
        th { background: #16a34a; color: white; padding: 12px; text-align: left; }
        td { padding: 12px; border-bottom: 1px solid #e5e7eb; }
        .badge-ok  { background: #dcfce7; color: #166534;
                     padding: 3px 10px; border-radius: 20px; font-size: 12px; }
        .badge-low { background: #fee2e2; color: #991b1b;
                     padding: 3px 10px; border-radius: 20px; font-size: 12px; }
        .badge-expiry { background: #fef9c3; color: #92400e;
                        padding: 3px 10px; border-radius: 20px; font-size: 12px; }
        .section-title { color: #166534; margin-top: 30px; }
    </style>
</head>
<body>
    <%
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        InventoryService is = new InventoryService();
        List<Inventory> allInv   = is.getAllInventory();
        List<Inventory> lowStock = is.getLowStockItems();
        List<Product>   expiring = is.getExpiringItems(7);
    %>
    <div class="navbar">
        <h1>🛒 Smart Grocery</h1>
        <div>
            <a href="dashboard.jsp">Dashboard</a>
            <a href="products.jsp">Products</a>
            <a href="LogoutServlet">Logout</a>
        </div>
    </div>
    <div class="content">
        <h2>🏭 Inventory</h2>

        <!-- Stats -->
        <div class="stats">
            <div class="stat-card">
                <h2><%= allInv.size() %></h2>
                <p>Total Items</p>
            </div>
            <div class="stat-card red">
                <h2><%= lowStock.size() %></h2>
                <p>Low Stock Items</p>
            </div>
            <div class="stat-card amber">
                <h2><%= expiring.size() %></h2>
                <p>Expiring Soon (7 days)</p>
            </div>
        </div>

        <!-- All Inventory -->
        <h3 class="section-title">📦 All Inventory</h3>
        <table>
            <thead>
                <tr>
                    <th>Inventory ID</th>
                    <th>Product ID</th>
                    <th>Stock Qty</th>
                    <th>Reorder Level</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <% for (Inventory i : allInv) { %>
                <tr>
                    <td><%= i.getInventoryId() %></td>
                    <td><%= i.getProductId() %></td>
                    <td><%= i.getQuantity() %></td>
                    <td><%= i.getReorderLevel() %></td>
                    <td>
                        <% if (i.isLowStock()) { %>
                            <span class="badge-low">⚠️ Low Stock</span>
                        <% } else { %>
                            <span class="badge-ok">✅ OK</span>
                        <% } %>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>

        <!-- Low Stock -->
        <% if (!lowStock.isEmpty()) { %>
        <h3 class="section-title">⚠️ Low Stock Alerts</h3>
        <table>
            <thead>
                <tr>
                    <th>Product ID</th>
                    <th>Current Stock</th>
                    <th>Reorder Level</th>
                </tr>
            </thead>
            <tbody>
                <% for (Inventory i : lowStock) { %>
                <tr style="background:#fff5f5">
                    <td><%= i.getProductId() %></td>
                    <td style="color:#dc2626;font-weight:bold">
                        <%= i.getQuantity() %>
                    </td>
                    <td><%= i.getReorderLevel() %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <% } %>

        <!-- Expiring Soon -->
        <% if (!expiring.isEmpty()) { %>
        <h3 class="section-title">⏰ Expiring Soon (within 7 days)</h3>
        <table>
            <thead>
                <tr>
                    <th>Product ID</th>
                    <th>Name</th>
                    <th>Expiry Date</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <% for (Product p : expiring) { %>
                <tr style="background:#fffbeb">
                    <td><%= p.getProductId() %></td>
                    <td><%= p.getName() %></td>
                    <td style="color:#d97706;font-weight:bold">
                        <%= p.getExpiryDate() %>
                    </td>
                    <td><span class="badge-expiry">⏰ Near Expiry</span></td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <% } %>

    </div>
</body>
</html>