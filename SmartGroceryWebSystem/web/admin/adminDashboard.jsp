<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<%@page import="model.Product"%>
<%@page import="model.Category"%>
<%@page import="model.Order"%>
<%@page import="service.ProductService"%>
<%@page import="service.CategoryService"%>
<%@page import="service.OrderService"%>
<%@page import="service.AuthService"%>
<%@page import="java.util.List"%>

<%
User user = (User) session.getAttribute("user");
if (user == null) {
    response.sendRedirect("../login.jsp");
    return;
}
if (!"admin".equalsIgnoreCase(user.getRole())) {
    response.sendRedirect("../dashboard.jsp");
    return;
}

ProductService productService = new ProductService();
CategoryService categoryService = new CategoryService();
OrderService orderService = new OrderService();
AuthService authService = new AuthService();

List<Product> products = productService.getAllProducts();
List<Category> categories = categoryService.getAllCategories();
List<Order> orders = orderService.getAllOrders();
List<User> users = authService.getAllUsers();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Panel | Smart Grocery</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
<style>
*{ margin:0; padding:0; box-sizing:border-box; font-family:'Inter',sans-serif; }
:root{ --green:#22c55e; --greenDark:#16a34a; --card:#181818; --border:#2b2b2b; --soft:#9ca3af; }
body{ background:#0b0b0b; color:white; }
a{ color:inherit; }

.sidebar{ position:fixed; left:0; top:0; width:250px; height:100vh; background:#111; border-right:1px solid #222; padding:25px; display:flex; flex-direction:column; overflow-y:auto; }
.logo{ display:flex; align-items:center; gap:12px; font-size:20px; font-weight:800; margin-bottom:4px; text-decoration:none; }
.logo i{ color:var(--green); background:rgba(34,197,94,.15); width:38px; height:38px; border-radius:10px; display:flex; align-items:center; justify-content:center; }
.logo-sub{ font-size:11px; color:var(--soft); margin-bottom:30px; margin-left:50px; }
.menu{ list-style:none; }
.menu li{ margin-bottom:6px; }
.menu a{ display:flex; align-items:center; gap:13px; padding:11px 14px; text-decoration:none; color:#cbd5e1; border-radius:10px; font-size:14px; font-weight:500; }
.menu a:hover{ background:#1c1c1c; color:white; }
.menu a.active{ background:var(--green); color:white; }
.side-label{ font-size:11px; letter-spacing:.08em; color:#666; text-transform:uppercase; margin:20px 0 8px 14px; font-weight:700; }
.back-link{ margin-top:auto; padding:12px 14px; border-radius:10px; color:var(--soft); text-decoration:none; font-size:13px; display:flex; align-items:center; gap:10px; border:1px solid var(--border); }
.back-link:hover{ color:white; border-color:var(--green); }

.main{ margin-left:250px; padding:36px 40px; }
.page-header{ margin-bottom:28px; }
.page-header h1{ font-size:26px; font-weight:800; }
.page-header p{ color:var(--soft); font-size:13.5px; margin-top:4px; }

.stats-grid{ display:grid; grid-template-columns:repeat(4,1fr); gap:18px; margin-bottom:32px; }
.stat-card{ background:var(--card); border:1px solid var(--border); border-radius:16px; padding:22px; }
.stat-card i{ width:42px; height:42px; border-radius:12px; background:rgba(34,197,94,.15); color:var(--green); display:flex; align-items:center; justify-content:center; font-size:18px; margin-bottom:14px; }
.stat-card b{ display:block; font-size:26px; font-weight:800; }
.stat-card span{ color:var(--soft); font-size:12.5px; }

.section-label{ font-size:12px; letter-spacing:.06em; color:#666; text-transform:uppercase; font-weight:700; margin-bottom:14px; }
.links-grid{ display:grid; grid-template-columns:repeat(4,1fr); gap:18px; }
.link-card{ background:var(--card); border:1px solid var(--border); border-radius:16px; padding:24px; text-decoration:none; color:white; transition:.2s; display:block; }
.link-card:hover{ border-color:var(--green); background:#1c1c1c; }
.link-card i{ font-size:22px; color:var(--green); margin-bottom:14px; display:block; }
.link-card b{ display:block; font-size:15px; margin-bottom:4px; }
.link-card span{ color:var(--soft); font-size:12.5px; }

@media(max-width:1000px){ .stats-grid, .links-grid{ grid-template-columns:1fr 1fr; } }
</style>
</head>
<body>

<div class="sidebar">
<a href="../dashboard.jsp" class="logo"><i class="fa-solid fa-shield-halved"></i><span>Admin Panel</span></a>
<div class="logo-sub">Smart Grocery</div>
<ul class="menu">
<li><a class="active" href="adminDashboard.jsp"><i class="fa-solid fa-gauge"></i> Dashboard</a></li>
<li><a href="manageProducts.jsp"><i class="fa-solid fa-box"></i> Products</a></li>
<li><a href="manageCategories.jsp"><i class="fa-solid fa-tags"></i> Categories</a></li>
<li><a href="manageOrders.jsp"><i class="fa-solid fa-receipt"></i> Orders</a></li>
<li><a href="manageUsers.jsp"><i class="fa-solid fa-users"></i> Users</a></li>
<li><a href="manageRecipes.jsp"><i class="fa-solid fa-book-open"></i> Recipes</a></li>
</ul>
<div class="side-label">Account</div>
<ul class="menu">
<li><a href="../LogoutServlet"><i class="fa-solid fa-right-from-bracket"></i> Logout</a></li>
</ul>
<a href="../dashboard.jsp" class="back-link"><i class="fa-solid fa-arrow-left"></i> Back to Site</a>
</div>

<div class="main">

<div class="page-header">
<h1>Welcome, <%= user.getName() %> 👋</h1>
<p>Here's an overview of your Smart Grocery store.</p>
</div>

<div class="stats-grid">
<div class="stat-card"><i class="fa-solid fa-box"></i><b><%= products.size() %></b><span>Products</span></div>
<div class="stat-card"><i class="fa-solid fa-tags"></i><b><%= categories.size() %></b><span>Categories</span></div>
<div class="stat-card"><i class="fa-solid fa-receipt"></i><b><%= orders.size() %></b><span>Orders</span></div>
<div class="stat-card"><i class="fa-solid fa-users"></i><b><%= users.size() %></b><span>Registered Users</span></div>
</div>

<div class="section-label">Quick Access</div>
<div class="links-grid">
<a href="manageProducts.jsp" class="link-card"><i class="fa-solid fa-box"></i><b>Manage Products</b><span>Add, edit or remove products</span></a>
<a href="manageCategories.jsp" class="link-card"><i class="fa-solid fa-tags"></i><b>Manage Categories</b><span>Organize product categories</span></a>
<a href="manageOrders.jsp" class="link-card"><i class="fa-solid fa-receipt"></i><b>Manage Orders</b><span>Track and update orders</span></a>
<a href="manageUsers.jsp" class="link-card"><i class="fa-solid fa-users"></i><b>Manage Users</b><span>View and manage accounts</span></a>
<a href="manageRecipes.jsp" class="link-card"><i class="fa-solid fa-book-open"></i><b>Manage Recipes</b><span>Add or remove recipes</span></a>
</div>

</div>

</body>
</html>
