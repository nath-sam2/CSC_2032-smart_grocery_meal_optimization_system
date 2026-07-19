<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>

<%
User user=(User)session.getAttribute("user");

if(user==null){
    response.sendRedirect("login.jsp");
    return;
}
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

/* Sidebar */

.sidebar{

position:fixed;

left:0;
top:0;

width:260px;
height:100vh;

background:#111;

border-right:1px solid #222;

padding:25px;

}

.logo{

display:flex;
align-items:center;
gap:12px;

font-size:28px;
font-weight:800;

margin-bottom:50px;

}

.logo i{

color:var(--green);

}

.menu{

list-style:none;

}

.menu li{

margin-bottom:12px;

}

.menu a{

display:flex;

align-items:center;

gap:15px;

padding:14px 18px;

text-decoration:none;

color:#cbd5e1;

border-radius:12px;

transition:.3s;

font-size:15px;

}

.menu a:hover{

background:var(--green);
color:white;

}

.menu a.active{

background:var(--green);
color:white;

}

/* Main */

.main{

margin-left:260px;

}

/* Navbar */

.navbar{

height:80px;

display:flex;

justify-content:space-between;

align-items:center;

padding:0 40px;

background:#111;

border-bottom:1px solid #222;

}

.search{

width:420px;

position:relative;

}

.search input{

width:100%;

padding:14px 20px;

padding-left:45px;

background:#1b1b1b;

border:1px solid #333;

border-radius:12px;

color:white;

outline:none;

}

.search i{

position:absolute;

left:15px;

top:15px;

color:#888;

}

.user{

display:flex;

align-items:center;

gap:20px;

}

.user i{

font-size:22px;

cursor:pointer;

}

.avatar{

width:45px;
height:45px;

background:var(--green);

border-radius:50%;

display:flex;

justify-content:center;

align-items:center;

font-weight:bold;

}

.content{

padding:40px;

}

.content h1{

font-size:40px;

margin-bottom:10px;

}

.content p{

color:#9ca3af;

font-size:18px;

}

.stats{

display:grid;
grid-template-columns:repeat(4,1fr);
gap:25px;
margin-top:45px;

}

.stat-card{

background:#181818;

border:1px solid #2d2d2d;

border-radius:18px;

padding:28px;

transition:.35s;

cursor:pointer;

position:relative;

overflow:hidden;

}

.stat-card:hover{

transform:translateY(-8px);

border-color:#22c55e;

box-shadow:0 15px 35px rgba(34,197,94,.15);

}

.stat-card::before{

content:"";

position:absolute;

top:0;
left:0;

width:100%;
height:4px;

background:#22c55e;

}

.icon-circle{

width:70px;
height:70px;

border-radius:50%;

display:flex;

justify-content:center;
align-items:center;

font-size:28px;

margin-bottom:25px;

}

.green{

background:rgba(34,197,94,.15);

color:#22c55e;

}

.orange{

background:rgba(245,158,11,.15);

color:#f59e0b;

}

.red{

background:rgba(239,68,68,.15);

color:#ef4444;

}

.blue{

background:rgba(59,130,246,.15);

color:#3b82f6;

}

.stat-number{

font-size:42px;

font-weight:800;

margin-bottom:6px;

}

.stat-title{

font-size:18px;

font-weight:600;

margin-bottom:5px;

}

.stat-sub{

font-size:14px;

color:#9ca3af;

}

@media(max-width:1200px){

.stats{

grid-template-columns:repeat(2,1fr);

}

}

@media(max-width:700px){

.stats{

grid-template-columns:1fr;

}

}
/* ==========================
   QUICK ACTIONS
========================== */

.section-title{

font-size:28px;

font-weight:700;

margin-top:55px;

margin-bottom:25px;

}

.quick-actions{

display:grid;

grid-template-columns:repeat(3,1fr);

gap:25px;

}

.action-card{

background:#181818;

border:1px solid #2d2d2d;

border-radius:18px;

padding:28px;

text-decoration:none;

color:white;

transition:.35s;

display:flex;

flex-direction:column;

align-items:center;

justify-content:center;

height:190px;

}

.action-card:hover{

transform:translateY(-8px);

border-color:#22c55e;

box-shadow:0 18px 40px rgba(34,197,94,.18);

}

.action-card i{

font-size:42px;

color:#22c55e;

margin-bottom:20px;

}

.action-card h3{

font-size:20px;

margin-bottom:8px;

}

.action-card p{

font-size:14px;

color:#9ca3af;

text-align:center;

line-height:22px;

}

@media(max-width:1100px){

.quick-actions{

grid-template-columns:repeat(2,1fr);

}

}

@media(max-width:700px){

.quick-actions{

grid-template-columns:1fr;

}

}
/* ==========================
   DASHBOARD WIDGETS
========================== */

