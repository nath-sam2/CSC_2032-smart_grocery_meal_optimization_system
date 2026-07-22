<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<%@page import="model.NotificationService"%>
<%@page import="model.Inventory"%>
<%@page import="model.Product"%>
<%@page import="service.InventoryService"%>
<%@page import="dao.ProductDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>

<%
User user = (User) session.getAttribute("user");
if (user == null) {
    response.sendRedirect("login.jsp");
    return;
}

// Alerts are built live from the current inventory data (same source as
// dashboard.jsp / lowstock.jsp / inventory.jsp) so the counts and messages
// on this page always match what's actually in My Inventory - no separate
// alert log to fall out of sync.
InventoryService inventoryService = new InventoryService();
ProductDAO productDAO = new ProductDAO();

List<Inventory> lowStockInv = user.isNotifyLowStock() ? inventoryService.getLowStockItems() : new ArrayList<Inventory>();
List<Product> expiringProducts = user.isNotifyExpiry() ? inventoryService.getExpiringItems(7) : new ArrayList<Product>();

int sidebarLowStockCount = lowStockInv.size();
int sidebarExpiryCount = expiringProducts.size();

SimpleDateFormat expFmt = new SimpleDateFormat("MMM d, yyyy");

List<NotificationService> allNotifs = new ArrayList<NotificationService>();
int lowStockCount = 0;
int expiryCount = 0;

for (Inventory inv : lowStockInv) {
    Product p = productDAO.getProductById(inv.getProductId());
    String pName = (p != null) ? p.getName() : ("Product #" + inv.getProductId());
    String msg = pName + " is running low - only " + inv.getQuantity()
            + " left (reorder at " + inv.getReorderLevel() + ").";
    allNotifs.add(new NotificationService(inv.getProductId(), msg, "LOW_STOCK", null));
    lowStockCount++;
}

for (Product p : expiringProducts) {
    String whenStr = p.getExpiryDate() != null ? expFmt.format(p.getExpiryDate()) : "soon";
    String msg = p.getName() + " is expiring soon - expires " + whenStr + ".";
    allNotifs.add(new NotificationService(p.getProductId(), msg, "EXPIRY", null));
    expiryCount++;
}

int unreadCount = allNotifs.size();

String filter = request.getParameter("filter");
if (filter == null) filter = "all";

List<NotificationService> notifs = new ArrayList<NotificationService>();
for (NotificationService n : allNotifs) {
    if ("all".equals(filter)
        || ("low".equals(filter) && "LOW_STOCK".equals(n.getType()))
        || ("expiry".equals(filter) && "EXPIRY".equals(n.getType()))) {
        notifs.add(n);
    }
}

