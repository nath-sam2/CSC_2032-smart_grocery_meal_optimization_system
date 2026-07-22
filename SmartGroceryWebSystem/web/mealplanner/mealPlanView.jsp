<%-- 
    Document   : mealPlanView
    Created on : Jul 13, 2026, 3:54:23?PM
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
            <a class="active" href="<%=navCtx%>/MealDashboardController">Meal Dashboard</a>
            <a class="" href="<%=navCtx%>/RecipeController">Recipes</a>
            <a class="" href="<%=navCtx%>/RecommendationController">Recommendations</a>
            <a class="" href="<%=navCtx%>/ShoppingListController">Shopping List</a>
            <a class="" href="<%=navCtx%>/UserDietaryRestrictionController">Dietary Restrictions</a>
            <a class="" href="<%=navCtx%>/FoodWasteController">Food Waste</a>
        </div>

<%@ page import="model.MealPlanner" %>
<%@ page import="model.MealPlanDetail" %>
<%@ page import="model.Recipe" %>
<%@ page import="dao.RecipeDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedHashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.time.LocalDate" %>

<%
MealPlanner plan =
(MealPlanner) request.getAttribute("mealPlan");

List<MealPlanDetail> details =
plan.getMealPlanDetails();

RecipeDAO recipeDAO = new RecipeDAO();

// Group meal details by date, preserving order
Map<LocalDate, List<MealPlanDetail>> grouped = new LinkedHashMap<>();

for (MealPlanDetail detail : details) {
    grouped.computeIfAbsent(detail.getMealDate(), k -> new java.util.ArrayList<>()).add(detail);
}
%>

<div class="page-container">

    <h2>Meal Plan: <%= plan.getPlanName() %></h2>

    <p>
        <%= plan.getStartDate() %> to <%= plan.getEndDate() %>
    </p>

    <a href="MealPlannerController?action=addMeal&id=<%=plan.getMealPlanId()%>" class="btn btn-primary">+ Add Meal</a>

    <br><br>

    <%
    for (Map.Entry<LocalDate, List<MealPlanDetail>> entry : grouped.entrySet()) {
    %>

    <div class="card">
        <h3><%= entry.getKey() %></h3>

        <table>
            <tr>
                <th>Meal Type</th>
                <th>Recipe</th>
                <th>Action</th>
            </tr>

            <%
            for (MealPlanDetail detail : entry.getValue()) {

                Recipe recipe = recipeDAO.getRecipeById(detail.getRecipeId());
                String recipeName = (recipe != null) ? recipe.getName() : "Unknown Recipe";
            %>

            <tr>
                <td data-label="Meal Type"><span class="badge badge-grade-b"><%= detail.getMealType() %></span></td>
                <td data-label="Recipe">
                    <a href="RecipeController?action=view&id=<%=detail.getRecipeId()%>" style="color: var(--green);"><%= recipeName %></a>
                </td>
                <td data-label="Action">
                    <a href="MealPlannerController?action=deleteMeal&id=<%=detail.getMealPlanDetailId()%>"
                       onclick="return confirm('Remove this meal?');"
                       class="btn btn-secondary">Delete</a>
                </td>
            </tr>

            <%
            }
            %>

        </table>
    </div>

    <%
    }
    %>

    <br>
    <a href="MealPlannerController?action=list" class="btn btn-secondary">Back to Plans</a>

</div>