.dashboard-grid{

display:grid;
grid-template-columns:1fr 1fr;
gap:25px;
margin-top:55px;

}

.widget{

background:#181818;
border:1px solid #2d2d2d;
border-radius:18px;
padding:28px;

}

.widget h2{

font-size:24px;
margin-bottom:22px;

}

.widget-item{

display:flex;
justify-content:space-between;
align-items:center;

padding:15px 0;

border-bottom:1px solid #2b2b2b;

}

.widget-item:last-child{

border-bottom:none;

}

.item-left{

display:flex;
align-items:center;
gap:15px;

}

.item-icon{

width:50px;
height:50px;

border-radius:50%;

display:flex;
justify-content:center;
align-items:center;

font-size:20px;

}

.red-bg{

background:rgba(239,68,68,.15);
color:#ef4444;

}

.green-bg{

background:rgba(34,197,94,.15);
color:#22c55e;

}

.orange-bg{

background:rgba(245,158,11,.15);
color:#f59e0b;

}

.item-name{

font-size:17px;
font-weight:600;

}

.item-desc{

font-size:13px;
color:#9ca3af;

margin-top:3px;

}

.badge{

padding:8px 14px;

border-radius:30px;

font-size:13px;
font-weight:600;

color:white;

}

.badge.red{

background:#ef4444;

}

.badge.orange{

background:#f59e0b;

}

.badge.green{

background:#22c55e;

}

@media(max-width:1000px){

.dashboard-grid{

grid-template-columns:1fr;

}

}
/*===========================
RECENT ORDERS
===========================*/

.bottom-grid{

display:grid;

grid-template-columns:2fr 1fr;

gap:25px;

margin-top:45px;

}

.table-card,
.progress-card{

background:#181818;

border:1px solid #2d2d2d;

border-radius:18px;

padding:28px;

}

.table-card h2,
.progress-card h2{

margin-bottom:20px;

font-size:24px;

}

table{

width:100%;

border-collapse:collapse;

}

table th{

text-align:left;

padding:15px;

color:#9ca3af;

border-bottom:1px solid #333;

}

table td{

padding:16px;

border-bottom:1px solid #2a2a2a;

}

.status{

padding:8px 14px;

border-radius:25px;

font-size:13px;

font-weight:600;

}

.delivered{

background:#22c55e;

}

.processing{

background:#f59e0b;

}

.cancelled{

background:#ef4444;

}

/*===========================
PROGRESS BARS
===========================*/

.progress-item{

margin-bottom:25px;

}

.progress-title{

display:flex;

justify-content:space-between;

margin-bottom:8px;

font-size:15px;

}

.progress{

height:10px;

background:#2a2a2a;

border-radius:10px;

overflow:hidden;

}

.progress span{

display:block;

height:100%;

background:#22c55e;

border-radius:10px;

}

@media(max-width:1000px){

.bottom-grid{

grid-template-columns:1fr;

}

}
/*==========================
FINAL SECTION
===========================*/

