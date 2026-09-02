package com.sunrisedental.web;

import com.sunrisedental.dao.UserDAO;
import com.sunrisedental.model.User;
import com.sunrisedental.service.AuthService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "AuthServlet", urlPatterns = {"/login", "/logout"})
public class AuthServlet extends HttpServlet {

    private AuthService authService;
    private UserDAO userDAO;

    @Override
    public void init() {
        this.authService = new AuthService();
        this.userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();

        if ("/logout".equals(path)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            authService.logout();
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            boolean isAuthenticated = authService.login(username, password);

            if (isAuthenticated) {
                User user = userDAO.findByUsername(username.trim());

                if (user != null) {
                    HttpSession session = request.getSession(true);
                    session.setAttribute("user", user.getUsername());
                    session.setAttribute("userRole", user.getRole().getRoleName());
                    session.setAttribute("userObj", user);

                    // Redirect to dashboard
                    response.sendRedirect(request.getContextPath() + "/dashboard");
                    return;
                }
            }

            request.setAttribute("errorMessage", "Invalid username or password. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace(); // Print stack trace to Tomcat console logs for debugging
            request.setAttribute("errorMessage", "Login Error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }
}