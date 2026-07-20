package controller;

import model.User;
import service.AuthService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {

    private AuthService authService = new AuthService();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");

        if ("updateProfile".equals(action)) {
            String name  = request.getParameter("name");
            String email = request.getParameter("email");

            boolean success = authService.updateProfile(
                user.getUserId(), name, email);

            if (success) {
                User refreshed = authService.getUserById(user.getUserId());
                session.setAttribute("user", refreshed);
                response.sendRedirect("profile.jsp?success=1");
            } else {
                response.sendRedirect("profile.jsp?error=1");
            }
            return;
        }

        if ("changePassword".equals(action)) {
            String currentPassword = request.getParameter("currentPassword");
            String newPassword     = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            if (newPassword == null || !newPassword.equals(confirmPassword)) {
                response.sendRedirect("settings.jsp?error=mismatch");
                return;
            }

            boolean success = authService.changePassword(
                user.getUserId(), currentPassword, newPassword);

            if (success) {
                response.sendRedirect("settings.jsp?success=1");
            } else {
                response.sendRedirect("settings.jsp?error=wrongpass");
            }
            return;
        }

        response.sendRedirect("profile.jsp");
    }
}
