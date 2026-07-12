<%-- 
    Document   : addRecipe
    Created on : Jul 12, 2026, 9:48:28?AM
    Author     : perer
--%>

<html>

<head>
<title>Add Recipe</title>
</head>

<body>


<h1>Add Recipe</h1>


<form action="RecipeController" method="post">


<input type="hidden" name="action" value="insert">


Name:
<input type="text" name="name">
<br>


Description:
<textarea name="description"></textarea>
<br>


Meal Type:
<input type="text" name="mealType">
<br>


Cuisine:
<input type="text" name="cuisine">
<br>


Cooking Time:
<input type="number" name="cookingTime">
<br>


Difficulty:
<input type="text" name="difficulty">
<br>


Servings:
<input type="number" name="servings">
<br>


<button type="submit">
Save Recipe
</button>


</form>


</body>

</html>
