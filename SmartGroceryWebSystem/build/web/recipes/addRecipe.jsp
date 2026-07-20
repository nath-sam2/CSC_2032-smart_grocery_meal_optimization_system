<%-- 
    Document   : addRecipe
    Created on : Jul 12, 2026, 9:48:28?AM
    Author     : perer
--%>
<%@ include file="/nav.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="page-container">

    <h2>Add Recipe</h2>

    <c:if test="${not empty formErrors}">
        <div class="alert alert-error" style="color: #b00020; margin-bottom: 10px;">
            <ul style="margin: 0; padding-left: 20px;">
                <c:forEach var="err" items="${formErrors}">
                    <li>${err}</li>
                </c:forEach>
            </ul>
        </div>
    </c:if>

    <c:if test="${not empty duplicateNameError}">
        <div class="alert alert-error" style="color: #b00020; margin-bottom: 10px;">
            ${duplicateNameError}
        </div>
    </c:if>

    <div class="card">
        <form action="RecipeController" method="post">

            <input type="hidden" name="action" value="insert">

            <p>
                <label>Name</label><br>
                <input type="text" name="name" value="${param.name}" required style="width:100%; padding:8px;">
            </p>

            <p>
                <label>Description</label><br>
                <textarea name="description" rows="3" style="width:100%; padding:8px;">${param.description}</textarea>
            </p>

            <p>
                <label>Meal Type</label><br>
                <select name="mealType" style="width:100%; padding:8px;">
                    <option value="Breakfast" ${param.mealType == 'Breakfast' ? 'selected' : ''}>Breakfast</option>
                    <option value="Lunch" ${param.mealType == 'Lunch' ? 'selected' : ''}>Lunch</option>
                    <option value="Dinner" ${param.mealType == 'Dinner' ? 'selected' : ''}>Dinner</option>
                </select>
            </p>

            <p>
                <label>Cuisine</label><br>
                <input type="text" name="cuisine" value="${param.cuisine}" style="width:100%; padding:8px;">
            </p>

            <p>
                <label>Cooking Time (minutes)</label><br>
                <input type="number" name="cookingTime" value="${param.cookingTime}" required style="width:100%; padding:8px;">
            </p>

            <p>
                <label>Difficulty</label><br>
                <select name="difficulty" style="width:100%; padding:8px;">
                    <option value="Easy" ${param.difficulty == 'Easy' ? 'selected' : ''}>Easy</option>
                    <option value="Medium" ${param.difficulty == 'Medium' ? 'selected' : ''}>Medium</option>
                    <option value="Hard" ${param.difficulty == 'Hard' ? 'selected' : ''}>Hard</option>
                </select>
            </p>

            <p>
                <label>Servings</label><br>
                <input type="number" name="servings" value="${param.servings}" required style="width:100%; padding:8px;">
            </p>

            <br>
            <button type="submit" class="btn btn-primary">Save Recipe</button>
            <a href="RecipeController" class="btn btn-secondary">Cancel</a>

        </form>
    </div>

</div>