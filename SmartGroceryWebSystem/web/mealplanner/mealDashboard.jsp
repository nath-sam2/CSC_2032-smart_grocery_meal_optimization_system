<%-- 
    Document   : mealDashboard
    Created on : Jul 18, 2026, 7:48:11?PM
    Author     : perer
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
        notifCount = new InventoryService().getExpiringItems(7).size();
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
        <li><a href="<%=navCtx%>/orders.jsp"><i class="fa-solid fa-receipt"></i> My Orders
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

<%@ page import="java.util.List" %>
<%@ page import="model.Recipe" %>
<%@ page import="model.Product" %>
<%@ page import="model.ShoppingList" %>

<%
List<Recipe> topRecommendations = (List<Recipe>) request.getAttribute("topRecommendations");
List<Product> expiringItems = (List<Product>) request.getAttribute("expiringItems");
ShoppingList latestList = (ShoppingList) request.getAttribute("latestShoppingList");
%>

<div class="page-container">

    <div class="dashboard-header">
        <h2>Welcome back!</h2>
        <p>Here's your healthy meal overview for today.</p>
    </div>

    <div class="card-grid">

        <!-- Today's Recommendations -->
        <div class="card card-highlight">
            <div class="card-header">
                <div class="card-icon icon-green"></div>
                <h3>Today's Recommendations</h3>
            </div>
            <div class="card-body">
                <% if (topRecommendations != null && !topRecommendations.isEmpty()) { %>
                    <% for (Recipe r : topRecommendations) { %>
                        <div class="list-row">
                            <a class="list-title" href="RecipeController?action=view&id=<%=r.getRecipeId()%>">
                                <%= r.getName() %>
                            </a>
                            <span class="badge badge-grade-b"><%= r.getMealType() %></span>
                        </div>
                    <% } %>
                <% } else { %>
                    <p class="card-empty">No recommendations available right now.</p>
                <% } %>
            </div>
            <div class="card-footer">
                <a href="RecommendationController" class="btn btn-primary">View All Recommendations</a>
            </div>
        </div>

        <!-- Expiring Soon -->
        <div class="card card-highlight">
            <div class="card-header">
                <div class="card-icon icon-red"></div>
                <h3>Expiring Soon</h3>
            </div>
            <div class="card-body">
                <% if (expiringItems != null && !expiringItems.isEmpty()) { %>
                    <% for (Product p : expiringItems) { %>
                        <div class="list-row">
                            <span class="badge badge-warning"><%= p.getName() %></span>
                            <span class="list-meta">expires <%= p.getExpiryDate() %></span>
                        </div>
                    <% } %>
                <% } else { %>
                    <p class="card-empty">Nothing expiring in the next 3 days.</p>
                <% } %>
            </div>
            <div class="card-footer">
                <a href="../inventory.jsp?filter=expiring" class="btn btn-secondary">View Expiring Items</a>
            </div>
        </div>

        <!-- Shopping List Summary -->
        <div class="card card-highlight">
            <div class="card-header">
                <div class="card-icon icon-blue"></div>
                <h3>Shopping List</h3>
            </div>
            <div class="card-body">
                <% if (latestList != null) { %>
                    <div class="stat-line">
                        <span>Latest list: #<%= latestList.getShoppingListId() %></span>
                        <span class="badge badge-grade-a"><%= latestList.getStatus() %></span>
                    </div>
                <% } else { %>
                    <p class="card-empty">No shopping lists yet.</p>
                <% } %>
            </div>
            <div class="card-footer">
                <% if (latestList != null) { %>
                    <a href="ShoppingListController?action=view&id=<%=latestList.getShoppingListId()%>" class="btn btn-primary">View Items</a>
                <% } %>
                <a href="ShoppingListController?action=list" class="btn btn-secondary">All Shopping Lists</a>
            </div>
        </div>

        <!-- Nutrition Summary -->
        <div class="card card-highlight">
            <div class="card-header">
                <div class="card-icon icon-purple"></div>
                <h3>Nutrition Snapshot</h3>
            </div>
            <div class="card-body">
                <p>Based on today's top pick: <b style="color:var(--text);"><%= (topRecommendations != null && !topRecommendations.isEmpty()) ? topRecommendations.get(0).getName() : "N/A" %></b></p>
                <p>Check the recipe details page for full nutrition facts and NutriScore grade.</p>
            </div>
            <% if (topRecommendations != null && !topRecommendations.isEmpty()) { %>
                <div class="card-footer">
                    <a href="RecipeController?action=view&id=<%=topRecommendations.get(0).getRecipeId()%>" class="btn btn-secondary">View Recipe</a>
                </div>
            <% } %>
        </div>

    </div>

</div>
