<%-- 
    Document   : addRestriction
    Created on : Jul 12, 2026, 4:14:25?PM
    Author     : perer
--%>
<%@ include file="/nav.jsp" %>
<html>

<head>
<title>Add Restriction</title>
</head>


<body>


<h2>Add Dietary Restriction</h2>



<form action="DietaryRestrictionController" method="post">


<input type="hidden" 
name="action" 
value="insert">


Restriction Name:

<input type="text"
name="restrictionName"
required>


<br><br>



Description:

<textarea name="description"></textarea>



<br><br>


<button type="submit">
Save
</button>



</form>


</body>

</html>