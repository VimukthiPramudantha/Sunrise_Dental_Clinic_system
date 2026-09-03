package com.sunrisedental.model;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.EnumSource;

import static org.junit.jupiter.api.Assertions.*;

@DisplayName("User Model Tests")
class UserTest {

    // ── Constructor & Getters ────────────────────────────────────────

    @Test
    @DisplayName("Constructor should set all fields correctly")
    void constructor_setsAllFields() {
        User user = new User(1, "admin", "hashedpw123", "System Admin", Role.ADMIN);

        assertAll("User constructor",
                () -> assertEquals(1, user.getUserId()),
                () -> assertEquals("admin", user.getUsername()),
                () -> assertEquals("hashedpw123", user.getPasswordHash()),
                () -> assertEquals("System Admin", user.getFullName()),
                () -> assertEquals(Role.ADMIN, user.getRole())
        );
    }

    @Test
    @DisplayName("getUserId should return the correct user id")
    void getUserId() {
        User user = new User(42, "testuser", "hash", "Test User", Role.DENTIST);
        assertEquals(42, user.getUserId());
    }

    @Test
    @DisplayName("getUsername should return the correct username")
    void getUsername() {
        User user = new User(1, "drsmith", "hash", "Dr. Smith", Role.DENTIST);
        assertEquals("drsmith", user.getUsername());
    }

    @Test
    @DisplayName("getPasswordHash should return the stored hash")
    void getPasswordHash() {
        String hash = "a5f3c8b2e1d4f6a7b8c9d0e1f2a3b4c5";
        User user = new User(1, "user", hash, "Full Name", Role.RECEPTIONIST);
        assertEquals(hash, user.getPasswordHash());
    }

    @Test
    @DisplayName("getFullName should return the correct full name")
    void getFullName() {
        User user = new User(1, "user", "hash", "Kamal Perera", Role.ADMIN);
        assertEquals("Kamal Perera", user.getFullName());
    }

    // ── Role Variants ────────────────────────────────────────────────

    @ParameterizedTest
    @EnumSource(Role.class)
    @DisplayName("User should correctly store and return any Role value")
    void getRole_allRoles(Role role) {
        User user = new User(1, "user", "hash", "Name", role);
        assertEquals(role, user.getRole());
    }

    @Test
    @DisplayName("User with ADMIN role")
    void userWithAdminRole() {
        User user = new User(1, "admin", "hash", "Admin User", Role.ADMIN);
        assertEquals(Role.ADMIN, user.getRole());
        assertTrue(user.getRole().canManageUsers());
    }

    @Test
    @DisplayName("User with RECEPTIONIST role")
    void userWithReceptionistRole() {
        User user = new User(2, "reception", "hash", "Reception Staff", Role.RECEPTIONIST);
        assertEquals(Role.RECEPTIONIST, user.getRole());
        assertTrue(user.getRole().canManageAppointments());
        assertFalse(user.getRole().canManageUsers());
    }

    @Test
    @DisplayName("User with DENTIST role")
    void userWithDentistRole() {
        User user = new User(3, "dentist", "hash", "Dr. Someone", Role.DENTIST);
        assertEquals(Role.DENTIST, user.getRole());
        assertFalse(user.getRole().canManageAppointments());
        assertFalse(user.getRole().canManageUsers());
    }

    // ── Edge Cases ───────────────────────────────────────────────────

    @Test
    @DisplayName("User with empty string fields should not throw")
    void userWithEmptyStrings() {
        User user = new User(0, "", "", "", Role.ADMIN);
        assertEquals("", user.getUsername());
        assertEquals("", user.getPasswordHash());
        assertEquals("", user.getFullName());
    }

    @Test
    @DisplayName("User with userId of 0 (placeholder for new users)")
    void userWithZeroId() {
        User user = new User(0, "newuser", "hash", "New User", Role.RECEPTIONIST);
        assertEquals(0, user.getUserId());
    }
}
