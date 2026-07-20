<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<%@page import="model.Order"%>
<%@page import="service.OrderService"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>

<%
User user = (User) session.getAttribute("user");
if (user == null) {
    response.sendRedirect("../login.jsp");
    return;
}
if (!"admin".equals(user.getRole())) {
    response.sendRedirect("../dashboard.jsp");
    return;
}

OrderService orderService = new OrderService();
List<Order> orders = orderService.getAllOrders();

SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy");

String updated = request.getParameter("updated");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Manage Orders | Admin</title>
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

.stats{ display:grid; grid-template-columns:repeat(4,1fr); gap:16px; margin-bottom:26px; }
.stat-card{ background:var(--card); border:1px solid var(--border); border-radius:14px; padding:18px; }
.stat-num{ font-size:22px; font-weight:800; }
.stat-title{ font-size:12px; color:var(--soft); margin-top:3px; }

.panel{ background:var(--card); border:1px solid var(--border); border-radius:16px; overflow:hidden; }
table{ width:100%; border-collapse:collapse; }
th{ background:#141414; color:var(--soft); text-transform:uppercase; font-size:11px; font-weight:700; padding:12px 16px; text-align:left; border-bottom:1px solid var(--border); }
td{ padding:12px 16px; border-bottom:1px solid #202020; font-size:13px; }
tr:hover td{ background:#1e1e1e; }

.badge{ font-size:10.5px; font-weight:700; padding:4px 11px; border-radius:20px; display:inline-block; }
.badge-pending{ background:rgba(245,158,11,.15); color:#f59e0b; }
.badge-processing{ background:rgba(59,130,246,.15); color:#3b82f6; }
.badge-shipped{ background:rgba(168,85,247,.15); color:#a855f7; }
.badge-delivered{ background:rgba(34,197,94,.15); color:var(--green); }
.badge-cancelled{ background:rgba(239,68,68,.15); color:#ef4444; }

.status-form{ display:flex; gap:6px; }
.status-form select{ background:#0f0f0f; border:1px solid var(--border); color:white; border-radius:8px; padding:6px 8px; font-size:12px; font-family:'Inter',sans-serif; }
.status-form button{ background:var(--green); border:none; color:white; border-radius:8px; padding:6px 12px; font-size:12px; font-weight:700; cursor:pointer; }
.status-form button:hover{ background:var(--greenDark); }
.empty-row{ text-align:center; padding:34px; color:var(--soft); }
</style>
</head>
<body>

<div class="sidebar">
<a href="../dashboard.jsp" class="logo"><i class="fa-solid fa-shield-halved"></i><span>Admin Panel</span></a>
<div class="logo-sub">Smart Grocery</div>
<ul class="menu">
<li><a href="manageProducts.jsp"><i class="fa-solid fa-box"></i> Products</a></li>
<li><a href="manageCategories.jsp"><i class="fa-solid fa-tags"></i> Categories</a></li>
<li><a class="active" href="manageOrders.jsp"><i class="fa-solid fa-receipt"></i> Orders</a></li>
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
<h1>🧾 Manage Orders</h1>
<p><%= orders.size() %> total orders</p>
</div>

<% if ("1".equals(updated)) { %><div class="banner banner-ok"><i class="fa-solid fa-circle-check"></i> Order status updated.</div><% } %>

<%
int pendingCount=0, processingCount=0, shippedCount=0, deliveredCount=0;
for (Order o : orders) {
    String s = o.getStatus() == null ? "" : o.getStatus().toUpperCase();
    if (s.equals("PENDING")) pendingCount++;
    else if (s.equals("PROCESSING")) processingCount++;
    else if (s.equals("SHIPPED")) shippedCount++;
    else if (s.equals("DELIVERED")) deliveredCount++;
}
%>

<div class="stats">
<div class="stat-card"><div class="stat-num"><%= pendingCount %></div><div class="stat-title">Pending</div></div>
<div class="stat-card"><div class="stat-num"><%= processingCount %></div><div class="stat-title">Processing</div></div>
<div class="stat-card"><div class="stat-num"><%= shippedCount %></div><div class="stat-title">Shipped</div></div>
<div class="stat-card"><div class="stat-num"><%= deliveredCount %></div><div class="stat-title">Delivered</div></div>
</div>

<div class="panel">
<table>
<thead>
<tr>
<th>Order ID</th>
<th>User ID</th>
<th>Date</th>
<th>Total</th>
<th>Status</th>
<th>Update Status</th>
</tr>
</thead>
<tbody>
<%
if (orders.isEmpty()) {
%>
<tr><td colspan="6" class="empty-row">No orders placed yet.</td></tr>
<%
} else {
    for (Order o : orders) {
        String s = o.getStatus() == null ? "PENDING" : o.getStatus().toUpperCase();
        String badgeClass;
        switch (s) {
            case "PROCESSING": badgeClass = "badge-processing"; break;
            case "SHIPPED":    badgeClass = "badge-shipped"; break;
            case "DELIVERED":  badgeClass = "badge-delivered"; break;
            case "CANCELLED":  badgeClass = "badge-cancelled"; break;
            default:           badgeClass = "badge-pending";
        }
%>
<tr>
<td>#<%= o.getOrderId() %></td>
<td>#<%= o.getUserId() %></td>
<td><%= o.getOrderDate() != null ? sdf.format(o.getOrderDate()) : "—" %></td>
<td style="font-weight:700;">Rs. <%= String.format("%.2f", o.getTotalAmount()) %></td>
<td><span class="badge <%= badgeClass %>"><%= s %></span></td>
<td>
<form class="status-form" action="../OrderServlet" method="get">
<input type="hidden" name="action" value="updateStatus">
<input type="hidden" name="orderId" value="<%= o.getOrderId() %>">
<select name="status">
<option value="PENDING" <%= s.equals("PENDING") ? "selected" : "" %>>Pending</option>
<option value="PROCESSING" <%= s.equals("PROCESSING") ? "selected" : "" %>>Processing</option>
<option value="SHIPPED" <%= s.equals("SHIPPED") ? "selected" : "" %>>Shipped</option>
<option value="DELIVERED" <%= s.equals("DELIVERED") ? "selected" : "" %>>Delivered</option>
<option value="CANCELLED" <%= s.equals("CANCELLED") ? "selected" : "" %>>Cancelled</option>
</select>
<button type="submit">Update</button>
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

</body>
</html>
