<%-- 
    Document   : addMeal
    Created on : Jul 13, 2026, 3:55:07?PM
    Author     : perer
--%>
<%@ include file="/nav.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Recipe" %>


<html>

<head>

<title>Add Meal</title>

</head>


<body>


<h2>Add Recipe To Meal Plan</h2>



<form action="MealPlannerController" method="post">


<input type="hidden"
       name="action"
       value="addMeal">



<input type="hidden"
       name="mealPlanId"
       value="<%=request.getAttribute("mealPlanId")%>">



<label>Select Recipe:</label>


<br>


<select name="recipeId">


<%

List<Recipe> recipes =
(List<Recipe>)
request.getAttribute("recipes");



for(Recipe recipe : recipes){

%>


<option value="<%=recipe.getRecipeId()%>">

<%=recipe.getName()%>

</option>


<%

}

%>


</select>



<br><br>



<label>Meal Type:</label>


<br>


<select name="mealType">


<option>Breakfast</option>

<option>Lunch</option>

<option>Dinner</option>

<option>Snack</option>


</select>



<br><br>



<label>Date:</label>


<br>


<input type="date"
       name="mealDate"
       required>


<br><br>



<button type="submit">

Add Meal

</button>


</form>


</body>

</html>
