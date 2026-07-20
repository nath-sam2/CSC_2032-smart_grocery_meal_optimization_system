<%-- 
    Document   : recommendation
    Created on : Jul 13, 2026, 9:29:22 AM
    Author     : perer
--%>
<%@ include file="/nav.jsp" %>
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

        <div class="card">

            <h3><%= recipe.getName() %></h3>

            <p>
                <span class="badge badge-grade-<%= Character.toLowerCase(grade) %>">NutriScore <%= grade %></span>
                <span class="badge badge-grade-b"><%= recipe.getMealType() %></span>

                <% if (usesExpiringIngredient) { %>
                    <span class="badge badge-warning">Uses Expiring Ingredients</span>
                <% } %>
            </p>

            <%
int healthScore = (nutrition != null) ? engine.calculateHealthScore(nutrition) : 0;
%>

<p>
    <% if (nutrition != null) { %>
        <%= nutrition.getCalories() %> kcal
    <% } else { %>
        Calories: N/A
    <% } %>
    &nbsp; | &nbsp; Recipe Score: <%= String.format("%.1f", score) %>
    &nbsp; | &nbsp; Health Score: <%= healthScore %>
</p>

            <p>
                Ingredients available: <%= availableCount %> / <%= required.size() %>
                <% if (missingCount > 0) { %>
                    <span class="badge badge-warning"><%= missingCount %> missing</span>
                <% } %>
            </p>

            <p><%= recipe.getCookingTime() %> mins ...  &nbsp; | &nbsp; <%= recipe.getDifficulty() %></p>

            <br>

            <a href="RecipeController?action=view&id=<%=recipe.getRecipeId()%>" class="btn btn-primary">View Recipe</a>
            <a href="MealPlannerController?action=quickAdd&recipeId=<%=recipe.getRecipeId()%>" class="btn btn-secondary">Add to Meal Plan</a>

        </div>

    <%
        }
    }
    %>

    </div>

</div>