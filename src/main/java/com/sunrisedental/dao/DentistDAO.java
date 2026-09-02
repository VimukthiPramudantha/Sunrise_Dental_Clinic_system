package com.sunrisedental.dao;

import com.sunrisedental.model.Dentist;
import com.sunrisedental.util.DatabaseConnectionManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DentistDAO {

    public List<Dentist> getAllDentists() throws SQLException {
        List<Dentist> dentists = new ArrayList<>();
        String sql = "SELECT id, full_name, specialization, consultation_fee FROM dentists ORDER BY full_name ASC";

        try (Connection conn = DatabaseConnectionManager.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Dentist dentist = new Dentist(
                        rs.getInt("id"),
                        rs.getString("full_name"),
                        rs.getString("specialization"),
                        rs.getBigDecimal("consultation_fee")
                );
                dentists.add(dentist);
            }
        }
        return dentists;
    }
}