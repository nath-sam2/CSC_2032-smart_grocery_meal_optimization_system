package service;

import dao.UserDAO;
import model.User;
import util.IDGenerator;
import java.util.List;

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

    // Used by ProfileServlet to update a user's name/email
    public boolean updateProfile(int userId, String name, String email) {
        return userDAO.updateProfile(userId, name, email);
    }

    // Used by ProfileServlet to save the path of an uploaded profile photo
    public boolean updateProfilePhoto(int userId, String photoPath) {
        return userDAO.updateProfilePhoto(userId, photoPath);
    }

    // Used by ProfileServlet after a successful profile update,
    // to refresh the session with the latest user data
    public User getUserById(int userId) {
        return userDAO.getUserById(userId);
    }

    // Used by ProfileServlet (settings.jsp) to change a user's password
    public boolean changePassword(int userId, String currentPassword, String newPassword) {
        User user = userDAO.getUserById(userId);
        if (user == null) return false;
        if (!user.getPassword().equals(currentPassword)) {
            return false; // wrong current password
        }
        return userDAO.updatePassword(userId, newPassword);
    }

    // Used by admin/manageUsers.jsp to list every registered account
    public List<User> getAllUsers() {
        return userDAO.getAllUsers();
    }

    // Used by admin/manageUsers.jsp to promote/demote a user's role
    public boolean updateUserRole(int userId, String newRole) {
        return userDAO.updateUserRole(userId, newRole);
    }

    // Used by admin/manageUsers.jsp to remove an account
    public boolean deleteUser(int userId) {
        return userDAO.deleteUser(userId);
    }
}
