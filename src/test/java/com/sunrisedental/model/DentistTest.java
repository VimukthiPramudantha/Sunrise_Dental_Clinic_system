package com.sunrisedental.model;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.*;

@DisplayName("Dentist Model Tests")
class DentistTest {

    // ── Default Constructor ──────────────────────────────────────────

    @Test
    @DisplayName("Default constructor should initialize id to 0 and other fields to null")
    void defaultConstructor_fieldsAreDefaults() {
        Dentist dentist = new Dentist();
        assertEquals(0, dentist.getId());
        assertNull(dentist.getFullName());
        assertNull(dentist.getSpecialization());
        assertNull(dentist.getConsultationFee());
    }

    // ── Parameterized Constructor ────────────────────────────────────

    @Test
    @DisplayName("Parameterized constructor should set all fields")
    void parameterizedConstructor_setsAllFields() {
        BigDecimal fee = new BigDecimal("2500.00");
        Dentist dentist = new Dentist(1, "Dr. Wijesinghe", "Orthodontics", fee);

        assertAll("Parameterized constructor",
                () -> assertEquals(1, dentist.getId()),
                () -> assertEquals("Dr. Wijesinghe", dentist.getFullName()),
                () -> assertEquals("Orthodontics", dentist.getSpecialization()),
                () -> assertEquals(fee, dentist.getConsultationFee())
        );
    }

    // ── ID ───────────────────────────────────────────────────────────

    @Test
    @DisplayName("setId and getId should work correctly")
    void setAndGetId() {
        Dentist dentist = new Dentist();
        dentist.setId(99);
        assertEquals(99, dentist.getId());
    }

    // ── Full Name ────────────────────────────────────────────────────

    @Test
    @DisplayName("setFullName and getFullName should work correctly")
    void setAndGetFullName() {
        Dentist dentist = new Dentist();
        dentist.setFullName("Dr. Jayawardena");
        assertEquals("Dr. Jayawardena", dentist.getFullName());
    }

    // ── Specialization ───────────────────────────────────────────────

    @Test
    @DisplayName("setSpecialization and getSpecialization should work correctly")
    void setAndGetSpecialization() {
        Dentist dentist = new Dentist();
        dentist.setSpecialization("Endodontics");
        assertEquals("Endodontics", dentist.getSpecialization());
    }

    // ── Consultation Fee ─────────────────────────────────────────────

    @Test
    @DisplayName("setConsultationFee and getConsultationFee should handle BigDecimal")
    void setAndGetConsultationFee() {
        Dentist dentist = new Dentist();
        BigDecimal fee = new BigDecimal("3000.50");
        dentist.setConsultationFee(fee);
        assertEquals(fee, dentist.getConsultationFee());
    }

    @Test
    @DisplayName("Consultation fee can be zero")
    void consultationFee_canBeZero() {
        Dentist dentist = new Dentist();
        dentist.setConsultationFee(BigDecimal.ZERO);
        assertEquals(BigDecimal.ZERO, dentist.getConsultationFee());
    }

    // ── Setters Override Constructor Values ──────────────────────────

    @Test
    @DisplayName("Setters should override values set by parameterized constructor")
    void settersOverrideConstructorValues() {
        Dentist dentist = new Dentist(1, "Dr. Original", "General", new BigDecimal("1000.00"));

        dentist.setId(2);
        dentist.setFullName("Dr. Updated");
        dentist.setSpecialization("Periodontics");
        dentist.setConsultationFee(new BigDecimal("4000.00"));

        assertAll("Overridden values",
                () -> assertEquals(2, dentist.getId()),
                () -> assertEquals("Dr. Updated", dentist.getFullName()),
                () -> assertEquals("Periodontics", dentist.getSpecialization()),
                () -> assertEquals(new BigDecimal("4000.00"), dentist.getConsultationFee())
        );
    }
}
