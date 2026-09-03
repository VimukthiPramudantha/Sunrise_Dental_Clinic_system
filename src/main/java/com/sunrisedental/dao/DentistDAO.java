package com.sunrisedental.dao;

import com.sunrisedental.model.Role;
import com.sunrisedental.model.User;
import com.sunrisedental.util.DatabaseConnectionManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DentistDAO {

    public List<User> getAllDentists() throws SQLException {
        List<User> dentists = new ArrayList<>();
        String sql = "SELECT user_id, username, full_name, role FROM users WHERE role = 'DENTIST'";

        try (Connection conn = DatabaseConnectionManager.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                User dentist = new User(
                        rs.getInt("user_id"),
                        rs.getString("username"),
                        "",
                        rs.getString("full_name"),
                        Role.fromString(rs.getString("role"))
                );
                dentists.add(dentist);
            }
        }
        return dentists;
    }
}