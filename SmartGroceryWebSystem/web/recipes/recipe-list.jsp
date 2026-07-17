<%-- 
    Document   : recipe-list
    Created on : Jul 11, 2026, 6:21:50?PM
    Author     : perer
--%>

<%@page import="java.util.List"%>
<%@page import="model.Recipe"%>

<html>
<head>
<title>Recipes</title>
</head>

<body>

<h1>Recipe List</h1>


<%
List<Recipe> recipes =
(List<Recipe>) request.getAttribute("recipes");


if(recipes != null){

    for(Recipe r : recipes){

%>


<h3>
<%= r.getName() %>
</h3>


<p>
<%= r.getDescription() %>
</p>

<hr>


<%
    }

}
%>


</body>
</html>
