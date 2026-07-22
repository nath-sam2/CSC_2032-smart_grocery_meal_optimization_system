<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<%@page import="model.CartItem"%>
<%@page import="model.Product"%>
<%@page import="service.CartService"%>
<%@page import="service.InventoryService"%>
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
InventoryService inventoryService = new InventoryService();

// Real sidebar badge counts - same source used on dashboard.jsp / lowstock.jsp / notifications.jsp
int sidebarExpiryCount = inventoryService.getExpiringItems(7).size();
int sidebarLowStockCount = inventoryService.getLowStockItems().size();

List<CartItem> items = cartService.getCartItems(user.getUserId());
double subtotal = cartService.getCartTotal(items);
double deliveryFee = (subtotal > 0) ? 250.00 : 0.00;
double total = subtotal + deliveryFee;
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>My Cart | Smart Grocery</title>

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
.content{ padding:40px; }

/* PAGE HEADER */
.page-header{ display:flex; justify-content:space-between; align-items:center; margin-bottom:28px; flex-wrap:wrap; gap:16px; }
.page-header h1{ font-size:28px; font-weight:800; }
.page-header p{ color:var(--soft); font-size:14px; margin-top:4px; }
.clear-cart-btn{ background:transparent; border:1px solid var(--border); color:var(--soft); padding:11px 18px; border-radius:12px; font-weight:700; font-size:13px; cursor:pointer; display:flex; align-items:center; gap:8px; text-decoration:none; }
.clear-cart-btn:hover{ border-color:#ef4444; color:#ef4444; }

.success-banner{ background:rgba(34,197,94,.12); border:1px solid rgba(34,197,94,.35); color:var(--green); padding:12px 18px; border-radius:12px; margin-bottom:22px; font-size:14px; font-weight:600; display:flex; align-items:center; gap:10px; }

/* CART LAYOUT */
.cart-layout{ display:grid; grid-template-columns:1.7fr 1fr; gap:26px; align-items:flex-start; }

.cart-panel{ background:var(--card); border:1px solid var(--border); border-radius:18px; padding:8px; }
.cart-panel-head{ display:flex; justify-content:space-between; align-items:center; padding:18px 20px; border-bottom:1px solid var(--border); }
.cart-panel-head h2{ font-size:16px; font-weight:700; }
.cart-panel-head span{ font-size:12.5px; color:var(--soft); }

/* CART ITEM ROW */
.cart-item{ display:flex; align-items:center; gap:18px; padding:20px; border-bottom:1px solid var(--border); }
.cart-item:last-child{ border-bottom:none; }

.item-icon{ width:64px; height:64px; min-width:64px; border-radius:14px; background:linear-gradient(135deg,#1c2e1c,#16351f); display:flex; align-items:center; justify-content:center; font-size:28px; }

.item-info{ flex:1; min-width:0; }
.item-name{ font-size:15px; font-weight:700; margin-bottom:4px; white-space:nowrap; overflow:hidden; text-overflow:ellipsis; }
.item-meta{ font-size:12.5px; color:var(--soft); }

.qty-control{ display:flex; align-items:center; gap:0; background:#111; border:1px solid var(--border); border-radius:10px; overflow:hidden; }
.qty-control a, .qty-control span{ width:32px; height:32px; display:flex; align-items:center; justify-content:center; text-decoration:none; color:white; font-size:13px; cursor:pointer; }
.qty-control a:hover{ background:#1c1c1c; color:var(--green); }
.qty-control span{ font-weight:700; border-left:1px solid var(--border); border-right:1px solid var(--border); cursor:default; }

.item-price{ width:110px; text-align:right; }
.item-price .unit-price{ font-size:11.5px; color:var(--soft); }
.item-price .subtotal{ font-size:15.5px; font-weight:800; color:white; }

.remove-btn{ width:38px; height:38px; border-radius:10px; background:rgba(239,68,68,.1); border:1px solid rgba(239,68,68,.25); color:#ef4444; display:flex; align-items:center; justify-content:center; text-decoration:none; font-size:14px; transition:.2s; }
.remove-btn:hover{ background:#ef4444; color:white; }

/* SUMMARY PANEL */
.summary-panel{ background:var(--card); border:1px solid var(--border); border-radius:18px; padding:26px; position:sticky; top:100px; }
.summary-panel h2{ font-size:17px; font-weight:700; margin-bottom:20px; }
.summary-row{ display:flex; justify-content:space-between; align-items:center; font-size:14px; color:var(--soft); margin-bottom:14px; }
.summary-row span.val{ color:white; font-weight:600; }
.summary-divider{ height:1px; background:var(--border); margin:16px 0; }
.summary-total{ display:flex; justify-content:space-between; align-items:center; font-size:19px; font-weight:800; margin-bottom:22px; }
.summary-total span.val{ color:var(--green); }

.btn-primary{ background:var(--green); color:white; border:none; padding:15px 26px; border-radius:12px; font-weight:700; cursor:pointer; font-size:14.5px; display:flex; align-items:center; justify-content:center; gap:10px; text-decoration:none; width:100%; }
.btn-primary:hover{ background:var(--greenDark); }
.btn-outline{ background:transparent; color:white; border:1px solid #555; padding:15px 26px; border-radius:12px; font-weight:700; cursor:pointer; font-size:14.5px; display:flex; align-items:center; justify-content:center; gap:10px; text-decoration:none; width:100%; margin-top:12px; }
.btn-outline:hover{ border-color:var(--green); color:var(--green); }

.promo-note{ display:flex; gap:10px; align-items:flex-start; background:rgba(34,197,94,.08); border:1px solid rgba(34,197,94,.25); padding:14px; border-radius:12px; margin-top:18px; font-size:12.5px; color:var(--soft); line-height:1.5; }
.promo-note i{ color:var(--green); margin-top:2px; }

/* EMPTY STATE */
.empty-state{ text-align:center; padding:90px 20px; color:var(--soft); background:var(--card); border:1px solid var(--border); border-radius:18px; }
.empty-state i{ font-size:46px; margin-bottom:18px; color:#444; display:block; }
.empty-state h3{ color:white; font-size:19px; margin-bottom:8px; }
.empty-state p{ margin-bottom:24px; font-size:13.5px; }
.empty-state a{ display:inline-flex; }

.footer{ margin-top:45px; padding:25px; text-align:center; color:#888; border-top:1px solid #222; font-size:13px; }

@media(max-width:900px){ .cart-layout{ grid-template-columns:1fr; } .summary-panel{ position:static; } }

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
<li><a href="notifications.jsp"><i class="fa-solid fa-bell"></i> Expiry Alerts
<% if (sidebarExpiryCount > 0) { %><span class="menu-count"><%= sidebarExpiryCount %></span><% } %>
</a></li>
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

<div class="page-header">
<div>
<h1>My Cart</h1>
<p><%= items.size() %> item<%= items.size() == 1 ? "" : "s" %> in your cart</p>
</div>
<% if (!items.isEmpty()) { %>
<a href="CartServlet?action=clear" class="clear-cart-btn"
   onclick="return confirm('Clear all items from your cart?');">
<i class="fa-solid fa-trash"></i> Clear Cart
</a>
<% } %>
</div>

<% if (items.isEmpty()) { %>

<div class="empty-state">
<i class="fa-solid fa-cart-shopping"></i>
<h3>Your cart is empty</h3>
<p>Looks like you haven't added anything yet. Let's fix that!</p>
<a href="products.jsp" class="btn-primary" style="width:auto; padding:14px 30px;">
<i class="fa-solid fa-cart-shopping"></i> Shop Groceries
</a>
</div>

<% } else { %>

<div class="cart-layout">

<!-- CART ITEMS -->
<div class="cart-panel">
<div class="cart-panel-head">
<h2>Cart Items</h2>
<span><%= items.size() %> item<%= items.size() == 1 ? "" : "s" %></span>
</div>

<%
for (CartItem item : items) {
    Product p = productDAO.getProductById(item.getProductId());
    String pName = (p != null) ? p.getName() : "Product #" + item.getProductId();
    String pUnit = (p != null) ? p.getUnit() : "";
%>
<div class="cart-item">

<div class="item-icon">🛒</div>

<div class="item-info">
<div class="item-name"><%= pName %></div>
<div class="item-meta">Rs. <%= String.format("%.2f", item.getPrice()) %> / <%= pUnit %></div>
</div>

<div class="qty-control">
<a href="CartServlet?action=update&cartItemId=<%= item.getCartItemId() %>&quantity=<%= item.getQuantity() - 1 %>">
<i class="fa-solid fa-minus"></i>
</a>
<span><%= item.getQuantity() %></span>
<a href="CartServlet?action=update&cartItemId=<%= item.getCartItemId() %>&quantity=<%= item.getQuantity() + 1 %>">
<i class="fa-solid fa-plus"></i>
</a>
</div>

<div class="item-price">
<div class="unit-price">Qty x Rs. <%= String.format("%.2f", item.getPrice()) %></div>
<div class="subtotal">Rs. <%= String.format("%.2f", item.getSubtotal()) %></div>
</div>

<a href="CartServlet?action=remove&cartItemId=<%= item.getCartItemId() %>" class="remove-btn"
   onclick="return confirm('Remove this item from your cart?');">
<i class="fa-solid fa-xmark"></i>
</a>

</div>
<% } %>

</div>

<!-- ORDER SUMMARY -->
<div class="summary-panel">
<h2><i class="fa-solid fa-receipt" style="color:var(--green);margin-right:8px;"></i>Order Summary</h2>

<div class="summary-row"><span>Subtotal</span><span class="val">Rs. <%= String.format("%.2f", subtotal) %></span></div>
<div class="summary-row"><span>Delivery Fee</span><span class="val">Rs. <%= String.format("%.2f", deliveryFee) %></span></div>

<div class="summary-divider"></div>

<div class="summary-total"><span>Total</span><span class="val">Rs. <%= String.format("%.2f", total) %></span></div>

<a href="checkout.jsp" class="btn-primary">
<i class="fa-solid fa-lock"></i> Proceed to Checkout
</a>
<a href="products.jsp" class="btn-outline">
<i class="fa-solid fa-arrow-left"></i> Continue Shopping
</a>

<div class="promo-note">
<i class="fa-solid fa-leaf"></i>
<span>Plan your meals and reduce food waste — check your <a href="mealplanner.jsp" style="color:var(--green);font-weight:700;">Meal Planner</a> before checking out.</span>
</div>

</div>

</div>

<% } %>

<div class="footer">
© 2026 Smart Grocery Management System
</div>

</div>

</div>

</body>
</html>
