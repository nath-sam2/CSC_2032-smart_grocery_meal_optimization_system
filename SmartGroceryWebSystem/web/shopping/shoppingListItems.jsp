<%-- 
    Document   : shoppingListItems
    Created on : Jul 18, 2026, 8:42:59?AM
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
        <li><a class="active" href="<%=navCtx%>/ShoppingListController"><i class="fa-solid fa-basket-shopping"></i> Meal Shopping List</a></li>
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
            <a class="" href="<%=navCtx%>/RecipeController">Recipes</a>
            <a class="" href="<%=navCtx%>/RecommendationController">Recommendations</a>
            <a class="active" href="<%=navCtx%>/ShoppingListController">Shopping List</a>
            <a class="" href="<%=navCtx%>/UserDietaryRestrictionController">Dietary Restrictions</a>
            <a class="" href="<%=navCtx%>/FoodWasteController">Food Waste</a>
        </div>

<%@ page import="java.util.List" %>
<%@ page import="model.ShoppingListItem" %>
<%@ page import="model.Ingredient" %>
<%@ page import="model.Inventory" %>
<%@ page import="dao.IngredientDAO" %>
<%@ page import="dao.InventoryDAO" %>

<%
List<ShoppingListItem> items =
(List<ShoppingListItem>) request.getAttribute("items");

IngredientDAO ingredientDAO = new IngredientDAO();
InventoryDAO inventoryDAO = new InventoryDAO();
%>

<div class="page-container">

    <h2>Shopping List Items</h2>

    <div class="card">

        <% if (items == null || items.isEmpty()) { %>

            <p>No items in this shopping list ? looks like everything needed was already in stock.</p>

        <% } else { %>

        <table>
            <tr>
                <th>Ingredient</th>
                <th>Quantity</th>
                <th>Availability</th>
                <th>Status</th>
                <th>Action</th>
            </tr>

            <%
                for(ShoppingListItem item : items){

                    Ingredient ingredient =
                    ingredientDAO.getIngredientById(item.getIngredientId());

                    String ingredientName =
                    (ingredient != null) ? ingredient.getName() : "Unknown Ingredient";

                    String availability = "Not tracked";
                    String availabilityBadgeClass = "badge-grade-c";

                    if (ingredient != null) {
                        Inventory inv = inventoryDAO.getInventoryByProduct(ingredient.getProductId());

                        if (inv == null) {
                            availability = "Out of stock";
                            availabilityBadgeClass = "badge-warning";
                        } else if (inv.getQuantity() <= 0) {
                            availability = "Out of stock";
                            availabilityBadgeClass = "badge-warning";
                        } else {
                            availability = "In stock (" + inv.getQuantity() + " " + item.getUnit() + ")";
                            availabilityBadgeClass = "badge-grade-a";
                        }
                    }

                    boolean purchased = "Purchased".equals(item.getStatus());
            %>

            <tr>
                <td data-label="Ingredient"><%=ingredientName%></td>
                <td data-label="Quantity"><%=item.getQuantity()%> <%=item.getUnit()%></td>
                <td data-label="Availability">
                    <span class="badge <%=availabilityBadgeClass%>"><%=availability%></span>
                </td>
                <td data-label="Status">
                    <span class="badge <%= purchased ? "badge-grade-a" : "badge-grade-c" %>"><%=item.getStatus()%></span>
                </td>
                <td data-label="Action">
                    <% if (!purchased) { %>
                        <a href="ShoppingListController?action=purchase&id=<%=item.getShoppingListItemId()%>" class="btn btn-secondary">Mark Purchased</a>
                    <% } else { %>
                        &#10003; Done
                    <% } %>
                </td>
            </tr>

            <%
                }
            %>

        </table>

        <% } %>

    </div>

    <br>
    <a href="ShoppingListController?action=list" class="btn btn-secondary">Back to Shopping Lists</a>
    <button onclick="window.print()" class="btn btn-secondary">Print List</button>

</div>