<%-- 
    Document   : addRestriction
    Created on : Jul 12, 2026, 4:14:25?PM
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
        <li><a href="<%=navCtx%>/MealDashboardController"><i class="fa-solid fa-utensils"></i> Meal Planner
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
        <li><a class="active" href="<%=navCtx%>/UserDietaryRestrictionController"><i class="fa-solid fa-leaf"></i> Dietary Restrictions</a></li>
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
            <a class="" href="<%=navCtx%>/MealDashboardController">Meal Dashboard</a>
            <a class="" href="<%=navCtx%>/RecipeController">Recipes</a>
            <a class="" href="<%=navCtx%>/RecommendationController">Recommendations</a>
            <a class="" href="<%=navCtx%>/ShoppingListController">Shopping List</a>
            <a class="active" href="<%=navCtx%>/UserDietaryRestrictionController">Dietary Restrictions</a>
            <a class="" href="<%=navCtx%>/FoodWasteController">Food Waste</a>
        </div>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="page-container">

    <div class="card">

        <h2>Add Dietary Restriction</h2>

        <a href="DietaryRestrictionController"
           class="btn btn-secondary">
            ← Back to Dietary Restrictions
        </a>

        <br><br>

        <c:if test="${not empty formError}">
            <div class="alert alert-error" style="margin-bottom: 10px;">
                ${formError}
            </div>
        </c:if>

        <form action="DietaryRestrictionController" method="post">

            <input type="hidden"
                   name="action"
                   value="insert">

            <label><strong>Restriction Name</strong></label><br>

            <input
                type="text"
                name="restrictionName"
                value="${param.restrictionName}"
                required
                style="width:100%;padding:10px;margin:8px 0 16px;">

            <label><strong>Description</strong></label><br>

            <textarea
                name="description"
                rows="4"
                style="width:100%;padding:10px;margin:8px 0 20px;">${param.description}</textarea>

            <button
                type="submit"
                class="btn btn-primary">
                Save Restriction
            </button>

        </form>

    </div>

</div>