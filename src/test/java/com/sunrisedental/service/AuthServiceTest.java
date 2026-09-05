package com.sunrisedental.service;

import com.sunrisedental.dao.UserDAO;
import com.sunrisedental.model.Role;
import com.sunrisedental.model.User;
import com.sunrisedental.util.PasswordUtil;
import com.sunrisedental.util.UserSession;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.sql.SQLException;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("AuthService Tests")
class AuthServiceTest {

    @Mock
    private UserDAO mockUserDAO;

    private AuthService authService;

    @BeforeEach
    void setUp() {
        authService = new AuthService(mockUserDAO);
        // Clean any lingering session state from previous tests
        UserSession.getInstance().cleanSession();
    }

    @Nested
    @DisplayName("Login")
    class LoginTests {

        @Test
        @DisplayName("Successful login with correct credentials should return true")
        void login_validCredentials_returnsTrue() throws SQLException {
            String password = "secret123";
            String hash = PasswordUtil.hashPassword(password);
            User user = new User(1, "admin", hash, "Admin User", Role.ADMIN);

            when(mockUserDAO.findByUsername("admin")).thenReturn(user);

            boolean result = authService.login("admin", password);

            assertTrue(result);
            verify(mockUserDAO).findByUsername("admin");
        }

        @Test
        @DisplayName("Successful login should create a UserSession")
        void login_validCredentials_createsSession() throws SQLException {
            String password = "secret123";
            String hash = PasswordUtil.hashPassword(password);
            User user = new User(1, "admin", hash, "Admin User", Role.ADMIN);

            when(mockUserDAO.findByUsername("admin")).thenReturn(user);

            authService.login("admin", password);

            assertTrue(UserSession.getInstance().isLoggedIn());
            assertEquals("admin", UserSession.getInstance().getCurrentUser().getUsername());
        }

        @Test
        @DisplayName("Login with wrong password should return false")
        void login_wrongPassword_returnsFalse() throws SQLException {
            String correctHash = PasswordUtil.hashPassword("correctPassword");
            User user = new User(1, "admin", correctHash, "Admin", Role.ADMIN);

            when(mockUserDAO.findByUsername("admin")).thenReturn(user);

            boolean result = authService.login("admin", "wrongPassword");

            assertFalse(result);
        }

        @Test
        @DisplayName("Login with non-existent user should return false")
        void login_nonExistentUser_returnsFalse() throws SQLException {
            when(mockUserDAO.findByUsername("unknown")).thenReturn(null);

            boolean result = authService.login("unknown", "anyPassword");

            assertFalse(result);
            verify(mockUserDAO).findByUsername("unknown");
        }

        @Test
        @DisplayName("Login with null username should throw IllegalArgumentException")
        void login_nullUsername_throwsException() {
            assertThrows(IllegalArgumentException.class,
                    () -> authService.login(null, "password"));
        }

        @Test
        @DisplayName("Login with null password should throw IllegalArgumentException")
        void login_nullPassword_throwsException() {
            assertThrows(IllegalArgumentException.class,
                    () -> authService.login("admin", null));
        }

        @Test
        @DisplayName("Login with empty username should throw IllegalArgumentException")
        void login_emptyUsername_throwsException() {
            assertThrows(IllegalArgumentException.class,
                    () -> authService.login("", "password"));
        }

        @Test
        @DisplayName("Login with whitespace-only username should throw IllegalArgumentException")
        void login_whitespaceUsername_throwsException() {
            assertThrows(IllegalArgumentException.class,
                    () -> authService.login("   ", "password"));
        }

        @Test
        @DisplayName("Login should trim username before lookup")
        void login_trimsUsername() throws SQLException {
            String password = "secret123";
            String hash = PasswordUtil.hashPassword(password);
            User user = new User(1, "admin", hash, "Admin", Role.ADMIN);

            when(mockUserDAO.findByUsername("admin")).thenReturn(user);

            boolean result = authService.login("  admin  ", password);

            assertTrue(result);
            verify(mockUserDAO).findByUsername("admin");
        }

        @Test
        @DisplayName("Login should propagate SQLException from DAO")
        void login_sqlException_propagated() throws SQLException {
            when(mockUserDAO.findByUsername(anyString())).thenThrow(new SQLException("DB down"));

            assertThrows(SQLException.class,
                    () -> authService.login("admin", "password"));
        }
    }


    @Nested
    @DisplayName("Register User")
    class RegisterTests {

        @Test
        @DisplayName("Successful registration should return true")
        void registerUser_validInput_returnsTrue() throws SQLException {
            when(mockUserDAO.findByUsername("newuser")).thenReturn(null);
            when(mockUserDAO.createUser(any(User.class))).thenReturn(true);

            boolean result = authService.registerUser("newuser", "password123", "New User", "RECEPTIONIST");

            assertTrue(result);
            verify(mockUserDAO).findByUsername("newuser");
            verify(mockUserDAO).createUser(any(User.class));
        }

        @Test
        @DisplayName("Registration should hash the password before storing")
        void registerUser_hashesPassword() throws SQLException {
            when(mockUserDAO.findByUsername("newuser")).thenReturn(null);
            when(mockUserDAO.createUser(any(User.class))).thenReturn(true);

            authService.registerUser("newuser", "password123", "New User", "ADMIN");

            verify(mockUserDAO).createUser(argThat(user ->
                    user.getPasswordHash().equals(PasswordUtil.hashPassword("password123"))
            ));
        }

        @Test
        @DisplayName("Registration should correctly map role string to Role enum")
        void registerUser_mapsRoleCorrectly() throws SQLException {
            when(mockUserDAO.findByUsername("newdentist")).thenReturn(null);
            when(mockUserDAO.createUser(any(User.class))).thenReturn(true);

            authService.registerUser("newdentist", "password123", "Dr. New", "DENTIST");

            verify(mockUserDAO).createUser(argThat(user ->
                    user.getRole() == Role.DENTIST
            ));
        }

