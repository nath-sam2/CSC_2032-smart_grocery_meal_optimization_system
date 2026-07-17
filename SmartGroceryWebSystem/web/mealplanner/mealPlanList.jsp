<%-- 
    Document   : mealPlanList
    Created on : Jul 13, 2026, 3:53:39?PM
    Author     : perer
--%>

<%@ page import="java.util.List" %>
<%@ page import="model.MealPlanner" %>

<html>

<head>

<title>My Meal Plans</title>

</head>


<body>


<h2>My Healthy Meal Plans</h2>


<a href="MealPlannerController?action=create">
Create New Meal Plan
</a>


<br><br>



<table border="1" cellpadding="10">


<tr>

<th>ID</th>
<th>Name</th>
<th>Start Date</th>
<th>End Date</th>
<th>Action</th>

</tr>



<%

List<MealPlanner> plans =
(List<MealPlanner>)
request.getAttribute("mealPlans");



if(plans != null){


for(MealPlanner plan : plans){

%>


<tr>


<td>
<%=plan.getMealPlanId()%>
</td>


<td>
<%=plan.getPlanName()%>
</td>


<td>
<%=plan.getStartDate()%>
</td>


<td>
<%=plan.getEndDate()%>
</td>


<td>

<a href="MealPlannerController?action=view&id=<%=plan.getMealPlanId()%>">

View

</a>


</td>


</tr>


<%

}

}

%>


</table>


</body>

</html>
