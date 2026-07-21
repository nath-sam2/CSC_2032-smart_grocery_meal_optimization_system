<%-- 
    Document   : shoppingList
    Created on : Jul 13, 2026, 5:33:56 PM
    Author     : perer
--%>
<%@ include file="/nav.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="model.ShoppingList" %>

<div class="page-container">

    <h2>My Shopping Lists</h2>

    <a href="<%=request.getContextPath()%>/shopping/generateShoppingList.jsp" class="btn btn-primary">+ Generate New Shopping List</a>
    <p style="font-size:0.9em;">Select a meal plan to generate a shopping list from.</p>

    <br>

    <div class="card-grid">

    <%
    List<ShoppingList> lists =
    (List<ShoppingList>) request.getAttribute("shoppingLists");

    if(lists != null){
        for(ShoppingList list : lists){
    %>
        <div class="card">
            <h3>Shopping List #<%=list.getShoppingListId()%></h3>
            <p>Created: <%=list.getCreatedDate()%></p>
            <p>
                <span class="badge badge-grade-<%= "Pending".equals(list.getStatus()) ? "c" : "a" %>">
                    <%=list.getStatus()%>
                </span>
            </p>
            <br>
            <a href="ShoppingListController?action=view&id=<%=list.getShoppingListId()%>" class="btn btn-primary">View Items</a>
        </div>
    <%
        }
    }
    %>

    </div>

    <%
    if(lists == null || lists.isEmpty()){
    %>
        <p>No shopping lists yet. Generate one from a meal plan!</p>
    <%
    }
    %>

</div>