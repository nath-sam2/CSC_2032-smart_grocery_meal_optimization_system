<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<%@page import="model.Inventory"%>
<%@page import="model.Product"%>
<%@page import="model.CartItem"%>
<%@page import="model.NotificationService"%>
<%@page import="service.InventoryService"%>
<%@page import="service.CartService"%>
<%@page import="dao.ProductDAO"%>
<%@page import="dao.NotificationDAO"%>
<%@page import="java.util.List"%>

<%
User user=(User)session.getAttribute("user");

if(user==null){
    response.sendRedirect("login.jsp");
    return;
}

InventoryService inventoryService = new InventoryService();
ProductDAO productDAO = new ProductDAO();
CartService cartService = new CartService();
NotificationDAO notificationDAO = new NotificationDAO();

// Real low stock items (quantity <= reorderLevel)
List<Inventory> lowStockList = inventoryService.getLowStockItems();
int lowStockCount = lowStockList.size();

// Real cart count
List<CartItem> cartItems = cartService.getCartItems(user.getUserId());
int cartCount = cartItems.size();

// Real unread notifications count
List<NotificationService> unreadNotifications = notificationDAO.getUnreadNotifications();
int notifCount = unreadNotifications.size();
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Dashboard | Smart Grocery</title>

<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Inter',sans-serif;
}

:root{

--green:#22c55e;
--greenDark:#16a34a;
--black:#0b0b0b;
--card:#181818;
--border:#2b2b2b;
--text:#ffffff;
--soft:#9ca3af;

}

body{
background:#0b0b0b;
color:white;
}

a{ color:inherit; }

button{ font-family:'Inter',sans-serif; }

/* ==========================
   SIDEBAR
========================== */

.sidebar{
position:fixed;
left:0;
top:0;
width:260px;
height:100vh;
background:#111;
border-right:1px solid #222;
padding:25px;
display:flex;
flex-direction:column;
overflow-y:auto;
}

.logo{
display:flex;
align-items:center;
gap:12px;
font-size:24px;
font-weight:800;
margin-bottom:5px;
text-decoration:none;
}

.logo i{
color:var(--green);
background:rgba(34,197,94,.15);
width:42px;
height:42px;
border-radius:12px;
display:flex;
align-items:center;
justify-content:center;
}

.logo-sub{
font-size:11px;
color:var(--soft);
margin-bottom:35px;
margin-left:54px;
margin-top:-2px;
}

.menu{
list-style:none;
}

.menu li{
margin-bottom:6px;
}

.menu a{
display:flex;
align-items:center;
gap:15px;
padding:12px 16px;
text-decoration:none;
color:#cbd5e1;
border-radius:12px;
transition:.25s;
font-size:14.5px;
font-weight:500;
position:relative;
cursor:pointer;
border:none;
background:none;
width:100%;
text-align:left;
}

.menu a:hover{
background:#1c1c1c;
color:white;
}

.menu a.active{
background:var(--green);
color:white;
}

.menu-count{
margin-left:auto;
background:#ef4444;
color:white;
font-size:11px;
font-weight:700;
padding:2px 8px;
border-radius:20px;
}

.menu a.active .menu-count{
background:rgba(255,255,255,.25);
}

.side-label{
font-size:11px;
letter-spacing:.08em;
color:#666;
text-transform:uppercase;
margin:22px 0 10px 16px;
font-weight:700;
}

