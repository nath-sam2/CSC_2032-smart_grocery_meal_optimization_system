<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<%@page import="model.Inventory"%>
<%@page import="model.Product"%>
<%@page import="service.InventoryService"%>
<%@page import="service.ProductService"%>
<%@page import="java.util.List"%>

<%
User user = (User) session.getAttribute("user");
if (user == null) {
    response.sendRedirect("login.jsp");
    return;
}

InventoryService inventoryService = new InventoryService();
ProductService productService = new ProductService();

List<Inventory> lowStock = inventoryService.getLowStockItems();
List<Product>   expiring = inventoryService.getExpiringItems(7);
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Low Stock | Smart Grocery</title>

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

/* SIDEBAR (same as dashboard/products/inventory) */
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
.help-card{ margin-top:auto; background:linear-gradient(135deg,#16a34a,#22c55e); border-radius:16px; padding:18px; text-decoration:none; display:block; color:white; }
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
.profile-chip{ display:flex; align-items:center; gap:10px; padding:6px 12px 6px 6px; background:#1b1b1b; border:1px solid #2b2b2b; border-radius:30px; cursor:pointer; text-decoration:none; }
.avatar{ width:34px; height:34px; background:var(--green); border-radius:50%; display:flex; justify-content:center; align-items:center; font-weight:bold; font-size:14px; overflow:hidden; }
.avatar img{ width:100%; height:100%; object-fit:cover; }
.profile-chip span{ font-size:14px; font-weight:600; color:white; }
.content{ padding:40px; }

/* PAGE HEADER */
.page-header{ margin-bottom:28px; }
.page-header h1{ font-size:28px; font-weight:800; }
.page-header p{ color:var(--soft); font-size:14px; margin-top:4px; }

/* STATS */
.stats{ display:grid; grid-template-columns:repeat(2,1fr); gap:20px; margin-bottom:36px; }
.stat-card{ background:var(--card); border:1px solid var(--border); border-radius:18px; padding:24px; display:flex; align-items:center; gap:16px; transition:.2s; text-decoration:none; }
.stat-card:hover{ border-color:var(--green); transform:translateY(-3px); }
.icon-circle{ min-width:54px; height:54px; border-radius:14px; display:flex; justify-content:center; align-items:center; font-size:20px; }
.red{ background:rgba(239,68,68,.15); color:#ef4444; }
.green{ background:rgba(34,197,94,.15); color:#22c55e; }
.stat-num{ font-size:26px; font-weight:800; color:white; }
.stat-title{ font-size:13.5px; color:var(--soft); margin-top:2px; }

/* SECTION */
.section-title{ font-size:19px; font-weight:700; margin:36px 0 18px; display:flex; align-items:center; justify-content:space-between; gap:10px; }
.section-title > span{ display:flex; align-items:center; gap:10px; }

/* PANEL / TABLE */
.panel{ background:var(--card); border:1px solid var(--border); border-radius:18px; overflow:hidden; margin-bottom:8px; }
table{ width:100%; border-collapse:collapse; }
th{ background:#141414; color:var(--soft); text-transform:uppercase; letter-spacing:.04em; font-size:11.5px; font-weight:700; padding:14px 20px; text-align:left; border-bottom:1px solid var(--border); }
td{ padding:14px 20px; border-bottom:1px solid #202020; font-size:13.5px; }
tr:last-child td{ border-bottom:none; }
tr:hover td{ background:#1e1e1e; }

.badge{ display:inline-flex; align-items:center; gap:5px; font-size:11.5px; font-weight:700; padding:5px 12px; border-radius:20px; }
.badge-low{ background:rgba(239,68,68,.15); color:#ef4444; }

.qty-cell{ font-weight:700; }
.qty-low{ color:#ef4444; }

.prod-name{ font-weight:600; }

.empty-row{ text-align:center; padding:40px; color:var(--soft); }

.footer{ margin-top:45px; padding:25px; text-align:center; color:#888; border-top:1px solid #222; font-size:13px; }

@media(max-width:1000px){ .stats{ grid-template-columns:1fr; } table{ display:block; overflow-x:auto; } }

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
<li><a href="mealplanner.jsp"><i class="fa-solid fa-utensils"></i> Meal Planner</a></li>
<li><a href="cart.jsp"><i class="fa-solid fa-list-check"></i> Shopping List</a></li>
<li><a href="recipes.jsp"><i class="fa-solid fa-book-open"></i> Recipes</a></li>
<li><a href="notifications.jsp"><i class="fa-solid fa-bell"></i> Expiry Alerts
<% if (!expiring.isEmpty()) { %><span class="menu-count"><%= expiring.size() %></span><% } %>
</a></li>
<li><a class="active" href="lowstock.jsp"><i class="fa-solid fa-triangle-exclamation"></i> Low Stock
<% if (!lowStock.isEmpty()) { %><span class="menu-count"><%= lowStock.size() %></span><% } %>
</a></li>
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
<input type="text" name="search" placeholder="Search products...">
<button type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
</form>

<div class="user">
<a href="cart.jsp" class="icon-btn"><i class="fa-solid fa-cart-shopping"></i></a>
<a href="notifications.jsp" class="icon-btn"><i class="fa-regular fa-bell"></i></a>
<a href="profile.jsp" class="profile-chip">
<div class="avatar"><% if (user.hasProfilePhoto()) { %><img src="<%= user.getProfilePhoto() %>" alt="Profile photo"><% } else { %><%= user.getName().substring(0,1).toUpperCase() %><% } %></div>
<span><%= user.getName() %></span>
<i class="fa-solid fa-chevron-down" style="font-size:11px;color:#888;"></i>
</a>
</div>
</div>

<div class="content">

<div class="page-header">
<h1>⚠️ Low Stock</h1>
<p>Every product currently at or below its reorder level, based on live inventory data.</p>
</div>

<!-- STATS -->
<div class="stats">
<div class="stat-card">
<div class="icon-circle red"><i class="fa-solid fa-triangle-exclamation"></i></div>
<div><div class="stat-num"><%= lowStock.size() %></div><div class="stat-title">Low Stock Items</div></div>
</div>
<a href="inventory.jsp" class="stat-card">
<div class="icon-circle green"><i class="fa-solid fa-warehouse"></i></div>
<div><div class="stat-num">View</div><div class="stat-title">Full Inventory</div></div>
</a>
</div>

<!-- LOW STOCK -->
<h2 class="section-title">
<span><i class="fa-solid fa-triangle-exclamation" style="color:#ef4444;"></i> Low Stock Items</span>
</h2>
<div class="panel">
<table>
<thead>
<tr>
<th>Product</th>
<th>Current Stock</th>
<th>Reorder Level</th>
<th>Status</th>
<th></th>
</tr>
</thead>
<tbody>
<%
if (lowStock.isEmpty()) {
%>
<tr><td colspan="5" class="empty-row">No low stock items right now. You're well stocked!</td></tr>
<%
} else {
    for (Inventory i : lowStock) {
        Product p = productService.getProductById(i.getProductId());
        String prodName = (p != null) ? p.getName() : ("Product #" + i.getProductId());
%>
<tr>
<td class="prod-name"><%= prodName %></td>
<td class="qty-cell qty-low"><%= i.getQuantity() %><% if (p != null) { %> <%= p.getUnit() %><% } %></td>
<td><%= i.getReorderLevel() %></td>
<td><span class="badge badge-low"><i class="fa-solid fa-triangle-exclamation"></i> Low Stock</span></td>
<td><a href="products.jsp?reorder=<%= i.getProductId() %>" class="badge badge-low"><i class="fa-solid fa-cart-plus"></i> Reorder</a></td>
</tr>
<%
    }
}
%>
</tbody>
</table>
</div>

</div>

<div class="footer">
© 2026 Smart Grocery Management System
</div>

</div>

</body>
</html>
