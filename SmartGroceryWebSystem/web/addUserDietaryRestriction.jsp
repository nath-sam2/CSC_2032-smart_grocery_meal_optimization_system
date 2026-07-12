<%-- 
    Document   : addUserDietaryRestriction
    Created on : Jul 12, 2026, 5:19:11 PM
    Author     : perer
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Add User Dietary Restriction</title>
</head>

<body>

<h1>Add Dietary Restriction to User</h1>


<form action="UserDietaryRestrictionController" method="post">


    <label>User ID:</label>
    <br>

    <input type="number" name="userId" required>

    <br><br>



    <label>Restriction ID:</label>
    <br>

    <input type="number" name="restrictionId" required>

    <br><br>



    <button type="submit">
        Add Restriction
    </button>


</form>


<br>


<a href="UserDietaryRestrictionController?userId=1">
    Back to User Restrictions
</a>


</body>
</html>
