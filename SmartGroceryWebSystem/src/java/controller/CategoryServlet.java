package controller;

import service.CategoryService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/CategoryServlet")
public class CategoryServlet extends HttpServlet {

    private CategoryService categoryService = new CategoryService();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            String name        = request.getParameter("name");
            String description = request.getParameter("description");

            boolean added = categoryService.addCategory(
                name, description
            );

            if (added) {
                response.sendRedirect("admin/manageCategories.jsp?success=1");
            } else {
                response.sendRedirect("admin/manageCategories.jsp?error=1");
            }
        }

        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            categoryService.deleteCategory(id);
            response.sendRedirect("admin/manageCategories.jsp?deleted=1");
        }
    }
}