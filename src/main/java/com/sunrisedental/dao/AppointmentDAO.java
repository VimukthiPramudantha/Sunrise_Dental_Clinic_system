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

        String insertPatientSql = "INSERT INTO patients (full_name, address, phone_number) VALUES (?, ?, ?)";
        String insertApptSql    = "INSERT INTO appointments (patient_id, dentist_id, treatment_type, appointment_date, time_slot) VALUES (?, ?, ?, ?, ?)";
        String updateApptNoSql  = "UPDATE appointments SET appointment_no = ? WHERE id = ?";

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
            generatedKeys.close();
            generatedKeys = null;

            // 2. Insert Appointment (appointment_no will be set after we have the ID)
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

            // 3. Generate appointment_no from the new ID and write it back
            String apptNo = String.format("APP-%05d", apptId + 1000);
            try (PreparedStatement updateStmt = conn.prepareStatement(updateApptNoSql)) {
                updateStmt.setString(1, apptNo);
                updateStmt.setInt(2, apptId);
                updateStmt.executeUpdate();
            }

            conn.commit(); // Commit Transaction

            return apptNo;

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
            if (patientStmt != null)   try { patientStmt.close();   } catch (SQLException ignored) {}
            if (apptStmt != null)      try { apptStmt.close();      } catch (SQLException ignored) {}
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