.help-card{
margin-top:auto;
background:linear-gradient(135deg,#16a34a,#22c55e);
border-radius:16px;
padding:18px;
cursor:pointer;
border:none;
text-align:left;
width:100%;
color:white;
}

.help-card i{
font-size:22px;
margin-bottom:8px;
display:block;
}

.help-card b{
display:block;
font-size:14px;
}

.help-card span{
font-size:12px;
opacity:.85;
}

/* ==========================
   MAIN
========================== */

.main{
margin-left:260px;
}

.navbar{
height:80px;
display:flex;
justify-content:space-between;
align-items:center;
padding:0 40px;
background:#111;
border-bottom:1px solid #222;
position:sticky;
top:0;
z-index:5;
}

.search{
width:420px;
position:relative;
display:flex;
}

.search input{
width:100%;
padding:13px 20px;
padding-left:45px;
background:#1b1b1b;
border:1px solid #333;
border-radius:12px 0 0 12px;
border-right:none;
color:white;
outline:none;
}

.search i.fa-magnifying-glass{
position:absolute;
left:16px;
top:15px;
color:#888;
}

.search button{
width:46px;
background:var(--green);
border:none;
border-radius:0 12px 12px 0;
color:white;
cursor:pointer;
font-size:15px;
}

.user{
display:flex;
align-items:center;
gap:22px;
}

.icon-btn{
position:relative;
width:44px;
height:44px;
border-radius:12px;
background:#1b1b1b;
border:1px solid #2b2b2b;
display:flex;
align-items:center;
justify-content:center;
font-size:17px;
color:#cbd5e1;
cursor:pointer;
text-decoration:none;
}

.icon-btn:hover{
border-color:var(--green);
color:var(--green);
}

.icon-btn .dot{
position:absolute;
top:-6px;
right:-6px;
background:#ef4444;
color:white;
font-size:10px;
font-weight:700;
min-width:18px;
height:18px;
border-radius:20px;
display:flex;
align-items:center;
justify-content:center;
padding:0 4px;
}

.profile-chip{
display:flex;
align-items:center;
gap:10px;
padding:6px 12px 6px 6px;
background:#1b1b1b;
border:1px solid #2b2b2b;
border-radius:30px;
cursor:pointer;
text-decoration:none;
}

.avatar{
width:34px;
height:34px;
background:var(--green);
border-radius:50%;
display:flex;
justify-content:center;
align-items:center;
font-weight:bold;
font-size:14px;
overflow:hidden;
}
.avatar img{ width:100%; height:100%; object-fit:cover; }

.profile-chip span{
font-size:14px;
font-weight:600;
color:white;
}

.content{
padding:40px;
}

/* ==========================
   HERO
========================== */

.hero{
position:relative;
border-radius:22px;
overflow:hidden;
min-height:260px;
display:flex;
align-items:center;
padding:45px;
background:
linear-gradient(100deg, rgba(6,10,6,.92) 15%, rgba(6,10,6,.35) 55%, rgba(6,10,6,.05) 80%),
url('https://images.unsplash.com/photo-1540420773420-3366772f4999?q=80&w=1600&auto=format&fit=crop') center/cover;
}

.hero-eyebrow{
display:flex;
align-items:center;
gap:8px;
color:var(--green);
font-weight:700;
font-size:14px;
margin-bottom:16px;
}

.hero h1{
font-size:38px;
line-height:1.2;
max-width:560px;
margin-bottom:14px;
}

.hero h1 span{
color:var(--green);
}

.hero p{
color:#d7d7d7;
max-width:480px;
line-height:24px;
margin-bottom:26px;
font-size:15px;
}

.hero-actions{
display:flex;
gap:14px;
}

.btn-primary{
background:var(--green);
color:white;
border:none;
padding:14px 26px;
border-radius:12px;
font-weight:700;
cursor:pointer;
font-size:14.5px;
display:flex;
align-items:center;
gap:10px;
text-decoration:none;
}

.btn-primary:hover{ background:var(--greenDark); }

.btn-outline{
background:transparent;
color:white;
border:1px solid #555;
padding:14px 26px;
border-radius:12px;
font-weight:700;
cursor:pointer;
font-size:14.5px;
display:flex;
align-items:center;
gap:10px;
text-decoration:none;
}

.btn-outline:hover{ border-color:var(--green); color:var(--green); }

/* ==========================
   STATS
========================== */

.stats{
display:grid;
grid-template-columns:repeat(4,1fr);
gap:22px;
margin-top:28px;
}

.stat-card{
background:var(--card);
border:1px solid var(--border);
border-radius:18px;
padding:22px;
display:flex;
align-items:center;
gap:16px;
transition:.3s;
text-decoration:none;
cursor:pointer;
}

.stat-card:hover{
border-color:var(--green);
transform:translateY(-4px);
}

.icon-circle{
min-width:54px;
height:54px;
border-radius:14px;
display:flex;
justify-content:center;
align-items:center;
font-size:20px;
}

.green{ background:rgba(34,197,94,.15); color:#22c55e; }
.orange{ background:rgba(245,158,11,.15); color:#f59e0b; }
.blue{ background:rgba(59,130,246,.15); color:#3b82f6; }
.purple{ background:rgba(168,85,247,.15); color:#a855f7; }

.stat-number{
font-size:24px;
font-weight:800;
display:flex;
align-items:center;
gap:8px;
color:white;
}

.stat-number .trend{
font-size:12px;
color:var(--green);
font-weight:700;
}

.stat-title{
font-size:13.5px;
color:var(--soft);
margin-top:2px;
}

/* ==========================
   SECTION TITLES
========================== */

.section-title{
font-size:22px;
font-weight:700;
margin-top:45px;
margin-bottom:22px;
display:flex;
align-items:center;
justify-content:space-between;
}

.section-title a{
font-size:13px;
color:var(--green);
font-weight:600;
text-decoration:none;
}

.section-title a:hover{ text-decoration:underline; }

/* ==========================
   WEEKLY MEAL PLANNER
========================== */

.planner{
display:grid;
grid-template-columns:repeat(7,1fr);
gap:16px;
}

.day-col{
background:var(--card);
border:1px solid var(--border);
border-radius:16px;
padding:16px;
min-height:280px;
display:flex;
flex-direction:column;
}

.day-col.today{
border-color:var(--green);
box-shadow:0 0 0 1px var(--green) inset;
}

.day-head{
font-size:12px;
font-weight:700;
letter-spacing:.05em;
color:var(--soft);
margin-bottom:14px;
display:flex;
align-items:center;
gap:6px;
}

.day-col.today .day-head{ color:var(--green); }

.meal-row{
display:flex;
align-items:flex-start;
gap:8px;
margin-bottom:14px;
font-size:12.5px;
}

.meal-emoji{
width:30px;
height:30px;
border-radius:9px;
background:#222;
display:flex;
align-items:center;
justify-content:center;
font-size:15px;
flex-shrink:0;
}

.meal-slot{
font-size:11px;
color:#777;
text-transform:uppercase;
letter-spacing:.03em;
}

.meal-name{
font-weight:600;
margin-top:1px;
}

.add-meal{
margin-top:auto;
color:var(--green);
font-size:12px;
font-weight:700;
text-decoration:none;
cursor:pointer;
}

.add-meal:hover{ text-decoration:underline; }

.add-empty{
font-size:12px;
color:var(--green);
font-weight:700;
margin-bottom:14px;
cursor:pointer;
background:none;
border:none;
text-align:left;
padding:0;
}

.add-empty:hover{ text-decoration:underline; }

/* ==========================
   BOTTOM GRID
========================== */

.bottom-grid{
display:grid;
grid-template-columns:1.5fr 1fr 1fr 1fr;
gap:22px;
margin-top:45px;
}

.panel{
background:var(--card);
border:1px solid var(--border);
border-radius:18px;
padding:24px;
}

.panel h2{
font-size:17px;
margin-bottom:18px;
display:flex;
justify-content:space-between;
align-items:center;
}

.panel h2 a{
font-size:12px;
color:var(--green);
font-weight:600;
text-decoration:none;
}

.panel h2 a:hover{ text-decoration:underline; }

/* AI recipes */

.recipe-grid{
display:grid;
grid-template-columns:repeat(2,1fr);
gap:16px;
}

.recipe-card{
background:#111;
border:1px solid var(--border);
border-radius:14px;
overflow:hidden;
}

.recipe-card img{
width:100%;
height:90px;
object-fit:cover;
display:block;
}

.recipe-body{
padding:12px;
}

.recipe-body h4{
font-size:13.5px;
margin-bottom:6px;
}

.tags{
display:flex;
gap:6px;
margin-bottom:8px;
flex-wrap:wrap;
}

.tag{
font-size:10px;
font-weight:700;
padding:3px 8px;
border-radius:20px;
background:rgba(34,197,94,.15);
color:var(--green);
}

.recipe-meta{
display:flex;
justify-content:space-between;
font-size:11.5px;
color:var(--soft);
margin-bottom:10px;
}

.cook-btn{
width:100%;
background:var(--green);
border:none;
color:white;
padding:9px;
border-radius:9px;
font-weight:700;
font-size:12.5px;
cursor:pointer;
text-decoration:none;
display:block;
text-align:center;
}

.cook-btn:hover{ background:var(--greenDark); }

/* list widgets */

.list-item{
display:flex;
align-items:center;
gap:12px;
padding:11px 0;
border-bottom:1px solid #232323;
text-decoration:none;
cursor:pointer;
}

.list-item:hover{ opacity:.8; }

.list-item:last-child{ border-bottom:none; }

.list-icon{
width:38px;
height:38px;
border-radius:10px;
display:flex;
align-items:center;
justify-content:center;
font-size:16px;
flex-shrink:0;
}

.list-name{
font-size:13.5px;
font-weight:600;
color:white;
}

.list-sub{
font-size:11.5px;
color:var(--soft);
margin-top:2px;
}

.list-badge{
margin-left:auto;
font-size:11px;
font-weight:700;
padding:5px 10px;
border-radius:20px;
white-space:nowrap;
}

.badge-red{ background:rgba(239,68,68,.15); color:#ef4444; }
.badge-orange{ background:rgba(245,158,11,.15); color:#f59e0b; }

/* stock bar */

.stock-bar{
width:60px;
height:6px;
border-radius:10px;
background:#2a2a2a;
overflow:hidden;
margin-left:auto;
}

.stock-bar span{
display:block;
height:100%;
background:#ef4444;
}

.stock-pct{
font-size:11px;
color:var(--soft);
margin-left:10px;
width:60px;
text-align:right;
}

/* shopping list */

.check-item{
display:flex;
align-items:center;
gap:12px;
padding:10px 0;
border-bottom:1px solid #232323;
font-size:13.5px;
cursor:pointer;
}

.check-item:last-child{ border-bottom:none; }

.check-item input{
width:17px;
height:17px;
accent-color:var(--green);
cursor:pointer;
}

.check-item.done span{
text-decoration:line-through;
color:#666;
}

.add-item-btn{
width:100%;
margin-top:14px;
background:transparent;
border:1.5px dashed #333;
color:var(--green);
padding:10px;
border-radius:10px;
font-weight:700;
font-size:12.5px;
cursor:pointer;
text-decoration:none;
display:block;
text-align:center;
}

.add-item-btn:hover{ border-color:var(--green); }

/* ==========================
   RECENT ACTIVITY
========================== */

.activity-strip{
margin-top:22px;
background:var(--card);
border:1px solid var(--border);
border-radius:18px;
padding:22px 26px;
display:flex;
align-items:center;
justify-content:space-between;
gap:20px;
flex-wrap:wrap;
}

.activity-strip h3{
font-size:14px;
display:flex;
align-items:center;
gap:8px;
color:var(--soft);
min-width:150px;
}

.activity-list{
display:flex;
gap:32px;
flex-wrap:wrap;
}

.activity-item{
display:flex;
align-items:center;
gap:10px;
font-size:12.5px;
}

.activity-item i{
width:32px;
height:32px;
border-radius:9px;
background:rgba(34,197,94,.15);
color:var(--green);
display:flex;
align-items:center;
justify-content:center;
font-size:13px;
}

.activity-item span{
display:block;
color:#666;
font-size:11px;
margin-top:2px;
}

.footer{
margin-top:45px;
padding:25px;
text-align:center;
color:#888;
border-top:1px solid #222;
font-size:13px;
}

@media(max-width:1300px){
.stats{ grid-template-columns:repeat(2,1fr); }
.planner{ grid-template-columns:repeat(4,1fr); }
.bottom-grid{ grid-template-columns:1fr 1fr; }
}

@media(max-width:800px){
.planner{ grid-template-columns:repeat(2,1fr); }
.bottom-grid{ grid-template-columns:1fr; }
.recipe-grid{ grid-template-columns:1fr 1fr; }
}

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
<a class="active" href="dashboard.jsp">
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
<a href="MealDashboardController">
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
<a href="RecipeController">
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
<a href="lowstock.jsp">
<i class="fa-solid fa-triangle-exclamation"></i>
Low Stock
<% if (lowStockCount > 0) { %><span class="menu-count"><%= lowStockCount %></span><% } %>
</a>
</li>

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
<div class="avatar"><% if (user.hasProfilePhoto()) { %><img src="<%= user.getProfilePhoto() %>" alt="Profile photo"><% } else { %><%= user.getName().substring(0,1).toUpperCase() %><% } %></div>
<span><%=user.getName()%></span>
<i class="fa-solid fa-chevron-down" style="font-size:11px;color:#888;"></i>
</a>

</div>

</div>

<div class="content">

<!-- HERO -->

<div class="hero">
<div>
<div class="hero-eyebrow"><i class="fa-solid fa-leaf"></i> SMART MEAL PLANNER</div>
<h1>Plan Healthy Meals,<br>Reduce Waste, <span>Save More.</span></h1>
<p>Organize your meals, track inventory and build a smarter kitchen every day.</p>
<div class="hero-actions">
<a href="MealDashboardController" class="btn-primary"><i class="fa-solid fa-calendar-check"></i> Plan Meals</a>
<a href="RecipeController" class="btn-outline"><i class="fa-solid fa-utensils"></i> Explore Recipes</a>
</div>
</div>
</div>

<!-- STATS -->

<div class="stats">

<a href="inventory.jsp" class="stat-card">
<div class="icon-circle green"><i class="fa-solid fa-box"></i></div>
<div>
<div class="stat-number">128 <span class="trend"><i class="fa-solid fa-arrow-up"></i> 12%</span></div>
<div class="stat-title">Inventory Items</div>
</div>
</a>

<a href="MealDashboardController" class="stat-card">
<div class="icon-circle orange"><i class="fa-solid fa-bowl-food"></i></div>
<div>
<div class="stat-number">18 <span class="trend"><i class="fa-solid fa-arrow-up"></i> 8%</span></div>
<div class="stat-title">Meals Planned This Week</div>
</div>
</a>

<a href="notifications.jsp" class="stat-card">
<div class="icon-circle blue"><i class="fa-solid fa-seedling"></i></div>
<div>
<div class="stat-number">8.4 kg <span class="trend"><i class="fa-solid fa-arrow-up"></i> 15%</span></div>
<div class="stat-title">Food Saved This Month</div>
</div>
</a>

<a href="orders.jsp" class="stat-card">
<div class="icon-circle purple"><i class="fa-solid fa-wallet"></i></div>
<div>
<div class="stat-number">Rs. 4,500 <span class="trend"><i class="fa-solid fa-arrow-up"></i> 10%</span></div>
<div class="stat-title">Money Saved This Month</div>
</div>
</a>

</div>

<!-- WEEKLY MEAL PLANNER -->

<h2 class="section-title">
<span><i class="fa-solid fa-calendar-days" style="color:var(--green);margin-right:8px;"></i>Weekly Meal Planner</span>
<a href="MealPlannerController?action=list">View Full Planner <i class="fa-solid fa-chevron-right"></i></a>
</h2>

<div class="planner">

<div class="day-col">
<div class="day-head">MON 19</div>
<div class="meal-row"><div class="meal-emoji">🥣</div><div><div class="meal-slot">Breakfast</div><div class="meal-name">Oats &amp; Banana</div></div></div>
<div class="meal-row"><div class="meal-emoji">🍚</div><div><div class="meal-slot">Lunch</div><div class="meal-name">Dal Rice</div></div></div>
<div class="meal-row"><div class="meal-emoji">🥦</div><div><div class="meal-slot">Dinner</div><div class="meal-name">Veg Stir Fry</div></div></div>
<a href="addMeal.jsp?day=Monday" class="add-meal">+ Add Meal</a>
</div>

<div class="day-col">
<div class="day-head">TUE 20</div>
<div class="meal-row"><div class="meal-emoji">🍳</div><div><div class="meal-slot">Breakfast</div><div class="meal-name">Bread &amp; Eggs</div></div></div>
<div class="meal-row"><div class="meal-emoji">🍛</div><div><div class="meal-slot">Lunch</div><div class="meal-name">Chicken Curry</div></div></div>
<div class="meal-row"><div class="meal-emoji">🍜</div><div><div class="meal-slot">Dinner</div><div class="meal-name">Rice &amp; Dahl</div></div></div>
<a href="addMeal.jsp?day=Tuesday" class="add-meal">+ Add Meal</a>
</div>

<div class="day-col today">
<div class="day-head"><i class="fa-solid fa-star"></i> WED 21</div>
<div class="meal-row"><div class="meal-emoji">🍹</div><div><div class="meal-slot">Breakfast</div><div class="meal-name">Smoothie Bowl</div></div></div>
<div class="meal-row"><div class="meal-emoji">🥙</div><div><div class="meal-slot">Lunch</div><div class="meal-name">Veg Wrap</div></div></div>
<div class="meal-row"><div class="meal-emoji">🥗</div><div><div class="meal-slot">Dinner</div><div class="meal-name">Grilled Veggies</div></div></div>
<a href="addMeal.jsp?day=Wednesday" class="add-meal">+ Add Meal</a>
</div>

<div class="day-col">
<div class="day-head">THU 22</div>
<div class="meal-row"><div class="meal-emoji">🍓</div><div><div class="meal-slot">Breakfast</div><div class="meal-name">Yogurt &amp; Fruit</div></div></div>
<div class="meal-row"><div class="meal-emoji">🥪</div><div><div class="meal-slot">Lunch</div><div class="meal-name">Veg Sandwich</div></div></div>
<div class="meal-row"><div class="meal-emoji">🍲</div><div><div class="meal-slot">Dinner</div><div class="meal-name">Veg Soup</div></div></div>
<a href="addMeal.jsp?day=Thursday" class="add-meal">+ Add Meal</a>
</div>

<div class="day-col">
<div class="day-head">FRI 23</div>
<a href="addMeal.jsp?day=Friday&amp;slot=Breakfast" class="add-empty">+ Add Breakfast</a>
<a href="addMeal.jsp?day=Friday&amp;slot=Lunch" class="add-empty">+ Add Lunch</a>
<a href="addMeal.jsp?day=Friday&amp;slot=Dinner" class="add-empty">+ Add Dinner</a>
</div>

<div class="day-col">
<div class="day-head">SAT 24</div>
<a href="addMeal.jsp?day=Saturday&amp;slot=Breakfast" class="add-empty">+ Add Breakfast</a>
<a href="addMeal.jsp?day=Saturday&amp;slot=Lunch" class="add-empty">+ Add Lunch</a>
<a href="addMeal.jsp?day=Saturday&amp;slot=Dinner" class="add-empty">+ Add Dinner</a>
</div>

<div class="day-col">
<div class="day-head">SUN 25</div>
<a href="addMeal.jsp?day=Sunday&amp;slot=Breakfast" class="add-empty">+ Add Breakfast</a>
<a href="addMeal.jsp?day=Sunday&amp;slot=Lunch" class="add-empty">+ Add Lunch</a>
<a href="addMeal.jsp?day=Sunday&amp;slot=Dinner" class="add-empty">+ Add Dinner</a>
</div>

</div>

<!-- BOTTOM GRID -->

<div class="bottom-grid">

<!-- AI RECIPES -->
<div class="panel">
<h2><span><i class="fa-solid fa-wand-magic-sparkles" style="color:var(--green);margin-right:6px;"></i>AI Suggested Recipes</span><a href="RecipeController">View All</a></h2>

<div class="recipe-grid">

<div class="recipe-card">
<img src="https://images.unsplash.com/photo-1604908176997-125f25cc6f3d?q=80&w=400&auto=format&fit=crop" alt="Chicken Curry">
<div class="recipe-body">
<h4>Chicken Curry</h4>
<div class="tags"><span class="tag">Protein</span><span class="tag">Spicy</span></div>
<div class="recipe-meta"><span><i class="fa-regular fa-clock"></i> 40 min</span><span>⭐ 4.8</span></div>
<a href="RecipeController?action=view&id=<realRecipeId>" class="cook-btn">Cook Now</a>
</div>
</div>

<div class="recipe-card">
<img src="https://images.unsplash.com/photo-1621996346565-e3dbc353d2e5?q=80&w=400&auto=format&fit=crop" alt="Veg Pasta">
<div class="recipe-body">
<h4>Veg Pasta</h4>
<div class="tags"><span class="tag">Vegetarian</span><span class="tag">Italian</span></div>
<div class="recipe-meta"><span><i class="fa-regular fa-clock"></i> 25 min</span><span>⭐ 4.3</span></div>
<a href="RecipeController?action=view&id=<realRecipeId>" class="cook-btn">Cook Now</a>
</div>
</div>

<div class="recipe-card">
<img src="https://images.unsplash.com/photo-1490474418585-ba9bad8fd0ea?q=80&w=400&auto=format&fit=crop" alt="Fruit Bowl">
<div class="recipe-body">
<h4>Fruit Bowl</h4>
<div class="tags"><span class="tag">Healthy</span></div>
<div class="recipe-meta"><span><i class="fa-regular fa-clock"></i> 15 min</span><span>⭐ 4.5</span></div>
<a href="RecipeController?action=view&id=<realRecipeId>" class="cook-btn">Cook Now</a>
</div>
</div>

<div class="recipe-card">
<img src="https://images.unsplash.com/photo-1622597467836-f3285f2131b8?q=80&w=400&auto=format&fit=crop" alt="Green Smoothie">
<div class="recipe-body">
<h4>Green Smoothie</h4>
<div class="tags"><span class="tag">Healthy</span></div>
<div class="recipe-meta"><span><i class="fa-regular fa-clock"></i> 10 min</span><span>⭐ 4.6</span></div>
<a href="RecipeController?action=view&id=<realRecipeId>" class="cook-btn">Cook Now</a>
</div>
</div>

</div>
</div>

<!-- EXPIRING SOON -->
<div class="panel">
<h2><span>⏰ Expiring Soon</span><a href="notifications.jsp">View All</a></h2>

<a href="inventory.jsp?item=Milk" class="list-item">
<div class="list-icon" style="background:rgba(239,68,68,.15);">🥛</div>
<div><div class="list-name">Milk</div><div class="list-sub">Expires in 2 days</div></div>
<div class="list-badge badge-red">2 days</div>
</a>

<a href="inventory.jsp?item=Tomatoes" class="list-item">
<div class="list-icon" style="background:rgba(239,68,68,.15);">🍅</div>
<div><div class="list-name">Tomatoes</div><div class="list-sub">Expires in 1 day</div></div>
<div class="list-badge badge-red">1 day</div>
</a>

<a href="inventory.jsp?item=Spinach" class="list-item">
<div class="list-icon" style="background:rgba(239,68,68,.15);">🥬</div>
<div><div class="list-name">Spinach</div><div class="list-sub">Expires today</div></div>
<div class="list-badge badge-red">Today</div>
</a>

<a href="inventory.jsp?item=Yogurt" class="list-item">
<div class="list-icon" style="background:rgba(245,158,11,.15);">🍦</div>
<div><div class="list-name">Yogurt</div><div class="list-sub">Expires in 2 days</div></div>
<div class="list-badge badge-orange">2 days</div>
</a>

</div>

<!-- LOW STOCK -->
<div class="panel">
<h2><span>📦 Low Stock Items</span><a href="lowstock.jsp">View All</a></h2>

<%
if (lowStockList.isEmpty()) {
%>
<div class="list-sub" style="padding:10px 0;">No low stock items right now. 🎉</div>
<%
} else {
    int shown = 0;
    for (Inventory inv : lowStockList) {
        if (shown >= 4) break; // dashboard preview shows top 4, full list on inventory.jsp
        shown++;

        Product p = productDAO.getProductById(inv.getProductId());
        String pName = (p != null) ? p.getName() : ("Product #" + inv.getProductId());

        int reorderLevel = inv.getReorderLevel();
        int qty = inv.getQuantity();
        // % of stock remaining relative to reorder level (capped 0-100)
        int pct;
        if (reorderLevel <= 0) {
            pct = (qty <= 0) ? 0 : 100;
        } else {
            pct = (int) Math.round((qty * 100.0) / reorderLevel);
            if (pct > 100) pct = 100;
            if (pct < 0) pct = 0;
        }
%>
<a href="products.jsp?reorder=<%= inv.getProductId() %>" class="list-item">
<div class="list-icon" style="background:#222;">📦</div>
<div><div class="list-name"><%= pName %></div><div class="list-sub"><%= qty %> left (reorder at <%= reorderLevel %>)</div></div>
<div class="stock-bar"><span style="width:<%= pct %>%"></span></div>
</a>
<%
    }
}
%>

</div>

<!-- SHOPPING LIST -->
<div class="panel">
<h2><span>🛒 Shopping List</span><a href="cart.jsp">View All</a></h2>

<form id="shoppingListForm" action="ShoppingListServlet" method="post">
<label class="check-item"><input type="checkbox" name="item" value="Milk" onchange="this.form.submit()"><span>Milk</span></label>
<label class="check-item done"><input type="checkbox" name="item" value="Bread" checked onchange="this.form.submit()"><span>Bread</span></label>
<label class="check-item"><input type="checkbox" name="item" value="Eggs" onchange="this.form.submit()"><span>Eggs</span></label>
<label class="check-item"><input type="checkbox" name="item" value="Cheese" onchange="this.form.submit()"><span>Cheese</span></label>
<label class="check-item done"><input type="checkbox" name="item" value="Apples" checked onchange="this.form.submit()"><span>Apples</span></label>
<label class="check-item"><input type="checkbox" name="item" value="Bananas" onchange="this.form.submit()"><span>Bananas</span></label>
</form>

<a href="cart.jsp" class="add-item-btn">+ Add Item</a>
</div>

</div>

<!-- RECENT ACTIVITY -->

<div class="activity-strip">
<h3><i class="fa-solid fa-chart-line" style="color:var(--green);"></i> Recent Activity</h3>
<div class="activity-list">

<div class="activity-item">
<i class="fa-solid fa-cart-plus"></i>
<div>Added Milk<span>10 min ago</span></div>
</div>

<div class="activity-item">
<i class="fa-solid fa-utensils"></i>
<div>Planned Dinner<span>1 hr ago</span></div>
</div>

<div class="activity-item">
<i class="fa-solid fa-bag-shopping"></i>
<div>Purchased Apples<span>3 hrs ago</span></div>
</div>

<div class="activity-item">
<i class="fa-solid fa-box-open"></i>
<div>Removed Bread<span>5 hrs ago</span></div>
</div>

</div>
<a href="orders.jsp" style="color:var(--green);font-size:12.5px;font-weight:700;text-decoration:none;">View All Activity <i class="fa-solid fa-chevron-right"></i></a>
</div>

<!-- FOOTER -->

<div class="footer">
© 2026 Smart Grocery Management System
<br><br>
Manage Smart • Eat Smart • Live Healthy 🌿
</div>

</div>

</div>

</body>
</html>
