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

    public User getUserById(int userId) {
        return userDAO.getUserById(userId);
    }

    public boolean updateProfile(int userId, String name, String email) {
        User existing = userDAO.getUserByEmail(email);
        if (existing != null && existing.getUserId() != userId) {
            // email already taken by another account
            return false;
        }
        return userDAO.updateProfile(userId, name, email);
    }

    public boolean changePassword(int userId, String currentPassword,
                                  String newPassword) {
        User user = userDAO.getUserById(userId);
        if (user == null || !user.getPassword().equals(currentPassword)) {
            return false;
        }
        return userDAO.updatePassword(userId, newPassword);
    }
}