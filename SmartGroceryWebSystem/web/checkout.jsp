<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<%@page import="model.CartItem"%>
<%@page import="model.Product"%>
<%@page import="service.CartService"%>
<%@page import="dao.ProductDAO"%>
<%@page import="java.util.List"%>

<%
User user = (User) session.getAttribute("user");
if (user == null) {
    response.sendRedirect("login.jsp");
    return;
}

CartService cartService = new CartService();
ProductDAO productDAO = new ProductDAO();

List<CartItem> items = cartService.getCartItems(user.getUserId());
double subtotal = cartService.getCartTotal(items);
double deliveryFee = (subtotal > 0) ? 250.00 : 0.00;
double total = subtotal + deliveryFee;

String success = (String) request.getAttribute("success");
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Checkout | Smart Grocery</title>

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
.avatar{ width:34px; height:34px; background:var(--green); border-radius:50%; display:flex; justify-content:center; align-items:center; font-weight:bold; font-size:14px; overflow:hidden; }
.avatar img{ width:100%; height:100%; object-fit:cover; }
.profile-chip span{ font-size:14px; font-weight:600; color:white; }
.content{ padding:40px; max-width:900px; }

/* PAGE HEADER */
.page-header{ margin-bottom:28px; }
.page-header h1{ font-size:28px; font-weight:800; }
.page-header p{ color:var(--soft); font-size:14px; margin-top:4px; }

/* ORDER PANEL */
.order-panel{ background:var(--card); border:1px solid var(--border); border-radius:18px; padding:8px; margin-bottom:22px; }
.order-panel-head{ display:flex; justify-content:space-between; align-items:center; padding:18px 20px; border-bottom:1px solid var(--border); }
.order-panel-head h2{ font-size:16px; font-weight:700; }
.order-panel-head span{ font-size:12.5px; color:var(--soft); }

table{ width:100%; border-collapse:collapse; }
th{ text-align:left; padding:14px 20px; font-size:11px; text-transform:uppercase; letter-spacing:.04em; color:var(--soft); font-weight:700; border-bottom:1px solid var(--border); }
td{ padding:16px 20px; border-bottom:1px solid var(--border); font-size:14px; }
tr:last-child td{ border-bottom:none; }
td.num{ text-align:right; }
th.num{ text-align:right; }

/* SUMMARY */
.summary-panel{ background:var(--card); border:1px solid var(--border); border-radius:18px; padding:26px; }
.summary-panel h2{ font-size:17px; font-weight:700; margin-bottom:20px; }
.summary-row{ display:flex; justify-content:space-between; align-items:center; font-size:14px; color:var(--soft); margin-bottom:14px; }
.summary-row span.val{ color:white; font-weight:600; }
.summary-divider{ height:1px; background:var(--border); margin:16px 0; }
.summary-total{ display:flex; justify-content:space-between; align-items:center; font-size:20px; font-weight:800; margin-bottom:22px; }
.summary-total span.val{ color:var(--green); }

