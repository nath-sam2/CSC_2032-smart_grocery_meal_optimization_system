<%@ include file="/nav.jsp" %>
<%@ page import="model.Recipe" %>

<%
Recipe r = (Recipe)request.getAttribute("recipe");
%>

<div class="page-container">

    <h2>Edit Recipe</h2>

    <div class="card">
        <form action="RecipeController" method="post">

            <input type="hidden" name="action" value="update">
            <input type="hidden" name="recipeId" value="<%=r.getRecipeId()%>">

            <p>
                <label>Name</label><br>
                <input type="text" name="name" value="<%=r.getName()%>" required style="width:100%; padding:8px;">
            </p>

            <p>
                <label>Description</label><br>
                <textarea name="description" rows="3" style="width:100%; padding:8px;"><%=r.getDescription()%></textarea>
            </p>

            <p>
                <label>Meal Type</label><br>
                <select name="mealType" style="width:100%; padding:8px;">
                    <option value="Breakfast" <%="Breakfast".equals(r.getMealType()) ? "selected" : ""%>>Breakfast</option>
                    <option value="Lunch" <%="Lunch".equals(r.getMealType()) ? "selected" : ""%>>Lunch</option>
                    <option value="Dinner" <%="Dinner".equals(r.getMealType()) ? "selected" : ""%>>Dinner</option>
                </select>
            </p>

            <p>
                <label>Cuisine</label><br>
                <input type="text" name="cuisine" value="<%=r.getCuisine()%>" style="width:100%; padding:8px;">
            </p>

            <p>
                <label>Cooking Time (minutes)</label><br>
                <input type="number" name="cookingTime" value="<%=r.getCookingTime()%>" required style="width:100%; padding:8px;">
            </p>

            <p>
                <label>Difficulty</label><br>
                <select name="difficulty" style="width:100%; padding:8px;">
                    <option value="Easy" <%="Easy".equals(r.getDifficulty()) ? "selected" : ""%>>Easy</option>
                    <option value="Medium" <%="Medium".equals(r.getDifficulty()) ? "selected" : ""%>>Medium</option>
                    <option value="Hard" <%="Hard".equals(r.getDifficulty()) ? "selected" : ""%>>Hard</option>
                </select>
            </p>

            <p>
                <label>Servings</label><br>
                <input type="number" name="servings" value="<%=r.getServings()%>" required style="width:100%; padding:8px;">
            </p>

            <br>
            <button type="submit" class="btn btn-primary">Update Recipe</button>
            <a href="RecipeController" class="btn btn-secondary">Cancel</a>

        </form>
    </div>

</div>