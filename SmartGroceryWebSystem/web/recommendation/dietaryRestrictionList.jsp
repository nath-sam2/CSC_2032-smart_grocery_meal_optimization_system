<%-- 
    Document   : dietaryRestrictionList
    Created on : Jul 12, 2026, 4:53:27 PM
    Author     : perer
--%>
<%@ include file="/nav.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="model.DietaryRestriction" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="page-container">

    <h2>Dietary Restrictions</h2>

    <a href="addRestriction.jsp" class="btn btn-primary">+ Add New Restriction</a>

    <br><br>

    <div class="card">
        <table>
            <tr>
                <th>ID</th>
                <th>Restriction Name</th>
                <th>Description</th>
                <th>Action</th>
            </tr>
            <%
            List<DietaryRestriction> restrictions =
            (List<DietaryRestriction>)request.getAttribute("restrictions");

            if(restrictions != null && !restrictions.isEmpty()){
                for(DietaryRestriction restriction : restrictions){
            %>
            <tr>
                <td data-label="ID"><%=restriction.getRestrictionId()%></td>
                <td data-label="Name"><%=restriction.getRestrictionName()%></td>
                <td data-label="Description"><%=restriction.getDescription()%></td>
                <td data-label="Action">
                    <a href="DietaryRestrictionController?action=edit&id=<%=restriction.getRestrictionId()%>" class="btn btn-secondary">Edit</a>
                    <a href="DietaryRestrictionController?action=delete&id=<%=restriction.getRestrictionId()%>"
                       onclick="return confirm('Delete this restriction?');"
                       class="btn btn-secondary">Delete</a>
                </td>
            </tr>
            <%
                }
            }
            else{
            %>
            <tr>
                <td colspan="4">No Dietary Restrictions Found</td>
            </tr>
            <%
            }
            %>
        </table>
    </div>

</div>