SimpleDateFormat sdf = new SimpleDateFormat("MMM d, h:mm a");
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Expiry Alerts | Smart Grocery</title>

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
.menu a{ display:flex; align-items:center; gap:15px; padding:12px 16px; text-decoration:none; color:#cbd5e1; border-radius:12px; transition:.25s; font-size:14.5px; font-weight:500; position:relative; }
.menu a:hover{ background:#1c1c1c; color:white; }
.menu a.active{ background:var(--green); color:white; }
.menu-count{ margin-left:auto; background:#ef4444; color:white; font-size:11px; font-weight:700; padding:2px 8px; border-radius:20px; }
.menu a.active .menu-count{ background:rgba(255,255,255,.25); }
.side-label{ font-size:11px; letter-spacing:.08em; color:#666; text-transform:uppercase; margin:22px 0 10px 16px; font-weight:700; }
.help-card{ margin-top:24px; background:linear-gradient(135deg,#16a34a,#22c55e); border-radius:16px; padding:18px; text-decoration:none; display:block; color:white; position:static; }
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
.avatar{ width:34px; height:34px; background:var(--green); border-radius:50%; display:flex; justify-content:center; align-items:center; font-weight:bold; font-size:14px; overflow:hidden; }
.avatar img{ width:100%; height:100%; object-fit:cover; }
.profile-chip span{ font-size:14px; font-weight:600; color:white; }
.content{ padding:40px; }

/* PAGE HEADER */
.page-header{ display:flex; justify-content:space-between; align-items:center; margin-bottom:28px; flex-wrap:wrap; gap:16px; }
.page-header h1{ font-size:28px; font-weight:800; }
.page-header p{ color:var(--soft); font-size:14px; margin-top:4px; }
.mark-all-btn{ background:transparent; border:1px solid var(--border); color:var(--soft); padding:11px 18px; border-radius:12px; font-weight:700; font-size:13px; cursor:pointer; display:flex; align-items:center; gap:8px; text-decoration:none; }
.mark-all-btn:hover{ border-color:var(--green); color:var(--green); }

/* STATS */
.stats{ display:grid; grid-template-columns:repeat(3,1fr); gap:22px; margin-bottom:32px; }
.stat-card{ background:var(--card); border:1px solid var(--border); border-radius:18px; padding:22px; display:flex; align-items:center; gap:16px; text-decoration:none; transition:.3s; cursor:pointer; }
.stat-card:hover{ border-color:var(--green); transform:translateY(-4px); }
.stat-card.active{ border-color:var(--green); box-shadow:0 0 0 1px var(--green) inset; }
.icon-circle{ min-width:54px; height:54px; border-radius:14px; display:flex; justify-content:center; align-items:center; font-size:20px; }
.red{ background:rgba(239,68,68,.15); color:#ef4444; }
.orange{ background:rgba(245,158,11,.15); color:#f59e0b; }
.blue{ background:rgba(59,130,246,.15); color:#3b82f6; }
.stat-number{ font-size:24px; font-weight:800; color:white; }
.stat-title{ font-size:13.5px; color:var(--soft); margin-top:2px; }

/* NOTIF PANEL */
.notif-panel{ background:var(--card); border:1px solid var(--border); border-radius:18px; padding:8px; }
.notif-panel-head{ display:flex; justify-content:space-between; align-items:center; padding:18px 20px; border-bottom:1px solid var(--border); }
.notif-panel-head h2{ font-size:16px; font-weight:700; }

.filter-tabs{ display:flex; gap:8px; padding:16px 20px 0 20px; }
.filter-tab{ padding:8px 16px; border-radius:100px; background:#111; border:1px solid var(--border); color:var(--soft); font-size:12.5px; font-weight:700; text-decoration:none; }
.filter-tab:hover{ border-color:var(--green); color:white; }
.filter-tab.active{ background:var(--green); color:white; border-color:var(--green); }

.notif-item{ display:flex; align-items:center; gap:16px; padding:20px; border-bottom:1px solid var(--border); }
.notif-item:last-child{ border-bottom:none; }

.notif-icon{ min-width:48px; width:48px; height:48px; border-radius:12px; display:flex; align-items:center; justify-content:center; font-size:20px; }
.notif-icon.LOW_STOCK{ background:rgba(239,68,68,.15); }
.notif-icon.EXPIRY{ background:rgba(245,158,11,.15); }

.notif-body{ flex:1; min-width:0; }
.notif-msg{ font-size:14px; color:white; margin-bottom:6px; line-height:1.4; }
.notif-meta{ display:flex; align-items:center; gap:10px; }
.notif-time{ font-size:12px; color:var(--soft); }

.badge{ font-size:10.5px; font-weight:700; padding:3px 10px; border-radius:20px; }
.badge-low{ background:rgba(239,68,68,.15); color:#ef4444; }
.badge-expiry{ background:rgba(245,158,11,.15); color:#f59e0b; }

.mark-read-btn{ background:transparent; border:1px solid var(--border); color:var(--soft); padding:9px 14px; border-radius:10px; font-weight:700; font-size:12px; cursor:pointer; text-decoration:none; white-space:nowrap; display:flex; align-items:center; gap:6px; }
.mark-read-btn:hover{ border-color:var(--green); color:var(--green); }

/* EMPTY */
.empty-state{ text-align:center; padding:90px 20px; color:var(--soft); }
.empty-state i{ font-size:46px; margin-bottom:18px; color:#444; display:block; }
.empty-state h3{ color:white; font-size:19px; margin-bottom:8px; }
.empty-state p{ font-size:13.5px; }

.footer{ margin-top:45px; padding:25px; text-align:center; color:#888; border-top:1px solid #222; font-size:13px; }

@media(max-width:800px){ .stats{ grid-template-columns:1fr; } }

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
<li><a href="dashboard.jsp"><i class="fa-solid fa-house"></i> Dashboard</a></li>
<li><a href="products.jsp"><i class="fa-solid fa-cart-shopping"></i> Shop Groceries</a></li>
<li><a href="inventory.jsp"><i class="fa-solid fa-warehouse"></i> My Inventory</a></li>
<li><a href="MealDashboardController"><i class="fa-solid fa-utensils"></i> Meal Planner</a></li>
<li><a href="cart.jsp"><i class="fa-solid fa-list-check"></i> Shopping List</a></li>
<li><a href="orders.jsp"><i class="fa-solid fa-receipt"></i> My Orders</a></li>
<li><a href="RecipeController"><i class="fa-solid fa-book-open"></i> Recipes</a></li>
<li>
<a class="active" href="notifications.jsp">
<i class="fa-solid fa-bell"></i>
Expiry Alerts
<% if (sidebarExpiryCount > 0) { %><span class="menu-count"><%= sidebarExpiryCount %></span><% } %>
</a>
</li>
<li><a href="lowstock.jsp"><i class="fa-solid fa-triangle-exclamation"></i> Low Stock
<% if (sidebarLowStockCount > 0) { %><span class="menu-count"><%= sidebarLowStockCount %></span><% } %>
</a></li>
</ul>

<div class="side-label">Meal Optimization</div>

<ul class="menu">

<li>
<a href="RecommendationController">
<i class="fa-solid fa-wand-magic-sparkles"></i>
Recommendations
</a>
</li>

<li>
<a href="ShoppingListController">
<i class="fa-solid fa-basket-shopping"></i>
Meal Shopping List
</a>
</li>

<li>
<a href="UserDietaryRestrictionController">
<i class="fa-solid fa-leaf"></i>
Dietary Restrictions
</a>
</li>

<li>
<a href="FoodWasteController">
<i class="fa-solid fa-recycle"></i>
Food Waste
</a>
</li>

</ul>

<div class="side-label">Account</div>
<ul class="menu">
<li><a href="profile.jsp"><i class="fa-solid fa-user"></i> Profile</a></li>
<li><a href="settings.jsp"><i class="fa-solid fa-gear"></i> Settings</a></li>
<li><a href="LogoutServlet"><i class="fa-solid fa-right-from-bracket"></i> Logout</a></li>
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
</a>
<a href="notifications.jsp" class="icon-btn">
<i class="fa-regular fa-bell"></i>
<% if (unreadCount > 0) { %><span class="dot"><%= unreadCount %></span><% } %>
</a>
<a href="profile.jsp" class="profile-chip">
<div class="avatar"><% if (user.hasProfilePhoto()) { %><img src="<%= user.getProfilePhoto() %>" alt="Profile photo"><% } else { %><%= user.getName().substring(0,1).toUpperCase() %><% } %></div>
<span><%= user.getName() %></span>
<i class="fa-solid fa-chevron-down" style="font-size:11px;color:#888;"></i>
</a>
</div>
</div>

<div class="content">

<div class="page-header">
<div>
<h1>Expiry &amp; Stock Alerts</h1>
<p><%= unreadCount %> active alert<%= unreadCount == 1 ? "" : "s" %> right now</p>
</div>
</div>

<!-- STATS -->
<div class="stats">

<a href="notifications.jsp?filter=all" class="stat-card <%= "all".equals(filter) ? "active" : "" %>">
<div class="icon-circle blue"><i class="fa-solid fa-bell"></i></div>
<div>
<div class="stat-number"><%= allNotifs.size() %></div>
<div class="stat-title">All Notifications</div>
</div>
</a>

<a href="notifications.jsp?filter=low" class="stat-card <%= "low".equals(filter) ? "active" : "" %>">
<div class="icon-circle red"><i class="fa-solid fa-triangle-exclamation"></i></div>
<div>
<div class="stat-number"><%= lowStockCount %></div>
<div class="stat-title">Low Stock Alerts</div>
</div>
</a>

<a href="notifications.jsp?filter=expiry" class="stat-card <%= "expiry".equals(filter) ? "active" : "" %>">
<div class="icon-circle orange"><i class="fa-solid fa-clock"></i></div>
<div>
<div class="stat-number"><%= expiryCount %></div>
<div class="stat-title">Expiry Alerts</div>
</div>
</a>

</div>

<!-- NOTIFICATIONS LIST -->
<div class="notif-panel">

<div class="notif-panel-head">
<h2>Notifications</h2>
</div>

<div class="filter-tabs">
<a href="notifications.jsp?filter=all" class="filter-tab <%= "all".equals(filter) ? "active" : "" %>">All</a>
<a href="notifications.jsp?filter=low" class="filter-tab <%= "low".equals(filter) ? "active" : "" %>">Low Stock</a>
<a href="notifications.jsp?filter=expiry" class="filter-tab <%= "expiry".equals(filter) ? "active" : "" %>">Near Expiry</a>
</div>

<% if (notifs.isEmpty()) { %>

<div class="empty-state">
<i class="fa-solid fa-circle-check"></i>
<h3>You're all caught up!</h3>
<p>No notifications to show right now.</p>
</div>

<% } else {
    for (NotificationService n : notifs) {
        boolean isLow = "LOW_STOCK".equals(n.getType());
%>
<div class="notif-item">

<div class="notif-icon <%= n.getType() %>">
<i class="fa-solid <%= isLow ? "fa-triangle-exclamation" : "fa-clock" %>" style="color:<%= isLow ? "#ef4444" : "#f59e0b" %>;"></i>
</div>

<div class="notif-body">
<div class="notif-msg"><%= n.getMessage() %></div>
<div class="notif-meta">
<span class="badge <%= isLow ? "badge-low" : "badge-expiry" %>"><%= isLow ? "Low Stock" : "Near Expiry" %></span>
<span class="notif-time"><%= n.getTimestamp() != null ? sdf.format(n.getTimestamp()) : "" %></span>
</div>
</div>

</div>
<% } } %>

</div>

<div class="footer">
© 2026 Smart Grocery Management System
</div>

</div>

</div>

</body>
</html>
