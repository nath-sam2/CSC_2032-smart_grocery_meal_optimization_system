<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<%@page import="model.Category"%>
<%@page import="service.CategoryService"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
    <title>Categories - Smart Grocery</title>
    <style>
        body { font-family: Arial; background: #f0fdf4; margin: 0; }
        .navbar { background: #16a34a; padding: 15px 30px;
                  display: flex; justify-content: space-between; }
        .navbar h1 { color: white; margin: 0; }
        .navbar a  { color: white; text-decoration: none; margin-left: 16px; }
        .content   { padding: 30px; }
        h2 { color: #166534; }
        table { width: 100%; border-collapse: collapse;
                background: white; border-radius: 10px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.08); }
        th { background: #16a34a; color: white; padding: 12px; }
        td { padding: 12px; border-bottom: 1px solid #e5e7eb; }
        .btn-red { background: #dc2626; color: white; padding: 6px 12px;
                   border: none; border-radius: 6px; cursor: pointer; }
        .form-box { background: white; padding: 20px;
                    border-radius: 10px; margin-bottom: 20px;
                    box-shadow: 0 2px 8px rgba(0,0,0,0.08);
                    max-width: 400px; }
        input { width: 100%; padding: 10px; margin: 6px 0;
                border: 1px solid #ddd; border-radius: 6px;
                box-sizing: border-box; }
        button { background: #16a34a; color: white; padding: 10px 20px;
                 border: none; border-radius: 6px; cursor: pointer; }
    </style>
</head>
<body>
    <%
        User user = (User) session.getAttribute("user");
        if (user == null || !user.getRole().equals("ADMIN")) {
            response.sendRedirect("login.jsp");
            return;
        }
        CategoryService cs = new CategoryService();
        List<Category> categories = cs.getAllCategories();
    %>
    <div class="navbar">
        <h1>🛒 Smart Grocery</h1>
        <div>
            <a href="dashboard.jsp">Dashboard</a>
            <a href="LogoutServlet">Logout</a>
        </div>
    </div>
    <div class="content">
        <h2>🗂️ Categories</h2>
        <div class="form-box">
            <h3>Add Category</h3>
            <form action="CategoryServlet" method="post">
                <input type="hidden" name="action" value="add"/>
                <input type="text" name="name"
                       placeholder="Category Name" required/>
                <input type="text" name="description"
                       placeholder="Description"/>
                <button type="submit">Add</button>
            </form>
        </div>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Description</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% for (Category c : categories) { %>
                <tr>
                    <td><%= c.getCategoryId() %></td>
                    <td><%= c.getName() %></td>
                    <td><%= c.getDescription() != null ?
                             c.getDescription() : "-" %></td>
                    <td>
                        <form action="CategoryServlet" method="post"
                              style="display:inline">
                            <input type="hidden" name="action"
                                   value="delete"/>
                            <input type="hidden" name="id"
                                   value="<%= c.getCategoryId() %>"/>
                            <button class="btn-red" type="submit"
                                    onclick="return confirm('Delete?')">
                                Delete
                            </button>
                        </form>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>