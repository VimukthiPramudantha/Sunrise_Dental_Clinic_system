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
        if (username == null || plainPassword == null || username.trim().isEmpty()) {
            throw new IllegalArgumentException("Username and password cannot be empty.");
        }

        User user = userDAO.findByUsername(username.trim());

        if (user != null && PasswordUtil.verifyPassword(plainPassword, user.getPasswordHash())) {
            UserSession.getInstance().createSession(user);
            return true;
        }
        return false;
    }

    public boolean registerUser(String username, String plainPassword, String fullName, String roleStr) throws SQLException {
        if (username == null || username.trim().isEmpty() ||
                plainPassword == null || plainPassword.trim().length() < 6 ||
                fullName == null || fullName.trim().isEmpty()) {
            throw new IllegalArgumentException("Invalid input: Password must be at least 6 characters and all fields are required.");
        }

        // Check if username already exists
        if (userDAO.findByUsername(username.trim()) != null) {
            throw new IllegalArgumentException("Username '" + username + "' is already taken.");
        }

        String hashedPassword = PasswordUtil.hashPassword(plainPassword);
        Role role = Role.fromString(roleStr);

        // Pass 0 as the ID placeholder; MySQL AUTO_INCREMENT assigns the actual ID
        User newUser = new User(0, username.trim(), hashedPassword, fullName.trim(), role);
        return userDAO.createUser(newUser);
    }

    public void logout() {
        UserSession.getInstance().cleanSession();
    }
}