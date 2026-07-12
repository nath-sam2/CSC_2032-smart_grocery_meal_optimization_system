<%-- 
    Document   : editDietaryRestriction
    Created on : Jul 12, 2026, 11:31:01?PM
    Author     : perer
--%>

<%@ page import="model.DietaryRestriction" %>


<%

DietaryRestriction r =
(DietaryRestriction)
request.getAttribute("restriction");

%>



<html>


<body>


<h2>Edit Restriction</h2>


<form action="DietaryRestrictionController" method="post">


<input type="hidden"
name="action"
value="update">


<input type="hidden"
name="restrictionId"
value="<%=r.getRestrictionId()%>">



Name:


<input type="text"
name="restrictionName"
value="<%=r.getRestrictionName()%>">



<br><br>


Description:


<textarea name="description">

<%=r.getDescription()%>

</textarea>


<br><br>


<button>
Update
</button>



</form>



</body>

</html>