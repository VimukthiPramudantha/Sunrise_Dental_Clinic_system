package com.sunrisedental.model;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDateTime;

import static org.junit.jupiter.api.Assertions.*;

@DisplayName("Bill Model Tests")
class BillTest {

    private Bill bill;

    @BeforeEach
    void setUp() {
        bill = new Bill();
    }

    // ── Default Constructor ──────────────────────────────────────────

    @Test
    @DisplayName("Default constructor should initialize numeric fields to 0")
    void defaultConstructor_numericFieldsAreZero() {
        assertEquals(0, bill.getId());
        assertEquals(0, bill.getAppointmentId());
    }

    @Test
    @DisplayName("Default constructor should initialize String fields to null")
    void defaultConstructor_stringFieldsAreNull() {
        assertNull(bill.getInvoiceNo());
        assertNull(bill.getAppointmentNo());
        assertNull(bill.getPatientName());
        assertNull(bill.getDentistName());
    }

    @Test
    @DisplayName("Default constructor should initialize BigDecimal fields to null")
    void defaultConstructor_bigDecimalFieldsAreNull() {
        assertNull(bill.getConsultationFee());
        assertNull(bill.getTreatmentCost());
        assertNull(bill.getMedicineCharges());
        assertNull(bill.getTotalAmount());
    }

    @Test
    @DisplayName("Default constructor should initialize Timestamp to null")
    void defaultConstructor_timestampIsNull() {
        assertNull(bill.getCreatedAt());
    }

    // ── ID ───────────────────────────────────────────────────────────

    @Test
    @DisplayName("setId and getId should work correctly")
    void setAndGetId() {
        bill.setId(101);
        assertEquals(101, bill.getId());
    }

    // ── Invoice No ───────────────────────────────────────────────────

    @Test
    @DisplayName("setInvoiceNo and getInvoiceNo should work correctly")
    void setAndGetInvoiceNo() {
        bill.setInvoiceNo("INV-05001");
        assertEquals("INV-05001", bill.getInvoiceNo());
    }

    // ── Appointment ID ───────────────────────────────────────────────

    @Test
    @DisplayName("setAppointmentId and getAppointmentId should work correctly")
    void setAndGetAppointmentId() {
        bill.setAppointmentId(55);
        assertEquals(55, bill.getAppointmentId());
    }

    // ── Appointment No ───────────────────────────────────────────────

    @Test
    @DisplayName("setAppointmentNo and getAppointmentNo should work correctly")
    void setAndGetAppointmentNo() {
        bill.setAppointmentNo("APP-1005");
        assertEquals("APP-1005", bill.getAppointmentNo());
    }

    // ── Patient Name ─────────────────────────────────────────────────

    @Test
    @DisplayName("setPatientName and getPatientName should work correctly")
    void setAndGetPatientName() {
        bill.setPatientName("Kamal Silva");
        assertEquals("Kamal Silva", bill.getPatientName());
    }

    // ── Dentist Name ─────────────────────────────────────────────────

    @Test
    @DisplayName("setDentistName and getDentistName should work correctly")
    void setAndGetDentistName() {
        bill.setDentistName("Dr. Fernando");
        assertEquals("Dr. Fernando", bill.getDentistName());
    }

    // ── Consultation Fee ─────────────────────────────────────────────

    @Test
    @DisplayName("setConsultationFee and getConsultationFee should handle BigDecimal")
    void setAndGetConsultationFee() {
        BigDecimal fee = new BigDecimal("1500.00");
        bill.setConsultationFee(fee);
        assertEquals(fee, bill.getConsultationFee());
    }

    // ── Treatment Cost ───────────────────────────────────────────────

    @Test
    @DisplayName("setTreatmentCost and getTreatmentCost should handle BigDecimal")
    void setAndGetTreatmentCost() {
        BigDecimal cost = new BigDecimal("5000.50");
        bill.setTreatmentCost(cost);
        assertEquals(cost, bill.getTreatmentCost());
    }

    // ── Medicine Charges ─────────────────────────────────────────────

