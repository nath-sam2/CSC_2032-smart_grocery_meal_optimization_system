<%-- 
    Document   : userDietaryRestrictionList
    Created on : Jul 12, 2026, 5:22:10?PM
    Author     : perer
--%>

<%@ page import="java.util.List" %>
<%@ page import="model.DietaryRestriction" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<html>

<head>

<title>My Dietary Restrictions</title>


<style>

body{
    font-family: Arial;
    margin:40px;
}


.card{

    border:1px solid #ccc;
    padding:15px;
    width:400px;
    margin-bottom:15px;

}


button{

    padding:8px 15px;

}


a{

    color:blue;
    text-decoration:none;

}

</style>


</head>



<body>


<h2>My Dietary Restrictions</h2>



<a href="DietaryRestrictionController?action=addUser">

Add New Restriction

</a>


<br><br>



<%


List<DietaryRestriction> list =
(List<DietaryRestriction>)
request.getAttribute("userRestrictions");



if(list != null && !list.isEmpty()){


for(DietaryRestriction r : list){


%>



<div class="card">


<h3>
<%= r.getRestrictionName() %>
</h3>


<p>

<%= r.getDescription() %>

</p>



<form action="DietaryRestrictionController" method="post">


<input type="hidden"
       name="action"
       value="deleteUserRestriction">



<input type="hidden"
       name="restrictionId"
       value="<%=r.getRestrictionId()%>">



<button type="submit"
onclick="return confirm('Remove this restriction?');">

Remove

</button>


</form>



</div>



<%


}


}

else{


%>


<p>

You have no dietary restrictions.

</p>



<%


}

%>



<br>


<a href="RecipeController">

Back to Recipes

</a>



</body>


</html>