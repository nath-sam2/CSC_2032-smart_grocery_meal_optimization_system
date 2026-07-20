<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<%@page import="model.Order"%>
<%@page import="model.OrderItem"%>
<%@page import="model.Product"%>
<%@page import="model.Inventory"%>
<%@page import="model.CartItem"%>
<%@page import="model.NotificationService"%>
<%@page import="service.OrderService"%>
<%@page import="service.InventoryService"%>
<%@page import="service.CartService"%>
<%@page import="dao.ProductDAO"%>
<%@page import="dao.NotificationDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>

<%
User user = (User) session.getAttribute("user");
if (user == null) {
    response.sendRedirect("login.jsp");
    return;
}

OrderService orderService = new OrderService();
ProductDAO productDAO = new ProductDAO();
boolean isAdmin = "ADMIN".equals(user.getRole());

// Same sidebar/navbar counters as dashboard.jsp, kept in sync
InventoryService inventoryService = new InventoryService();
CartService cartService = new CartService();
NotificationDAO notificationDAO = new NotificationDAO();

int lowStockCount = inventoryService.getLowStockItems().size();
List<CartItem> cartItems = cartService.getCartItems(user.getUserId());
int cartCount = cartItems.size();
List<NotificationService> unreadNotifications = notificationDAO.getUnreadNotifications();
int notifCount = unreadNotifications.size();

List<Order> orders;
if (isAdmin) {
    orders = orderService.getAllOrders();
} else {
    orders = orderService.getOrdersByUser(user.getUserId());
}

int pendingCount = 0, processingCount = 0, deliveredCount = 0;
double lifetimeSpend = 0;
for (Order o : orders) {
    String st = o.getStatus() == null ? "" : o.getStatus().toUpperCase();
    if (st.equals("PENDING")) pendingCount++;
    else if (st.equals("PROCESSING")) processingCount++;
    else if (st.equals("DELIVERED")) deliveredCount++;
    lifetimeSpend += o.getTotalAmount();
}

SimpleDateFormat sdf = new SimpleDateFormat("MMM d, yyyy");
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>My Orders | Smart Grocery</title>

<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

<style>

*{ margin:0; padding:0; box-sizing:border-box; font-family:'Inter',sans-serif; }

:root{
--green:#22c55e;
--greenDark:#16a34a;
--black:#0b0b0b;
--card:#181818;
--border:#2b2b2b;
--text:#ffffff;
--soft:#9ca3af;
}

