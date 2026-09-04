package com.sunrisedental.web;

import com.sunrisedental.dao.AppointmentDAO;
import com.sunrisedental.dao.DentistDAO;
import com.sunrisedental.model.Appointment;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "AppointmentSearchServlet", urlPatterns = {"/appointments/search", "/appointments/edit", "/appointments/delete"})
public class AppointmentSearchServlet extends HttpServlet {

    private AppointmentDAO appointmentDAO;
    private DentistDAO dentistDAO;

    @Override
    public void init() {
        this.appointmentDAO = new AppointmentDAO();
        this.dentistDAO = new DentistDAO();
    }

    // Inside AppointmentSearchServlet.java

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userObj") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Get current logged-in user object
        com.sunrisedental.model.User currentUser = (com.sunrisedental.model.User) session.getAttribute("userObj");
        int currentUserId = currentUser.getUserId(); // Direct integer ID
        String userRole = currentUser.getRole().name();

        try {
            if ("/appointments/edit".equals(path)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Appointment appt = appointmentDAO.getAppointmentById(id);
                request.setAttribute("appointment", appt);
                request.setAttribute("dentists", dentistDAO.getAllDentists());
                request.getRequestDispatcher("/WEB-INF/views/edit-appointment.jsp").forward(request, response);

            } else if ("/appointments/delete".equals(path)) {
                if (!"ADMIN".equalsIgnoreCase(userRole)) {
                    response.sendRedirect(request.getContextPath() + "/access-denied");
                    return;
                }
                int id = Integer.parseInt(request.getParameter("id"));
                appointmentDAO.deleteAppointment(id);
                response.sendRedirect(request.getContextPath() + "/appointments/search?success=Appointment+deleted+successfully");

            } else {
                String query = request.getParameter("query");
                List<Appointment> appointments;

                // IF DENTIST: restrict search to only their own appointments using currentUserId
                if ("DENTIST".equalsIgnoreCase(userRole)) {
                    appointments = appointmentDAO.searchAppointmentsByDentist(query, currentUserId);
                } else {
                    appointments = appointmentDAO.searchAppointments(query);
                }

                request.setAttribute("appointments", appointments);
                request.setAttribute("query", query);
                request.getRequestDispatcher("/WEB-INF/views/search-appointments.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException("Database error handling appointment operation", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        if ("/appointments/edit".equals(path)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                int dentistId = Integer.parseInt(request.getParameter("dentistId"));
                String treatment = request.getParameter("treatmentType");
                String date = request.getParameter("appointmentDate");
                String timeSlot = request.getParameter("timeSlot");

                boolean updated = appointmentDAO.updateAppointment(id, dentistId, treatment, date, timeSlot);

                if (updated) {
                    response.sendRedirect(request.getContextPath() + "/appointments/search?success=Appointment+updated+successfully");
                } else {
                    request.setAttribute("errorMessage", "Failed to update appointment.");
                    doGet(request, response);
                }
            } catch (SQLException e) {
                request.setAttribute("errorMessage", "Error updating: " + e.getMessage());
                doGet(request, response);
            }
        }
    }
}