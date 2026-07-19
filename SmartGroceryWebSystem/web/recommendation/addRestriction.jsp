<%-- 
    Document   : addRestriction
    Created on : Jul 12, 2026, 4:14:25?PM
    Author     : perer
--%>
<%@ include file="/nav.jsp" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<div class="page-container">

    <div class="card">

        <h2>Add Dietary Restriction</h2>

        <a href="DietaryRestrictionController"
           class="btn btn-secondary">
            ← Back to Dietary Restrictions
        </a>

        <br><br>

        <form action="DietaryRestrictionController" method="post">

            <input type="hidden"
                   name="action"
                   value="insert">

            <label><strong>Restriction Name</strong></label><br>

            <input
                type="text"
                name="restrictionName"
                required
                style="width:100%;padding:10px;margin:8px 0 16px;">

            <label><strong>Description</strong></label><br>

            <textarea
                name="description"
                rows="4"
                style="width:100%;padding:10px;margin:8px 0 20px;"></textarea>

            <button
                type="submit"
                class="btn btn-primary">
                Save Restriction
            </button>

        </form>

    </div>

</div>