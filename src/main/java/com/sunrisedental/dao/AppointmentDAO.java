package com.sunrisedental.dao;

import com.sunrisedental.model.Appointment;
import com.sunrisedental.util.DatabaseConnectionManager;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

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
            conn.setAutoCommit(false);

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

            String apptNo = String.format("APP-%05d", apptId + 1000);
            try (PreparedStatement updateStmt = conn.prepareStatement(updateApptNoSql)) {
                updateStmt.setString(1, apptNo);
                updateStmt.setInt(2, apptId);
                updateStmt.executeUpdate();
            }

            conn.commit();
            return apptNo;

        } catch (SQLException e) {
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException rollbackEx) { e.addSuppressed(rollbackEx); }
            }
            throw e;
        } finally {
            if (generatedKeys != null) try { generatedKeys.close(); } catch (SQLException ignored) {}
            if (patientStmt != null)   try { patientStmt.close();   } catch (SQLException ignored) {}
            if (apptStmt != null)      try { apptStmt.close();      } catch (SQLException ignored) {}
            if (conn != null) {
                try { conn.setAutoCommit(true); conn.close(); } catch (SQLException ignored) {}
            }
        }
    }

    public List<Appointment> searchAppointments(String query) throws SQLException {
        List<Appointment> list = new ArrayList<>();

        boolean hasQuery = query != null && !query.trim().isEmpty();

        String sql = "SELECT a.id, a.appointment_no, a.patient_id, p.full_name AS patient_name, p.phone_number, " +
                "a.dentist_id, u.full_name AS dentist_name, a.treatment_type, a.appointment_date, a.time_slot " +
                "FROM appointments a " +
                "JOIN patients p ON a.patient_id = p.patient_id " +
                "JOIN users u ON a.dentist_id = u.user_id ";

        if (hasQuery) {
            sql += "WHERE a.appointment_no LIKE ? OR p.full_name LIKE ? OR p.phone_number LIKE ? ";
        }

        sql += "ORDER BY a.appointment_date DESC";

        try (Connection conn = DatabaseConnectionManager.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            if (hasQuery) {
                String searchTerm = "%" + query.trim() + "%";
                stmt.setString(1, searchTerm);
                stmt.setString(2, searchTerm);
                stmt.setString(3, searchTerm);
            }

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Appointment appt = new Appointment();
                    appt.setId(rs.getInt("id"));
                    appt.setAppointmentNo(rs.getString("appointment_no"));
                    appt.setPatientId(rs.getInt("patient_id"));
                    appt.setPatientName(rs.getString("patient_name"));
                    appt.setPatientPhone(rs.getString("phone_number"));
                    appt.setDentistId(rs.getInt("dentist_id"));
                    appt.setDentistName(rs.getString("dentist_name"));
                    appt.setTreatmentType(rs.getString("treatment_type"));
                    appt.setAppointmentDate(rs.getDate("appointment_date"));
                    appt.setTimeSlot(rs.getString("time_slot"));
                    list.add(appt);
                }
            }
        }
        return list;
    }

    public Appointment getAppointmentById(int id) throws SQLException {
        String sql = "SELECT a.id, a.appointment_no, a.patient_id, p.full_name AS patient_name, p.phone_number, " +
                "a.dentist_id, u.full_name AS dentist_name, a.treatment_type, a.appointment_date, a.time_slot " +
                "FROM appointments a " +
                "JOIN patients p ON a.patient_id = p.patient_id " +
                "JOIN users u ON a.dentist_id = u.user_id WHERE a.id = ?";

        try (Connection conn = DatabaseConnectionManager.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Appointment appt = new Appointment();
                    appt.setId(rs.getInt("id"));
                    appt.setAppointmentNo(rs.getString("appointment_no"));
                    appt.setPatientId(rs.getInt("patient_id"));
                    appt.setPatientName(rs.getString("patient_name"));
                    appt.setPatientPhone(rs.getString("phone_number"));
                    appt.setDentistId(rs.getInt("dentist_id"));
                    appt.setDentistName(rs.getString("dentist_name"));
                    appt.setTreatmentType(rs.getString("treatment_type"));
                    appt.setAppointmentDate(rs.getDate("appointment_date"));
                    appt.setTimeSlot(rs.getString("time_slot"));
                    return appt;
                }
            }
        }
        return null;
    }

    // Update appointment details
    public boolean updateAppointment(int apptId, int dentistId, String treatment, String date, String timeSlot) throws SQLException {
        String sql = "UPDATE appointments SET dentist_id = ?, treatment_type = ?, appointment_date = ?, time_slot = ? WHERE id = ?";
        try (Connection conn = DatabaseConnectionManager.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, dentistId);
            stmt.setString(2, treatment);
            stmt.setDate(3, Date.valueOf(date));
            stmt.setString(4, timeSlot);
            stmt.setInt(5, apptId);

            return stmt.executeUpdate() > 0;
        }
    }

    // Delete appointment (Restricted to ADMIN at Servlet level)
    public boolean deleteAppointment(int apptId) throws SQLException {
        String sql = "DELETE FROM appointments WHERE id = ?";
        try (Connection conn = DatabaseConnectionManager.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, apptId);
            return stmt.executeUpdate() > 0;
        }
    }

    // Dashboard Counters
    public int getTodayAppointmentCount() throws SQLException {
        String sql = "SELECT COUNT(*) FROM appointments WHERE appointment_date = CURDATE()";
        try (Connection conn = DatabaseConnectionManager.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    public int getTodayAppointmentsByDentist(int dentistId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM appointments WHERE dentist_id = ? AND appointment_date = CURDATE()";
        try (Connection conn = DatabaseConnectionManager.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, dentistId);
            try (ResultSet rs = stmt.executeQuery()) { return rs.next() ? rs.getInt(1) : 0; }
        }
    }

    public int getTotalAppointmentsByDentist(int dentistId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM appointments WHERE dentist_id = ?";
        try (Connection conn = DatabaseConnectionManager.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, dentistId);
            try (ResultSet rs = stmt.executeQuery()) { return rs.next() ? rs.getInt(1) : 0; }
        }
    }
}