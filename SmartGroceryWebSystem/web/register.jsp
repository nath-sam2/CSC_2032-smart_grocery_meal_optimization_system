<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Register - Smart Grocery</title>
    <style>
        body { font-family: Arial; background: #f0fdf4;
               display: flex; justify-content: center;
               align-items: center; height: 100vh; margin: 0; }
        .box { background: white; padding: 40px;
               border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);
               width: 350px; }
        h2   { color: #16a34a; text-align: center; }
        input, select { width: 100%; padding: 10px; margin: 8px 0;
                        border: 1px solid #ddd; border-radius: 6px;
                        box-sizing: border-box; font-size: 14px; }
        button { width: 100%; padding: 12px; background: #16a34a;
                 color: white; border: none; border-radius: 6px;
                 font-size: 16px; cursor: pointer; margin-top: 10px; }
        button:hover { background: #15803d; }
        .link { text-align: center; margin-top: 12px; font-size: 14px; }
        .error { color: red; text-align: center; font-size: 13px; }
        .success { color: green; text-align: center; font-size: 13px; }
    </style>
</head>
<body>
    <div class="box">
        <h2>🛒 Register</h2>
        <% String error = (String) request.getAttribute("error");
           String success = (String) request.getAttribute("success");
           if (error != null) { %>
            <p class="error"><%= error %></p>
        <% } %>
        <% if (success != null) { %>
            <p class="success"><%= success %></p>
        <% } %>
        <form action="RegisterServlet" method="post">
            <input type="text" name="name"
                   placeholder="Full Name" required/>
            <input type="email" name="email"
                   placeholder="Email" required/>
            <input type="password" name="password"
                   placeholder="Password" required/>
            <select name="role">
                <option value="USER">User</option>
                <option value="ADMIN">Admin</option>
            </select>
            <button type="submit">Register</button>
        </form>
        <div class="link">
            Already have an account?
            <a href="login.jsp">Login</a>
        </div>
    </div>
</body>
</html>