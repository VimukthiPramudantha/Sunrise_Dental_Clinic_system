package com.sunrisedental.dao;

import com.sunrisedental.model.Bill;
import com.sunrisedental.util.DatabaseConnectionManager;

import java.math.BigDecimal;
import java.sql.*;

public class BillingDAO {

    public String generateInvoice(int appointmentId, BigDecimal consultationFee,
                                  BigDecimal treatmentCost, BigDecimal medicineCharges) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        String insertSql = "INSERT INTO bills (invoice_no, appointment_id, consultation_fee, treatment_cost, medicine_charges, total_amount) VALUES (?, ?, ?, ?, ?, ?)";
        String updateInvoiceNoSql = "UPDATE bills SET invoice_no = ? WHERE id = ?";

        try {
            conn = DatabaseConnectionManager.getInstance().getConnection();
            conn.setAutoCommit(false);

            // Calculate total: Consultation + Treatment + Additional/Medicine
            BigDecimal total = consultationFee.add(treatmentCost).add(medicineCharges);

            stmt = conn.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, "TEMP"); // Temporary placeholder
            stmt.setInt(2, appointmentId);
            stmt.setBigDecimal(3, consultationFee);
            stmt.setBigDecimal(4, treatmentCost);
            stmt.setBigDecimal(5, medicineCharges);
            stmt.setBigDecimal(6, total);
            stmt.executeUpdate();

            int billId = 0;
            rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                billId = rs.getInt(1);
            }

            String invoiceNo = String.format("INV-%05d", billId + 5000);
            try (PreparedStatement updateStmt = conn.prepareStatement(updateInvoiceNoSql)) {
                updateStmt.setString(1, invoiceNo);
                updateStmt.setInt(2, billId);
                updateStmt.executeUpdate();
            }

            conn.commit();
            return invoiceNo;

        } catch (SQLException e) {
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { e.addSuppressed(ex); }
            }
            throw e;
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
            if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
            if (conn != null) {
                try { conn.setAutoCommit(true); conn.close(); } catch (SQLException ignored) {}
            }
        }
    }

    public Bill getBillByInvoiceNo(String invoiceNo) throws SQLException {
        String sql = "SELECT b.id, b.invoice_no, b.appointment_id, b.consultation_fee, b.treatment_cost, " +
                "b.medicine_charges, b.total_amount, b.created_at, a.appointment_no, " +
                "p.full_name AS patient_name, d.full_name AS dentist_name " +
                "FROM bills b " +
                "JOIN appointments a ON b.appointment_id = a.id " +
                "JOIN patients p ON a.patient_id = p.patient_id " +
                "JOIN dentists d ON a.dentist_id = d.id " +
                "WHERE b.invoice_no = ?";

        try (Connection conn = DatabaseConnectionManager.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, invoiceNo);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Bill bill = new Bill();
                    bill.setId(rs.getInt("id"));
                    bill.setInvoiceNo(rs.getString("invoice_no"));
                    bill.setAppointmentId(rs.getInt("appointment_id"));
                    bill.setAppointmentNo(rs.getString("appointment_no"));
                    bill.setPatientName(rs.getString("patient_name"));
                    bill.setDentistName(rs.getString("dentist_name"));
                    bill.setConsultationFee(rs.getBigDecimal("consultation_fee"));
                    bill.setTreatmentCost(rs.getBigDecimal("treatment_cost"));
                    bill.setMedicineCharges(rs.getBigDecimal("medicine_charges"));
                    bill.setTotalAmount(rs.getBigDecimal("total_amount"));
                    bill.setCreatedAt(rs.getTimestamp("created_at"));
                    return bill;
                }
            }
        }
        return null;
    }
}