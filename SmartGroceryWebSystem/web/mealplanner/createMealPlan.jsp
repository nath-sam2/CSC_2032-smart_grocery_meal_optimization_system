<%-- 
    Document   : createMealPlan
    Created on : Jul 13, 2026, 3:52:45 PM
    Author     : perer
--%>
<%@ page import="model.User" %>
<%@ page import="model.CartItem" %>
<%@ page import="model.NotificationService" %>
<%@ page import="service.CartService" %>
<%@ page import="dao.NotificationDAO" %>
<%@ page import="java.util.List" %>

<%
User navUser = (User) session.getAttribute("user");

int cartCount = 0;
int notifCount = 0;

if (navUser != null) {
    try {
        List<CartItem> navCartItems = new CartService().getCartItems(navUser.getUserId());
        cartCount = navCartItems.size();
    } catch (Exception e) { /* best-effort only */ }

    try {
        List<NotificationService> navUnread = new NotificationDAO().getUnreadNotifications();
        notifCount = navUnread.size();
    } catch (Exception e) { /* best-effort only */ }
}

String navCtx = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Smart Grocery - Healthy Meal Optimization</title>

<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
<link rel="stylesheet" href="<%=navCtx%>/css/style.css">
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">

    <a href="<%=navCtx%>/dashboard.jsp" class="logo">
        <i class="fa-solid fa-cart-shopping"></i>
        <span>Smart Grocery</span>
    </a>
    <div class="logo-sub">Manage Smart, Eat Smart</div>

    <ul class="menu">
        <li><a href="<%=navCtx%>/dashboard.jsp"><i class="fa-solid fa-house"></i> Dashboard
        </a></li>
        <li><a href="<%=navCtx%>/products.jsp"><i class="fa-solid fa-cart-shopping"></i> Shop Groceries
        </a></li>
        <li><a href="<%=navCtx%>/inventory.jsp"><i class="fa-solid fa-warehouse"></i> My Inventory
        </a></li>
        <li><a class="active" href="<%=navCtx%>/MealDashboardController"><i class="fa-solid fa-utensils"></i> Meal Planner
        </a></li>
        <li><a href="<%=navCtx%>/cart.jsp"><i class="fa-solid fa-list-check"></i> Shopping List
            <% if (cartCount > 0) { %><span class="menu-count"><%= cartCount %></span><% } %>
        </a></li>
        <li><a href="<%=navCtx%>/RecipeController"><i class="fa-solid fa-book-open"></i> Recipes
        </a></li>
        <li><a href="<%=navCtx%>/notifications.jsp"><i class="fa-solid fa-bell"></i> Expiry Alerts
            <% if (notifCount > 0) { %><span class="menu-count"><%= notifCount %></span><% } %>
        </a></li>
        <li><a href="<%=navCtx%>/lowstock.jsp"><i class="fa-solid fa-triangle-exclamation"></i> Low Stock
        </a></li>
    </ul>

    <div class="side-label">Meal Optimization</div>

    <ul class="menu">
        <li><a href="<%=navCtx%>/RecommendationController"><i class="fa-solid fa-wand-magic-sparkles"></i> Recommendations</a></li>
        <li><a href="<%=navCtx%>/ShoppingListController"><i class="fa-solid fa-basket-shopping"></i> Meal Shopping List</a></li>
        <li><a href="<%=navCtx%>/UserDietaryRestrictionController"><i class="fa-solid fa-leaf"></i> Dietary Restrictions</a></li>
        <li><a href="<%=navCtx%>/FoodWasteController"><i class="fa-solid fa-recycle"></i> Food Waste</a></li>
    </ul>

    <div class="side-label">Account</div>

    <ul class="menu">
        <li><a href="<%=navCtx%>/profile.jsp"><i class="fa-solid fa-user"></i> Profile</a></li>
        <li><a href="<%=navCtx%>/settings.jsp"><i class="fa-solid fa-gear"></i> Settings</a></li>
        <li><a href="<%=navCtx%>/LogoutServlet"><i class="fa-solid fa-right-from-bracket"></i> Logout</a></li>
    </ul>

</div>

