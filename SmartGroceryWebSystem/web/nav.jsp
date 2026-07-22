<%--
    Document   : nav
    Created on : Jul 18, 2026, 10:43:53?AM
    Author     : perer
    Updated    : now renders the same app-wide sidebar + topbar used on
                 Member 1's pages, so navigating between sections feels
                 like one app instead of two different UIs.
--%>
<%@ page import="model.User" %>
<%@ page import="model.CartItem" %>
<%@ page import="service.CartService" %>
<%@ page import="service.InventoryService" %>
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
        notifCount = navUser.isNotifyExpiry() ? new InventoryService().getExpiringItems(7).size() : 0;
    } catch (Exception e) { /* best-effort only */ }
}

String navCtx = request.getContextPath();
String navUri = request.getRequestURI();
boolean onMealSection = navUri.contains("MealDashboardController")
        || navUri.contains("MealPlannerController")
        || navUri.contains("RecipeController")
        || navUri.contains("RecommendationController")
        || navUri.contains("DietaryRestrictionController")
        || navUri.contains("UserDietaryRestrictionController")
        || navUri.contains("FoodWasteController")
        || navUri.contains("ShoppingListController");
boolean onRecipes = navUri.contains("RecipeController");
boolean onRecommendations = navUri.contains("RecommendationController");
boolean onShoppingList = navUri.contains("ShoppingListController");
boolean onMealPlanner = navUri.contains("MealPlannerController") || navUri.contains("MealDashboardController");
boolean onDietary = navUri.contains("DietaryRestrictionController") || navUri.contains("UserDietaryRestrictionController");
boolean onFoodWaste = navUri.contains("FoodWasteController");
%>
<!-- DEBUG navUri = <%= navUri %> -->

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
        <li><a href="<%=navCtx%>/dashboard.jsp"><i class="fa-solid fa-house"></i> Dashboard</a></li>
        <li><a href="<%=navCtx%>/products.jsp"><i class="fa-solid fa-cart-shopping"></i> Shop Groceries</a></li>
        <li><a href="<%=navCtx%>/inventory.jsp"><i class="fa-solid fa-warehouse"></i> My Inventory</a></li>
        <li><a href="<%=navCtx%>/cart.jsp"><i class="fa-solid fa-list-check"></i> Shopping List
            <% if (cartCount > 0) { %><span class="menu-count"><%= cartCount %></span><% } %>
        </a></li>
        <li><a href="<%=navCtx%>/orders.jsp"><i class="fa-solid fa-receipt"></i> My Orders
        </a></li>
        <li><a href="<%=navCtx%>/notifications.jsp"><i class="fa-solid fa-bell"></i> Expiry Alerts
            <% if (notifCount > 0) { %><span class="menu-count"><%= notifCount %></span><% } %>
        </a></li>
        <li><a href="<%=navCtx%>/lowstock.jsp"><i class="fa-solid fa-triangle-exclamation"></i> Low Stock</a></li>
    </ul>

    <div class="side-label">Meal Optimization</div>

    <ul class="menu">
        <li><a class="<%= onMealSection ? "active" : "" %>" href="<%=navCtx%>/MealDashboardController"><i class="fa-solid fa-utensils"></i> Meal Planner</a></li>
        <li><a class="<%= onRecipes ? "active" : "" %>" href="<%=navCtx%>/RecipeController"><i class="fa-solid fa-book-open"></i> Recipes</a></li>
        <li><a class="<%= onRecommendations ? "active" : "" %>" href="<%=navCtx%>/RecommendationController"><i class="fa-solid fa-wand-magic-sparkles"></i> Recommendations</a></li>
        <li><a class="<%= onShoppingList ? "active" : "" %>" href="<%=navCtx%>/ShoppingListController"><i class="fa-solid fa-basket-shopping"></i> Meal Shopping List</a></li>
        <li><a class="<%= onDietary ? "active" : "" %>" href="<%=navCtx%>/UserDietaryRestrictionController"><i class="fa-solid fa-leaf"></i> Dietary Restrictions</a></li>
        <li><a class="<%= onFoodWaste ? "active" : "" %>" href="<%=navCtx%>/FoodWasteController"><i class="fa-solid fa-recycle"></i> Food Waste</a></li>
    </ul>

    <div class="side-label">Account</div>

    <ul class="menu">
        <li><a href="<%=navCtx%>/profile.jsp"><i class="fa-solid fa-user"></i> Profile</a></li>
        <li><a href="<%=navCtx%>/settings.jsp"><i class="fa-solid fa-gear"></i> Settings</a></li>
        <li><a href="<%=navCtx%>/LogoutServlet"><i class="fa-solid fa-right-from-bracket"></i> Logout</a></li>
    </ul>

    <a href="tel:+94112345678" class="help-card">
        <i class="fa-solid fa-phone"></i>
        <b>Need Help?</b>
        <span>Emergency Call</span>
    </a>

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
                            <img src="<%=navCtx%>/<%= navUser.getProfilePhoto() %>" alt="Profile photo">
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
            <a class="<%= onMealPlanner ? "active" : "" %>" href="<%=navCtx%>/MealDashboardController">Meal Dashboard</a>
            <a class="<%= onRecipes ? "active" : "" %>" href="<%=navCtx%>/RecipeController">Recipes</a>
            <a class="<%= onRecommendations ? "active" : "" %>" href="<%=navCtx%>/RecommendationController">Recommendations</a>
            <a class="<%= onShoppingList ? "active" : "" %>" href="<%=navCtx%>/ShoppingListController">Shopping List</a>
            <a class="<%= onDietary ? "active" : "" %>" href="<%=navCtx%>/UserDietaryRestrictionController">Dietary Restrictions</a>
            <a class="<%= onFoodWaste ? "active" : "" %>" href="<%=navCtx%>/FoodWasteController">Food Waste</a>
        </div>
