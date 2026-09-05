package com.sunrisedental.util;

import com.sunrisedental.model.Role;
import com.sunrisedental.model.User;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

@DisplayName("UserSession Tests")
class UserSessionTest {

    @BeforeEach
    void setUp() {
        // Ensure a clean session state before each test
        UserSession.getInstance().cleanSession();
    }


    @Test
    @DisplayName("getInstance should always return the same instance")
    void getInstance_returnsSameInstance() {
        UserSession session1 = UserSession.getInstance();
        UserSession session2 = UserSession.getInstance();
        assertSame(session1, session2);
    }

    @Test
    @DisplayName("getInstance should never return null")
    void getInstance_neverReturnsNull() {
        assertNotNull(UserSession.getInstance());
    }


    @Test
    @DisplayName("isLoggedIn should return false when no session is created")
    void isLoggedIn_noSession_returnsFalse() {
        assertFalse(UserSession.getInstance().isLoggedIn());
    }

    @Test
    @DisplayName("isLoggedIn should return true after createSession is called")
    void isLoggedIn_afterCreateSession_returnsTrue() {
        User user = new User(1, "admin", "hash", "Admin", Role.ADMIN);
        UserSession.getInstance().createSession(user);
        assertTrue(UserSession.getInstance().isLoggedIn());
    }


    @Test
    @DisplayName("getCurrentUser should return null when no session exists")
    void getCurrentUser_noSession_returnsNull() {
        assertNull(UserSession.getInstance().getCurrentUser());
    }

    @Test
    @DisplayName("getCurrentUser should return the user set by createSession")
    void getCurrentUser_afterCreateSession_returnsCorrectUser() {
        User user = new User(5, "drperera", "hash", "Dr. Perera", Role.DENTIST);
        UserSession.getInstance().createSession(user);

        User current = UserSession.getInstance().getCurrentUser();
        assertNotNull(current);
        assertEquals(5, current.getUserId());
        assertEquals("drperera", current.getUsername());
        assertEquals("Dr. Perera", current.getFullName());
        assertEquals(Role.DENTIST, current.getRole());
    }

    @Test
    @DisplayName("createSession should replace existing session user")
    void createSession_replacesPreviousUser() {
        User user1 = new User(1, "user1", "hash1", "User One", Role.ADMIN);
        User user2 = new User(2, "user2", "hash2", "User Two", Role.RECEPTIONIST);

        UserSession.getInstance().createSession(user1);
        assertEquals("user1", UserSession.getInstance().getCurrentUser().getUsername());

        UserSession.getInstance().createSession(user2);
        assertEquals("user2", UserSession.getInstance().getCurrentUser().getUsername());
    }


    @Test
    @DisplayName("cleanSession should clear the current user")
    void cleanSession_clearsCurrentUser() {
        User user = new User(1, "admin", "hash", "Admin", Role.ADMIN);
        UserSession.getInstance().createSession(user);
        assertTrue(UserSession.getInstance().isLoggedIn());

        UserSession.getInstance().cleanSession();
        assertFalse(UserSession.getInstance().isLoggedIn());
        assertNull(UserSession.getInstance().getCurrentUser());
    }

    @Test
    @DisplayName("cleanSession on already clean session should not throw")
    void cleanSession_alreadyClean_noException() {
        assertDoesNotThrow(() -> UserSession.getInstance().cleanSession());
        assertFalse(UserSession.getInstance().isLoggedIn());
    }

    @Test
    @DisplayName("Full lifecycle: create → verify → clean → verify")
    void fullLifecycle() {
        UserSession session = UserSession.getInstance();

        // Initially not logged in
        assertFalse(session.isLoggedIn());

        // Create session
        User user = new User(10, "lifecycle", "hash", "Lifecycle User", Role.RECEPTIONIST);
        session.createSession(user);
        assertTrue(session.isLoggedIn());
        assertEquals("lifecycle", session.getCurrentUser().getUsername());

        // Clean session
        session.cleanSession();
        assertFalse(session.isLoggedIn());
        assertNull(session.getCurrentUser());
    }
}
