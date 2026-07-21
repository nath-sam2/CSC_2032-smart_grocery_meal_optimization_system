<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<%@page import="model.Recipe"%>
<%@page import="model.Ingredient"%>
<%@page import="model.RecipeIngredient"%>
<%@page import="model.DietaryRestriction"%>
<%@page import="model.NutritionFacts"%>
<%@page import="model.MealPlanner"%>
<%@page import="model.ShoppingList"%>
<%@page import="model.ShoppingListItem"%>
<%@page import="dao.*"%>
<%@page import="service.RecommendationEngine"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
    <title>Module System Test - Healthy Meal Optimization</title>
    <style>
        body { font-family: Arial; background: #f0fdf4; padding: 30px; }
        h2 { color: #166534; }
        .section { background: white; padding: 20px; border-radius: 10px;
                   box-shadow: 0 2px 8px rgba(0,0,0,0.08);
                   margin-bottom: 20px; }
        .section h3 { color: #1d4ed8; margin-top: 0; }
        .result { padding: 8px 14px; border-radius: 6px;
                  margin: 4px 0; font-size: 14px; }
        .result.pass { background: #dcfce7; color: #166534; }
        .result.fail { background: #fee2e2; color: #991b1b; }
        .summary { background: #1d4ed8; color: white; padding: 20px;
                   border-radius: 10px; text-align: center;
                   margin-bottom: 20px; }
        .summary h2 { color: white; margin: 0; }
    </style>
</head>
<body>
    <%
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = util.SessionUtil.getLoggedInUserId(session);

        // DAOs / services under test
        RecipeDAO recipeDAO = new RecipeDAO();
        IngredientDAO ingredientDAO = new IngredientDAO();
        DietaryRestrictionDAO restrictionDAO = new DietaryRestrictionDAO();
        UserDietaryRestrictionDAO userRestrictionDAO = new UserDietaryRestrictionDAO();
        NutritionFactsDAO nutritionDAO = new NutritionFactsDAO();
        MealPlannerDAO mealPlannerDAO = new MealPlannerDAO();
        ShoppingListDAO shoppingListDAO = new ShoppingListDAO();
        ShoppingListItemDAO shoppingListItemDAO = new ShoppingListItemDAO();
        RecommendationEngine engine = new RecommendationEngine();

        int pass = 0, fail = 0;

        // ---- Tests (each wrapped defensively so one failure doesn't kill the page) ----
        List<Recipe> allRecipes = null;
        boolean t1;
        try { allRecipes = recipeDAO.getAllRecipes(); t1 = allRecipes != null; }
        catch (Exception e) { t1 = false; }

        List<Ingredient> allIngredients = null;
        boolean t2;
        try { allIngredients = ingredientDAO.getAllIngredients(); t2 = allIngredients != null; }
        catch (Exception e) { t2 = false; }

        List<DietaryRestriction> allRestrictions = null;
        boolean t3;
        try { allRestrictions = restrictionDAO.getAllRestrictions(); t3 = allRestrictions != null; }
        catch (Exception e) { t3 = false; }

        List<DietaryRestriction> myRestrictions = null;
        boolean t4;
        try { myRestrictions = userRestrictionDAO.getRestrictionsByUserId(userId); t4 = myRestrictions != null; }
        catch (Exception e) { t4 = false; }

        List<NutritionFacts> allNutrition = null;
        boolean t5;
        try { allNutrition = nutritionDAO.getAllNutritionFacts(); t5 = allNutrition != null; }
        catch (Exception e) { t5 = false; }

        List<MealPlanner> myPlans = null;
        boolean t6;
        try { myPlans = mealPlannerDAO.getMealPlansByUser(userId); t6 = myPlans != null; }
        catch (Exception e) { t6 = false; }

        List<Recipe> recommended = null;
        boolean t7;
        try { recommended = engine.recommendRecipes(userId); t7 = recommended != null; }
        catch (Exception e) { t7 = false; }

        List<Recipe> wasteRecs = null;
        boolean t8;
        try { wasteRecs = engine.recommendWasteReducingRecipes(userId); t8 = wasteRecs != null; }
        catch (Exception e) { t8 = false; }

        boolean t9;
        Recipe sampleRecipe = (allRecipes != null && !allRecipes.isEmpty()) ? allRecipes.get(0) : null;
        List<RecipeIngredient> sampleIngredients = null;
        try {
            if (sampleRecipe != null) {
                sampleIngredients = IngredientDAO.getIngredientsByRecipe(sampleRecipe.getRecipeId());
            }
            t9 = true; // passes as long as it doesn't throw, even if there are no recipes yet
        } catch (Exception e) { t9 = false; }

        boolean t10;
        try {
            // Invalid recipe ID should come back null, not throw
            Recipe invalid = recipeDAO.getRecipeById(-999999);
            t10 = (invalid == null);
        } catch (Exception e) { t10 = false; }

        if(t1)pass++; else fail++;
        if(t2)pass++; else fail++;
        if(t3)pass++; else fail++;
        if(t4)pass++; else fail++;
        if(t5)pass++; else fail++;
        if(t6)pass++; else fail++;
        if(t7)pass++; else fail++;
        if(t8)pass++; else fail++;
        if(t9)pass++; else fail++;
        if(t10)pass++; else fail++;
    %>

    <h2>🧪 Day 21 — Healthy Meal Optimization Module Test</h2>

    <div class="summary">
        <h2>Results: <%= pass %> / 10 Passed</h2>
        <p style="margin:8px 0 0">
            ✅ Pass: <%= pass %> &nbsp;|&nbsp;
            ❌ Fail: <%= fail %>
        </p>
    </div>

    <!-- Recipes -->
    <div class="section">
        <h3>🍽️ Recipe Management</h3>
        <div class="result <%= t1 ? "pass" : "fail" %>">
            <%= t1 ? "✅" : "❌" %> Recipes loaded:
            <%= allRecipes != null ? allRecipes.size() : 0 %> found
        </div>
        <% if (allRecipes != null && allRecipes.isEmpty()) { %>
            <div class="result fail">⚠️ No recipes in the database yet — add at least one to exercise the rest of the module.</div>
        <% } %>
    </div>

    <!-- Ingredients -->
    <div class="section">
        <h3>🥕 Ingredient Management</h3>
        <div class="result <%= t2 ? "pass" : "fail" %>">
            <%= t2 ? "✅" : "❌" %> Ingredients loaded:
            <%= allIngredients != null ? allIngredients.size() : 0 %> found
        </div>
        <div class="result <%= t9 ? "pass" : "fail" %>">
            <%= t9 ? "✅" : "❌" %> Recipe-ingredient lookup:
            <% if (sampleRecipe != null) { %>
                <%= sampleIngredients != null ? sampleIngredients.size() : 0 %> ingredients for "<%= sampleRecipe.getName() %>"
            <% } else { %>
                skipped (no recipes to test against)
            <% } %>
        </div>
    </div>

    <!-- Dietary Restrictions -->
    <div class="section">
        <h3>🚫 Dietary Restrictions</h3>
        <div class="result <%= t3 ? "pass" : "fail" %>">
            <%= t3 ? "✅" : "❌" %> Available restriction types:
            <%= allRestrictions != null ? allRestrictions.size() : 0 %> found
        </div>
        <div class="result <%= t4 ? "pass" : "fail" %>">
            <%= t4 ? "✅" : "❌" %> Your active restrictions:
            <%= myRestrictions != null ? myRestrictions.size() : 0 %>
            <% if (myRestrictions != null && myRestrictions.isEmpty()) { %>
                (none set — recommendations should show the full unfiltered recipe list)
            <% } %>
        </div>
    </div>

    <!-- Nutrition -->
    <div class="section">
        <h3>📊 Nutrition Facts</h3>
        <div class="result <%= t5 ? "pass" : "fail" %>">
            <%= t5 ? "✅" : "❌" %> Nutrition records loaded:
            <%= allNutrition != null ? allNutrition.size() : 0 %> found
        </div>
    </div>

    <!-- Meal Planner -->
    <div class="section">
        <h3>📅 Meal Planner</h3>
        <div class="result <%= t6 ? "pass" : "fail" %>">
            <%= t6 ? "✅" : "❌" %> Your meal plans loaded:
            <%= myPlans != null ? myPlans.size() : 0 %> found
        </div>
    </div>

    <!-- Recommendation Engine -->
    <div class="section">
        <h3>🧠 Recommendation Engine</h3>
        <div class="result <%= t7 ? "pass" : "fail" %>">
            <%= t7 ? "✅" : "❌" %> Recommended recipes (dietary-filtered, scored):
            <%= recommended != null ? recommended.size() : 0 %> returned
        </div>
        <div class="result <%= t8 ? "pass" : "fail" %>">
            <%= t8 ? "✅" : "❌" %> Food-waste-reduction recipes (expiry-prioritized):
            <%= wasteRecs != null ? wasteRecs.size() : 0 %> returned
        </div>
    </div>

    <!-- Edge case: invalid ID -->
    <div class="section">
        <h3>🧪 Edge Case: Invalid Recipe ID</h3>
        <div class="result <%= t10 ? "pass" : "fail" %>">
            <%= t10 ? "✅" : "❌" %> Looking up a non-existent recipe ID returns null instead of throwing
        </div>
    </div>

    <p><a href="dashboard.jsp">← Back to Dashboard</a></p>
</body>
</html>
