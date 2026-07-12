<%-- 
    Document   : userDietaryRestrictionList
    Created on : Jul 12, 2026, 5:22:10 PM
    Author     : perer
--%>

<%@ page import="java.util.List" %>
<%@ page import="model.DietaryRestriction" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<html>

<head>

<title>User Dietary Restrictions</title>


<style>

table {
    border-collapse: collapse;
    width: 80%;
}


th, td {

    border: 1px solid black;
    padding: 10px;
    text-align: left;

}


</style>


</head>



<body>


<h1>User Dietary Restrictions</h1>


<a href="addUserDietaryRestriction.jsp">
    Add Restriction
</a>


<br><br>



<%

int userId = (Integer)request.getAttribute("userId");


List<DietaryRestriction> restrictions =
(List<DietaryRestriction>)request.getAttribute("restrictions");


%>



<table>


<tr>

<th>Restriction ID</th>
<th>Restriction Name</th>
<th>Description</th>
<th>Action</th>

</tr>



<%

if(restrictions != null && !restrictions.isEmpty()){


    for(DietaryRestriction restriction : restrictions){

%>



<tr>


<td>
<%= restriction.getRestrictionId() %>
</td>


<td>
<%= restriction.getRestrictionName() %>
</td>


<td>
<%= restriction.getDescription() %>
</td>


<td>

<a href="UserDietaryRestrictionController?action=delete&userId=<%=userId%>&restrictionId=<%=restriction.getRestrictionId()%>"
onclick="return confirm('Remove this restriction?');">

Delete

</a>

</td>


</tr>



<%

    }

}

else {

%>


<tr>

<td colspan="4">

No restrictions assigned to this user.

</td>

</tr>


<%

}

%>


</table>



</body>

</html>
