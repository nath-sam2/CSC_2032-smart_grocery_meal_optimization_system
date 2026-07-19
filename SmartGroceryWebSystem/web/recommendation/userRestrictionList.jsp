<%-- 
    Document   : userDietaryRestrictionList
    Created on : Jul 12, 2026, 5:22:10?PM
    Author     : perer
--%>

<%@ include file="/nav.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="model.DietaryRestriction" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="page-container">

    <h2>My Dietary Restrictions</h2>

    <a href="DietaryRestrictionController?action=addUser" class="btn btn-primary">+ Add New Restriction</a>

    <br><br>

    <div class="card-grid">

    <%
    List<DietaryRestriction> list =
    (List<DietaryRestriction>) request.getAttribute("userRestrictions");

    if(list != null && !list.isEmpty()){
        for(DietaryRestriction r : list){
    %>
        <div class="card">
            <h3><%= r.getRestrictionName() %></h3>
            <p><%= r.getDescription() %></p>

            <form action="DietaryRestrictionController" method="post">
                <input type="hidden" name="action" value="deleteUserRestriction">
                <input type="hidden" name="restrictionId" value="<%=r.getRestrictionId()%>">
                <button type="submit"
                        onclick="return confirm('Remove this restriction?');"
                        class="btn btn-secondary">Remove</button>
            </form>
        </div>
    <%
        }
    }
    else{
    %>
        <p>You have no dietary restrictions.</p>
    <%
    }
    %>

    </div>

    <br>
    <a href="RecipeController" class="btn btn-secondary">Back to Recipes</a>

</div>