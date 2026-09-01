package com.sunrisedental.service;

import com.sunrisedental.dao.UserDAO;
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

    public void logout() {
        UserSession.getInstance().cleanSession();
    }
}