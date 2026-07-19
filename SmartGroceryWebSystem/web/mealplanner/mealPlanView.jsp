<%-- 
    Document   : mealPlanView
    Created on : Jul 13, 2026, 3:54:23?PM
    Author     : perer
--%>
<%@ include file="/nav.jsp" %>
<%@ page import="model.MealPlanner" %>
<%@ page import="model.MealPlanDetail" %>
<%@ page import="java.util.List" %>


<html>

<head>

<title>Meal Plan Details</title>

</head>


<body>


<h2>
Meal Plan:
${mealPlan.planName}
</h2>


<a href="MealPlannerController?action=addMeal&id=${mealPlan.mealPlanId}">
Add Meal
</a>


<br><br>


<table border="1" cellpadding="10">


<tr>

<th>Date</th>
<th>Meal Type</th>
<th>Recipe ID</th>
<th>Action</th>

</tr>



<%

MealPlanner plan =
(MealPlanner)
request.getAttribute("mealPlan");


List<MealPlanDetail> details =
plan.getMealPlanDetails();



for(MealPlanDetail detail : details){

%>


<tr>


<td>
<%=detail.getMealDate()%>
</td>


<td>
<%=detail.getMealType()%>
</td>


<td>
<%=detail.getRecipeId()%>
</td>


<td>


<a href="MealPlannerController?action=deleteMeal&id=<%=detail.getMealPlanDetailId()%>">

Delete

</a>


</td>


</tr>


<%

}

%>


</table>


<br>


<a href="MealPlannerController?action=list">
Back to Plans
</a>


</body>

</html>