body{ background:#0b0b0b; color:white; }
a{ color:inherit; }
button{ font-family:'Inter',sans-serif; }

/* SIDEBAR (same as dashboard) */
.sidebar{
position:fixed; left:0; top:0; width:260px; height:100vh;
background:#111; border-right:1px solid #222; padding:25px;
display:flex; flex-direction:column; overflow-y:auto;
}
.logo{ display:flex; align-items:center; gap:12px; font-size:24px; font-weight:800; margin-bottom:5px; text-decoration:none; }
.logo i{ color:var(--green); background:rgba(34,197,94,.15); width:42px; height:42px; border-radius:12px; display:flex; align-items:center; justify-content:center; }
.logo-sub{ font-size:11px; color:var(--soft); margin-bottom:35px; margin-left:54px; margin-top:-2px; }
.menu{ list-style:none; }
.menu li{ margin-bottom:6px; }
.menu a{ display:flex; align-items:center; gap:15px; padding:12px 16px; text-decoration:none; color:#cbd5e1; border-radius:12px; transition:.25s; font-size:14.5px; font-weight:500; position:relative; cursor:pointer; border:none; background:none; width:100%; text-align:left; }
.menu a:hover{ background:#1c1c1c; color:white; }
.menu a.active{ background:var(--green); color:white; }
.menu-count{ margin-left:auto; background:#ef4444; color:white; font-size:11px; font-weight:700; padding:2px 8px; border-radius:20px; }
.menu a.active .menu-count{ background:rgba(255,255,255,.25); }
.side-label{ font-size:11px; letter-spacing:.08em; color:#666; text-transform:uppercase; margin:22px 0 10px 16px; font-weight:700; }
.help-card{ margin-top:auto; background:linear-gradient(135deg,#16a34a,#22c55e); border-radius:16px; padding:18px; cursor:pointer; border:none; text-align:left; width:100%; text-decoration:none; display:block; color:white; }
.help-card i{ font-size:22px; margin-bottom:8px; display:block; }
.help-card b{ display:block; font-size:14px; }
.help-card span{ font-size:12px; opacity:.85; }

/* MAIN */
.main{ margin-left:260px; }
.navbar{ height:80px; display:flex; justify-content:space-between; align-items:center; padding:0 40px; background:#111; border-bottom:1px solid #222; position:sticky; top:0; z-index:5; }
.search{ width:420px; position:relative; display:flex; }
.search input{ width:100%; padding:13px 20px; padding-left:45px; background:#1b1b1b; border:1px solid #333; border-radius:12px 0 0 12px; border-right:none; color:white; outline:none; }
.search i.fa-magnifying-glass{ position:absolute; left:16px; top:15px; color:#888; }
.search button{ width:46px; background:var(--green); border:none; border-radius:0 12px 12px 0; color:white; cursor:pointer; font-size:15px; }
.user{ display:flex; align-items:center; gap:22px; }
.icon-btn{ position:relative; width:44px; height:44px; border-radius:12px; background:#1b1b1b; border:1px solid #2b2b2b; display:flex; align-items:center; justify-content:center; font-size:17px; color:#cbd5e1; cursor:pointer; text-decoration:none; }
.icon-btn:hover{ border-color:var(--green); color:var(--green); }
.icon-btn .dot{ position:absolute; top:-6px; right:-6px; background:#ef4444; color:white; font-size:10px; font-weight:700; min-width:18px; height:18px; border-radius:20px; display:flex; align-items:center; justify-content:center; padding:0 4px; }
.profile-chip{ display:flex; align-items:center; gap:10px; padding:6px 12px 6px 6px; background:#1b1b1b; border:1px solid #2b2b2b; border-radius:30px; cursor:pointer; text-decoration:none; }
.avatar{ width:34px; height:34px; background:var(--green); border-radius:50%; display:flex; justify-content:center; align-items:center; font-weight:bold; font-size:14px; }
.profile-chip span{ font-size:14px; font-weight:600; color:white; }
.content{ padding:40px; }

/* PAGE HEADER */
.page-header{ display:flex; justify-content:space-between; align-items:center; margin-bottom:28px; flex-wrap:wrap; gap:16px; }
.page-header h1{ font-size:28px; font-weight:800; }
.page-header p{ color:var(--soft); font-size:14px; margin-top:4px; }

/* STATS */
.stats{ display:grid; grid-template-columns:repeat(4,1fr); gap:20px; margin-bottom:32px; }
.stat-card{ background:var(--card); border:1px solid var(--border); border-radius:18px; padding:22px; display:flex; align-items:center; gap:16px; }
.icon-circle{ min-width:50px; height:50px; border-radius:14px; display:flex; justify-content:center; align-items:center; font-size:19px; }
.green-bg{ background:rgba(34,197,94,.15); color:var(--green); }
.yellow-bg{ background:rgba(245,158,11,.15); color:#f59e0b; }
.blue-bg{ background:rgba(59,130,246,.15); color:#3b82f6; }
.purple-bg{ background:rgba(168,85,247,.15); color:#a855f7; }
.stat-number{ font-size:22px; font-weight:800; color:white; }
.stat-title{ font-size:12.5px; color:var(--soft); margin-top:2px; }

/* ORDERS PANEL */
.orders-panel{ background:var(--card); border:1px solid var(--border); border-radius:18px; padding:8px; }
.orders-panel-head{ display:flex; justify-content:space-between; align-items:center; padding:18px 20px; border-bottom:1px solid var(--border); }
.orders-panel-head h2{ font-size:16px; font-weight:700; }
.orders-panel-head span{ font-size:12.5px; color:var(--soft); }

/* ORDER CARD */
.order-card{ border-bottom:1px solid var(--border); }
.order-card:last-child{ border-bottom:none; }
.order-head{ display:flex; align-items:center; gap:18px; padding:20px; flex-wrap:wrap; }
.order-icon{ width:48px; height:48px; min-width:48px; border-radius:12px; background:linear-gradient(135deg,#1c2e1c,#16351f); display:flex; align-items:center; justify-content:center; font-size:19px; color:var(--green); }
.order-info{ flex:1; min-width:180px; }
.order-id{ font-size:15px; font-weight:700; margin-bottom:4px; }
.order-meta{ font-size:12.5px; color:var(--soft); }
.order-meta b{ color:#cbd5e1; }

.badge{ font-size:11px; font-weight:700; padding:5px 13px; border-radius:20px; text-transform:capitalize; white-space:nowrap; }
.badge-pending{ background:rgba(245,158,11,.15); color:#f59e0b; }
.badge-processing{ background:rgba(59,130,246,.15); color:#3b82f6; }
.badge-delivered{ background:rgba(34,197,94,.15); color:var(--green); }
.badge-cancelled{ background:rgba(239,68,68,.15); color:#ef4444; }

.order-total{ width:110px; text-align:right; font-size:16px; font-weight:800; color:white; }

.toggle-btn{ width:38px; height:38px; border-radius:10px; background:#111; border:1px solid var(--border); color:#cbd5e1; display:flex; align-items:center; justify-content:center; cursor:pointer; font-size:13px; }
.toggle-btn:hover{ border-color:var(--green); color:var(--green); }

.status-select{ background:#111; border:1px solid var(--border); border-radius:10px; padding:8px 12px; color:white; font-size:12.5px; font-weight:600; }

/* ORDER ITEMS (details) */
.order-details{ display:none; padding:0 20px 20px 86px; }
.order-details.open{ display:block; }
.order-item-row{ display:flex; justify-content:space-between; align-items:center; padding:10px 16px; background:#111; border:1px solid var(--border); border-radius:10px; margin-bottom:8px; font-size:13px; }
.order-item-row:last-child{ margin-bottom:0; }
.order-item-row .name{ color:white; font-weight:600; }
.order-item-row .qty{ color:var(--soft); }
.order-item-row .amt{ color:var(--green); font-weight:700; }
.no-items{ color:var(--soft); font-size:13px; padding:8px 16px; }

/* EMPTY STATE */
.empty-state{ text-align:center; padding:90px 20px; color:var(--soft); background:var(--card); border:1px solid var(--border); border-radius:18px; }
.empty-state i{ font-size:46px; margin-bottom:18px; color:#444; display:block; }
.empty-state h3{ color:white; font-size:19px; margin-bottom:8px; }
.empty-state p{ margin-bottom:24px; font-size:13.5px; }
.empty-state a{ display:inline-flex; align-items:center; gap:10px; background:var(--green); color:white; padding:14px 30px; border-radius:12px; text-decoration:none; font-weight:700; font-size:14px; }
.empty-state a:hover{ background:var(--greenDark); }

.footer{ margin-top:45px; padding:25px; text-align:center; color:#888; border-top:1px solid #222; font-size:13px; }

@media(max-width:900px){ .stats{ grid-template-columns:1fr 1fr; } .order-details{ padding-left:20px; } }

</style>

</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
<a href="dashboard.jsp" class="logo">
<i class="fa-solid fa-cart-shopping"></i>
<span>Smart Grocery</span>
</a>
<div class="logo-sub">Manage Smart, Eat Smart</div>

<ul class="menu">

<li>
<a href="dashboard.jsp">
<i class="fa-solid fa-house"></i>
Dashboard
</a>
</li>

<li>
<a href="products.jsp">
<i class="fa-solid fa-cart-shopping"></i>
Shop Groceries
</a>
</li>

<li>
<a href="inventory.jsp">
<i class="fa-solid fa-warehouse"></i>
My Inventory
</a>
</li>

<li>
<a href="mealplanner.jsp">
<i class="fa-solid fa-utensils"></i>
Meal Planner
</a>
</li>

<li>
<a href="cart.jsp">
<i class="fa-solid fa-list-check"></i>
Shopping List
<% if (cartCount > 0) { %><span class="menu-count"><%= cartCount %></span><% } %>
</a>
</li>

<li>
<a class="active" href="orders.jsp">
<i class="fa-solid fa-receipt"></i>
My Orders
</a>
</li>

<li>
<a href="recipes.jsp">
<i class="fa-solid fa-book-open"></i>
Recipes
</a>
</li>

<li>
<a href="notifications.jsp">
<i class="fa-solid fa-bell"></i>
Expiry Alerts
<% if (notifCount > 0) { %><span class="menu-count"><%= notifCount %></span><% } %>
</a>
</li>

<li>
<a href="inventory.jsp?filter=low">
<i class="fa-solid fa-triangle-exclamation"></i>
Low Stock
<% if (lowStockCount > 0) { %><span class="menu-count"><%= lowStockCount %></span><% } %>
</a>
</li>

</ul>

<div class="side-label">Account</div>

<ul class="menu">

<li>
<a href="profile.jsp">
<i class="fa-solid fa-user"></i>
Profile
</a>
</li>

<li>
<a href="settings.jsp">
<i class="fa-solid fa-gear"></i>
Settings
</a>
</li>

<li>
<a href="LogoutServlet">
<i class="fa-solid fa-right-from-bracket"></i>
Logout
</a>
</li>

</ul>

<a href="tel:+94112345678" class="help-card">
<i class="fa-solid fa-phone"></i>
<b>Need Help?</b>
<span>Emergency Call</span>
</a>
</div>

<!-- Main -->
<div class="main">

<div class="navbar">
<form class="search" action="products.jsp" method="get">
<i class="fa-solid fa-magnifying-glass"></i>
<input type="text" name="search" placeholder="Search products, recipes...">
<button type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
</form>

<div class="user">
<a href="cart.jsp" class="icon-btn">
<i class="fa-solid fa-cart-shopping"></i>
<% if (cartCount > 0) { %><span class="dot"><%= cartCount %></span><% } %>
</a>
<a href="notifications.jsp" class="icon-btn">
<i class="fa-regular fa-bell"></i>
<% if (notifCount > 0) { %><span class="dot"><%= notifCount %></span><% } %>
</a>
<a href="profile.jsp" class="profile-chip">
<div class="avatar"><%= user.getName().substring(0,1).toUpperCase() %></div>
<span><%= user.getName() %></span>
<i class="fa-solid fa-chevron-down" style="font-size:11px;color:#888;"></i>
</a>
</div>
</div>

<div class="content">

<div class="page-header">
<div>
<h1><%= isAdmin ? "All Orders" : "My Orders" %></h1>
<p><%= orders.size() %> order<%= orders.size() == 1 ? "" : "s" %><%= isAdmin ? " across all customers" : " placed so far" %></p>
</div>
</div>

<!-- STATS -->
<div class="stats">
<div class="stat-card">
<div class="icon-circle green-bg"><i class="fa-solid fa-receipt"></i></div>
<div><div class="stat-number"><%= orders.size() %></div><div class="stat-title">Total Orders</div></div>
</div>
<div class="stat-card">
<div class="icon-circle yellow-bg"><i class="fa-solid fa-clock"></i></div>
<div><div class="stat-number"><%= pendingCount %></div><div class="stat-title">Pending</div></div>
</div>
<div class="stat-card">
<div class="icon-circle blue-bg"><i class="fa-solid fa-truck"></i></div>
<div><div class="stat-number"><%= processingCount %></div><div class="stat-title">Processing</div></div>
</div>
<div class="stat-card">
<div class="icon-circle purple-bg"><i class="fa-solid fa-money-bill-wave"></i></div>
<div><div class="stat-number">Rs. <%= String.format("%.2f", lifetimeSpend) %></div><div class="stat-title"><%= isAdmin ? "Total Revenue" : "Total Spent" %></div></div>
</div>
</div>

<!-- ORDERS LIST -->
<% if (orders.isEmpty()) { %>

<div class="empty-state">
<i class="fa-solid fa-receipt"></i>
<h3>No orders yet</h3>
<p>Once you place an order it'll show up here with full tracking.</p>
<a href="products.jsp"><i class="fa-solid fa-cart-shopping"></i> Start Shopping</a>
</div>

<% } else { %>

<div class="orders-panel">
<div class="orders-panel-head">
<h2>Order History</h2>
<span><%= orders.size() %> total</span>
</div>

<%
for (Order o : orders) {
    String st = o.getStatus() == null ? "PENDING" : o.getStatus().toUpperCase();
    String badgeClass;
    switch (st) {
        case "PROCESSING": badgeClass = "badge-processing"; break;
        case "DELIVERED":  badgeClass = "badge-delivered";  break;
        case "CANCELLED":  badgeClass = "badge-cancelled";  break;
        default:           badgeClass = "badge-pending";
    }
    List<OrderItem> lineItems = orderService.getOrderItems(o.getOrderId());
%>
<div class="order-card">

<div class="order-head">
<div class="order-icon"><i class="fa-solid fa-box"></i></div>

<div class="order-info">
<div class="order-id">Order #<%= o.getOrderId() %><% if (isAdmin) { %> <span style="color:var(--soft);font-weight:500;">— User #<%= o.getUserId() %></span><% } %></div>
<div class="order-meta"><b><%= o.getOrderDate() != null ? sdf.format(o.getOrderDate()) : "" %></b> &nbsp;•&nbsp; <%= lineItems.size() %> item<%= lineItems.size() == 1 ? "" : "s" %></div>
</div>

<% if (isAdmin) { %>
<form action="OrderServlet" method="get" style="display:flex; align-items:center; gap:10px;">
<input type="hidden" name="action" value="updateStatus">
<input type="hidden" name="orderId" value="<%= o.getOrderId() %>">
<select name="status" class="status-select" onchange="this.form.submit()">
<option value="PENDING" <%= st.equals("PENDING") ? "selected" : "" %>>Pending</option>
<option value="PROCESSING" <%= st.equals("PROCESSING") ? "selected" : "" %>>Processing</option>
<option value="DELIVERED" <%= st.equals("DELIVERED") ? "selected" : "" %>>Delivered</option>
<option value="CANCELLED" <%= st.equals("CANCELLED") ? "selected" : "" %>>Cancelled</option>
</select>
</form>
<% } else { %>
<span class="badge <%= badgeClass %>"><%= st.toLowerCase() %></span>
<% } %>

<div class="order-total">Rs. <%= String.format("%.2f", o.getTotalAmount()) %></div>

<div class="toggle-btn" onclick="toggleDetails(<%= o.getOrderId() %>)">
<i class="fa-solid fa-chevron-down" id="icon-<%= o.getOrderId() %>"></i>
</div>
</div>

<div class="order-details" id="details-<%= o.getOrderId() %>">
<%
if (lineItems.isEmpty()) {
%>
<div class="no-items">No item details recorded for this order.</div>
<%
} else {
    for (OrderItem oi : lineItems) {
        Product p = productDAO.getProductById(oi.getProductId());
        String pName = (p != null) ? p.getName() : "Product #" + oi.getProductId();
%>
<div class="order-item-row">
<span class="name"><%= pName %></span>
<span class="qty">Qty <%= oi.getQuantity() %> &times; Rs. <%= String.format("%.2f", oi.getPrice()) %></span>
<span class="amt">Rs. <%= String.format("%.2f", oi.getSubtotal()) %></span>
</div>
<%
    }
}
%>
</div>

</div>
<% } %>

</div>

<% } %>

<div class="footer">
© 2026 Smart Grocery Management System
</div>

</div>

</div>

<script>
function toggleDetails(orderId) {
    var details = document.getElementById('details-' + orderId);
    var icon = document.getElementById('icon-' + orderId);
    details.classList.toggle('open');
    icon.style.transform = details.classList.contains('open') ? 'rotate(180deg)' : 'rotate(0deg)';
}
</script>

</body>
</html>
