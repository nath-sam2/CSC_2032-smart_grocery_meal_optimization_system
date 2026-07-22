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
        <li><a href="<%=navCtx%>/orders.jsp"><i class="fa-solid fa-receipt"></i> My Orders
        </a></li>
        <li><a class="active" href="<%=navCtx%>/RecipeController"><i class="fa-solid fa-book-open"></i> Recipes
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
            <a class="" href="<%=navCtx%>/MealDashboardController">Meal Dashboard</a>
            <a class="active" href="<%=navCtx%>/RecipeController">Recipes</a>
            <a class="" href="<%=navCtx%>/RecommendationController">Recommendations</a>
            <a class="" href="<%=navCtx%>/ShoppingListController">Shopping List</a>
            <a class="" href="<%=navCtx%>/UserDietaryRestrictionController">Dietary Restrictions</a>
            <a class="" href="<%=navCtx%>/FoodWasteController">Food Waste</a>
        </div>

<%@ page import="model.Recipe" %>
<%@ page import="java.util.List" %>

<%
Recipe r = (Recipe)request.getAttribute("recipe");
List<String> formErrors = (List<String>) request.getAttribute("formErrors");
%>

<div class="page-container">

    <h2>Edit Recipe</h2>

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
        <form action="RecipeController" method="post">

            <input type="hidden" name="action" value="update">
            <input type="hidden" name="recipeId" value="<%=r.getRecipeId()%>">

            <p>
                <label>Name</label><br>
                <input type="text" name="name" value="<%=r.getName()%>" required style="width:100%; padding:8px;">
            </p>

            <p>
                <label>Description</label><br>
                <textarea name="description" rows="3" style="width:100%; padding:8px;"><%=r.getDescription()%></textarea>
            </p>

            <p>
                <label>Meal Type</label><br>
                <select name="mealType" style="width:100%; padding:8px;">
                    <option value="Breakfast" <%="Breakfast".equals(r.getMealType()) ? "selected" : ""%>>Breakfast</option>
                    <option value="Lunch" <%="Lunch".equals(r.getMealType()) ? "selected" : ""%>>Lunch</option>
                    <option value="Dinner" <%="Dinner".equals(r.getMealType()) ? "selected" : ""%>>Dinner</option>
                </select>
            </p>

            <p>
                <label>Cuisine</label><br>
                <input type="text" name="cuisine" value="<%=r.getCuisine()%>" style="width:100%; padding:8px;">
            </p>

            <p>
                <label>Cooking Time (minutes)</label><br>
                <input type="number" name="cookingTime" value="<%= request.getParameter("cookingTime") != null ? request.getParameter("cookingTime") : r.getCookingTime() %>" required style="width:100%; padding:8px;">
            </p>

            <p>
                <label>Difficulty</label><br>
                <select name="difficulty" style="width:100%; padding:8px;">
                    <option value="Easy" <%="Easy".equals(r.getDifficulty()) ? "selected" : ""%>>Easy</option>
                    <option value="Medium" <%="Medium".equals(r.getDifficulty()) ? "selected" : ""%>>Medium</option>
                    <option value="Hard" <%="Hard".equals(r.getDifficulty()) ? "selected" : ""%>>Hard</option>
                </select>
            </p>

            <p>
                <label>Servings</label><br>
                <input type="number" name="servings" value="<%= request.getParameter("servings") != null ? request.getParameter("servings") : r.getServings() %>" required style="width:100%; padding:8px;">
            </p>

            <p>
                <label>Image URL</label><br>
                <input type="url" name="imageUrl" value="<%= r.getImageUrl() != null ? r.getImageUrl() : "" %>" placeholder="https://example.com/photo.jpg" style="width:100%; padding:8px;">
            </p>

            <br>
            <button type="submit" class="btn btn-primary">Update Recipe</button>
            <a href="RecipeController" class="btn btn-secondary">Cancel</a>

        </form>
    </div>

</div>