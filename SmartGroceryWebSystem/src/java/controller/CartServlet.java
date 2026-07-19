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
            cartService.addToCart(
                user.getUserId(), productId, 1, price
            );
            response.sendRedirect("cart.jsp");
        }

        if ("remove".equals(action)) {
            int cartItemId = Integer.parseInt(
                request.getParameter("cartItemId"));
            cartService.removeFromCart(cartItemId);
            response.sendRedirect("cart.jsp");
        }
    }
}