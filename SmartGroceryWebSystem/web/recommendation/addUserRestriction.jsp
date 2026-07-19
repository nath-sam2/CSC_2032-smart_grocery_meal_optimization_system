<%-- 
    Document   : addUserDietaryRestriction
    Created on : Jul 12, 2026, 5:19:11 PM
    Author     : perer
--%>
<%@ include file="/nav.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.DietaryRestriction" %>

<div class="page-container">

    <div class="card">
        <h2>Add Dietary Restriction</h2>

        <form action="DietaryRestrictionController" method="post">

            <input type="hidden" name="action" value="addUserRestriction">

            <p>
                <label>Select Restriction</label><br>
                <select name="restrictionId" required style="width:100%; padding:8px;">
                    <option value="">-- Select Restriction --</option>
                    <%
                    List<DietaryRestriction> restrictions =
                    (List<DietaryRestriction>) request.getAttribute("restrictions");

                    if(restrictions != null){
                        for(DietaryRestriction r : restrictions){
                    %>
                        <option value="<%=r.getRestrictionId()%>">
                            <%=r.getRestrictionName()%>
                        </option>
                    <%
                        }
                    }
                    %>
                </select>
            </p>

            <br>
            <button type="submit" class="btn btn-primary">Add Restriction</button>
            <a href="DietaryRestrictionController?action=userRestrictions" class="btn btn-secondary">Cancel</a>

        </form>
    </div>

</div>