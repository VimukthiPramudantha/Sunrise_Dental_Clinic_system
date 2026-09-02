package com.sunrisedental.dao;

import com.sunrisedental.model.Role;
import com.sunrisedental.model.User;
import com.sunrisedental.util.DatabaseConnectionManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    public User findByUsername(String username) throws SQLException {
        String sql = "SELECT user_id, username, password_hash, full_name, role FROM users WHERE username = ?";

        try (Connection conn = DatabaseConnectionManager.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new User(
                            rs.getInt("user_id"), // Fixed: rs.getInt for integer primary key
                            rs.getString("username"),
                            rs.getString("password_hash"),
                            rs.getString("full_name"),
                            Role.fromString(rs.getString("role"))
                    );
                }
            }
        }
        return null;
    }

    public boolean createUser(User user) throws SQLException {
        // Removed user_id from the INSERT statement to let MySQL AUTO_INCREMENT handle it
        String sql = "INSERT INTO users (username, password_hash, full_name, role) VALUES (?, ?, ?, ?)";

        try (Connection conn = DatabaseConnectionManager.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getPasswordHash());
            stmt.setString(3, user.getFullName());
            stmt.setString(4, user.getRole().getRoleName());

            return stmt.executeUpdate() > 0;
        }
    }
}