        @Test
        @DisplayName("Registration with existing username should throw IllegalArgumentException")
        void registerUser_existingUsername_throwsException() throws SQLException {
            User existingUser = new User(1, "existing", "hash", "Existing", Role.ADMIN);
            when(mockUserDAO.findByUsername("existing")).thenReturn(existingUser);

            IllegalArgumentException ex = assertThrows(IllegalArgumentException.class,
                    () -> authService.registerUser("existing", "password123", "Name", "ADMIN"));

            assertTrue(ex.getMessage().contains("already taken"));
        }

        @Test
        @DisplayName("Registration with password shorter than 6 chars should throw IllegalArgumentException")
        void registerUser_shortPassword_throwsException() {
            assertThrows(IllegalArgumentException.class,
                    () -> authService.registerUser("user", "12345", "Name", "ADMIN"));
        }

        @Test
        @DisplayName("Registration with null username should throw IllegalArgumentException")
        void registerUser_nullUsername_throwsException() {
            assertThrows(IllegalArgumentException.class,
                    () -> authService.registerUser(null, "password123", "Name", "ADMIN"));
        }

        @Test
        @DisplayName("Registration with empty username should throw IllegalArgumentException")
        void registerUser_emptyUsername_throwsException() {
            assertThrows(IllegalArgumentException.class,
                    () -> authService.registerUser("", "password123", "Name", "ADMIN"));
        }

        @Test
        @DisplayName("Registration with null password should throw IllegalArgumentException")
        void registerUser_nullPassword_throwsException() {
            assertThrows(IllegalArgumentException.class,
                    () -> authService.registerUser("user", null, "Name", "ADMIN"));
        }

        @Test
        @DisplayName("Registration with null fullName should throw IllegalArgumentException")
        void registerUser_nullFullName_throwsException() {
            assertThrows(IllegalArgumentException.class,
                    () -> authService.registerUser("user", "password123", null, "ADMIN"));
        }

        @Test
        @DisplayName("Registration with empty fullName should throw IllegalArgumentException")
        void registerUser_emptyFullName_throwsException() {
            assertThrows(IllegalArgumentException.class,
                    () -> authService.registerUser("user", "password123", "", "ADMIN"));
        }

        @Test
        @DisplayName("Registration with invalid role string should throw IllegalArgumentException")
        void registerUser_invalidRole_throwsException() throws SQLException {
            when(mockUserDAO.findByUsername("user")).thenReturn(null);

            assertThrows(IllegalArgumentException.class,
                    () -> authService.registerUser("user", "password123", "Name", "INVALID_ROLE"));
        }

        @Test
        @DisplayName("Registration should trim username and fullName")
        void registerUser_trimsInputFields() throws SQLException {
            when(mockUserDAO.findByUsername("trimmed")).thenReturn(null);
            when(mockUserDAO.createUser(any(User.class))).thenReturn(true);

            authService.registerUser("  trimmed  ", "password123", "  Trimmed Name  ", "ADMIN");

            verify(mockUserDAO).findByUsername("trimmed");
            verify(mockUserDAO).createUser(argThat(user ->
                    "trimmed".equals(user.getUsername()) && "Trimmed Name".equals(user.getFullName())
            ));
        }

        @Test
        @DisplayName("Registration should set userId to 0 for new users")
        void registerUser_setsUserIdToZero() throws SQLException {
            when(mockUserDAO.findByUsername("user")).thenReturn(null);
            when(mockUserDAO.createUser(any(User.class))).thenReturn(true);

            authService.registerUser("user", "password123", "Name", "RECEPTIONIST");

            verify(mockUserDAO).createUser(argThat(user -> user.getUserId() == 0));
        }

        @Test
        @DisplayName("Registration should propagate SQLException from DAO")
        void registerUser_sqlException_propagated() throws SQLException {
            when(mockUserDAO.findByUsername("user")).thenReturn(null);
            when(mockUserDAO.createUser(any(User.class))).thenThrow(new SQLException("Connection lost"));

            assertThrows(SQLException.class,
                    () -> authService.registerUser("user", "password123", "Name", "ADMIN"));
        }
    }


    @Nested
    @DisplayName("Logout")
    class LogoutTests {

        @Test
        @DisplayName("Logout should clear the UserSession")
        void logout_clearsSession() throws SQLException {
            // First log in
            String password = "secret";
            String hash = PasswordUtil.hashPassword(password);
            User user = new User(1, "admin", hash, "Admin", Role.ADMIN);
            when(mockUserDAO.findByUsername("admin")).thenReturn(user);
            authService.login("admin", password);
            assertTrue(UserSession.getInstance().isLoggedIn());

            // Then log out
            authService.logout();
            assertFalse(UserSession.getInstance().isLoggedIn());
            assertNull(UserSession.getInstance().getCurrentUser());
        }

        @Test
        @DisplayName("Logout when not logged in should not throw")
        void logout_notLoggedIn_noException() {
            assertDoesNotThrow(() -> authService.logout());
        }
    }


    @Nested
    @DisplayName("Constructor")
    class ConstructorTests {

        @Test
        @DisplayName("Parameterized constructor should accept a UserDAO")
        void parameterizedConstructor_acceptsUserDAO() {
            AuthService service = new AuthService(mockUserDAO);
            assertNotNull(service);
        }

        @Test
        @DisplayName("Default constructor should create an AuthService instance")
        void defaultConstructor_createsInstance() {
            // This will create a real UserDAO internally — just verifying no crash
            AuthService service = new AuthService();
            assertNotNull(service);
        }
    }
}
