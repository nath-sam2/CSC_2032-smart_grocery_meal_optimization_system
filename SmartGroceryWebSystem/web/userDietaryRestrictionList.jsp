<%-- 
    Document   : userDietaryRestrictionList
    Created on : Jul 12, 2026, 5:22:10?PM
    Author     : perer
--%>

<%@ page import="java.util.List" %>
<%@ page import="model.DietaryRestriction" %>



<html>

<body>


<h2>My Dietary Restrictions</h2>


<%

List<DietaryRestriction> list =
(List<DietaryRestriction>)
request.getAttribute("userRestrictions");


for(DietaryRestriction r:list){

%>


<p>

<b>
<%=r.getRestrictionName()%>
</b>

<br>

<%=r.getDescription()%>


</p>


<%

}

%>


</body>

</html>