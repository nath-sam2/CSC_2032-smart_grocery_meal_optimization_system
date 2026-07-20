package controller;

import model.User;
import service.AuthService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/UserManageServlet")
public class UserManageServle extends HttpServlet {

    private AuthService authService = new AuthService();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        User admin = (User) request.getSession().getAttribute("user");
        if (admin == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        if (!"admin".equals(admin.getRole())) {
            response.sendRedirect("dashboard.jsp");
            return;
        }

        String action = request.getParameter("action");

        if ("updateRole".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            String role = request.getParameter("role");
            authService.updateUserRole(userId, role);
            response.sendRedirect("admin/manageUsers.jsp?updated=1");
        }

        if ("delete".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            // safety: an admin cannot delete their own account this way
            if (userId != admin.getUserId()) {
                authService.deleteUser(userId);
            }
            response.sendRedirect("admin/manageUsers.jsp?deleted=1");
        }
    }
}
