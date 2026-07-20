<%-- 
    Document   : recipeDetails
    Created on : Jul 12, 2026, 5:37:24 PM
    Author     : perer
--%>
<%@ include file="/nav.jsp" %>
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