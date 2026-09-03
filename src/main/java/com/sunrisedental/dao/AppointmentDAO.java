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


    public Appointment getAppointmentById(int id) throws SQLException {
        String sql = "SELECT a.id, a.appointment_no, a.patient_id, p.full_name AS patient_name, p.phone_number, " +
                "a.dentist_id, COALESCE(u.full_name, 'Unassigned') AS dentist_name, " +
                "a.treatment_type, a.appointment_date, a.time_slot, a.status " +
                "FROM appointments a " +
                "JOIN patients p ON a.patient_id = p.patient_id " +
                "LEFT JOIN users u ON a.dentist_id = u.user_id " +
                "WHERE a.id = ?";

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
                    appt.setDentistName(rs.getString("dentist_name")); // Properly set dentist_name
                    appt.setTreatmentType(rs.getString("treatment_type"));
                    appt.setAppointmentDate(rs.getDate("appointment_date"));
                    appt.setTimeSlot(rs.getString("time_slot"));
                    appt.setStatus(rs.getString("status"));
                    return appt;
                }
            }
        }
        return null;
    }

    public List<Appointment> getAppointmentsByDentist(int dentistId) throws SQLException {
        List<Appointment> appointments = new ArrayList<>();
        String sql = "SELECT a.id, a.appointment_no, p.full_name AS patient_name, p.phone_number, " +
                "a.treatment_type, a.appointment_date, a.time_slot, a.status " +
                "FROM appointments a " +
                "JOIN patients p ON a.patient_id = p.patient_id " +
                "WHERE a.dentist_id = ? " +
                "ORDER BY a.appointment_date DESC, a.time_slot ASC";

        try (Connection conn = DatabaseConnectionManager.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, dentistId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Appointment appt = new Appointment();
                    appt.setId(rs.getInt("id"));
                    appt.setAppointmentNo(rs.getString("appointment_no"));
                    appt.setPatientName(rs.getString("patient_name"));
                    appt.setPatientPhone(rs.getString("phone_number"));
                    appt.setTreatmentType(rs.getString("treatment_type"));
                    appt.setAppointmentDate(rs.getDate("appointment_date"));
                    appt.setTimeSlot(rs.getString("time_slot"));
                    appt.setStatus(rs.getString("status"));

                    appointments.add(appt);
                }
            }
        }
        return appointments;
    }

    public List<Appointment> searchAppointments(String query) throws SQLException {
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT a.id, a.appointment_no, p.full_name AS patient_name, p.phone_number, " +
                "COALESCE(u.full_name, 'Unassigned') AS dentist_name, " +
                "a.treatment_type, a.appointment_date, a.time_slot, a.status " +
                "FROM appointments a " +
                "JOIN patients p ON a.patient_id = p.patient_id " +
                "LEFT JOIN users u ON a.dentist_id = u.user_id " +
                "WHERE (? IS NULL OR ? = '' " +
                "   OR a.appointment_no LIKE CONCAT('%', ?, '%') " +
                "   OR p.full_name LIKE CONCAT('%', ?, '%') " +
                "   OR p.phone_number LIKE CONCAT('%', ?, '%')) " +
                "ORDER BY a.appointment_date DESC";

        try (Connection conn = DatabaseConnectionManager.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, query);
            stmt.setString(2, query);
            stmt.setString(3, query);
            stmt.setString(4, query);
            stmt.setString(5, query);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Appointment appt = new Appointment();
                    appt.setId(rs.getInt("id"));
                    appt.setAppointmentNo(rs.getString("appointment_no"));
                    appt.setPatientName(rs.getString("patient_name"));
                    appt.setPatientPhone(rs.getString("phone_number"));
                    appt.setDentistName(rs.getString("dentist_name")); // Properly set dentist_name
                    appt.setTreatmentType(rs.getString("treatment_type"));
                    appt.setAppointmentDate(rs.getDate("appointment_date"));
                    appt.setTimeSlot(rs.getString("time_slot"));
                    appt.setStatus(rs.getString("status"));
                    list.add(appt);
                }
            }
        }
        return list;
    }

    public boolean updateAppointment(int id, int dentistId, String treatment, String date, String timeSlot) throws SQLException {
        String sql = "UPDATE appointments SET dentist_id = ?, treatment_type = ?, appointment_date = ?, time_slot = ? WHERE id = ?";

        try (Connection conn = DatabaseConnectionManager.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, dentistId);
            stmt.setString(2, treatment);
            stmt.setDate(3, Date.valueOf(date));
            stmt.setString(4, timeSlot);
            stmt.setInt(5, id);

            return stmt.executeUpdate() > 0;
        }
    }

    public boolean deleteAppointment(int id) throws SQLException {
        String sql = "DELETE FROM appointments WHERE id = ?";

        try (Connection conn = DatabaseConnectionManager.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        }
    }

    // --- DASHBOARD METRIC METHODS ---

    public int getTodayAppointmentCount() throws SQLException {
        String sql = "SELECT COUNT(*) FROM appointments WHERE appointment_date = CURDATE()";
        try (Connection conn = DatabaseConnectionManager.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public int getTodayAppointmentsByDentist(int dentistId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM appointments WHERE dentist_id = ? AND appointment_date = CURDATE()";
        try (Connection conn = DatabaseConnectionManager.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, dentistId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    public int getTotalAppointmentsByDentist(int dentistId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM appointments WHERE dentist_id = ?";
        try (Connection conn = DatabaseConnectionManager.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, dentistId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }
}