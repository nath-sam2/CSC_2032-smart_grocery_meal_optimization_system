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

        <div class="card card-highlight">

            <% if (recipe.getImageUrl() != null && !recipe.getImageUrl().trim().isEmpty()) { %>
                <div class="recipe-thumb">
                    <img src="<%= recipe.getImageUrl() %>" alt="<%= recipe.getName() %>">
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