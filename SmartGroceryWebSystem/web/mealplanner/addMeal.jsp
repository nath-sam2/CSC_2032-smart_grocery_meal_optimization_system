<%-- 
    Document   : addMeal
    Created on : Jul 13, 2026, 3:55:07 PM
    Author     : perer
--%>
<%@ include file="/nav.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Recipe" %>

<div class="page-container">

    <h2>Add Recipe To Meal Plan</h2>

    <div class="card">
        <form action="MealPlannerController" method="post">

            <input type="hidden" name="action" value="addMeal">
            <input type="hidden" name="mealPlanId" value="<%=request.getAttribute("mealPlanId")%>">

            <p>
                <label>Select Recipe</label><br>
                <select name="recipeId" style="width:100%; padding:8px;">
                <%
                List<Recipe> recipes =
                (List<Recipe>) request.getAttribute("recipes");

                for(Recipe recipe : recipes){
                %>
                    <option value="<%=recipe.getRecipeId()%>">
                        <%=recipe.getName()%> (<%=recipe.getMealType()%>)
                    </option>
                <%
                }
                %>
                </select>
            </p>

            <p>
                <label>Meal Type</label><br>
                <select name="mealType" style="width:100%; padding:8px;">
                    <option>Breakfast</option>
                    <option>Lunch</option>
                    <option>Dinner</option>
                    <option>Snack</option>
                </select>
            </p>

            <p>
                <label>Date</label><br>
                <input type="date" name="mealDate" required style="width:100%; padding:8px;">
            </p>

            <br>
            <button type="submit" class="btn btn-primary">Add Meal</button>
            <a href="MealPlannerController?action=view&id=<%=request.getAttribute("mealPlanId")%>" class="btn btn-secondary">Cancel</a>

        </form>
    </div>

</div>