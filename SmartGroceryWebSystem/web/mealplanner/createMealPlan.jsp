<%-- 
    Document   : createMealPlan
    Created on : Jul 13, 2026, 3:52:45 PM
    Author     : perer
--%>
<%@ include file="/nav.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
<title>Create Meal Plan</title>
</head>

<body>


<h2>Create Healthy Meal Plan</h2>


<form action="MealPlannerController" method="post">


<input type="hidden" name="action" value="createPlan">


<label>Plan Name:</label>

<br>

<input type="text" 
       name="planName"
       value="My Healthy Weekly Plan"
       required>


<br><br>


<label>Start Date:</label>

<br>

<input type="date"
       name="startDate"
       required>


<br><br>



<label>End Date:</label>

<br>

<input type="date"
       name="endDate"
       required>


<br><br>



<button type="submit">
Create Plan
</button>


</form>


<br>


<a href="MealPlannerController?action=list">
Back
</a>


</body>
</html>