.hero-banner{

margin-top:45px;

background:linear-gradient(120deg,#16a34a,#22c55e);

border-radius:20px;

padding:40px;

display:flex;

justify-content:space-between;

align-items:center;

overflow:hidden;

}

.hero-banner h2{

font-size:36px;

margin-bottom:10px;

}

.hero-banner p{

font-size:16px;

color:#e8ffe8;

max-width:500px;

line-height:28px;

}

.hero-banner button{

margin-top:25px;

padding:14px 28px;

background:white;

color:#16a34a;

font-weight:bold;

border:none;

border-radius:10px;

cursor:pointer;

transition:.3s;

}

.hero-banner button:hover{

transform:translateY(-3px);

}

.hero-icon{

font-size:120px;

opacity:.25;

}

/*=====================
ANALYTICS
=====================*/

.analytics{

display:grid;

grid-template-columns:2fr 1fr;

gap:25px;

margin-top:40px;

}

.chart-card,
.profile-card{

background:#181818;

border:1px solid #2d2d2d;

border-radius:18px;

padding:30px;

}

.chart-bars{

display:flex;

align-items:flex-end;

justify-content:space-between;

height:220px;

margin-top:25px;

}

.bar{

width:45px;

background:#22c55e;

border-radius:8px 8px 0 0;

transition:.4s;

}

.bar:hover{

background:#16a34a;

}

.bar1{height:90px;}
.bar2{height:130px;}
.bar3{height:170px;}
.bar4{height:120px;}
.bar5{height:200px;}
.bar6{height:150px;}
.bar7{height:180px;}

.profile{

text-align:center;

}

.profile img{

width:90px;

height:90px;

border-radius:50%;

margin-bottom:15px;

border:4px solid #22c55e;

}

.profile h3{

margin-bottom:8px;

}

.profile p{

color:#9ca3af;

margin-bottom:25px;

}

.profile button{

padding:12px 24px;

background:#22c55e;

color:white;

border:none;

border-radius:10px;

cursor:pointer;

}

.footer{

margin-top:60px;

padding:25px;

text-align:center;

color:#888;

border-top:1px solid #222;

}

@media(max-width:1000px){

.analytics{

grid-template-columns:1fr;

}

.hero-banner{

flex-direction:column;

text-align:center;

gap:25px;

}

}
</style>

</head>

<body>

<!-- Sidebar -->

<div class="sidebar">

<div class="logo">

<i class="fa-solid fa-cart-shopping"></i>

<span>Smart Grocery</span>

</div>

<ul class="menu">

<li>
<a class="active" href="#">
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
<a href="orders.jsp">
<i class="fa-solid fa-box"></i>
My Orders
</a>
</li>

<li>
<a href="inventory.jsp">
<i class="fa-solid fa-warehouse"></i>
Inventory
</a>
</li>

<li>
<a href="mealplanner.jsp">
<i class="fa-solid fa-utensils"></i>
Meal Planner
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
Notifications
</a>
</li>

<li>
<a href="cart.jsp">
<i class="fa-solid fa-cart-plus"></i>
My Cart
</a>
</li>

<li>
<a href="LogoutServlet">
<i class="fa-solid fa-right-from-bracket"></i>
Logout
</a>
</li>

</ul>

</div>

<!-- Main -->

<div class="main">

<div class="navbar">

<div class="search">

<i class="fa-solid fa-magnifying-glass"></i>

<input
type="text"
placeholder="Search products, recipes...">

</div>

<div class="user">

<i class="fa-regular fa-bell"></i>

<div>

<b>Welcome, <%=user.getName()%></b>

</div>

<div class="avatar">

<%=user.getName().substring(0,1).toUpperCase()%>

</div>

</div>

</div>

<div class="content">

<h1>Welcome Back 👋</h1>

<p>
Manage your groceries, inventory and healthy meals from one place.
</p>

<div class="stats">

<div class="stat-card">

<div class="icon-circle green">

<i class="fa-solid fa-box"></i>

</div>

<div class="stat-number">
128
</div>

<div class="stat-title">
Total Inventory
</div>

<div class="stat-sub">
Items available in your kitchen
</div>

</div>

<div class="stat-card">

<div class="icon-circle orange">

<i class="fa-solid fa-triangle-exclamation"></i>

</div>

<div class="stat-number">
12
</div>

<div class="stat-title">
Low Stock
</div>

<div class="stat-sub">
Need to reorder soon
</div>

</div>

<div class="stat-card">

<div class="icon-circle red">

<i class="fa-solid fa-calendar-days"></i>

</div>

<div class="stat-number">
7
</div>

<div class="stat-title">
Expiring Soon
</div>

<div class="stat-sub">
Expire within 7 days
</div>

</div>

<div class="stat-card">

<div class="icon-circle blue">

<i class="fa-solid fa-truck-fast"></i>

</div>

<div class="stat-number">
5
</div>

<div class="stat-title">
Active Orders
</div>

<div class="stat-sub">
Currently processing
</div>

</div>

</div>

</div>

</div>
<h2 class="section-title">

Quick Actions

</h2>

<div class="quick-actions">

<a href="products.jsp" class="action-card">

<i class="fa-solid fa-cart-shopping"></i>

<h3>Shop Groceries</h3>

<p>
Browse fresh groceries and add products to your cart.
</p>

</a>

<a href="inventory.jsp" class="action-card">

<i class="fa-solid fa-warehouse"></i>

<h3>Inventory</h3>

<p>
Track available items and monitor stock levels.
</p>

</a>

<a href="mealplanner.jsp" class="action-card">

<i class="fa-solid fa-utensils"></i>

<h3>Meal Planner</h3>

<p>
Generate healthy meal plans using your inventory.
</p>

</a>

<a href="recipes.jsp" class="action-card">

<i class="fa-solid fa-book-open"></i>

<h3>Recipes</h3>

<p>
Find delicious recipes based on available ingredients.
</p>

</a>

<a href="cart.jsp" class="action-card">

<i class="fa-solid fa-cart-plus"></i>

<h3>My Cart</h3>

<p>
Review your shopping cart before checkout.
</p>

</a>

<a href="notifications.jsp" class="action-card">

<i class="fa-solid fa-bell"></i>

<h3>Notifications</h3>

<p>
Check expiry alerts, low stock warnings and updates.
</p>

</a>

</div>
<div class="dashboard-grid">

<!-- Expiring Soon -->

<div class="widget">

<h2>⏰ Expiring Soon</h2>

<div class="widget-item">

<div class="item-left">

<div class="item-icon red-bg">
🥛
</div>

<div>

<div class="item-name">Milk</div>

<div class="item-desc">
Expires in 2 days
</div>

</div>

</div>

<span class="badge red">
Urgent
</span>

</div>

<div class="widget-item">

<div class="item-left">

<div class="item-icon orange-bg">
🥚
</div>

<div>

<div class="item-name">Eggs</div>

<div class="item-desc">
Expires in 4 days
</div>

</div>

</div>

<span class="badge orange">
Soon
</span>

</div>

<div class="widget-item">

<div class="item-left">

<div class="item-icon green-bg">
🍎
</div>

<div>

<div class="item-name">Apples</div>

<div class="item-desc">
Expires in 6 days
</div>

</div>

</div>

<span class="badge green">
Fresh
</span>

</div>

</div>

<!-- Meal Recommendations -->

<div class="widget">

<h2>🍽 Recommended Meals</h2>

<div class="widget-item">

<div class="item-left">

<div class="item-icon green-bg">
🥗
</div>

<div>

<div class="item-name">
Healthy Salad
</div>

<div class="item-desc">
Uses lettuce, tomatoes & eggs
</div>

</div>

</div>

</div>

<div class="widget-item">

<div class="item-left">

<div class="item-icon orange-bg">
🍝
</div>

<div>

<div class="item-name">
Pasta Primavera
</div>

<div class="item-desc">
Uses vegetables before expiry
</div>

</div>

</div>

</div>

<div class="widget-item">

<div class="item-left">

<div class="item-icon green-bg">
🍲
</div>

<div>

<div class="item-name">
Chicken Soup
</div>

<div class="item-desc">
High protein dinner
</div>

</div>

</div>

</div>

<div class="widget-item">

<div class="item-left">

<div class="item-icon green-bg">
🥪
</div>

<div>

<div class="item-name">
Sandwich
</div>

<div class="item-desc">
Ready in only 10 minutes
</div>

</div>

</div>

</div>

</div>

</div>
<div class="bottom-grid">

<!-- Recent Orders -->

<div class="table-card">

<h2>🛒 Recent Orders</h2>

<table>

<tr>

<th>Order ID</th>

<th>Date</th>

<th>Total</th>

<th>Status</th>

</tr>

<tr>

<td>#10021</td>

<td>15 Jul</td>

<td>$38.40</td>

<td>

<span class="status delivered">

Delivered

</span>

</td>

</tr>

<tr>

<td>#10022</td>

<td>16 Jul</td>

<td>$52.80</td>

<td>

<span class="status processing">

Processing

</span>

</td>

</tr>

<tr>

<td>#10023</td>

<td>17 Jul</td>

<td>$18.60</td>

<td>

<span class="status cancelled">

Cancelled

</span>

</td>

</tr>

</table>

</div>

<!-- Inventory -->

<div class="progress-card">

<h2>📦 Inventory Overview</h2>

<div class="progress-item">

<div class="progress-title">

<span>Vegetables</span>

<span>82%</span>

</div>

<div class="progress">

<span style="width:82%"></span>

</div>

</div>

<div class="progress-item">

<div class="progress-title">

<span>Dairy</span>

<span>61%</span>

</div>

<div class="progress">

<span style="width:61%"></span>

</div>

</div>

<div class="progress-item">

<div class="progress-title">

<span>Fruits</span>

<span>90%</span>

</div>

<div class="progress">

<span style="width:90%"></span>

</div>

</div>

<div class="progress-item">

<div class="progress-title">

<span>Bakery</span>

<span>45%</span>

</div>

<div class="progress">

<span style="width:45%"></span>

</div>

</div>

</div>

</div>
<!-- HERO BANNER -->

<div class="hero-banner">

<div>

<h2>Eat Healthy. Waste Less. 🌱</h2>

<p>

Smart Grocery helps you manage your inventory,
track expiry dates, receive smart notifications,
and generate healthy meal plans using available ingredients.

</p>

<button>

Explore Features →

</button>

</div>

<div class="hero-icon">

🥗

</div>

</div>

<!-- ANALYTICS -->

<div class="analytics">

<div class="chart-card">

<h2>📈 Weekly Grocery Activity</h2>

<div class="chart-bars">

<div class="bar bar1"></div>

<div class="bar bar2"></div>

<div class="bar bar3"></div>

<div class="bar bar4"></div>

<div class="bar bar5"></div>

<div class="bar bar6"></div>

<div class="bar bar7"></div>

</div>

</div>

<div class="profile-card">

<div class="profile">

<img src="https://i.pravatar.cc/150?img=12">

<h3>

<%=user.getName()%>

</h3>

<p>

Smart Grocery Member

</p>

<button>

Edit Profile

</button>

</div>

</div>

</div>

<!-- FOOTER -->

<div class="footer">

© 2026 Smart Grocery Management System

<br><br>

Manage Smart • Eat Smart • Live Healthy 🌿

</div>
</body>
</html>