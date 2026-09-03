package com.sunrisedental.util;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

@DisplayName("PasswordUtil Tests")
class PasswordUtilTest {

    // ── hashPassword() ───────────────────────────────────────────────

    @Test
    @DisplayName("hashPassword should return a non-null string")
    void hashPassword_returnsNonNull() {
        String hash = PasswordUtil.hashPassword("password123");
        assertNotNull(hash);
    }

    @Test
    @DisplayName("hashPassword should return a 64-character hex string (SHA-256)")
    void hashPassword_returns64CharHex() {
        String hash = PasswordUtil.hashPassword("testpassword");
        assertEquals(64, hash.length());
        assertTrue(hash.matches("[0-9a-f]{64}"), "Hash should be lowercase hex");
    }

    @Test
    @DisplayName("hashPassword should be deterministic (same input → same output)")
    void hashPassword_isDeterministic() {
        String password = "mySecret!@#";
        String hash1 = PasswordUtil.hashPassword(password);
        String hash2 = PasswordUtil.hashPassword(password);
        assertEquals(hash1, hash2);
    }

    @Test
    @DisplayName("hashPassword should produce different hashes for different passwords")
    void hashPassword_differentPasswords_differentHashes() {
        String hash1 = PasswordUtil.hashPassword("password1");
        String hash2 = PasswordUtil.hashPassword("password2");
        assertNotEquals(hash1, hash2);
    }

    @Test
    @DisplayName("hashPassword should handle empty string without throwing")
    void hashPassword_emptyString() {
        String hash = PasswordUtil.hashPassword("");
        assertNotNull(hash);
        assertEquals(64, hash.length());
    }

    @Test
    @DisplayName("hashPassword should handle Unicode characters")
    void hashPassword_unicodeCharacters() {
        String hash = PasswordUtil.hashPassword("පාස්වර්ඩ්");
        assertNotNull(hash);
        assertEquals(64, hash.length());
    }

    @Test
    @DisplayName("hashPassword with spaces should produce a valid hash")
    void hashPassword_withSpaces() {
        String hash = PasswordUtil.hashPassword("password with spaces");
        assertNotNull(hash);
        assertEquals(64, hash.length());
    }

    // ── verifyPassword() ─────────────────────────────────────────────

    @Test
    @DisplayName("verifyPassword should return true for matching password")
    void verifyPassword_matching() {
        String password = "correctPassword";
        String hash = PasswordUtil.hashPassword(password);
        assertTrue(PasswordUtil.verifyPassword(password, hash));
    }

    @Test
    @DisplayName("verifyPassword should return false for non-matching password")
    void verifyPassword_nonMatching() {
        String hash = PasswordUtil.hashPassword("correctPassword");
        assertFalse(PasswordUtil.verifyPassword("wrongPassword", hash));
    }

    @Test
    @DisplayName("verifyPassword should return false when comparing different-case passwords")
    void verifyPassword_caseSensitive() {
        String hash = PasswordUtil.hashPassword("Password");
        assertFalse(PasswordUtil.verifyPassword("password", hash));
    }

    @Test
    @DisplayName("verifyPassword should return true for empty string matching empty hash")
    void verifyPassword_emptyString() {
        String hash = PasswordUtil.hashPassword("");
        assertTrue(PasswordUtil.verifyPassword("", hash));
    }

    @Test
    @DisplayName("verifyPassword should return false for empty input vs non-empty hash")
    void verifyPassword_emptyVsNonEmpty() {
        String hash = PasswordUtil.hashPassword("somepassword");
        assertFalse(PasswordUtil.verifyPassword("", hash));
    }

    // ── Known SHA-256 Value ──────────────────────────────────────────

    @Test
    @DisplayName("hashPassword('password') should match known SHA-256 digest")
    void hashPassword_knownDigest() {
        // SHA-256 of "password" is well-known
        String expected = "5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8";
        assertEquals(expected, PasswordUtil.hashPassword("password"));
    }
}
