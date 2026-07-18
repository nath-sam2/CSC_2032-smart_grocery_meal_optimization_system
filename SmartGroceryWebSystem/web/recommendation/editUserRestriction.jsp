<%-- 
    Document   : editUserRestriction
    Created on : Jul 12, 2026, 11:23:18 PM
    Author     : perer
--%>
<%@ include file="/nav.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>


<body>


<h2>
Edit Dietary Restriction
</h2>

<a href="DietaryRestrictionController">

Manage Dietary Restrictions

</a>


<form action="DietaryRestrictionController"
method="post">


<input type="hidden"
name="action"
value="update">



<input type="hidden"
name="oldRestrictionId"
value="${restrictionId}">



New Restriction ID:


<input type="number"
name="restrictionId">



<br><br>



<button type="submit">

Update

</button>


</form>



</body>

</html>
