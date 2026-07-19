<%-- 
    Document   : mealDashboard
    Created on : Jul 18, 2026, 7:48:11?PM
    Author     : perer
--%>

<%@ include file="/nav.jsp" %>
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

    <h2>Welcome back!</h2>
    <p>Here's your healthy meal overview for today.</p>

    <br>

    <div class="card-grid">

        <!-- Today's Recommendations -->
        <div class="card">
            <h3>Today's Recommendations</h3>
            <% if (topRecommendations != null && !topRecommendations.isEmpty()) { %>
                <% for (Recipe r : topRecommendations) { %>
                    <p>
                        <a href="RecipeController?action=view&id=<%=r.getRecipeId()%>">
                            <%= r.getName() %>
                        </a>
                        &nbsp; <span class="badge badge-grade-b"><%= r.getMealType() %></span>
                    </p>
                <% } %>
            <% } else { %>
                <p>No recommendations available right now.</p>
            <% } %>
            <br>
            <a href="RecommendationController" class="btn btn-primary">View All Recommendations</a>
        </div>

        <!-- Expiring Soon -->
        <div class="card">
            <h3>Expiring Soon</h3>
            <% if (expiringItems != null && !expiringItems.isEmpty()) { %>
                <% for (Product p : expiringItems) { %>
                    <p>
                        <span class="badge badge-warning"><%= p.getName() %></span>
                        expires <%= p.getExpiryDate() %>
                    </p>
                <% } %>
            <% } else { %>
                <p>Nothing expiring in the next 3 days.</p>
            <% } %>
        </div>

        <!-- Shopping List Summary -->
        <div class="card">
            <h3>Shopping List</h3>
            <% if (latestList != null) { %>
                <p>Latest list: #<%= latestList.getShoppingListId() %></p>
                <p>Status: <span class="badge badge-grade-a"><%= latestList.getStatus() %></span></p>
                <br>
                <a href="ShoppingListController?action=view&id=<%=latestList.getShoppingListId()%>" class="btn btn-primary">View Items</a>
            <% } else { %>
                <p>No shopping lists yet.</p>
            <% } %>
            <br>
            <a href="ShoppingListController?action=list" class="btn btn-secondary">All Shopping Lists</a>
        </div>

        <!-- Nutrition Summary -->
        <div class="card">
            <h3>Nutrition Snapshot</h3>
            <p>Based on today's top pick: <b><%= (topRecommendations != null && !topRecommendations.isEmpty()) ? topRecommendations.get(0).getName() : "N/A" %></b></p>
            <p>Check the recipe details page for full nutrition facts and NutriScore grade.</p>
        </div>

    </div>

</div>