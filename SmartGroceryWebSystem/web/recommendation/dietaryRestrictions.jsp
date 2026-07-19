<%-- 
    Document   : dietaryRestrictions
    Created on : Jul 12, 2026, 11:20:37?PM
    Author     : perer
--%>
<%@ include file="/nav.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="model.DietaryRestriction" %>

<div class="page-container">

    <div class="card">

        <h2>My Dietary Restrictions</h2>

        <table>

            <tr>
                <th>Restriction</th>
                <th>Description</th>
                <th>Action</th>
            </tr>

            <%
                List<DietaryRestriction> restrictions =
                    (List<DietaryRestriction>) request.getAttribute("restrictions");

                if (restrictions != null) {
                    for (DietaryRestriction r : restrictions) {
            %>

            <tr>

                <td data-label="Restriction">
                    <%= r.getRestrictionName() %>
                </td>

                <td data-label="Description">
                    <%= r.getDescription() %>
                </td>

                <td data-label="Action">

                    <form action="DietaryRestrictionController"
                          method="post"
                          style="display:inline;">

                        <input type="hidden"
                               name="action"
                               value="deleteUserRestriction">

                        <input type="hidden"
                               name="restrictionId"
                               value="<%= r.getRestrictionId() %>">

                        <button class="btn btn-secondary"
                                type="submit">
                            Remove
                        </button>

                    </form>

                </td>

            </tr>

            <%
                    }
                }
            %>

        </table>

    </div>

    <div class="card">

        <h3>Add Dietary Restriction</h3>

        <form action="DietaryRestrictionController"
              method="post">

            <input type="hidden"
                   name="action"
                   value="addUserRestriction">

            <label>Select Restriction</label><br><br>

            <select name="restrictionId">

                <%
                    List<DietaryRestriction> all =
                        (List<DietaryRestriction>) request.getAttribute("allRestrictions");

                    if (all != null) {
                        for (DietaryRestriction r : all) {
                %>

                <option value="<%= r.getRestrictionId() %>">
                    <%= r.getRestrictionName() %>
                </option>

                <%
                        }
                    }
                %>

            </select>

            <br><br>

            <button class="btn btn-primary"
                    type="submit">
                Add Restriction
            </button>

        </form>

    </div>

</div>