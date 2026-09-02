package com.sunrisedental.controller;

import com.sunrisedental.dao.AppointmentDAO;
import com.sunrisedental.dao.PatientDAO;
import com.sunrisedental.util.UserSession;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private final AppointmentDAO appointmentDAO = new AppointmentDAO();
    private final PatientDAO patientDAO = new PatientDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("userObj") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        com.sunrisedental.model.User userObj = (com.sunrisedental.model.User) session.getAttribute("userObj");

        if (userObj == null || userObj.getRole() == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String role = userObj.getRole().name();

        try {
            Map<String, Object> dashboardStats = new HashMap<>();

            switch (role) {
                case "ADMIN":
                    dashboardStats.put("totalPatients", patientDAO.getTotalPatientCount());
                    dashboardStats.put("todayAppointments", appointmentDAO.getTodayAppointmentCount());
                    dashboardStats.put("totalUsers", patientDAO.getTotalUserCount());
                    break;

                case "DENTIST":
                    int dentistId = userObj.getUserId();
                    dashboardStats.put("myTodayAppointments", appointmentDAO.getTodayAppointmentsByDentist(dentistId));
                    dashboardStats.put("myTotalAppointments", appointmentDAO.getTotalAppointmentsByDentist(dentistId));
                    break;

                case "RECEPTIONIST":
                    dashboardStats.put("todayAppointments", appointmentDAO.getTodayAppointmentCount());
                    dashboardStats.put("totalPatients", patientDAO.getTotalPatientCount());
                    break;

                default:
                    break;
            }

            req.setAttribute("stats", dashboardStats);
            req.setAttribute("currentUser", userObj);

            req.getRequestDispatcher("/WEB-INF/views/dashboard.jsp").forward(req, resp);

        } catch (SQLException e) {
            req.setAttribute("errorMessage", "Database error loading dashboard data: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/dashboard.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doGet(req, resp);
    }
}