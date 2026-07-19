<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<%@page import="model.CartItem"%>
<%@page import="service.CartService"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
    <title>Cart - Smart Grocery</title>
    <style>
        body { font-family: Arial; background: #f0fdf4; margin: 0; }
        .navbar { background: #16a34a; padding: 15px 30px;
                  display: flex; justify-content: space-between; }
        .navbar h1 { color: white; margin: 0; font-size: 20px; }
        .navbar a  { color: white; text-decoration: none; margin-left: 16px; }
        .content   { padding: 30px; }
        h2 { color: #166534; }
        table { width: 100%; border-collapse: collapse;
                background: white; border-radius: 10px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.08); }
        th { background: #16a34a; color: white; padding: 12px; text-align: left; }
        td { padding: 12px; border-bottom: 1px solid #e5e7eb; }
        tr:hover td { background: #f0fdf4; }
        .btn { background: #16a34a; color: white; padding: 8px 16px;
               border: none; border-radius: 6px; cursor: pointer;
               text-decoration: none; font-size: 14px; }
        .btn-red { background: #dc2626; color: white; padding: 8px 16px;
                   border: none; border-radius: 6px; cursor: pointer; }
        .total-box { background: white; padding: 20px; border-radius: 10px;
                     margin-top: 20px; box-shadow: 0 2px 8px rgba(0,0,0,0.08);
                     text-align: right; }
        .total-box h3 { color: #166534; font-size: 22px; }
        .empty { text-align: center; padding: 40px; color: #6b7280; }
    </style>
</head>
<body>
    <%
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        CartService cs = new CartService();
        List<CartItem> items = cs.getCartItems(user.getUserId());
        double total = cs.getCartTotal(items);
    %>
    <div class="navbar">
        <h1>🛒 Smart Grocery</h1>
        <div>
            <a href="products.jsp">Shop</a>
            <a href="dashboard.jsp">Dashboard</a>
            <a href="LogoutServlet">Logout</a>
        </div>
    </div>
    <div class="content">
        <h2>🛍️ My Cart</h2>
        <% if (items.isEmpty()) { %>
            <div class="empty">
                <h3>Your cart is empty!</h3>
                <a href="products.jsp" class="btn">Shop Now</a>
            </div>
        <% } else { %>
        <table>
            <thead>
                <tr>
                    <th>Product ID</th>
                    <th>Quantity</th>
                    <th>Price</th>
                    <th>Subtotal</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% for (CartItem item : items) { %>
                <tr>
                    <td><%= item.getProductId() %></td>
                    <td><%= item.getQuantity() %></td>
                    <td>Rs. <%= item.getPrice() %></td>
                    <td>Rs. <%= item.getSubtotal() %></td>
                    <td>
                        <a href="CartServlet?action=remove&cartItemId=
                           <%= item.getCartItemId() %>"
                           class="btn-red">Remove</a>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <div class="total-box">
            <h3>Total: Rs. <%= total %></h3>
            <a href="checkout.jsp" class="btn">Proceed to Checkout</a>
        </div>
        <% } %>
    </div>
</body>
</html>