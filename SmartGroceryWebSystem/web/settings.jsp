<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>

<%
User user = (User) session.getAttribute("user");
if (user == null) {
    response.sendRedirect("login.jsp");
    return;
}

String success = request.getParameter("success");
String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Settings | Smart Grocery</title>

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
button, input{ font-family:'Inter',sans-serif; }

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
.profile-chip{ display:flex; align-items:center; gap:10px; padding:6px 12px 6px 6px; background:#1b1b1b; border:1px solid #2b2b2b; border-radius:30px; cursor:pointer; text-decoration:none; }
.avatar{ width:34px; height:34px; background:var(--green); border-radius:50%; display:flex; justify-content:center; align-items:center; font-weight:bold; font-size:14px; overflow:hidden; }
.avatar img{ width:100%; height:100%; object-fit:cover; }
.profile-chip span{ font-size:14px; font-weight:600; color:white; }
.content{ padding:40px; max-width:960px; }

/* PAGE HEADER */
.page-header{ margin-bottom:28px; }
.page-header h1{ font-size:28px; font-weight:800; }
.page-header p{ color:var(--soft); font-size:14px; margin-top:4px; }

.alert{ padding:14px 18px; border-radius:12px; margin-bottom:22px; font-size:14px; font-weight:600; display:flex; align-items:center; gap:10px; }
.alert-success{ background:rgba(34,197,94,.12); border:1px solid rgba(34,197,94,.35); color:var(--green); }
.alert-error{ background:rgba(239,68,68,.12); border:1px solid rgba(239,68,68,.35); color:#ef4444; }

/* PANEL */
.panel{ background:var(--card); border:1px solid var(--border); border-radius:18px; padding:28px; margin-bottom:26px; }
.panel h3{ font-size:17px; font-weight:700; margin-bottom:6px; display:flex; align-items:center; gap:10px; }
.panel .sub{ color:var(--soft); font-size:13px; margin-bottom:22px; }

.form-grid{ display:grid; grid-template-columns:1fr; gap:20px; margin-bottom:24px; max-width:420px; }
.form-group{ display:flex; flex-direction:column; gap:8px; }
.form-group label{ font-size:12.5px; font-weight:700; color:var(--soft); text-transform:uppercase; letter-spacing:.03em; }
.form-group input{ background:#111; border:1px solid var(--border); border-radius:10px; padding:13px 16px; color:white; font-size:14px; outline:none; }
.form-group input:focus{ border-color:var(--green); }

.btn-primary{ background:var(--green); color:white; border:none; padding:13px 26px; border-radius:12px; font-weight:700; cursor:pointer; font-size:14px; display:inline-flex; align-items:center; gap:10px; }
.btn-primary:hover{ background:var(--greenDark); }

/* PREFERENCE ROWS */
.pref-row{ display:flex; justify-content:space-between; align-items:center; padding:16px 0; border-bottom:1px solid var(--border); }
.pref-row:last-child{ border-bottom:none; }
.pref-row div b{ display:block; font-size:14px; margin-bottom:3px; }
.pref-row div span{ color:var(--soft); font-size:12.5px; }

.switch{ position:relative; width:46px; height:26px; }
.switch input{ opacity:0; width:0; height:0; }
.slider{ position:absolute; cursor:pointer; inset:0; background:#333; border-radius:30px; transition:.2s; }
.slider:before{ content:""; position:absolute; height:20px; width:20px; left:3px; top:3px; background:white; border-radius:50%; transition:.2s; }
.switch input:checked + .slider{ background:var(--green); }
.switch input:checked + .slider:before{ transform:translateX(20px); }

/* DANGER ZONE */
.danger-zone{ border:1px solid rgba(239,68,68,.35); }
.danger-zone h3{ color:#ef4444; }
.btn-danger{ background:transparent; border:1px solid #ef4444; color:#ef4444; padding:13px 26px; border-radius:12px; font-weight:700; cursor:pointer; font-size:14px; display:inline-flex; align-items:center; gap:10px; text-decoration:none; }
.btn-danger:hover{ background:#ef4444; color:white; }

.footer{ margin-top:45px; padding:25px; text-align:center; color:#888; border-top:1px solid #222; font-size:13px; }

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
<li><a href="notifications.jsp"><i class="fa-solid fa-bell"></i> Expiry Alerts</a></li>
<li><a href="lowstock.jsp"><i class="fa-solid fa-triangle-exclamation"></i> Low Stock</a></li>
</ul>

<div class="side-label">Account</div>
<ul class="menu">
<li><a href="profile.jsp"><i class="fa-solid fa-user"></i> Profile</a></li>
<li><a class="active" href="settings.jsp"><i class="fa-solid fa-gear"></i> Settings</a></li>
<% if ("admin".equalsIgnoreCase(user.getRole())) { %>
<li><a href="admin/adminDashboard.jsp"><i class="fa-solid fa-shield-halved"></i> Admin Panel</a></li>
<% } %>
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
<h1>Settings</h1>
<p>Manage your password, notification preferences and account.</p>
</div>

<% if ("1".equals(success)) { %>
<div class="alert alert-success"><i class="fa-solid fa-circle-check"></i> Password updated successfully.</div>
<% } %>
<% if ("mismatch".equals(error)) { %>
<div class="alert alert-error"><i class="fa-solid fa-circle-exclamation"></i> New password and confirmation do not match.</div>
<% } %>
<% if ("wrongpass".equals(error)) { %>
<div class="alert alert-error"><i class="fa-solid fa-circle-exclamation"></i> Current password is incorrect.</div>
<% } %>

<!-- CHANGE PASSWORD -->
<div class="panel">
<h3><i class="fa-solid fa-key" style="color:var(--green);"></i> Change Password</h3>
<div class="sub">Use a strong password you don't use anywhere else.</div>

<form action="ProfileServlet" method="post">
<input type="hidden" name="action" value="changePassword">
<div class="form-grid">

<div class="form-group">
<label>Current Password</label>
<input type="password" name="currentPassword" required>
</div>

<div class="form-group">
<label>New Password</label>
<input type="password" name="newPassword" required minlength="6">
</div>

<div class="form-group">
<label>Confirm New Password</label>
<input type="password" name="confirmPassword" required minlength="6">
</div>

</div>
<button type="submit" class="btn-primary"><i class="fa-solid fa-floppy-disk"></i> Update Password</button>
</form>
</div>

<!-- NOTIFICATION PREFERENCES -->
<div class="panel">
<h3><i class="fa-solid fa-bell" style="color:var(--green);"></i> Notification Preferences</h3>
<div class="sub">Choose which alerts you want to receive.</div>

<div class="pref-row">
<div><b>Expiry Alerts</b><span>Get notified when items are about to expire.</span></div>
<label class="switch"><input type="checkbox" id="pref-expiry" data-pref="expiry" checked><span class="slider"></span></label>
</div>

<div class="pref-row">
<div><b>Low Stock Alerts</b><span>Get notified when inventory runs low.</span></div>
<label class="switch"><input type="checkbox" id="pref-lowstock" data-pref="lowstock" checked><span class="slider"></span></label>
</div>

<div class="pref-row">
<div><b>Meal Planner Reminders</b><span>Daily reminders to plan your meals.</span></div>
<label class="switch"><input type="checkbox" id="pref-mealplanner" data-pref="mealplanner"><span class="slider"></span></label>
</div>

<div id="pref-saved-msg" style="display:none; margin-top:14px; font-size:12.5px; color:var(--green); font-weight:600;">
<i class="fa-solid fa-circle-check"></i> Preference saved.
</div>

</div>

<!-- ACCOUNT -->
<div class="panel danger-zone">
<h3><i class="fa-solid fa-triangle-exclamation"></i> Account</h3>
<div class="sub">Sign out of Smart Grocery on this device.</div>
<% if ("admin".equalsIgnoreCase(user.getRole())) { %>
<a href="admin/adminDashboard.jsp" class="btn-primary" style="margin-right:12px; text-decoration:none;"><i class="fa-solid fa-shield-halved"></i> Go to Admin Panel</a>
<% } %>
<a href="LogoutServlet" class="btn-danger"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
</div>

</div>

<div class="footer">
© 2026 Smart Grocery Management System
</div>

</div>

<script>
(function(){
  var prefKeys = ['expiry','lowstock','mealplanner'];
  var storageKey = 'sg_notif_prefs';

  function loadPrefs(){
    try{
      var saved = JSON.parse(localStorage.getItem(storageKey));
      if(saved){
        prefKeys.forEach(function(k){
          if(typeof saved[k] === 'boolean'){
            document.getElementById('pref-' + k).checked = saved[k];
          }
        });
      }
    }catch(e){ /* ignore corrupt storage */ }
  }

  function savePrefs(){
    var data = {};
    prefKeys.forEach(function(k){
      data[k] = document.getElementById('pref-' + k).checked;
    });
    localStorage.setItem(storageKey, JSON.stringify(data));

    var msg = document.getElementById('pref-saved-msg');
    msg.style.display = 'block';
    clearTimeout(msg._hideTimer);
    msg._hideTimer = setTimeout(function(){ msg.style.display = 'none'; }, 1800);
  }

  loadPrefs();

  prefKeys.forEach(function(k){
    document.getElementById('pref-' + k).addEventListener('change', savePrefs);
  });
})();
</script>

</body>
</html>
