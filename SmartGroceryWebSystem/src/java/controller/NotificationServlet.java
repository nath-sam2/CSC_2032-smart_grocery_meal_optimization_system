package controller;

import model.User;
import model.NotificationService;
import service.NotificationAlertService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/NotificationServlet")
public class NotificationServlet extends HttpServlet {

    private NotificationAlertService notifService = new NotificationAlertService();

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

        if ("markRead".equals(action)) {
            int notifId = Integer.parseInt(
                request.getParameter("notifId"));
            notifService.markAsRead(notifId);
            response.sendRedirect("notifications.jsp");
        }

        if ("markAllRead".equals(action)) {
            List<NotificationService> unread =
                notifService.getUnreadNotifications();
            for (NotificationService n : unread) {
                notifService.markAsRead(n.getNotifId());
            }
            response.sendRedirect("notifications.jsp");
        }
    }
}
