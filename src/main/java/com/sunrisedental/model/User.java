package com.sunrisedental.model;

public class User {
    private String userId;
    private String username;
    private String passwordHash;
    private String fullName;
    private Role role;

    public User(String userId, String username, String passwordHash, String fullName, Role role) {
        this.userId = userId;
        this.username = username;
        this.passwordHash = passwordHash;
        this.fullName = fullName;
        this.role = role;
    }

    public String getUserId() { return userId; }
    public String getUsername() { return username; }
    public String getPasswordHash() { return passwordHash; }
    public String getFullName() { return fullName; }
    public Role getRole() { return role; }
}