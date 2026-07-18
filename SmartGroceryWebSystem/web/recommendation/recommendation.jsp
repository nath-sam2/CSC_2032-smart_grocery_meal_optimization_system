<%-- 
    Document   : recommendation
    Created on : Jul 13, 2026, 9:29:22?AM
    Author     : perer
--%>
<%@ include file="/nav.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Recipe" %>
<%@ page import="dao.NutritionFactsDAO" %>
<%@ page import="model.NutritionFacts" %>
<%@ page import="service.RecommendationEngine" %>


<html>

<head>

<title>Healthy Meal Recommendations</title>


<style>

table{

border-collapse:collapse;
width:90%;

}


th,td{

border:1px solid black;
padding:10px;

}


</style>


</head>


<body>


<h1>
Healthy Meal Recommendations
</h1>



<table>


<tr>

<th>
Recipe Name
</th>


<th>
Meal Type
</th>


<th>
Cuisine
</th>


<th>
Cooking Time
</th>


<th>
Difficulty
</th>


<th>
Calories
</th>


<th>
NutriScore
</th>


</tr>



<%


List<Recipe> recipes =
(List<Recipe>)request.getAttribute(
"recommendations"
);



NutritionFactsDAO nutritionDAO =
new NutritionFactsDAO();



RecommendationEngine engine =
new RecommendationEngine();



if(recipes != null){


for(Recipe recipe : recipes){



NutritionFacts nutrition =
nutritionDAO.getNutritionFactsByRecipeId(
recipe.getRecipeId()
);



char grade =
engine.getRecipeGrade(
recipe.getRecipeId()
);



%>



<tr>


<td>

<a href="RecipeController?action=view&id=<%=recipe.getRecipeId()%>">

<%=recipe.getName()%>

</a>

</td>



<td>
<%=recipe.getMealType()%>
</td>


<td>
<%=recipe.getCuisine()%>
</td>



<td>
<%=recipe.getCookingTime()%> mins
</td>



<td>
<%=recipe.getDifficulty()%>
</td>



<td>

<%

if(nutrition != null){

%>

<%=nutrition.getCalories()%> kcal


<%

}
else{

%>

N/A


<%

}

%>

</td>




<td>

<%=grade%>


</td>



</tr>



<%


}

}


%>



</table>



</body>

</html>
