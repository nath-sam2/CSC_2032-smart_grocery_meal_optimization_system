<%-- 
    Document   : mealPlanView
    Created on : Jul 13, 2026, 3:54:23?PM
    Author     : perer
--%>
<%@ include file="/nav.jsp" %>
<%@ page import="model.MealPlanner" %>
<%@ page import="model.MealPlanDetail" %>
<%@ page import="model.Recipe" %>
<%@ page import="dao.RecipeDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedHashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.time.LocalDate" %>

<%
MealPlanner plan =
(MealPlanner) request.getAttribute("mealPlan");

List<MealPlanDetail> details =
plan.getMealPlanDetails();

RecipeDAO recipeDAO = new RecipeDAO();

// Group meal details by date, preserving order
Map<LocalDate, List<MealPlanDetail>> grouped = new LinkedHashMap<>();

for (MealPlanDetail detail : details) {
    grouped.computeIfAbsent(detail.getMealDate(), k -> new java.util.ArrayList<>()).add(detail);
}
%>

<div class="page-container">

    <h2>Meal Plan: <%= plan.getPlanName() %></h2>

    <p>
        <%= plan.getStartDate() %> to <%= plan.getEndDate() %>
    </p>

    <a href="MealPlannerController?action=addMeal&id=<%=plan.getMealPlanId()%>" class="btn btn-primary">+ Add Meal</a>

    <br><br>

    <%
    for (Map.Entry<LocalDate, List<MealPlanDetail>> entry : grouped.entrySet()) {
    %>

    <div class="card">
        <h3><%= entry.getKey() %></h3>

        <table>
            <tr>
                <th>Meal Type</th>
                <th>Recipe</th>
                <th>Action</th>
            </tr>

            <%
            for (MealPlanDetail detail : entry.getValue()) {

                Recipe recipe = recipeDAO.getRecipeById(detail.getRecipeId());
                String recipeName = (recipe != null) ? recipe.getName() : "Unknown Recipe";
            %>

            <tr>
                <td data-label="Meal Type"><span class="badge badge-grade-b"><%= detail.getMealType() %></span></td>
                <td data-label="Recipe">
                    <a href="RecipeController?action=view&id=<%=detail.getRecipeId()%>" style="color: var(--green);"><%= recipeName %></a>
                </td>
                <td data-label="Action">
                    <a href="MealPlannerController?action=deleteMeal&id=<%=detail.getMealPlanDetailId()%>"
                       onclick="return confirm('Remove this meal?');"
                       class="btn btn-secondary">Delete</a>
                </td>
            </tr>

            <%
            }
            %>

        </table>
    </div>

    <%
    }
    %>

    <br>
    <a href="MealPlannerController?action=list" class="btn btn-secondary">Back to Plans</a>

</div>