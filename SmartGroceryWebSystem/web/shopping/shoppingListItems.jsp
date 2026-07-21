<%-- 
    Document   : shoppingListItems
    Created on : Jul 18, 2026, 8:42:59?AM
    Author     : perer
--%>
<%@ include file="/nav.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="model.ShoppingListItem" %>
<%@ page import="model.Ingredient" %>
<%@ page import="model.Inventory" %>
<%@ page import="dao.IngredientDAO" %>
<%@ page import="dao.InventoryDAO" %>

<%
List<ShoppingListItem> items =
(List<ShoppingListItem>) request.getAttribute("items");

IngredientDAO ingredientDAO = new IngredientDAO();
InventoryDAO inventoryDAO = new InventoryDAO();
%>

<div class="page-container">

    <h2>Shopping List Items</h2>

    <div class="card">

        <% if (items == null || items.isEmpty()) { %>

            <p>No items in this shopping list ? looks like everything needed was already in stock.</p>

        <% } else { %>

        <table>
            <tr>
                <th>Ingredient</th>
                <th>Quantity</th>
                <th>Availability</th>
                <th>Status</th>
                <th>Action</th>
            </tr>

            <%
                for(ShoppingListItem item : items){

                    Ingredient ingredient =
                    ingredientDAO.getIngredientById(item.getIngredientId());

                    String ingredientName =
                    (ingredient != null) ? ingredient.getName() : "Unknown Ingredient";

                    String availability = "Not tracked";
                    String availabilityBadgeClass = "badge-grade-c";

                    if (ingredient != null) {
                        Inventory inv = inventoryDAO.getInventoryByProduct(ingredient.getProductId());

                        if (inv == null) {
                            availability = "Out of stock";
                            availabilityBadgeClass = "badge-warning";
                        } else if (inv.getQuantity() <= 0) {
                            availability = "Out of stock";
                            availabilityBadgeClass = "badge-warning";
                        } else {
                            availability = "In stock (" + inv.getQuantity() + " " + item.getUnit() + ")";
                            availabilityBadgeClass = "badge-grade-a";
                        }
                    }

                    boolean purchased = "Purchased".equals(item.getStatus());
            %>

            <tr>
                <td data-label="Ingredient"><%=ingredientName%></td>
                <td data-label="Quantity"><%=item.getQuantity()%> <%=item.getUnit()%></td>
                <td data-label="Availability">
                    <span class="badge <%=availabilityBadgeClass%>"><%=availability%></span>
                </td>
                <td data-label="Status">
                    <span class="badge <%= purchased ? "badge-grade-a" : "badge-grade-c" %>"><%=item.getStatus()%></span>
                </td>
                <td data-label="Action">
                    <% if (!purchased) { %>
                        <a href="ShoppingListController?action=purchase&id=<%=item.getShoppingListItemId()%>" class="btn btn-secondary">Mark Purchased</a>
                    <% } else { %>
                        &#10003; Done
                    <% } %>
                </td>
            </tr>

            <%
                }
            %>

        </table>

        <% } %>

    </div>

    <br>
    <a href="ShoppingListController?action=list" class="btn btn-secondary">Back to Shopping Lists</a>
    <button onclick="window.print()" class="btn btn-secondary">Print List</button>

</div>