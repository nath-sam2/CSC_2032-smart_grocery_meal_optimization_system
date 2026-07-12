<%-- 
    Document   : dietaryRestrictionList
    Created on : Jul 12, 2026, 4:53:27 PM
    Author     : perer
--%>

<%@ page import="java.util.List" %>
<%@ page import="model.DietaryRestriction" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<html>

<head>
    <title>Dietary Restrictions</title>
    <style>

table {
    border-collapse: collapse;
    width: 90%;
}


th, td {
    border: 1px solid black;
    padding: 10px;
    text-align: left;
}


td:nth-child(3) {
    max-width: 400px;
    word-wrap: break-word;
}


a {
    color: blue;
}

</style>
</head>


<body>


<h1>Dietary Restrictions</h1>


<a href="addRestriction.jsp">
    Add New Restriction
</a>


<br><br>



<table border="1" cellpadding="10">


<tr>

<th>ID</th>
<th>Restriction Name</th>
<th>Description</th>
<th>Action</th>

</tr>



<%

List<DietaryRestriction> restrictions =
(List<DietaryRestriction>) request.getAttribute("restrictions");


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


<a href="DietaryRestrictionController?action=delete&id=<%=restriction.getRestrictionId()%>"
onclick="return confirm('Delete this restriction?');">

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

No Dietary Restrictions Found

</td>

</tr>


<%

}

%>


</table>



</body>

</html>
