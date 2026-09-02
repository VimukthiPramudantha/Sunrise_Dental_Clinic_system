package com.sunrisedental.util;
import com.sunrisedental.model.Role;
import com.sunrisedental.model.User;

public class UserSession {
    private static volatile UserSession instance;
    private User currentUser;
    private Role role;

    private UserSession() {}

    public static UserSession getInstance() {
        if (instance == null) {
            synchronized (UserSession.class) {
                if (instance == null) {
                    instance = new UserSession();
                }
            }
        }
        return instance;
    }

    public void createSession(User user) {
        this.currentUser = user;
    }

    public User getCurrentUser() {
        return currentUser;
    }

    public boolean isLoggedIn() {
        return currentUser != null;
    }

    public void cleanSession() {
        this.currentUser = null;
    }
    public Role getRole() {
        return role;
    }

}