.btn-primary{ background:var(--green); color:white; border:none; padding:15px 26px; border-radius:12px; font-weight:700; cursor:pointer; font-size:14.5px; display:flex; align-items:center; justify-content:center; gap:10px; text-decoration:none; width:100%; }
.btn-primary:hover{ background:var(--greenDark); }
.btn-outline{ background:transparent; color:white; border:1px solid #555; padding:15px 26px; border-radius:12px; font-weight:700; cursor:pointer; font-size:14.5px; display:flex; align-items:center; justify-content:center; gap:10px; text-decoration:none; width:100%; margin-top:12px; }
.btn-outline:hover{ border-color:var(--green); color:var(--green); }

/* SUCCESS STATE */
.success-card{ background:var(--card); border:1px solid rgba(34,197,94,.35); border-radius:18px; padding:60px 30px; text-align:center; }
.success-card i.big-check{ font-size:56px; color:var(--green); margin-bottom:18px; display:block; }
.success-card h2{ font-size:24px; font-weight:800; margin-bottom:10px; }
.success-card p{ color:var(--soft); font-size:14.5px; margin-bottom:26px; }

.empty-state{ text-align:center; padding:90px 20px; color:var(--soft); background:var(--card); border:1px solid var(--border); border-radius:18px; }
.empty-state i{ font-size:46px; margin-bottom:18px; color:#444; display:block; }
.empty-state h3{ color:white; font-size:19px; margin-bottom:8px; }
.empty-state p{ margin-bottom:24px; font-size:13.5px; }

.footer{ margin-top:45px; padding:25px; text-align:center; color:#888; border-top:1px solid #222; font-size:13px; }

@media(max-width:800px){ table, thead, tbody, th, td, tr{ display:block; } th{ display:none; } td{ border:none; padding:8px 20px; } }

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
<li>
<a class="active" href="cart.jsp">
<i class="fa-solid fa-list-check"></i>
Shopping List
<% if (!items.isEmpty()) { %><span class="menu-count"><%= items.size() %></span><% } %>
</a>
</li>
<li><a href="RecipeController"><i class="fa-solid fa-book-open"></i> Recipes</a></li>
<li><a href="notifications.jsp"><i class="fa-solid fa-bell"></i> Expiry Alerts</a></li>
<li><a href="lowstock.jsp"><i class="fa-solid fa-triangle-exclamation"></i> Low Stock</a></li>
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
<% if (!items.isEmpty()) { %><span class="dot"><%= items.size() %></span><% } %>
</a>
<a href="notifications.jsp" class="icon-btn">
<i class="fa-regular fa-bell"></i>
</a>
<a href="profile.jsp" class="profile-chip">
<div class="avatar"><% if (user.hasProfilePhoto()) { %><img src="<%= user.getProfilePhoto() %>" alt="Profile photo"><% } else { %><%= user.getName().substring(0,1).toUpperCase() %><% } %></div>
<span><%= user.getName() %></span>
<i class="fa-solid fa-chevron-down" style="font-size:11px;color:#888;"></i>
</a>
</div>
</div>

<div class="content">

<% if (success != null) { %>

<div class="page-header">
<h1>Checkout</h1>
<p>Your order has been placed.</p>
</div>

<div class="success-card">
<i class="fa-solid fa-circle-check big-check"></i>
<h2>Order placed successfully!</h2>
<p>Thanks, <%= user.getName() %> — we're getting your groceries ready.</p>
<a href="orders.jsp" class="btn-primary" style="width:auto; display:inline-flex; padding:14px 30px;">
<i class="fa-solid fa-receipt"></i> View My Orders
</a>
</div>

<% } else if (items.isEmpty()) { %>

<div class="page-header">
<h1>Checkout</h1>
<p>Review your order before you place it.</p>
</div>

<div class="empty-state">
<i class="fa-solid fa-cart-shopping"></i>
<h3>Your cart is empty</h3>
<p>Add a few items before checking out.</p>
<a href="products.jsp" class="btn-primary" style="width:auto; display:inline-flex; padding:14px 30px;">
<i class="fa-solid fa-cart-shopping"></i> Shop Groceries
</a>
</div>

<% } else { %>

<div class="page-header">
<div>
<h1>Checkout</h1>
<p><%= items.size() %> item<%= items.size() == 1 ? "" : "s" %> ready to order</p>
</div>
</div>

<div class="order-panel">
<div class="order-panel-head">
<h2><i class="fa-solid fa-receipt" style="color:var(--green);margin-right:8px;"></i>Order Summary</h2>
<span><%= items.size() %> item<%= items.size() == 1 ? "" : "s" %></span>
</div>

<table>
<thead>
<tr>
<th>Product</th>
<th class="num">Qty</th>
<th class="num">Price</th>
<th class="num">Subtotal</th>
</tr>
</thead>
<tbody>
<%
for (CartItem item : items) {
    Product p = productDAO.getProductById(item.getProductId());
    String pName = (p != null) ? p.getName() : "Product #" + item.getProductId();
%>
<tr>
<td data-label="Product"><%= pName %></td>
<td class="num" data-label="Qty"><%= item.getQuantity() %></td>
<td class="num" data-label="Price">Rs. <%= String.format("%.2f", item.getPrice()) %></td>
<td class="num" data-label="Subtotal">Rs. <%= String.format("%.2f", item.getSubtotal()) %></td>
</tr>
<% } %>
</tbody>
</table>
</div>

<div class="summary-panel">
<h2>Payment Summary</h2>

<div class="summary-row"><span>Subtotal</span><span class="val">Rs. <%= String.format("%.2f", subtotal) %></span></div>
<div class="summary-row"><span>Delivery Fee</span><span class="val">Rs. <%= String.format("%.2f", deliveryFee) %></span></div>

<div class="summary-divider"></div>

<div class="summary-total"><span>Total</span><span class="val">Rs. <%= String.format("%.2f", total) %></span></div>

<form action="OrderServlet" method="post">
<input type="hidden" name="action" value="place">
<button type="submit" class="btn-primary">
<i class="fa-solid fa-lock"></i> Place Order
</button>
</form>

<a href="cart.jsp" class="btn-outline">
<i class="fa-solid fa-arrow-left"></i> Back to Cart
</a>

</div>

<% } %>

<div class="footer">
© 2026 Smart Grocery Management System
</div>

</div>

</div>

</body>
</html>