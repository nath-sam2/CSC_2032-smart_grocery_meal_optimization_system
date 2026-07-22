<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
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

AuthService authService = new AuthService();
List<User> users = authService.getAllUsers();

String updated = request.getParameter("updated");
String deleted = request.getParameter("deleted");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Manage Users | Admin</title>
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

.panel{ background:var(--card); border:1px solid var(--border); border-radius:16px; overflow:hidden; }
table{ width:100%; border-collapse:collapse; }
th{ background:#141414; color:var(--soft); text-transform:uppercase; font-size:11px; font-weight:700; padding:12px 16px; text-align:left; border-bottom:1px solid var(--border); }
td{ padding:12px 16px; border-bottom:1px solid #202020; font-size:13px; }
tr:hover td{ background:#1e1e1e; }

.user-cell{ display:flex; align-items:center; gap:10px; }
.avatar{ width:32px; height:32px; border-radius:50%; background:var(--green); display:flex; align-items:center; justify-content:center; font-weight:700; font-size:13px; flex-shrink:0; }

.role-form{ display:flex; gap:6px; }
.role-form select{ background:#0f0f0f; border:1px solid var(--border); color:white; border-radius:8px; padding:6px 8px; font-size:12px; font-family:'Inter',sans-serif; }
.role-form button{ background:var(--green); border:none; color:white; border-radius:8px; padding:6px 12px; font-size:12px; font-weight:700; cursor:pointer; }
.role-form button:hover{ background:var(--greenDark); }

.badge{ font-size:10.5px; font-weight:700; padding:4px 11px; border-radius:20px; }
.badge-admin{ background:rgba(168,85,247,.15); color:#a855f7; }
.badge-user{ background:rgba(34,197,94,.15); color:var(--green); }

.action-link{ color:#ef4444; font-size:12px; font-weight:700; text-decoration:none; }
.action-link:hover{ text-decoration:underline; }
.self-tag{ color:var(--soft); font-size:11.5px; font-style:italic; }
.empty-row{ text-align:center; padding:34px; color:var(--soft); }
</style>
</head>
<body>

<div class="sidebar">
<a href="../dashboard.jsp" class="logo"><i class="fa-solid fa-shield-halved"></i><span>Admin Panel</span></a>
<div class="logo-sub">Smart Grocery</div>
<ul class="menu">
<li><a href="adminDashboard.jsp"><i class="fa-solid fa-gauge"></i> Dashboard</a></li>
<li><a href="manageProducts.jsp"><i class="fa-solid fa-box"></i> Products</a></li>
<li><a href="manageCategories.jsp"><i class="fa-solid fa-tags"></i> Categories</a></li>
<li><a href="manageOrders.jsp"><i class="fa-solid fa-receipt"></i> Orders</a></li>
<li><a class="active" href="manageUsers.jsp"><i class="fa-solid fa-users"></i> Users</a></li>
</ul>
<div class="side-label">Account</div>
<ul class="menu">
<li><a href="../LogoutServlet"><i class="fa-solid fa-right-from-bracket"></i> Logout</a></li>
</ul>
<a href="../dashboard.jsp" class="back-link"><i class="fa-solid fa-arrow-left"></i> Back to Site</a>
</div>

<div class="main">

<div class="page-header">
<h1>👥 Manage Users</h1>
<p><%= users.size() %> registered accounts</p>
</div>

<% if ("1".equals(updated)) { %><div class="banner banner-ok"><i class="fa-solid fa-circle-check"></i> User role updated.</div><% } %>
<% if ("1".equals(deleted)) { %><div class="banner banner-ok"><i class="fa-solid fa-circle-check"></i> User account deleted.</div><% } %>

<div class="panel">
<table>
<thead>
<tr>
<th>User</th>
<th>Email</th>
<th>Role</th>
<th>Change Role</th>
<th></th>
</tr>
</thead>
<tbody>
<%
if (users.isEmpty()) {
%>
<tr><td colspan="5" class="empty-row">No registered users yet.</td></tr>
<%
} else {
    for (User u : users) {
        boolean isAdmin = "admin".equalsIgnoreCase(u.getRole());
        boolean isSelf = u.getUserId() == user.getUserId();
%>
<tr>
<td>
<div class="user-cell">
<div class="avatar"><%= u.getName().substring(0,1).toUpperCase() %></div>
<span style="font-weight:600;"><%= u.getName() %></span>
</div>
</td>
<td style="color:var(--soft);"><%= u.getEmail() %></td>
<td><span class="badge <%= isAdmin ? "badge-admin" : "badge-user" %>"><%= u.getRole() %></span></td>
<td>
<form class="role-form" action="../UserManageServlet" method="get">
<input type="hidden" name="action" value="updateRole">
<input type="hidden" name="userId" value="<%= u.getUserId() %>">
<select name="role">
<option value="user" <%= !isAdmin ? "selected" : "" %>>User</option>
<option value="admin" <%= isAdmin ? "selected" : "" %>>Admin</option>
</select>
<button type="submit">Save</button>
</form>
</td>
<td>
<% if (isSelf) { %>
<span class="self-tag">This is you</span>
<% } else { %>
<a href="../UserManageServlet?action=delete&userId=<%= u.getUserId() %>" class="action-link" onclick="return confirm('Delete this user account?')"><i class="fa-solid fa-trash"></i> Delete</a>
<% } %>
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

</body>
</html>
