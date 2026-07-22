package controller;

import model.User;
import service.AuthService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

@WebServlet("/ProfileServlet")
@MultipartConfig(
    maxFileSize = 5 * 1024 * 1024,      // 5MB per file
    maxRequestSize = 6 * 1024 * 1024
)
public class ProfileServlet extends HttpServlet {

    private AuthService authService = new AuthService();

    // Where uploaded photos are written to on disk, relative to the webapp root
    private static final String UPLOAD_DIR = "images/profiles";

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

        if ("uploadPhoto".equals(action)) {
            try {
                Part filePart = request.getPart("photo");

                if (filePart == null || filePart.getSize() == 0) {
                    response.sendRedirect("profile.jsp?error=nophoto");
                    return;
                }

                String contentType = filePart.getContentType();
                if (contentType == null || !contentType.startsWith("image/")) {
                    response.sendRedirect("profile.jsp?error=badtype");
                    return;
                }

                String submittedName = filePart.getSubmittedFileName();
                String extension = "";
                if (submittedName != null && submittedName.contains(".")) {
                    extension = submittedName.substring(submittedName.lastIndexOf('.'));
                }

                String fileName = "user_" + user.getUserId() + "_" +
                                   UUID.randomUUID().toString().substring(0, 8) + extension;

                String uploadPath = getServletContext().getRealPath("/" + UPLOAD_DIR);
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                filePart.write(uploadPath + File.separator + fileName);

                String relativePath = UPLOAD_DIR + "/" + fileName;
                boolean success = authService.updateProfilePhoto(user.getUserId(), relativePath);

                if (success) {
                    User refreshed = authService.getUserById(user.getUserId());
                    session.setAttribute("user", refreshed);
                    response.sendRedirect("profile.jsp?success=photo");
                } else {
                    response.sendRedirect("profile.jsp?error=1");
                }
            } catch (IllegalStateException tooLarge) {
                // Thrown when the file exceeds @MultipartConfig maxFileSize/maxRequestSize
                response.sendRedirect("profile.jsp?error=toolarge");
            } catch (Exception ex) {
                // Any unexpected I/O or DB failure - fail gracefully instead of a raw 500 page
                ex.printStackTrace();
                response.sendRedirect("profile.jsp?error=1");
            }
            return;
        }

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

        if ("updatePreferences".equals(action)) {
            boolean notifyExpiry = "true".equals(request.getParameter("notifyExpiry"));
            boolean notifyLowStock = "true".equals(request.getParameter("notifyLowStock"));
            boolean notifyMealPlanner = "true".equals(request.getParameter("notifyMealPlanner"));

            boolean success = authService.updateNotificationPreferences(
                    user.getUserId(), notifyExpiry, notifyLowStock, notifyMealPlanner);

            if (success) {
                User refreshed = authService.getUserById(user.getUserId());
                session.setAttribute("user", refreshed);
            }

            // Called via fetch() from settings.jsp - plain text response, no redirect
            response.setContentType("text/plain");
            response.getWriter().write(success ? "ok" : "error");
            return;
        }

        response.sendRedirect("profile.jsp");
    }
}
