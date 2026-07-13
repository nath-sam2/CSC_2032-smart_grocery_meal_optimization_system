<%-- 
    Document   : addUserDietaryRestriction
    Created on : Jul 12, 2026, 5:19:11 PM
    Author     : perer
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>
<%@ page import="model.DietaryRestriction" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<html>

<head>

<title>Add Dietary Restriction</title>

</head>


<body>


<h2>Add Dietary Restriction</h2>



<form action="DietaryRestrictionController" method="post">


<input type="hidden"
       name="action"
       value="addUserRestriction">



<label>Select Restriction:</label>

<br><br>



<select name="restrictionId" required>


<option value="">
-- Select Restriction --
</option>



<%

List<DietaryRestriction> restrictions =
(List<DietaryRestriction>)
request.getAttribute("restrictions");



if(restrictions != null){


for(DietaryRestriction r : restrictions){

%>



<option value="<%=r.getRestrictionId()%>">

<%=r.getRestrictionName()%>

</option>



<%

}

}

%>


</select>



<br><br>



<button type="submit">

Add Restriction

</button>



</form>



<br>



<a href="DietaryRestrictionController?action=userRestrictions">

Back to My Restrictions

</a>



</body>


</html>