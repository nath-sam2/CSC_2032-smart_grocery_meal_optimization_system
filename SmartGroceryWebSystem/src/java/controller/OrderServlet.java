package controller;

import model.User;
import model.CartItem;
import service.OrderService;
import service.CartService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {

    private OrderService orderService = new OrderService();
    private CartService  cartService  = new CartService();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        User user = (User) request.getSession()
                                  .getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        if ("place".equals(action)) {
            List<CartItem> items = cartService.getCartItems(
                user.getUserId()
            );
            boolean placed = orderService.placeOrder(
                user.getUserId(), items
            );
            if (placed) {
                request.setAttribute("success", "true");
                request.getRequestDispatcher("checkout.jsp")
                       .forward(request, response);
            } else {
                response.sendRedirect("cart.jsp");
            }
        }
    }
}