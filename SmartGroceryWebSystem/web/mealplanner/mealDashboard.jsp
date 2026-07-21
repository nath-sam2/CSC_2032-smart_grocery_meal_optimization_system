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
