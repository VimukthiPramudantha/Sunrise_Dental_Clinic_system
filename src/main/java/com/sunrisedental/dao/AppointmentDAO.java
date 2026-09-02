package com.sunrisedental.dao;

import com.sunrisedental.util.DatabaseConnectionManager;
import java.sql.*;

public class AppointmentDAO {

    public String createAppointmentWithPatient(String name, String address, String phone,
                                               int dentistId, String treatment,
                                               String date, String timeSlot) throws SQLException {
        Connection conn = null;
        PreparedStatement patientStmt = null;
        PreparedStatement apptStmt = null;
        ResultSet generatedKeys = null;
        String generatedApptNo = null;

        String insertPatientSql = "INSERT INTO patients (full_name, address, phone_number) VALUES (?, ?, ?)";
        String insertApptSql = "INSERT INTO appointments (patient_id, dentist_id, treatment_type, appointment_date, time_slot) VALUES (?, ?, ?, ?, ?)";
        String fetchApptNoSql = "SELECT appointment_no FROM appointments WHERE id = ?";

        try {
            conn = DatabaseConnectionManager.getInstance().getConnection();
            conn.setAutoCommit(false); // Begin Transaction

            // 1. Insert Patient
            patientStmt = conn.prepareStatement(insertPatientSql, Statement.RETURN_GENERATED_KEYS);
            patientStmt.setString(1, name);
            patientStmt.setString(2, address);
            patientStmt.setString(3, phone);
            patientStmt.executeUpdate();

            generatedKeys = patientStmt.getGeneratedKeys();
            int patientId = 0;
            if (generatedKeys.next()) {
                patientId = generatedKeys.getInt(1);
            }

            // 2. Insert Appointment
            apptStmt = conn.prepareStatement(insertApptSql, Statement.RETURN_GENERATED_KEYS);
            apptStmt.setInt(1, patientId);
            apptStmt.setInt(2, dentistId);
            apptStmt.setString(3, treatment);
            apptStmt.setDate(4, Date.valueOf(date));
            apptStmt.setString(5, timeSlot);
            apptStmt.executeUpdate();

            int apptId = 0;
            try (ResultSet apptKeys = apptStmt.getGeneratedKeys()) {
                if (apptKeys.next()) {
                    apptId = apptKeys.getInt(1);
                }
            }

            conn.commit(); // Commit Transaction

            // 3. Fetch auto-generated string (APP-100X)
            try (PreparedStatement fetchStmt = conn.prepareStatement(fetchApptNoSql)) {
                fetchStmt.setInt(1, apptId);
                try (ResultSet rs = fetchStmt.executeQuery()) {
                    if (rs.next()) {
                        generatedApptNo = rs.getString("appointment_no");
                    }
                }
            }

            return generatedApptNo;

        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException rollbackEx) {
                    e.addSuppressed(rollbackEx);
                }
            }
            throw e;
        } finally {
            if (generatedKeys != null) try { generatedKeys.close(); } catch (SQLException ignored) {}
            if (patientStmt != null) try { patientStmt.close(); } catch (SQLException ignored) {}
            if (apptStmt != null) try { apptStmt.close(); } catch (SQLException ignored) {}
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException ignored) {}
            }
        }
    }

    // --- Temporary Stubs for DashboardServlet Support ---

    public int getTodayAppointmentCount() throws SQLException {
        // Placeholder return until appointment queries are written
        return 0;
    }

    public int getTodayAppointmentsByDentist(int dentistId) throws SQLException {
        // Placeholder return until appointment queries are written
        return 0;
    }

    public int getTotalAppointmentsByDentist(int dentistId) throws SQLException {
        // Placeholder return until appointment queries are written
        return 0;
    }
}