<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<%@page import="model.Category"%>
<%@page import="service.CategoryService"%>
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

CategoryService categoryService = new CategoryService();
List<Category> categories = categoryService.getAllCategories();

String success = request.getParameter("success");
String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Manage Categories | Admin</title>
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
.page-header{ margin-bottom:26px; }
.page-header h1{ font-size:26px; font-weight:800; }
.page-header p{ color:var(--soft); font-size:13.5px; margin-top:4px; }

.banner{ padding:12px 18px; border-radius:12px; margin-bottom:20px; font-size:13.5px; font-weight:600; }
.banner-ok{ background:rgba(34,197,94,.12); border:1px solid rgba(34,197,94,.35); color:var(--green); }
.banner-err{ background:rgba(239,68,68,.12); border:1px solid rgba(239,68,68,.35); color:#ef4444; }

.layout{ display:grid; grid-template-columns:340px 1fr; gap:24px; align-items:start; }

.form-panel{ background:var(--card); border:1px solid var(--border); border-radius:16px; padding:24px; position:sticky; top:24px; }
.form-panel h3{ font-size:15px; margin-bottom:18px; display:flex; align-items:center; gap:8px; }
.form-group{ margin-bottom:14px; }
.form-group label{ display:block; font-size:12px; font-weight:600; color:var(--soft); margin-bottom:6px; }
.form-group input, .form-group textarea{ width:100%; padding:10px 12px; background:#0f0f0f; border:1px solid var(--border); border-radius:9px; color:white; font-size:13.5px; font-family:'Inter',sans-serif; outline:none; resize:vertical; }
.form-group input:focus, .form-group textarea:focus{ border-color:var(--green); }
.btn-submit{ width:100%; background:var(--green); color:white; border:none; padding:12px; border-radius:10px; font-weight:700; font-size:14px; cursor:pointer; margin-top:6px; }
.btn-submit:hover{ background:var(--greenDark); }

.panel{ background:var(--card); border:1px solid var(--border); border-radius:16px; overflow:hidden; }
table{ width:100%; border-collapse:collapse; }
th{ background:#141414; color:var(--soft); text-transform:uppercase; font-size:11px; font-weight:700; padding:12px 16px; text-align:left; border-bottom:1px solid var(--border); }
td{ padding:12px 16px; border-bottom:1px solid #202020; font-size:13px; }
tr:hover td{ background:#1e1e1e; }
.delete-form{ display:inline; }
.action-link{ color:#ef4444; font-size:12px; font-weight:700; text-decoration:none; background:none; border:none; cursor:pointer; font-family:'Inter',sans-serif; }
.action-link:hover{ text-decoration:underline; }
.empty-row{ text-align:center; padding:34px; color:var(--soft); }

@media(max-width:1000px){ .layout{ grid-template-columns:1fr; } }
</style>
</head>
<body>

<div class="sidebar">
<a href="../dashboard.jsp" class="logo"><i class="fa-solid fa-shield-halved"></i><span>Admin Panel</span></a>
<div class="logo-sub">Smart Grocery</div>
<ul class="menu">
<li><a href="manageProducts.jsp"><i class="fa-solid fa-box"></i> Products</a></li>
<li><a class="active" href="manageCategories.jsp"><i class="fa-solid fa-tags"></i> Categories</a></li>
<li><a href="manageOrders.jsp"><i class="fa-solid fa-receipt"></i> Orders</a></li>
<li><a href="manageUsers.jsp"><i class="fa-solid fa-users"></i> Users</a></li>
</ul>
<div class="side-label">Account</div>
<ul class="menu">
<li><a href="../LogoutServlet"><i class="fa-solid fa-right-from-bracket"></i> Logout</a></li>
</ul>
<a href="../dashboard.jsp" class="back-link"><i class="fa-solid fa-arrow-left"></i> Back to Site</a>
</div>

<div class="main">

<div class="page-header">
<h1>🏷️ Manage Categories</h1>
<p><%= categories.size() %> categories</p>
</div>

<% if ("1".equals(success)) { %><div class="banner banner-ok"><i class="fa-solid fa-circle-check"></i> Category added successfully.</div><% } %>
<% if ("1".equals(error)) { %><div class="banner banner-err"><i class="fa-solid fa-circle-exclamation"></i> Failed to add category.</div><% } %>

<div class="layout">

<!-- Add Category Form -->
<div class="form-panel">
<h3><i class="fa-solid fa-plus" style="color:var(--green);"></i> Add New Category</h3>
<form action="../CategoryServlet" method="post">
<input type="hidden" name="action" value="add">
<div class="form-group">
<label>Category Name</label>
<input type="text" name="name" placeholder="e.g. Dairy" required>
</div>
<div class="form-group">
<label>Description</label>
<textarea name="description" rows="3" placeholder="Short description"></textarea>
</div>
<button type="submit" class="btn-submit">Add Category</button>
</form>
</div>

<!-- Category List -->
<div class="panel">
<table>
<thead>
<tr>
<th>ID</th>
<th>Name</th>
<th>Description</th>
<th></th>
</tr>
</thead>
<tbody>
<%
if (categories.isEmpty()) {
%>
<tr><td colspan="4" class="empty-row">No categories yet. Add your first category using the form.</td></tr>
<%
} else {
    for (Category c : categories) {
%>
<tr>
<td>#<%= c.getCategoryId() %></td>
<td style="font-weight:600;"><%= c.getName() %></td>
<td style="color:var(--soft);"><%= c.getDescription() %></td>
<td>
<form class="delete-form" action="../CategoryServlet" method="post" onsubmit="return confirm('Delete this category?')">
<input type="hidden" name="action" value="delete">
<input type="hidden" name="id" value="<%= c.getCategoryId() %>">
<button type="submit" class="action-link"><i class="fa-solid fa-trash"></i> Delete</button>
</form>
</td>
</tr>
<%
    }
}
%>
</tbody>
</table>
</div>

</div>
</div>

</body>
</html>
