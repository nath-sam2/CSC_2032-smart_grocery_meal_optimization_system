<%-- 
    Document   : foodWasteReduction
    Created on : Jul 15, 2026, 4:15:09?PM
    Author     : perer
--%>

<%@page import="java.util.List"%>
<%@page import="model.Recipe"%>
<%@page import="service.RecommendationEngine"%>

<%
List<Recipe> recipes =
(List<Recipe>)request.getAttribute("recipes");

RecommendationEngine engine =
new RecommendationEngine();
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Food Waste Reduction</title>

<style>

body{

font-family:Arial,Helvetica,sans-serif;
background:#f5f5f5;
margin:0;

}

.container{

width:90%;
margin:auto;
padding:20px;

}

h1{

color:#2e7d32;

}

.card{

background:white;
padding:20px;
margin-bottom:20px;
border-radius:10px;
box-shadow:0px 2px 8px rgba(0,0,0,.2);

}

table{

width:100%;
border-collapse:collapse;

}

th{

background:#2e7d32;
color:white;
padding:12px;

}

td{

padding:10px;
border-bottom:1px solid #ddd;

}

tr:hover{

background:#f2f2f2;

}

.badge{

padding:5px 10px;
border-radius:20px;
color:white;
font-weight:bold;

}

.A{

background:#2e7d32;

}

.B{

background:#66bb6a;

}

.C{

background:#fbc02d;

}

.D{

background:#ef6c00;

}

.E{

background:#d32f2f;

}

.placeholder{

color:#777;
font-style:italic;

}

</style>

</head>

<body>

<div class="container">

<h1>Food Waste Reduction</h1>

<div class="card">

<h2>Ingredients Expiring Soon</h2>

<p class="placeholder">

Inventory integration pending...

This section will display ingredients that are close to expiry
after Member 1 completes the Inventory module.

</p>

<ul>

<li>Milk (1 day left)</li>

<li>Spinach (2 days left)</li>

<li>Carrot (3 days left)</li>

</ul>

</div>

<div class="card">

<h2>Recommended Recipes</h2>

<table>

<tr>

<th>Recipe</th>

<th>Meal Type</th>

<th>Cuisine</th>

<th>Cooking Time</th>

<th>Difficulty</th>

<th>NutriScore</th>

</tr>

<%

if(recipes!=null){

for(Recipe recipe:recipes){

char grade=
engine.getRecipeGrade(recipe.getRecipeId());

%>

<tr>

<td><%=recipe.getName()%></td>

<td><%=recipe.getMealType()%></td>

<td><%=recipe.getCuisine()%></td>

<td><%=recipe.getCookingTime()%> mins</td>

<td><%=recipe.getDifficulty()%></td>

<td>

<span class="badge <%=grade%>">

<%=grade%>

</span>

</td>

</tr>

<%

}

}

%>

</table>

</div>

<div class="card">

<h2>Estimated Food Waste Reduction</h2>

<h3 style="color:#2e7d32;">Approximately 75%</h3>

<p class="placeholder">

This percentage will be calculated using inventory
expiry information after integration with Member 1.

</p>

</div>

</div>

</body>

</html>
