<%-- 
    Document   : recipeDetails
    Created on : Jul 12, 2026, 5:37:24?PM
    Author     : perer
--%>
<%@ include file="/nav.jsp" %>
<%@ page import="model.Recipe" %>
<%@ page import="model.RecipeIngredient" %>
<%@ page import="model.NutritionFacts" %>

<%@ page import="dao.IngredientDAO" %>
<%@ page import="dao.NutritionFactsDAO" %>

<%@ page import="java.util.List" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html>

<head>
    <title>Recipe Details</title>
</head>


<body>


<%

Recipe recipe = (Recipe) request.getAttribute("recipe");

int recipeId = recipe.getRecipeId();


// Load recipe ingredients
List<RecipeIngredient> ingredients =
        IngredientDAO.getIngredientsByRecipe(recipeId);


// Load nutrition facts
NutritionFactsDAO nutritionDAO = new NutritionFactsDAO();

NutritionFacts nutritionFacts =
        nutritionDAO.getNutritionByRecipeId(recipeId);


request.setAttribute("nutritionFacts", nutritionFacts);

%>



<h1>Recipe Details</h1>



<h2>
    <%= recipe.getName() %>
</h2>



<p>
<b>Description:</b>
<%= recipe.getDescription() %>
</p>


<p>
<b>Meal Type:</b>
<%= recipe.getMealType() %>
</p>


<p>
<b>Cuisine:</b>
<%= recipe.getCuisine() %>
</p>


<p>
<b>Cooking Time:</b>
<%= recipe.getCookingTime() %> minutes
</p>


<p>
<b>Difficulty:</b>
<%= recipe.getDifficulty() %>
</p>


<p>
<b>Servings:</b>
<%= recipe.getServings() %>
</p>



<hr>



<h2>Ingredients</h2>


<table border="1">


<tr>
    <th>Ingredient</th>
    <th>Quantity</th>
    <th>Unit</th>
</tr>



<%

for(RecipeIngredient i : ingredients){

%>


<tr>

<td>
<%= i.getIngredientName() %>
</td>


<td>
<%= i.getQuantity() %>
</td>


<td>
<%= i.getUnit() %>
</td>


</tr>


<%

}

%>


</table>



<hr>



<h2>Nutrition Facts</h2>



<c:if test="${not empty nutritionFacts}">


<table border="1">


<tr>
    <th>Nutrient</th>
    <th>Amount</th>
</tr>


<tr>
    <td>Serving Size</td>
    <td>${nutritionFacts.servingSize}</td>
</tr>


<tr>
    <td>Calories</td>
    <td>${nutritionFacts.calories} kcal</td>
</tr>


<tr>
    <td>Total Fat</td>
    <td>${nutritionFacts.totalFat} g</td>
</tr>


<tr>
    <td>Saturated Fat</td>
    <td>${nutritionFacts.saturatedFat} g</td>
</tr>


<tr>
    <td>Protein</td>
    <td>${nutritionFacts.protein} g</td>
</tr>


<tr>
    <td>Carbohydrates</td>
    <td>${nutritionFacts.totalCarbohydrates} g</td>
</tr>


<tr>
    <td>Dietary Fiber</td>
    <td>${nutritionFacts.dietaryFiber} g</td>
</tr>


<tr>
    <td>Sugar</td>
    <td>${nutritionFacts.totalSugar} g</td>
</tr>


<tr>
    <td>Sodium</td>
    <td>${nutritionFacts.sodium} mg</td>
</tr>


</table>


</c:if>



<c:if test="${empty nutritionFacts}">

<p>
No nutrition information available.
</p>

</c:if>



<br><br>



<a href="RecipeController">
Back to Recipe List
</a>



</body>

</html>