package controller;

import service.AuthService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    private AuthService authService = new AuthService();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String name     = request.getParameter("name");
        String email    = request.getParameter("email");
        String password = request.getParameter("password");
        String role     = request.getParameter("role");

        boolean success = authService.registerUser(
            name, email, password, role
        );

        if (success) {
            request.setAttribute("success",
                "Registered successfully! Please login.");
            request.getRequestDispatcher("register.jsp")
                   .forward(request, response);
        } else {
            request.setAttribute("error",
                "Email already registered!");
            request.getRequestDispatcher("register.jsp")
                   .forward(request, response);
        }
    }
}