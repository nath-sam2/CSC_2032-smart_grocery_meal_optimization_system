package controller;

import model.User;
import service.CartService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {

    private CartService cartService = new CartService();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        User user = (User) request.getSession()
                                  .getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        if ("add".equals(action)) {
            int productId = Integer.parseInt(
                request.getParameter("productId"));
            double price  = Double.parseDouble(
                request.getParameter("price"));

            
            int quantity = 1;
            String quantityParam = request.getParameter("quantity");
            if (quantityParam != null) {
                try {
                    quantity = Math.max(1, Integer.parseInt(quantityParam));
                } catch (NumberFormatException ignored) {
                    quantity = 1;
                }
            }

            cartService.addToCart(
                user.getUserId(), productId, quantity, price
            );
            response.sendRedirect("cart.jsp");
        }

        if ("remove".equals(action)) {
            int cartItemId = Integer.parseInt(
                request.getParameter("cartItemId"));
            cartService.removeFromCart(cartItemId);
            response.sendRedirect("cart.jsp");
        }

        if ("update".equals(action)) {
            int cartItemId = Integer.parseInt(
                request.getParameter("cartItemId"));
            int quantity = Integer.parseInt(
                request.getParameter("quantity"));
            if (quantity < 1) {
                cartService.removeFromCart(cartItemId);
            } else {
                cartService.updateQuantity(cartItemId, quantity);
            }
            response.sendRedirect("cart.jsp");
        }

        if ("clear".equals(action)) {
            cartService.clearCart(user.getUserId());
            response.sendRedirect("cart.jsp");
        }
    }
}