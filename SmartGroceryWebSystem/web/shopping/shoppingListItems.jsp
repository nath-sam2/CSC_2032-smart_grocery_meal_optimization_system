<%-- 
    Document   : shoppingListItems
    Created on : Jul 18, 2026, 8:42:59?AM
    Author     : perer
--%>

<%@ page import="java.util.List" %>
<%@ page import="model.ShoppingListItem" %>
<%@ page import="model.Ingredient" %>
<%@ page import="dao.IngredientDAO" %>
<html>
<body>

<h2>
Shopping List Items
</h2>

<%
List<ShoppingListItem> items =
(List<ShoppingListItem>)
request.getAttribute("items");

IngredientDAO ingredientDAO = new IngredientDAO();

if(items != null){
for(ShoppingListItem item : items){

Ingredient ingredient =
ingredientDAO.getIngredientById(item.getIngredientId());

String ingredientName =
(ingredient != null) ? ingredient.getName() : "Unknown Ingredient";
%>

<hr>
<p>
Ingredient:
<%=ingredientName%>
</p>
<p>
Quantity:
<%=item.getQuantity()%>
<%=item.getUnit()%>
</p>
<p>
Status:
<%=item.getStatus()%>
</p>

<%
}
}
%>

<hr>
<a href="ShoppingListController?action=list">
Back to Shopping Lists
</a>

</body>
</html>
