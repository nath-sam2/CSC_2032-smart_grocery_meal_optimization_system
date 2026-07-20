<%-- 
    Document   : generateShoppingList
    Created on : Jul 13, 2026, 5:33:08 PM
    Author     : perer
--%>
<%@ include file="/nav.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.MealPlanner" %>
<%@ page import="dao.MealPlannerDAO" %>

<%
HttpSession genSession = request.getSession();
Integer genUserId = (Integer) genSession.getAttribute("userId");
if (genUserId == null) {
    genUserId = 6;
}

MealPlannerDAO mealPlannerDAO = new MealPlannerDAO();
List<MealPlanner> userPlans = mealPlannerDAO.getMealPlansByUser(genUserId);
%>

<div class="page-container">

    <h2>Generate Shopping List From Meal Plan</h2>

    <div class="card">

        <% if (userPlans == null || userPlans.isEmpty()) { %>

            <p>You don't have any meal plans yet.</p>
            <br>
            <a href="<%=request.getContextPath()%>/MealPlannerController?action=create" class="btn btn-primary">Create a Meal Plan</a>

        <% } else { %>

            <form action="<%=request.getContextPath()%>/ShoppingListController" method="get">

                <input type="hidden" name="action" value="generate">

                <p>
                    <label>Select Meal Plan</label><br>
                    <select name="mealPlanId" style="width:100%; padding:8px;">
                    <%
                    for (MealPlanner plan : userPlans) {
                    %>
                        <option value="<%=plan.getMealPlanId()%>">
                            <%=plan.getPlanName()%> (<%=plan.getStartDate()%> to <%=plan.getEndDate()%>)
                        </option>
                    <%
                    }
                    %>
                    </select>
                </p>

                <br>
                <button type="submit" class="btn btn-primary">Generate Shopping List</button>

            </form>

        <% } %>

    </div>

    <br>
    <a href="<%=request.getContextPath()%>/ShoppingListController?action=list" class="btn btn-secondary">View Shopping Lists</a>

</div>