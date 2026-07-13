<%-- 
    Document   : dietaryRestrictionList
    Created on : Jul 12, 2026, 4:53:27 PM
    Author     : perer
--%>

<%@ page import="java.util.List" %>
<%@ page import="model.DietaryRestriction" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<%@ page import="java.util.List" %>
<%@ page import="model.DietaryRestriction" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<html>

<head>

<title>Dietary Restrictions</title>


<style>

body{
    font-family: Arial;
    margin:40px;
}


table {

    border-collapse: collapse;
    width:90%;

}


th, td {

    border:1px solid black;
    padding:10px;

}


th {

    background:#eeeeee;

}


a {

    color:blue;
    text-decoration:none;

}


.action a {

    margin-right:10px;

}

</style>


</head>


<body>


<h1>Dietary Restrictions</h1>



<a href="addRestriction.jsp">
    Add New Restriction
</a>


<br><br>



<table>


<tr>

<th>ID</th>

<th>Restriction Name</th>

<th>Description</th>

<th>Action</th>

</tr>



<%

List<DietaryRestriction> restrictions =
(List<DietaryRestriction>)request.getAttribute("restrictions");



if(restrictions != null && !restrictions.isEmpty()){


for(DietaryRestriction restriction : restrictions){


%>


<tr>


<td>

<%=restriction.getRestrictionId()%>

</td>



<td>

<%=restriction.getRestrictionName()%>

</td>



<td>

<%=restriction.getDescription()%>

</td>



<td class="action">


<a href="DietaryRestrictionController?action=edit&id=<%=restriction.getRestrictionId()%>">

Edit

</a>



<a href="DietaryRestrictionController?action=delete&id=<%=restriction.getRestrictionId()%>"
onclick="return confirm('Delete this restriction?');">

Delete

</a>



</td>


</tr>



<%

}

}

else{

%>


<tr>

<td colspan="4">

No Dietary Restrictions Found

</td>

</tr>


<%

}

%>



</table>



</body>


</html>