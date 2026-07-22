<%-- 
    Document   : recommendation
    Created on : Jul 13, 2026, 9:29:22 AM
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
        <li><a class="active" href="<%=navCtx%>/RecommendationController"><i class="fa-solid fa-wand-magic-sparkles"></i> Recommendations</a></li>
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
            <a class="" href="<%=navCtx%>/MealDashboardController">Meal Dashboard</a>
            <a class="" href="<%=navCtx%>/RecipeController">Recipes</a>
            <a class="active" href="<%=navCtx%>/RecommendationController">Recommendations</a>
            <a class="" href="<%=navCtx%>/ShoppingListController">Shopping List</a>
            <a class="" href="<%=navCtx%>/UserDietaryRestrictionController">Dietary Restrictions</a>
            <a class="" href="<%=navCtx%>/FoodWasteController">Food Waste</a>
        </div>

<%@ page import="java.util.List" %>
<%@ page import="model.Recipe" %>
<%@ page import="model.RecipeIngredient" %>
<%@ page import="dao.NutritionFactsDAO" %>
<%@ page import="dao.IngredientDAO" %>
<%@ page import="model.NutritionFacts" %>
<%@ page import="service.RecommendationEngine" %>

<%
List<Recipe> recipes =
        (List<Recipe>) request.getAttribute("recommendations");

NutritionFactsDAO nutritionDAO = new NutritionFactsDAO();
RecommendationEngine engine = new RecommendationEngine();
%>

<div class="page-container">

    <h2>Healthy Meal Recommendations</h2>

    <div class="card-grid">

    <%
    if (recipes != null) {
        for (Recipe recipe : recipes) {

            NutritionFacts nutrition =
                    nutritionDAO.getNutritionFactsByRecipeId(recipe.getRecipeId());

            char grade = engine.getRecipeGrade(recipe.getRecipeId());

            double score = engine.calculateRecipeScore(recipe);

            List<RecipeIngredient> required =
                    IngredientDAO.getIngredientsByRecipe(recipe.getRecipeId());

            int missingCount = engine.getMissingIngredientsForRecipe(recipe.getRecipeId()).size();
            int availableCount = required.size() - missingCount;

            boolean usesExpiringIngredient =
                    engine.calculateWasteReductionScore(recipe) >= 25;
    %>

        <div class="card card-highlight">

            <%
            String localImg = util.RecipeImageResolver.resolve(application, recipe.getName());
            String imgSrc = (localImg != null) ? (navCtx + "/" + localImg) : recipe.getImageUrl();
            %>
            <% if (imgSrc != null && !imgSrc.trim().isEmpty()) { %>
                <div class="recipe-thumb">
                    <img src="<%= imgSrc %>" alt="<%= recipe.getName() %>">
                </div>
            <% } else { %>
                <div class="recipe-thumb placeholder"><span>No image</span></div>
            <% } %>

            <h3><%= recipe.getName() %></h3>

            <div class="recipe-badges">
                <span class="badge badge-grade-<%= Character.toLowerCase(grade) %>">NutriScore <%= grade %></span>
                <span class="badge badge-grade-b"><%= recipe.getMealType() %></span>

                <% if (usesExpiringIngredient) { %>
                    <span class="badge badge-warning">Uses Expiring Ingredients</span>
                <% } %>
            </div>

            <%
int healthScore = (nutrition != null) ? engine.calculateHealthScore(nutrition) : 0;
%>

<div class="recipe-stats">
    <span>
    <% if (nutrition != null) { %>
        <%= nutrition.getCalories() %> kcal
    <% } else { %>
        Calories: N/A
    <% } %>
    </span>
    <span class="stat-divider">&bull;</span>
    <span>Recipe Score: <%= String.format("%.1f", score) %></span>
    <span class="stat-divider">&bull;</span>
    <span>Health Score: <%= healthScore %></span>
</div>

            <div class="ingredient-progress">
                <div class="progress-track">
                    <div class="progress-fill" style="width:<%= required.isEmpty() ? 0 : (availableCount * 100 / required.size()) %>%"></div>
                </div>
                <span class="progress-label"><%= availableCount %> / <%= required.size() %> available</span>
                <% if (missingCount > 0) { %>
                    <span class="badge badge-warning"><%= missingCount %> missing</span>
                <% } %>
            </div>

            <p class="recipe-meta"><%= recipe.getCookingTime() %> mins &nbsp;&bull;&nbsp; <%= recipe.getDifficulty() %></p>

            <div class="card-footer">
                <a href="RecipeController?action=view&id=<%=recipe.getRecipeId()%>" class="btn btn-primary">View Recipe</a>
                <a href="MealPlannerController?action=quickAdd&recipeId=<%=recipe.getRecipeId()%>" class="btn btn-secondary">Add to Meal Plan</a>
            </div>

        </div>

    <%
        }
    }
    %>

    </div>

</div>