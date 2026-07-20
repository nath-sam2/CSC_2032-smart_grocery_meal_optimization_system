<%-- 
    Document   : foodWasteReduction
    Created on : Jul 15, 2026, 4:15:09?PM
    Author     : perer
--%>
<%@ include file="/nav.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Recipe" %>
<%@ page import="model.Product" %>
<%@ page import="service.RecommendationEngine" %>
<%@ page import="dao.InventoryDAO" %>

<%
List<Recipe> recipes =
(List<Recipe>) request.getAttribute("recipes");

RecommendationEngine engine = new RecommendationEngine();
InventoryDAO inventoryDAO = new InventoryDAO();

List<Product> expiringItems = inventoryDAO.getExpiringItems(3);
%>

<div class="page-container">

    <h2>Food Waste Reduction</h2>

    <div class="card">
        <h3>Ingredients Expiring Soon</h3>

        <% if (expiringItems != null && !expiringItems.isEmpty()) { %>
            <ul>
            <%
            for (Product p : expiringItems) {
            %>
                <li><%= p.getName() %> - expires <%= p.getExpiryDate() %></li>
            <%
            }
            %>
            </ul>
        <% } else { %>
            <p>Nothing expiring in the next 3 days.</p>
        <% } %>
    </div>

    <div class="card">
        <h3>Recommended Recipes (Prioritized to Reduce Waste)</h3>

        <table>
            <tr>
                <th>Recipe</th>
                <th>Meal Type</th>
                <th>Cuisine</th>
                <th>Cooking Time</th>
                <th>Difficulty</th>
                <th>NutriScore</th>
                <th>Waste Reduction Score</th>
            </tr>

            <%
            if (recipes != null) {
                for (Recipe recipe : recipes) {

                    char grade = engine.getRecipeGrade(recipe.getRecipeId());
                    double wasteScore = engine.calculateWasteReductionScore(recipe);
            %>
            <tr>
                <td data-label="Recipe"><%= recipe.getName() %></td>
                <td data-label="Meal Type"><%= recipe.getMealType() %></td>
                <td data-label="Cuisine"><%= recipe.getCuisine() %></td>
                <td data-label="Cooking Time"><%= recipe.getCookingTime() %> mins</td>
                <td data-label="Difficulty"><%= recipe.getDifficulty() %></td>
                <td data-label="NutriScore">
                    <span class="badge badge-grade-<%= Character.toLowerCase(grade) %>"><%= grade %></span>
                </td>
                <td data-label="Waste Reduction Score"><%= String.format("%.1f", wasteScore) %></td>
            </tr>
            <%
                }
            }
            %>
        </table>
    </div>

</div>