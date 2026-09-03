package com.sunrisedental.model;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;

import static org.junit.jupiter.api.Assertions.*;

@DisplayName("Role Enum Tests")
class RoleTest {

    // ── values() ─────────────────────────────────────────────────────

    @Test
    @DisplayName("Role enum should have exactly 3 constants")
    void enumHasThreeConstants() {
        assertEquals(3, Role.values().length);
    }

    @Test
    @DisplayName("Role enum should contain ADMIN, RECEPTIONIST, and DENTIST")
    void enumContainsExpectedValues() {
        Role[] roles = Role.values();
        assertArrayEquals(
                new Role[]{Role.ADMIN, Role.RECEPTIONIST, Role.DENTIST},
                roles
        );
    }

    // ── getRoleName() ────────────────────────────────────────────────

    @Test
    @DisplayName("ADMIN getRoleName should return 'ADMIN'")
    void adminRoleName() {
        assertEquals("ADMIN", Role.ADMIN.getRoleName());
    }

    @Test
    @DisplayName("RECEPTIONIST getRoleName should return 'RECEPTIONIST'")
    void receptionistRoleName() {
        assertEquals("RECEPTIONIST", Role.RECEPTIONIST.getRoleName());
    }

    @Test
    @DisplayName("DENTIST getRoleName should return 'DENTIST'")
    void dentistRoleName() {
        assertEquals("DENTIST", Role.DENTIST.getRoleName());
    }

    // ── fromString() — Valid Inputs ──────────────────────────────────

    @Test
    @DisplayName("fromString('ADMIN') should return Role.ADMIN")
    void fromString_admin() {
        assertEquals(Role.ADMIN, Role.fromString("ADMIN"));
    }

    @Test
    @DisplayName("fromString('RECEPTIONIST') should return Role.RECEPTIONIST")
    void fromString_receptionist() {
        assertEquals(Role.RECEPTIONIST, Role.fromString("RECEPTIONIST"));
    }

    @Test
    @DisplayName("fromString('DENTIST') should return Role.DENTIST")
    void fromString_dentist() {
        assertEquals(Role.DENTIST, Role.fromString("DENTIST"));
    }

    // ── fromString() — Case Insensitive ──────────────────────────────

    @ParameterizedTest
    @ValueSource(strings = {"admin", "Admin", "ADMIN", "aDmIn"})
    @DisplayName("fromString should be case-insensitive for ADMIN")
    void fromString_caseInsensitive_admin(String input) {
        assertEquals(Role.ADMIN, Role.fromString(input));
    }

    @ParameterizedTest
    @ValueSource(strings = {"receptionist", "Receptionist", "RECEPTIONIST"})
    @DisplayName("fromString should be case-insensitive for RECEPTIONIST")
    void fromString_caseInsensitive_receptionist(String input) {
        assertEquals(Role.RECEPTIONIST, Role.fromString(input));
    }

    @ParameterizedTest
    @ValueSource(strings = {"dentist", "Dentist", "DENTIST"})
    @DisplayName("fromString should be case-insensitive for DENTIST")
    void fromString_caseInsensitive_dentist(String input) {
        assertEquals(Role.DENTIST, Role.fromString(input));
    }

    // ── fromString() — Invalid Inputs ────────────────────────────────

    @Test
    @DisplayName("fromString with invalid role should throw IllegalArgumentException")
    void fromString_invalidRole_throwsException() {
        IllegalArgumentException ex = assertThrows(
                IllegalArgumentException.class,
                () -> Role.fromString("MANAGER")
        );
        assertTrue(ex.getMessage().contains("Invalid Role"));
    }

    @Test
    @DisplayName("fromString with empty string should throw IllegalArgumentException")
    void fromString_emptyString_throwsException() {
        assertThrows(IllegalArgumentException.class, () -> Role.fromString(""));
    }

    @Test
    @DisplayName("fromString with null should throw exception")
    void fromString_null_throwsException() {
        assertThrows(Exception.class, () -> Role.fromString(null));
    }

    // ── canManageAppointments() ──────────────────────────────────────

    @Test
    @DisplayName("ADMIN can manage appointments")
    void admin_canManageAppointments() {
        assertTrue(Role.ADMIN.canManageAppointments());
    }

    @Test
    @DisplayName("RECEPTIONIST can manage appointments")
    void receptionist_canManageAppointments() {
        assertTrue(Role.RECEPTIONIST.canManageAppointments());
    }

    @Test
    @DisplayName("DENTIST cannot manage appointments")
    void dentist_cannotManageAppointments() {
        assertFalse(Role.DENTIST.canManageAppointments());
    }

    // ── canManageBilling() ───────────────────────────────────────────

    @Test
    @DisplayName("ADMIN can manage billing")
    void admin_canManageBilling() {
        assertTrue(Role.ADMIN.canManageBilling());
    }

    @Test
    @DisplayName("RECEPTIONIST can manage billing")
    void receptionist_canManageBilling() {
        assertTrue(Role.RECEPTIONIST.canManageBilling());
    }

    @Test
    @DisplayName("DENTIST cannot manage billing")
    void dentist_cannotManageBilling() {
        assertFalse(Role.DENTIST.canManageBilling());
    }

    // ── canManageUsers() ─────────────────────────────────────────────

    @Test
    @DisplayName("ADMIN can manage users")
    void admin_canManageUsers() {
        assertTrue(Role.ADMIN.canManageUsers());
    }

    @Test
    @DisplayName("RECEPTIONIST cannot manage users")
    void receptionist_cannotManageUsers() {
        assertFalse(Role.RECEPTIONIST.canManageUsers());
    }

    @Test
    @DisplayName("DENTIST cannot manage users")
    void dentist_cannotManageUsers() {
        assertFalse(Role.DENTIST.canManageUsers());
    }
}
