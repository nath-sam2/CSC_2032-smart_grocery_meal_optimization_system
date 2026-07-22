<%-- 
    Document   : recipeDetails
    Created on : Jul 12, 2026, 5:37:24 PM
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
<%@ page import="model.RecipeIngredient" %>
<%@ page import="model.NutritionFacts" %>
<%@ page import="dao.IngredientDAO" %>
<%@ page import="dao.NutritionFactsDAO" %>
<%@ page import="service.NutriScoreService" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
Recipe recipe = (Recipe) request.getAttribute("recipe");
int recipeId = recipe.getRecipeId();

List<RecipeIngredient> ingredients =
        IngredientDAO.getIngredientsByRecipe(recipeId);

NutritionFactsDAO nutritionDAO = new NutritionFactsDAO();
NutritionFacts nutritionFacts =
        nutritionDAO.getNutritionByRecipeId(recipeId);

request.setAttribute("nutritionFacts", nutritionFacts);

char grade = ' ';
if (nutritionFacts != null) {
    grade = NutriScoreService.calculateNutriScore(nutritionFacts, false);
}
%>

<div class="page-container">

    <h2><%= recipe.getName() %></h2>

    <%
    String detailsLocalImg = util.RecipeImageResolver.resolve(application, recipe.getName());
    String detailsImgSrc = (detailsLocalImg != null) ? (navCtx + "/" + detailsLocalImg) : recipe.getImageUrl();
    %>

    <% if (detailsImgSrc != null && !detailsImgSrc.trim().isEmpty()) { %>
        <img class="recipe-hero" src="<%= detailsImgSrc %>" alt="<%= recipe.getName() %>">
    <% } else { %>
        <div class="recipe-hero-placeholder">No image available</div>
    <% } %>

    <div class="card">

        <p>
            <span class="badge badge-grade-b"><%= recipe.getMealType() %></span>
            <span class="badge badge-grade-c"><%= recipe.getCuisine() %></span>
            <span class="badge badge-grade-c"><%= recipe.getDifficulty() %></span>

            <% if (nutritionFacts != null) { %>
                <span class="badge badge-grade-<%= Character.toLowerCase(grade) %>">
                    NutriScore <%= grade %>
                </span>
            <% } %>

            <% if (nutritionFacts != null && nutritionFacts.getProtein() >= 15) { %>
                <span class="badge badge-grade-a">High Protein</span>
            <% } %>

            <% if (nutritionFacts != null && nutritionFacts.getTotalFat() <= 5) { %>
                <span class="badge badge-grade-a">Low Fat</span>
            <% } %>

            <% if (nutritionFacts != null && nutritionFacts.getDietaryFiber() >= 5) { %>
                <span class="badge badge-grade-a">High Fiber</span>
            <% } %>
        </p>

        <p><%= recipe.getDescription() %></p>

        <p><%= recipe.getCookingTime() %> mins &nbsp; | &nbsp; <%= recipe.getServings() %> servings</p>

    </div>

    <div class="card">
        <h3>Ingredients</h3>
        <% if (!ingredients.isEmpty()) { %>
        <table>
            <tr>
                <th>Ingredient</th>
                <th>Quantity</th>
                <th>Unit</th>
            </tr>
            <%
            for(RecipeIngredient i : ingredients){
            %>
            <tr>
                <td data-label="Ingredient"><%= i.getIngredientName() %></td>
                <td data-label="Quantity"><%= i.getQuantity() %></td>
                <td data-label="Unit"><%= i.getUnit() %></td>
            </tr>
            <%
            }
            %>
        </table>
        <% } else { %>
        <p>No ingredients listed.</p>
        <% } %>
    </div>

    <div class="card">
        <h3>Nutrition Facts</h3>
        <c:if test="${not empty nutritionFacts}">
        <table>
            <tr><th>Nutrient</th><th>Amount</th></tr>
            <tr><td data-label="Nutrient">Serving Size</td><td data-label="Amount">${nutritionFacts.servingSize}</td></tr>
            <tr><td data-label="Nutrient">Calories</td><td data-label="Amount">${nutritionFacts.calories} kcal</td></tr>
            <tr><td data-label="Nutrient">Total Fat</td><td data-label="Amount">${nutritionFacts.totalFat} g</td></tr>
            <tr><td data-label="Nutrient">Saturated Fat</td><td data-label="Amount">${nutritionFacts.saturatedFat} g</td></tr>
            <tr><td data-label="Nutrient">Protein</td><td data-label="Amount">${nutritionFacts.protein} g</td></tr>
            <tr><td data-label="Nutrient">Carbohydrates</td><td data-label="Amount">${nutritionFacts.totalCarbohydrates} g</td></tr>
            <tr><td data-label="Nutrient">Dietary Fiber</td><td data-label="Amount">${nutritionFacts.dietaryFiber} g</td></tr>
            <tr><td data-label="Nutrient">Sugar</td><td data-label="Amount">${nutritionFacts.totalSugar} g</td></tr>
            <tr><td data-label="Nutrient">Sodium</td><td data-label="Amount">${nutritionFacts.sodium} mg</td></tr>
        </table>
        </c:if>
        <c:if test="${empty nutritionFacts}">
        <p>No nutrition information available.</p>
        </c:if>
    </div>

    <br>
    <a href="RecipeController" class="btn btn-secondary">Back to Recipe List</a>

</div>