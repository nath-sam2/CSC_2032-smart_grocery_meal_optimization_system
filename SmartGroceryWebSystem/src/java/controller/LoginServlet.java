package controller;

import model.User;
import service.AuthService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private AuthService authService = new AuthService();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email    = request.getParameter("email");
        String password = request.getParameter("password");

        User user = authService.loginUser(email, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            if (user.getRole().equals("ADMIN")) {
                response.sendRedirect("adminDashboard.jsp");
            } else {
                response.sendRedirect("dashboard.jsp");
            }
        } else {
            request.setAttribute("error", "Invalid email or password!");
            request.getRequestDispatcher("login.jsp")
                   .forward(request, response);
        }
    }
}