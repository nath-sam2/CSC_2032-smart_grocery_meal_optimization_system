package service;

import dao.UserDAO;
import model.User;
import util.IDGenerator;

public class AuthService {

    private UserDAO userDAO = new UserDAO();

    public boolean registerUser(String name, String email,
                                String password, String role) {
        if (userDAO.getUserByEmail(email) != null) {
            System.out.println("Email already registered!");
            return false;
        }
        int id = IDGenerator.generateId("users");
        User user = new User(id, name, email, password, role);
        return userDAO.insertUser(user);
    }

    public User loginUser(String email, String password) {
        User user = userDAO.getUserByEmail(email);
        if (user != null && user.getPassword().equals(password)) {
            return user;
        }
        return null;
    }
}