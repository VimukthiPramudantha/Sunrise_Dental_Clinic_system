package com.sunrisedental.model;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.sql.Date;

import static org.junit.jupiter.api.Assertions.*;

@DisplayName("Appointment Model Tests")
class AppointmentTest {

    private Appointment appointment;

    @BeforeEach
    void setUp() {
        appointment = new Appointment();
    }

    @Test
    @DisplayName("Default constructor should initialize numeric fields to 0")
    void defaultConstructor_numericFieldsAreZero() {
        assertEquals(0, appointment.getId());
        assertEquals(0, appointment.getPatientId());
        assertEquals(0, appointment.getDentistId());
    }

    @Test
    @DisplayName("Default constructor should initialize String fields to null")
    void defaultConstructor_stringFieldsAreNull() {
        assertNull(appointment.getAppointmentNo());
        assertNull(appointment.getPatientName());
        assertNull(appointment.getPatientPhone());
        assertNull(appointment.getDentistName());
        assertNull(appointment.getTreatmentType());
        assertNull(appointment.getTimeSlot());
        assertNull(appointment.getStatus());
    }

    @Test
    @DisplayName("Default constructor should initialize Date field to null")
    void defaultConstructor_dateFieldIsNull() {
        assertNull(appointment.getAppointmentDate());
    }

    @Test
    @DisplayName("setId and getId should work correctly")
    void setAndGetId() {
        appointment.setId(42);
        assertEquals(42, appointment.getId());
    }

    @Test
    @DisplayName("setAppointmentNo and getAppointmentNo should work correctly")
    void setAndGetAppointmentNo() {
        appointment.setAppointmentNo("APP-1001");
        assertEquals("APP-1001", appointment.getAppointmentNo());
    }

    @Test
    @DisplayName("setPatientId and getPatientId should work correctly")
    void setAndGetPatientId() {
        appointment.setPatientId(10);
        assertEquals(10, appointment.getPatientId());
    }

    @Test
    @DisplayName("setPatientName and getPatientName should work correctly")
    void setAndGetPatientName() {
        appointment.setPatientName("John Doe");
        assertEquals("John Doe", appointment.getPatientName());
    }

    @Test
    @DisplayName("setPatientPhone and getPatientPhone should work correctly")
    void setAndGetPatientPhone() {
        appointment.setPatientPhone("+94771234567");
        assertEquals("+94771234567", appointment.getPatientPhone());
    }

    @Test
    @DisplayName("setDentistId and getDentistId should work correctly")
    void setAndGetDentistId() {
        appointment.setDentistId(5);
        assertEquals(5, appointment.getDentistId());
    }

    @Test
    @DisplayName("setDentistName and getDentistName should work correctly")
    void setAndGetDentistName() {
        appointment.setDentistName("Dr. Smith");
        assertEquals("Dr. Smith", appointment.getDentistName());
    }

    @Test
    @DisplayName("setTreatmentType and getTreatmentType should work correctly")
    void setAndGetTreatmentType() {
        appointment.setTreatmentType("Root Canal");
        assertEquals("Root Canal", appointment.getTreatmentType());
    }

    @Test
    @DisplayName("setAppointmentDate and getAppointmentDate should work with java.sql.Date")
    void setAndGetAppointmentDate() {
        Date date = Date.valueOf("2026-09-15");
        appointment.setAppointmentDate(date);
        assertEquals(date, appointment.getAppointmentDate());
    }

    @Test
    @DisplayName("setAppointmentDate should accept null")
    void setAppointmentDate_null() {
        appointment.setAppointmentDate(null);
        assertNull(appointment.getAppointmentDate());
    }

    @Test
    @DisplayName("setTimeSlot and getTimeSlot should work correctly")
    void setAndGetTimeSlot() {
        appointment.setTimeSlot("09:00 AM - 10:00 AM");
        assertEquals("09:00 AM - 10:00 AM", appointment.getTimeSlot());
    }

    @Test
    @DisplayName("setStatus and getStatus should work correctly")
    void setAndGetStatus() {
        appointment.setStatus("CONFIRMED");
        assertEquals("CONFIRMED", appointment.getStatus());
    }

    @Test
    @DisplayName("Status can be set to all valid values")
    void setStatus_allValidValues() {
        String[] statuses = {"PENDING", "CONFIRMED", "COMPLETED", "CANCELLED"};
        for (String status : statuses) {
            appointment.setStatus(status);
            assertEquals(status, appointment.getStatus());
        }
    }

    @Test
    @DisplayName("All fields should be settable and retrievable on the same instance")
    void allFieldsSetAndGet() {
        appointment.setId(1);
        appointment.setAppointmentNo("APP-2001");
        appointment.setPatientId(100);
        appointment.setPatientName("Jane Doe");
        appointment.setPatientPhone("0112223344");
        appointment.setDentistId(7);
        appointment.setDentistName("Dr. Perera");
        appointment.setTreatmentType("Filling");
        appointment.setAppointmentDate(Date.valueOf("2026-12-25"));
        appointment.setTimeSlot("02:00 PM - 03:00 PM");
        appointment.setStatus("PENDING");

        assertAll("All fields",
                () -> assertEquals(1, appointment.getId()),
                () -> assertEquals("APP-2001", appointment.getAppointmentNo()),
                () -> assertEquals(100, appointment.getPatientId()),
                () -> assertEquals("Jane Doe", appointment.getPatientName()),
                () -> assertEquals("0112223344", appointment.getPatientPhone()),
                () -> assertEquals(7, appointment.getDentistId()),
                () -> assertEquals("Dr. Perera", appointment.getDentistName()),
                () -> assertEquals("Filling", appointment.getTreatmentType()),
                () -> assertEquals(Date.valueOf("2026-12-25"), appointment.getAppointmentDate()),
                () -> assertEquals("02:00 PM - 03:00 PM", appointment.getTimeSlot()),
                () -> assertEquals("PENDING", appointment.getStatus())
        );
    }
}
