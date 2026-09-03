package com.sunrisedental.controller;

import com.sunrisedental.dao.AppointmentDAO;
import com.sunrisedental.model.Appointment;
import com.sunrisedental.util.UserSession;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/appointments/my-schedule")
public class AppointmentServlet extends HttpServlet {

    private final AppointmentDAO appointmentDAO = new AppointmentDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("userSession") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        UserSession userSession = (UserSession) session.getAttribute("userSession");

        // Role verification
        if (!"DENTIST".equals(userSession.getRole().name())) {
            resp.sendRedirect(req.getContextPath() + "/access-denied.jsp");
            return;
        }

        try {
            // Check with logged-in dentist's ID
            int dentistId = userSession.getCurrentUser().getUserId();
            List<Appointment> appointments = appointmentDAO.getAppointmentsByDentist(dentistId);

            req.setAttribute("appointments", appointments);
            req.getRequestDispatcher("/views/dentist-appointments.jsp").forward(req, resp);

        } catch (SQLException e) {
            req.setAttribute("errorMessage", "Error fetching appointments: " + e.getMessage());
            req.getRequestDispatcher("/views/dentist-appointments.jsp").forward(req, resp);
        }
    }
}