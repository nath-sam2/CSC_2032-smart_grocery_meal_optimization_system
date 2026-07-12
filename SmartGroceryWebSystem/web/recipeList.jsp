<%-- 
    Document   : recipeList
    Created on : Jul 12, 2026, 9:47:30?AM
    Author     : perer
--%>

<%@ page import="java.util.List" %>
<%@ page import="model.Recipe" %>

<html>
<head>
<title>Recipe List</title>
</head>

<body>


<h1>Recipe List</h1>

<a href="addRecipe.jsp">
    Add New Recipe
</a>


<hr>


<%
List<Recipe> recipes =
(List<Recipe>)request.getAttribute("recipes");


for(Recipe r : recipes){
%>


<h2>
<%= r.getName() %>
</h2>


<p>
<%= r.getDescription() %>
</p>


<p>
Meal Type:
<%= r.getMealType() %>
</p>


<p>
Cuisine:
<%= r.getCuisine() %>
</p>


<a href="RecipeController?action=edit&id=<%=r.getRecipeId()%>">
Edit
</a>


|

<a href="RecipeController?action=delete&id=<%=r.getRecipeId()%>"
onclick="return confirm('Delete this recipe?');">
Delete
</a>


<hr>


<%
}
%>


</body>
</html>
