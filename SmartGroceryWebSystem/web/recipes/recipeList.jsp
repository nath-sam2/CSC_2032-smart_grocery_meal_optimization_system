<%-- 
    Document   : recipeList
    Created on : Jul 12, 2026, 9:47:30?AM
    Author     : perer
--%>
<%@ include file="/nav.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Recipe" %>

<div class="page-container">

    <h2>Recipe List</h2>

    <a href="RecipeController?action=create" class="btn btn-primary">+ Add New Recipe</a>

    <br><br>

    <div class="card-grid">

    <%
    List<Recipe> recipes =
    (List<Recipe>)request.getAttribute("recipes");

    for(Recipe r : recipes){
    %>

        <div class="card">
            <h3><%= r.getName() %></h3>
            <p><%= r.getDescription() %></p>

            <p>
                <span class="badge badge-grade-a"><%= r.getMealType() %></span>
                <span class="badge badge-grade-b"><%= r.getCuisine() %></span>
                <span class="badge badge-grade-c"><%= r.getDifficulty() %></span>
            </p>

            <p> <%= r.getCookingTime() %> mins &nbsp; | &nbsp;  <%= r.getServings() %> servings</p>

            <br>

            <a href="RecipeController?action=view&id=<%=r.getRecipeId()%>" class="btn btn-primary">View Details</a>
            <a href="RecipeController?action=edit&id=<%=r.getRecipeId()%>" class="btn btn-secondary">Edit</a>
            <a href="RecipeController?action=delete&id=<%=r.getRecipeId()%>"
               onclick="return confirm('Delete this recipe?');"
               class="btn btn-secondary">Delete</a>
        </div>

    <%
    }
    %>

    </div>

</div>