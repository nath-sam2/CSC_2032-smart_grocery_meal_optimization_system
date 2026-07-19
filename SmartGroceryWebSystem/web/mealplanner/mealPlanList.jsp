<%-- 
    Document   : mealPlanList
    Created on : Jul 13, 2026, 3:53:39?PM
    Author     : perer
--%>
<%@ include file="/nav.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="model.MealPlanner" %>

<div class="page-container">

    <h2>My Healthy Meal Plans</h2>

    <a href="MealPlannerController?action=create" class="btn btn-primary">+ Create New Meal Plan</a>

    <br><br>

    <div class="card-grid">

    <%
    List<MealPlanner> plans =
    (List<MealPlanner>) request.getAttribute("mealPlans");

    if(plans != null){
        for(MealPlanner plan : plans){
    %>

        <div class="card">
            <h3><%=plan.getPlanName()%></h3>

            <p>
                <span class="badge badge-grade-b"><%=plan.getStartDate()%> to <%=plan.getEndDate()%></span>
            </p>

            <p>Plan #<%=plan.getMealPlanId()%></p>

            <br>

            <a href="MealPlannerController?action=view&id=<%=plan.getMealPlanId()%>" class="btn btn-primary">View Plan</a>
        </div>

    <%
        }
    }
    %>

    </div>

    <%
    if(plans == null || plans.isEmpty()){
    %>
        <p>You don't have any meal plans yet. Create one to get started!</p>
    <%
    }
    %>

</div>
