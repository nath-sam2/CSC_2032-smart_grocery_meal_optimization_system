<%-- 
    Document   : nav
    Created on : Jul 18, 2026, 10:43:53?AM
    Author     : perer
--%>

<!DOCTYPE html>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">

<div class="navbar">
    <div class="brand">Smart Grocery - Healthy Meal Optimization</div>
    <div class="nav-links">
        <a href="<%=request.getContextPath()%>/MealDashboardController">Dashboard</a>
        <a href="<%=request.getContextPath()%>/RecipeController">Recipes</a>
        <a href="<%=request.getContextPath()%>/RecommendationController">Recommendations</a>
        <a href="<%=request.getContextPath()%>/MealPlannerController">Meal Planner</a>
        <a href="<%=request.getContextPath()%>/ShoppingListController">Shopping List</a>
    </div>
</div>