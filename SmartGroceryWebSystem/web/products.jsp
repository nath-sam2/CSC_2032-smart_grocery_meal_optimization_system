<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<%@page import="model.Product"%>
<%@page import="model.Category"%>
<%@page import="service.ProductService"%>
<%@page import="service.CategoryService"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>

<%
User user = (User) session.getAttribute("user");
if (user == null) {
    response.sendRedirect("login.jsp");
    return;
}

ProductService productService = new ProductService();
CategoryService categoryService = new CategoryService();

String search = request.getParameter("search");
String added  = request.getParameter("added");

List<Product> products;
if (search != null && !search.trim().isEmpty()) {
    products = productService.searchProduct(search.trim());
} else {
    products = productService.getAllProducts();
}

List<Category> categories = categoryService.getAllCategories();
Map<Integer, String> categoryNames = new HashMap<Integer, String>();
for (Category c : categories) {
    categoryNames.put(c.getCategoryId(), c.getName());
}
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Shop Groceries | Smart Grocery</title>

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
.icon-btn .dot{ position:absolute; top:-6px; right:-6px; background:#ef4444; color:white; font-size:10px; font-weight:700; min-width:18px; height:18px; border-radius:20px; display:flex; align-items:center; justify-content:center; padding:0 4px; }
.profile-chip{ display:flex; align-items:center; gap:10px; padding:6px 12px 6px 6px; background:#1b1b1b; border:1px solid #2b2b2b; border-radius:30px; cursor:pointer; text-decoration:none; }
.avatar{ width:34px; height:34px; background:var(--green); border-radius:50%; display:flex; justify-content:center; align-items:center; font-weight:bold; font-size:14px; }
.profile-chip span{ font-size:14px; font-weight:600; color:white; }
.content{ padding:40px; }

/* PAGE HEADER */
.page-header{ display:flex; justify-content:space-between; align-items:center; margin-bottom:28px; flex-wrap:wrap; gap:16px; }
.page-header h1{ font-size:28px; font-weight:800; }
.page-header p{ color:var(--soft); font-size:14px; margin-top:4px; }

.success-banner{ background:rgba(34,197,94,.12); border:1px solid rgba(34,197,94,.35); color:var(--green); padding:12px 18px; border-radius:12px; margin-bottom:22px; font-size:14px; font-weight:600; }

/* CATEGORY FILTER CHIPS */
.cat-filters{ display:flex; gap:10px; flex-wrap:wrap; margin-bottom:30px; }
.cat-chip{ padding:9px 18px; border-radius:100px; background:var(--card); border:1px solid var(--border); color:var(--soft); font-size:13px; font-weight:600; text-decoration:none; transition:.2s; }
.cat-chip:hover{ border-color:var(--green); color:white; }
.cat-chip.active{ background:var(--green); color:white; border-color:var(--green); }

/* PRODUCT GRID */
.product-grid{ display:grid; grid-template-columns:repeat(auto-fill,minmax(230px,1fr)); gap:20px; }
.product-card{ background:var(--card); border:1px solid var(--border); border-radius:16px; overflow:hidden; transition:.25s; display:flex; flex-direction:column; }
.product-card:hover{ border-color:var(--green); transform:translateY(-3px); }
.product-img{ height:140px; background:linear-gradient(135deg,#1c2e1c,#16351f); display:flex; align-items:center; justify-content:center; font-size:44px; }
.product-body{ padding:16px; display:flex; flex-direction:column; flex:1; }
.product-cat{ font-size:10.5px; font-weight:700; color:var(--green); text-transform:uppercase; letter-spacing:.04em; margin-bottom:6px; }
.product-name{ font-size:15px; font-weight:700; margin-bottom:6px; }
.product-meta{ font-size:12px; color:var(--soft); margin-bottom:12px; }
.stock-tag{ display:inline-block; font-size:10.5px; font-weight:700; padding:3px 9px; border-radius:20px; margin-bottom:10px; width:fit-content; }
.stock-in{ background:rgba(34,197,94,.15); color:var(--green); }
.stock-low{ background:rgba(245,158,11,.15); color:#f59e0b; }
.stock-out{ background:rgba(239,68,68,.15); color:#ef4444; }
.product-footer{ margin-top:auto; display:flex; align-items:center; justify-content:space-between; gap:10px; }
.product-price{ font-size:17px; font-weight:800; color:white; }
.product-price span{ font-size:11px; color:var(--soft); font-weight:500; }
.add-cart-form{ display:flex; }
.add-cart-btn{ background:var(--green); border:none; color:white; width:38px; height:38px; border-radius:10px; font-size:15px; cursor:pointer; display:flex; align-items:center; justify-content:center; transition:.2s; }
.add-cart-btn:hover{ background:var(--greenDark); }
.add-cart-btn:disabled{ background:#333; color:#666; cursor:not-allowed; }

.empty-state{ text-align:center; padding:80px 20px; color:var(--soft); }
.empty-state i{ font-size:40px; margin-bottom:16px; color:#444; display:block; }

.footer{ margin-top:45px; padding:25px; text-align:center; color:#888; border-top:1px solid #222; font-size:13px; }

@media(max-width:800px){ .product-grid{ grid-template-columns:repeat(2,1fr); } }

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
<li><a class="active" href="products.jsp"><i class="fa-solid fa-cart-shopping"></i> Shop Groceries</a></li>
<li><a href="inventory.jsp"><i class="fa-solid fa-warehouse"></i> My Inventory</a></li>
<li><a href="mealplanner.jsp"><i class="fa-solid fa-utensils"></i> Meal Planner</a></li>
<li><a href="cart.jsp"><i class="fa-solid fa-list-check"></i> Shopping List</a></li>
<li><a href="recipes.jsp"><i class="fa-solid fa-book-open"></i> Recipes</a></li>
<li><a href="notifications.jsp"><i class="fa-solid fa-bell"></i> Expiry Alerts</a></li>
<li><a href="inventory.jsp?filter=low"><i class="fa-solid fa-triangle-exclamation"></i> Low Stock</a></li>
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
<input type="text" name="search" placeholder="Search products..." value="<%= search != null ? search : "" %>">
<button type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
</form>

<div class="user">
<a href="cart.jsp" class="icon-btn">
<i class="fa-solid fa-cart-shopping"></i>
</a>
<a href="notifications.jsp" class="icon-btn">
<i class="fa-regular fa-bell"></i>
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
<h1>Shop Groceries</h1>
<p><%= products.size() %> products available<% if (search != null && !search.trim().isEmpty()) { %> for "<%= search %>"<% } %></p>
</div>
</div>

<% if ("1".equals(added)) { %>
<div class="success-banner"><i class="fa-solid fa-circle-check"></i> Item added to your cart successfully.</div>
<% } %>

<!-- Category filter chips -->
<div class="cat-filters">
<a href="products.jsp" class="cat-chip <%= search == null ? "active" : "" %>">All Products</a>
<%
for (Category c : categories) {
%>
<a href="products.jsp?search=<%= c.getName() %>" class="cat-chip"><%= c.getName() %></a>
<%
}
%>
</div>

<!-- Product grid -->
<% if (products.isEmpty()) { %>
<div class="empty-state">
<i class="fa-solid fa-box-open"></i>
No products found<% if (search != null) { %> for "<%= search %>"<% } %>.
</div>
<% } else { %>
<div class="product-grid">
<%
for (Product p : products) {
    String catName = categoryNames.get(p.getCategoryId());
    if (catName == null) catName = "General";

    String stockClass;
    String stockLabel;
    if (p.getQuantity() <= 0) {
        stockClass = "stock-out"; stockLabel = "Out of Stock";
    } else if (p.getQuantity() < 10) {
        stockClass = "stock-low"; stockLabel = "Low Stock";
    } else {
        stockClass = "stock-in"; stockLabel = "In Stock";
    }
%>
<div class="product-card">
<div class="product-img">🛒</div>
<div class="product-body">
<div class="product-cat"><%= catName %></div>
<div class="product-name"><%= p.getName() %></div>
<div class="product-meta"><%= p.getQuantity() %> <%= p.getUnit() %> available</div>
<div class="stock-tag <%= stockClass %>"><%= stockLabel %></div>
<div class="product-footer">
<div class="product-price">Rs. <%= String.format("%.2f", p.getPrice()) %><span> / <%= p.getUnit() %></span></div>
<%
    if (p.getQuantity() <= 0) {
%>
<button type="button" class="add-cart-btn" disabled>
<i class="fa-solid fa-plus"></i>
</button>
<%
    } else {
%>
<a href="CartServlet?action=add&productId=<%= p.getProductId() %>&price=<%= p.getPrice() %>" class="add-cart-btn">
<i class="fa-solid fa-plus"></i>
</a>
<%
    }
%>
</div>
</div>
</div>
<%
}
%>
</div>
<% } %>

</div>

<div class="footer">
© 2026 Smart Grocery Management System
</div>

</div>

</body>
</html>
