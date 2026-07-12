<%-- 
    Document   : dietaryRestrictions
    Created on : Jul 12, 2026, 11:20:37?PM
    Author     : perer
--%>

<%@ page import="java.util.List" %>
<%@ page import="model.DietaryRestriction" %>


<html>

<head>

<title>
Dietary Restrictions
</title>

</head>


<body>


<h2>
My Dietary Restrictions
</h2>



<table border="1">


<tr>

<th>
Restriction
</th>

<th>
Description
</th>

<th>
Action
</th>


</tr>



<%

List<DietaryRestriction> restrictions =
(List<DietaryRestriction>)
request.getAttribute("restrictions");



for(DietaryRestriction r : restrictions){

%>


<tr>

<td>
<%=r.getRestrictionName()%>
</td>


<td>
<%=r.getDescription()%>
</td>


<td>


<a href="DietaryRestrictionController?action=delete&restrictionId=<%=r.getRestrictionId()%>">

Delete

</a>


</td>


</tr>


<%

}

%>


</table>




<h3>
Add New Restriction
</h3>



<form action="DietaryRestrictionController"
method="post">


<input type="hidden"
name="action"
value="add">



<select name="restrictionId">


<%

List<DietaryRestriction> all =
(List<DietaryRestriction>)
request.getAttribute("allRestrictions");



for(DietaryRestriction r: all){

%>


<option value="<%=r.getRestrictionId()%>">

<%=r.getRestrictionName()%>

</option>


<%

}

%>


</select>



<br><br>


<button type="submit">

Add Restriction

</button>


</form>



</body>

</html>