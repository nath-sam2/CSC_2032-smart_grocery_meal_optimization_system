<%-- 
    Document   : addRecipe
    Created on : Jul 12, 2026, 9:48:28?AM
    Author     : perer
--%>
<%@ include file="/nav.jsp" %>

<div class="page-container">

    <h2>Add Recipe</h2>

    <div class="card">
        <form action="RecipeController" method="post">

            <input type="hidden" name="action" value="insert">

            <p>
                <label>Name</label><br>
                <input type="text" name="name" required style="width:100%; padding:8px;">
            </p>

            <p>
                <label>Description</label><br>
                <textarea name="description" rows="3" style="width:100%; padding:8px;"></textarea>
            </p>

            <p>
                <label>Meal Type</label><br>
                <select name="mealType" style="width:100%; padding:8px;">
                    <option value="Breakfast">Breakfast</option>
                    <option value="Lunch">Lunch</option>
                    <option value="Dinner">Dinner</option>
                </select>
            </p>

            <p>
                <label>Cuisine</label><br>
                <input type="text" name="cuisine" style="width:100%; padding:8px;">
            </p>

            <p>
                <label>Cooking Time (minutes)</label><br>
                <input type="number" name="cookingTime" required style="width:100%; padding:8px;">
            </p>

            <p>
                <label>Difficulty</label><br>
                <select name="difficulty" style="width:100%; padding:8px;">
                    <option value="Easy">Easy</option>
                    <option value="Medium">Medium</option>
                    <option value="Hard">Hard</option>
                </select>
            </p>

            <p>
                <label>Servings</label><br>
                <input type="number" name="servings" required style="width:100%; padding:8px;">
            </p>

            <br>
            <button type="submit" class="btn btn-primary">Save Recipe</button>
            <a href="RecipeController" class="btn btn-secondary">Cancel</a>

        </form>
    </div>

</div>