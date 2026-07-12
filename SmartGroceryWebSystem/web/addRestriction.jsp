<%-- 
    Document   : addRestriction
    Created on : Jul 12, 2026, 4:14:25 PM
    Author     : perer
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Add Dietary Restriction</title>
</head>

<body>

<h1>Add Dietary Restriction</h1>


<form action="DietaryRestrictionController" method="post">

    <label>Restriction Name:</label>
    <br>
    <input type="text" name="restrictionName" required>

    <br><br>


    <label>Description:</label>
    <br>
    <textarea name="description" rows="4" cols="40" required></textarea>

    <br><br>


    <button type="submit">
        Save Restriction
    </button>

</form>


<br>

<a href="DietaryRestrictionController">
    Back to Restriction List
</a>


</body>
</html>