<!-- Main -->
<div class="main">

    <div class="topbar">

        <form class="search" action="<%=navCtx%>/products.jsp" method="get">
            <i class="fa-solid fa-magnifying-glass"></i>
            <input type="text" name="search" placeholder="Search products, recipes...">
            <button type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
        </form>

        <div class="user">
            <a href="<%=navCtx%>/cart.jsp" class="icon-btn">
                <i class="fa-solid fa-cart-shopping"></i>
                <% if (cartCount > 0) { %><span class="dot"><%= cartCount %></span><% } %>
            </a>
            <a href="<%=navCtx%>/notifications.jsp" class="icon-btn">
                <i class="fa-regular fa-bell"></i>
                <% if (notifCount > 0) { %><span class="dot"><%= notifCount %></span><% } %>
            </a>

            <% if (navUser != null) { %>
                <a href="<%=navCtx%>/profile.jsp" class="profile-chip">
                    <div class="avatar">
                        <% if (navUser.hasProfilePhoto()) { %>
                            <img src="<%= navUser.getProfilePhoto() %>" alt="Profile photo">
                        <% } else { %>
                            <%= navUser.getName().substring(0,1).toUpperCase() %>
                        <% } %>
                    </div>
                    <span><%= navUser.getName() %></span>
                    <i class="fa-solid fa-chevron-down" style="font-size:11px;color:#888;"></i>
                </a>
            <% } else { %>
                <a href="<%=navCtx%>/login.jsp" class="profile-chip">
                    <div class="avatar"><i class="fa-solid fa-user"></i></div>
                    <span>Sign In</span>
                </a>
            <% } %>
        </div>

    </div>

    <div class="content">

        <div class="subnav">
            <a class="active" href="<%=navCtx%>/MealDashboardController">Meal Dashboard</a>
            <a class="" href="<%=navCtx%>/RecipeController">Recipes</a>
            <a class="" href="<%=navCtx%>/RecommendationController">Recommendations</a>
            <a class="" href="<%=navCtx%>/ShoppingListController">Shopping List</a>
            <a class="" href="<%=navCtx%>/UserDietaryRestrictionController">Dietary Restrictions</a>
            <a class="" href="<%=navCtx%>/FoodWasteController">Food Waste</a>
        </div>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>

<%
    List<String> formErrors = (List<String>) request.getAttribute("formErrors");
    String submittedPlanName = (String) request.getAttribute("planName");
    String submittedStartDate = (String) request.getAttribute("startDate");
    String submittedEndDate = (String) request.getAttribute("endDate");
%>

<div class="page-container">

    <h2>Create Healthy Meal Plan</h2>

    <% if (formErrors != null && !formErrors.isEmpty()) { %>
    <div class="alert alert-error" style="margin-bottom: 10px;">
        <ul style="margin: 0; padding-left: 20px;">
            <% for (String err : formErrors) { %>
            <li><%= err %></li>
            <% } %>
        </ul>
    </div>
    <% } %>

    <div class="card">
        <h3>Option 1: Auto-Generate Weekly Plan</h3>
        <p>Let the system build a 7-day plan automatically using your dietary restrictions, available inventory, and healthiest recipes.</p>
        <br>
        <a href="MealPlannerController?action=generate" class="btn btn-primary">Generate Meal Plan Automatically</a>
    </div>

    <br>

    <div class="card">
        <h3>Option 2: Create a Custom Plan</h3>

        <form action="MealPlannerController" method="post">

            <input type="hidden" name="action" value="createPlan">

            <p>
                <label>Plan Name</label><br>
                <input type="text" name="planName" value="<%= submittedPlanName != null ? submittedPlanName : "My Healthy Weekly Plan" %>" required style="width:100%; padding:8px;">
            </p>

            <p>
                <label>Start Date</label><br>
                <input type="date" name="startDate" value="<%= submittedStartDate != null ? submittedStartDate : "" %>" required style="width:100%; padding:8px;">
            </p>

            <p>
                <label>End Date</label><br>
                <input type="date" name="endDate" value="<%= submittedEndDate != null ? submittedEndDate : "" %>" required style="width:100%; padding:8px;">
            </p>

            <br>
            <button type="submit" class="btn btn-primary">Create Plan</button>
            <a href="MealPlannerController?action=list" class="btn btn-secondary">Cancel</a>

        </form>
    </div>

</div>