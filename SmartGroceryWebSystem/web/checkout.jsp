<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<%@page import="model.CartItem"%>
<%@page import="service.CartService"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
    <title>Checkout - Smart Grocery</title>
    <style>
        body { font-family: Arial; background: #f0fdf4; margin: 0; }
        .navbar { background: #16a34a; padding: 15px 30px;
                  display: flex; justify-content: space-between; }
        .navbar h1 { color: white; margin: 0; }
        .navbar a  { color: white; text-decoration: none; margin-left: 16px; }
        .content   { padding: 30px; max-width: 600px; }
        h2 { color: #166534; }
        .box { background: white; padding: 24px; border-radius: 10px;
               box-shadow: 0 2px 8px rgba(0,0,0,0.08); margin-bottom: 20px; }
        table { width: 100%; border-collapse: collapse; }
        th { background: #16a34a; color: white; padding: 10px; text-align: left; }
        td { padding: 10px; border-bottom: 1px solid #e5e7eb; }
        .total { font-size: 20px; font-weight: bold; color: #166534;
                 text-align: right; margin-top: 10px; }
        .btn { background: #16a34a; color: white; padding: 12px 24px;
               border: none; border-radius: 8px; cursor: pointer;
               font-size: 16px; width: 100%; margin-top: 16px; }
        .btn:hover { background: #15803d; }
        .success { background: #dcfce7; border: 1px solid #16a34a;
                   padding: 16px; border-radius: 8px; color: #166534;
                   text-align: center; }
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
        String success = (String) request.getAttribute("success");
    %>
    <div class="navbar">
        <h1>🛒 Smart Grocery</h1>
        <div>
            <a href="cart.jsp">Cart</a>
            <a href="dashboard.jsp">Dashboard</a>
        </div>
    </div>
    <div class="content">
        <h2>✅ Checkout</h2>
        <% if (success != null) { %>
            <div class="success">
                <h3>🎉 Order placed successfully!</h3>
                <a href="orders.jsp">View My Orders</a>
            </div>
        <% } else { %>
        <div class="box">
            <h3>Order Summary</h3>
            <table>
                <thead>
                    <tr><th>Product ID</th><th>Qty</th>
                        <th>Price</th><th>Subtotal</th></tr>
                </thead>
                <tbody>
                    <% for (CartItem item : items) { %>
                    <tr>
                        <td><%= item.getProductId() %></td>
                        <td><%= item.getQuantity() %></td>
                        <td>Rs. <%= item.getPrice() %></td>
                        <td>Rs. <%= item.getSubtotal() %></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            <div class="total">Total: Rs. <%= total %></div>
            <form action="OrderServlet" method="post">
                <input type="hidden" name="action" value="place"/>
                <button type="submit" class="btn">
                    Place Order
                </button>
            </form>
        </div>
        <% } %>
    </div>
</body>
</html>