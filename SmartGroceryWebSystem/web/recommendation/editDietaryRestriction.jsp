<%-- 
    Document   : editDietaryRestriction
    Created on : Jul 12, 2026, 11:31:01?PM
    Author     : perer
--%>
<%@ include file="/nav.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="page-container">

    <div class="card">

        <h2>Edit Dietary Restriction</h2>

        <a href="DietaryRestrictionController"
           class="btn btn-secondary">
            ← Back to Dietary Restrictions
        </a>

        <br><br>

        <form action="DietaryRestrictionController" method="post">

            <input type="hidden" name="action" value="update">

            <input type="hidden"
                   name="restrictionId"
                   value="${restriction.restrictionId}">

            <label><strong>Restriction Name</strong></label><br>

            <input
                type="text"
                name="restrictionName"
                value="${restriction.restrictionName}"
                required
                style="width:100%;padding:10px;margin-top:5px;margin-bottom:15px;">

            <label><strong>Description</strong></label><br>

            <textarea
                name="description"
                rows="4"
                style="width:100%;padding:10px;margin-top:5px;margin-bottom:20px;">${restriction.description}</textarea>

            <button type="submit"
                    class="btn btn-primary">

                Update Restriction

            </button>

        </form>

    </div>

</div>