    @Test
    @DisplayName("setMedicineCharges and getMedicineCharges should handle BigDecimal")
    void setAndGetMedicineCharges() {
        BigDecimal charges = new BigDecimal("750.25");
        bill.setMedicineCharges(charges);
        assertEquals(charges, bill.getMedicineCharges());
    }

    @Test
    @DisplayName("Medicine charges can be zero")
    void medicineCharges_canBeZero() {
        bill.setMedicineCharges(BigDecimal.ZERO);
        assertEquals(BigDecimal.ZERO, bill.getMedicineCharges());
    }

    // ── Total Amount ─────────────────────────────────────────────────

    @Test
    @DisplayName("setTotalAmount and getTotalAmount should handle BigDecimal")
    void setAndGetTotalAmount() {
        BigDecimal total = new BigDecimal("7250.75");
        bill.setTotalAmount(total);
        assertEquals(total, bill.getTotalAmount());
    }

    @Test
    @DisplayName("Total amount should be sum of fee components")
    void totalAmount_matchesSumOfComponents() {
        BigDecimal consultationFee = new BigDecimal("1500.00");
        BigDecimal treatmentCost = new BigDecimal("5000.00");
        BigDecimal medicineCharges = new BigDecimal("750.00");
        BigDecimal expectedTotal = consultationFee.add(treatmentCost).add(medicineCharges);

        bill.setConsultationFee(consultationFee);
        bill.setTreatmentCost(treatmentCost);
        bill.setMedicineCharges(medicineCharges);
        bill.setTotalAmount(expectedTotal);

        assertEquals(new BigDecimal("7250.00"), bill.getTotalAmount());
    }

    // ── Created At ───────────────────────────────────────────────────

    @Test
    @DisplayName("setCreatedAt and getCreatedAt should handle Timestamp")
    void setAndGetCreatedAt() {
        Timestamp now = Timestamp.valueOf(LocalDateTime.of(2026, 9, 3, 14, 30, 0));
        bill.setCreatedAt(now);
        assertEquals(now, bill.getCreatedAt());
    }

    @Test
    @DisplayName("createdAt can be set to null")
    void setCreatedAt_null() {
        bill.setCreatedAt(null);
        assertNull(bill.getCreatedAt());
    }

    // ── Full Object Wiring ───────────────────────────────────────────

    @Test
    @DisplayName("All fields should be settable and retrievable on the same instance")
    void allFieldsSetAndGet() {
        Timestamp ts = Timestamp.valueOf(LocalDateTime.now());

        bill.setId(1);
        bill.setInvoiceNo("INV-05500");
        bill.setAppointmentId(10);
        bill.setAppointmentNo("APP-1010");
        bill.setPatientName("Nimali Perera");
        bill.setDentistName("Dr. Kumara");
        bill.setConsultationFee(new BigDecimal("2000.00"));
        bill.setTreatmentCost(new BigDecimal("8000.00"));
        bill.setMedicineCharges(new BigDecimal("500.00"));
        bill.setTotalAmount(new BigDecimal("10500.00"));
        bill.setCreatedAt(ts);

        assertAll("All bill fields",
                () -> assertEquals(1, bill.getId()),
                () -> assertEquals("INV-05500", bill.getInvoiceNo()),
                () -> assertEquals(10, bill.getAppointmentId()),
                () -> assertEquals("APP-1010", bill.getAppointmentNo()),
                () -> assertEquals("Nimali Perera", bill.getPatientName()),
                () -> assertEquals("Dr. Kumara", bill.getDentistName()),
                () -> assertEquals(new BigDecimal("2000.00"), bill.getConsultationFee()),
                () -> assertEquals(new BigDecimal("8000.00"), bill.getTreatmentCost()),
                () -> assertEquals(new BigDecimal("500.00"), bill.getMedicineCharges()),
                () -> assertEquals(new BigDecimal("10500.00"), bill.getTotalAmount()),
                () -> assertEquals(ts, bill.getCreatedAt())
        );
    }
}
