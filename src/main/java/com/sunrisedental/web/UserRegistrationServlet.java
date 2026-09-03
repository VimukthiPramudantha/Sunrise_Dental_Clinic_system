package com.sunrisedental.web;

import com.sunrisedental.service.AuthService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

// 1. Updated URL Pattern to /admin-register
@WebServlet(name = "UserRegistrationServlet", urlPatterns = {"/admin-register"})
public class UserRegistrationServlet extends HttpServlet {

    private AuthService authService;

    @Override
    public void init() {
        this.authService = new AuthService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String userRole = (session != null) ? (String) session.getAttribute("userRole") : "";

        if (!"ADMIN".equalsIgnoreCase(userRole)) {
            response.sendRedirect(request.getContextPath() + "/access-denied");
            return;
        }

        // 2. Updated target JSP path
        request.getRequestDispatcher("/WEB-INF/views/admin-register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String userRole = (session != null) ? (String) session.getAttribute("userRole") : "";

        if (!"ADMIN".equalsIgnoreCase(userRole)) {
            response.sendRedirect(request.getContextPath() + "/access-denied");
            return;
        }

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");
        String roleStr = request.getParameter("role");

        try {
            boolean success = authService.registerUser(username, password, fullName, roleStr);

            if (success) {
                request.setAttribute("successMessage", "Staff member '" + fullName + "' (" + roleStr + ") registered successfully!");
            } else {
                request.setAttribute("errorMessage", "Failed to register user. Please try again.");
            }
        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", e.getMessage());
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
        }

        // 3. Updated target JSP path
        request.getRequestDispatcher("/WEB-INF/views/admin-register.jsp").forward(request, response);
    }
}