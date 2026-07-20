<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<%@page import="model.Product"%>
<%@page import="model.Category"%>
<%@page import="model.Inventory"%>
<%@page import="model.Order"%>
<%@page import="model.CartItem"%>
<%@page import="model.NotificationService"%>
<%@page import="service.*"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
    <title>System Test - Smart Grocery</title>
    <style>
        body { font-family: Arial; background: #f0fdf4; padding: 30px; }
        h2 { color: #166534; }
        .section { background: white; padding: 20px; border-radius: 10px;
                   box-shadow: 0 2px 8px rgba(0,0,0,0.08);
                   margin-bottom: 20px; }
        .section h3 { color: #1d4ed8; margin-top: 0; }
        .ok  { color: #16a34a; font-weight: bold; }
        .err { color: #dc2626; font-weight: bold; }
        .result { padding: 8px 14px; border-radius: 6px;
                  margin: 4px 0; font-size: 14px; }
        .result.pass { background: #dcfce7; color: #166534; }
        .result.fail { background: #fee2e2; color: #991b1b; }
        .summary { background: #1d4ed8; color: white; padding: 20px;
                   border-radius: 10px; text-align: center;
                   margin-bottom: 20px; }
        .summary h2 { color: white; margin: 0; }
    </style>
</head>
<body>
    <%
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Services
        AuthService       authService  = new AuthService();
        CategoryService   catService   = new CategoryService();
        ProductService    prodService  = new ProductService();
        InventoryService  invService   = new InventoryService();
        CartService       cartService  = new CartService();
        OrderService      orderService = new OrderService();
        NotificationAlertService ns   = new NotificationAlertService();

        int pass = 0; int fail = 0;

        // Tests
        boolean t1 = authService.loginUser(
            user.getEmail(), user.getPassword()) != null;
        boolean t2 = !catService.getAllCategories().isEmpty();
        boolean t3 = !prodService.getAllProducts().isEmpty();
        boolean t4 = !invService.getAllInventory().isEmpty();
        boolean t5 = invService.getLowStockItems() != null;
        boolean t6 = invService.getExpiringItems(7) != null;
        boolean t7 = !orderService.getAllOrders().isEmpty();
        boolean t8 = ns.getAllNotifications() != null;
        boolean t9 = ns.getAvailableProducts() != null;
        boolean t10 = ns.getExpiringProducts(7) != null;

        if(t1)pass++; else fail++;
        if(t2)pass++; else fail++;
        if(t3)pass++; else fail++;
        if(t4)pass++; else fail++;
        if(t5)pass++; else fail++;
        if(t6)pass++; else fail++;
        if(t7)pass++; else fail++;
        if(t8)pass++; else fail++;
        if(t9)pass++; else fail++;
        if(t10)pass++; else fail++;
    %>

    <h2>🧪 Day 24 — Full System Test</h2>

    <!-- Summary -->
    <div class="summary">
        <h2>Results: <%= pass %> / 10 Passed</h2>
        <p style="margin:8px 0 0">
            ✅ Pass: <%= pass %> &nbsp;|&nbsp;
            ❌ Fail: <%= fail %>
        </p>
    </div>

    <!-- Auth -->
    <div class="section">
        <h3>🔐 Authentication System</h3>
        <div class="result <%= t1 ? "pass" : "fail" %>">
            <%= t1 ? "✅" : "❌" %> Login Test —
            User: <%= user.getName() %> | Role: <%= user.getRole() %>
        </div>
    </div>

    <!-- Category -->
    <div class="section">
        <h3>🗂️ Category System</h3>
        <%
            List<Category> cats = catService.getAllCategories();
        %>
        <div class="result <%= t2 ? "pass" : "fail" %>">
            <%= t2 ? "✅" : "❌" %> Categories loaded:
            <%= cats.size() %> found
        </div>
        <% for (Category c : cats) { %>
            <div class="result pass">
                &nbsp;&nbsp;→ <%= c.getCategoryId() %> |
                <%= c.getName() %>
            </div>
        <% } %>
    </div>

    <!-- Product -->
    <div class="section">
        <h3>📦 Product System</h3>
        <%
            List<Product> products = prodService.getAllProducts();
        %>
        <div class="result <%= t3 ? "pass" : "fail" %>">
            <%= t3 ? "✅" : "❌" %> Products loaded:
            <%= products.size() %> found
        </div>
        <% for (Product p : products) { %>
            <div class="result pass">
                &nbsp;&nbsp;→ <%= p.getProductId() %> |
                <%= p.getName() %> | Rs.<%= p.getPrice() %>
            </div>
        <% } %>
    </div>

    <!-- Inventory -->
    <div class="section">
        <h3>🏭 Inventory System</h3>
        <%
            List<Inventory> inv      = invService.getAllInventory();
            List<Inventory> lowStock = invService.getLowStockItems();
            List<Product>   expiring = invService.getExpiringItems(7);
        %>
        <div class="result <%= t4 ? "pass" : "fail" %>">
            <%= t4 ? "✅" : "❌" %> Inventory loaded:
            <%= inv.size() %> records
        </div>
        <div class="result <%= t5 ? "pass" : "fail" %>">
            <%= t5 ? "✅" : "❌" %> Low stock check:
            <%= lowStock.size() %> items low
        </div>
        <div class="result <%= t6 ? "pass" : "fail" %>">
            <%= t6 ? "✅" : "❌" %> Expiry check:
            <%= expiring.size() %> expiring within 7 days
        </div>
    </div>

    <!-- Order -->
    <div class="section">
        <h3>🧾 Order System</h3>
        <%
            List<Order> orders = orderService.getAllOrders();
        %>
        <div class="result <%= t7 ? "pass" : "fail" %>">
            <%= t7 ? "✅" : "❌" %> Orders loaded:
            <%= orders.size() %> orders found
        </div>
        <% for (Order o : orders) { %>
            <div class="result pass">
                &nbsp;&nbsp;→ Order #<%= o.getOrderId() %> |
                Rs.<%= o.getTotalAmount() %> |
                <%= o.getStatus() %>
            </div>
        <% } %>
    </div>

    <!-- Notification -->
    <div class="section">
        <h3>🔔 Notification System</h3>
        <%
            List<NotificationService> notifs = ns.getAllNotifications();
        %>
        <div class="result <%= t8 ? "pass" : "fail" %>">
            <%= t8 ? "✅" : "❌" %> Notifications:
            <%= notifs.size() %> found
        </div>
        <% for (NotificationService n : notifs) { %>
            <div class="result pass">
                &nbsp;&nbsp;→ [<%= n.getType() %>]
                <%= n.getMessage() %>
            </div>
        <% } %>
    </div>

    <!-- Integration -->
    <div class="section">
        <h3>🔗 Member 2 Integration API</h3>
        <%
            List<Product> available = ns.getAvailableProducts();
            List<Product> expiring2 = ns.getExpiringProducts(7);
        %>
        <div class="result <%= t9 ? "pass" : "fail" %>">
            <%= t9 ? "✅" : "❌" %> Available products API:
            <%= available.size() %> products
        </div>
        <div class="result <%= t10 ? "pass" : "fail" %>">
            <%= t10 ? "✅" : "❌" %> Expiring products API:
            <%= expiring2.size() %> products
        </div>
    </div>

    <p><a href="dashboard.jsp">← Back to Dashboard</a></p>
</body>
</html>