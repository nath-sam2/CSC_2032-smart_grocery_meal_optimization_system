<%-- 
    Document   : editRecipe
    Created on : Jul 12, 2026, 9:49:22?AM
    Author     : perer
--%>
<%@ include file="/nav.jsp" %>
<%@ page import="model.Recipe" %>

<%
Recipe r = (Recipe)request.getAttribute("recipe");
%>


<html>

<head>
<title>Edit Recipe</title>
</head>


<body>


<h1>Edit Recipe</h1>


<form action="RecipeController" method="post">


<input type="hidden" name="action" value="update">


<input type="hidden" name="recipeId"
value="<%=r.getRecipeId()%>">


Name:

<input type="text" name="name"
value="<%=r.getName()%>">

<br>


Description:

<textarea name="description">
<%=r.getDescription()%>
</textarea>

<br>


Meal Type:

<input type="text" name="mealType"
value="<%=r.getMealType()%>">

<br>


Cuisine:

<input type="text" name="cuisine"
value="<%=r.getCuisine()%>">

<br>


Cooking Time:

<input type="number" name="cookingTime"
value="<%=r.getCookingTime()%>">

<br>


Difficulty:

<input type="text" name="difficulty"
value="<%=r.getDifficulty()%>">

<br>


Servings:

<input type="number" name="servings"
value="<%=r.getServings()%>">

<br>


<button type="submit">
Update Recipe
</button>


</form>


</body>
</html>
