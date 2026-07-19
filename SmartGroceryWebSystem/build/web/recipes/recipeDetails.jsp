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

        <p>? <%= recipe.getCookingTime() %> mins &nbsp; | &nbsp; ? <%= recipe.getServings() %> servings</p>

    </div>

    <div class="card">
        <h3>Ingredients</h3>
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
                <td