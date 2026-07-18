<%-- 
    Document   : generateShoppingList
    Created on : Jul 13, 2026, 5:33:08 PM
    Author     : perer
--%>
<%@ include file="/nav.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" %>


<html>

<head>

<title>
Generate Shopping List
</title>

</head>


<body>


<h2>
Generate Shopping List From Meal Plan
</h2>



<form action="ShoppingListController"
      method="get">


<input type="hidden"
       name="action"
       value="generate">



<label>
Meal Plan ID:
</label>


<input type="number"
       name="mealPlanId"
       required>


<br><br>


<button type="submit">

Generate Shopping List

</button>


</form>



<br>


<a href="ShoppingListController?action=list">

View Shopping Lists

</a>



</body>

</html>