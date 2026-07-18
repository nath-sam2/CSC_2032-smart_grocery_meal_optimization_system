<%-- 
    Document   : shoppingList
    Created on : Jul 13, 2026, 5:33:56?PM
    Author     : perer
--%>
<%@ include file="/nav.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="model.ShoppingList" %>
<%@ page import="model.ShoppingListItem" %>


<html>

<body>


<h2>
My Shopping Lists
</h2>



<%

List<ShoppingList> lists =
(List<ShoppingList>)
request.getAttribute("shoppingLists");


if(lists != null){


for(ShoppingList list : lists){

%>


<hr>


<h3>
Shopping List ID:
<%=list.getShoppingListId()%>
</h3>


<p>

Created Date:

<%=list.getCreatedDate()%>

</p>



<p>

Status:

<%=list.getStatus()%>

</p>



<a href="ShoppingListController?action=view&id=<%=list.getShoppingListId()%>">

View Items

</a>



<%

}

}

%>



<hr>


<a href="generateShoppingList.jsp">

Generate New Shopping List

</a>



</body>

</html>
