package com.sunrisedental.service;

import com.sunrisedental.dao.UserDAO;
import com.sunrisedental.model.Role;
import com.sunrisedental.model.User;
import com.sunrisedental.util.PasswordUtil;
import com.sunrisedental.util.UserSession;

import java.sql.SQLException;

public class AuthService {

    private final UserDAO userDAO;

    public AuthService() {
        this.userDAO = new UserDAO();
    }

    public AuthService(UserDAO userDAO) {
        this.userDAO = userDAO;
    }

    public boolean login(String username, String plainPassword) throws SQLException {
        if (username == null || plainPassword == null || username.trim().isEmpty() || plainPassword.isEmpty()) {
            throw new IllegalArgumentException("Username and password cannot be empty.");
        }

        String cleanUsername = username.trim();
        User user = userDAO.findByUsername(cleanUsername);

        if (user != null && PasswordUtil.verifyPassword(plainPassword, user.getPasswordHash())) {

            UserSession.getInstance().createSession(user);
            return true;
        }

        return false;
    }

    public boolean registerUser(String username, String plainPassword, String fullName, String roleStr) throws SQLException {

        if (username == null || username.trim().isEmpty()) {
            throw new IllegalArgumentException("Username is required.");
        }

        if (plainPassword == null || plainPassword.trim().length() < 6) {
            throw new IllegalArgumentException("Password must be at least 6 characters long.");
        }

        if (fullName == null || fullName.trim().isEmpty()) {
            throw new IllegalArgumentException("Full name is required.");
        }

        if (roleStr == null || roleStr.trim().isEmpty()) {
            throw new IllegalArgumentException("System role assignment is required.");
        }

        String cleanUsername = username.trim();

        if (userDAO.findByUsername(cleanUsername) != null) {
            throw new IllegalArgumentException("Username '" + cleanUsername + "' is already taken.");
        }

        String userId = "USR-" + (System.currentTimeMillis() % 10000);

        String hashedPassword = PasswordUtil.hashPassword(plainPassword);

        Role role = Role.fromString(roleStr);

        User newUser = new User(userId, cleanUsername, hashedPassword, fullName.trim(), role);
        return userDAO.createUser(newUser);
    }

    public void logout() {
        UserSession.getInstance().cleanSession();
    }
}