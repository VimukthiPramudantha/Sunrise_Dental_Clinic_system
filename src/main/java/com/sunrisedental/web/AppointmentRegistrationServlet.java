package com.sunrisedental.web;

import com.sunrisedental.dao.AppointmentDAO;
import com.sunrisedental.dao.DentistDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "AppointmentRegistrationServlet", urlPatterns = {"/appointments/new", "/appointments/create"})
public class AppointmentRegistrationServlet extends HttpServlet {

    private AppointmentDAO appointmentDAO;
    private DentistDAO dentistDAO;

    @Override
    public void init() {
        this.appointmentDAO = new AppointmentDAO();
        this.dentistDAO = new DentistDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String userRole = (session != null) ? (String) session.getAttribute("userRole") : "";

        if (!"ADMIN".equalsIgnoreCase(userRole) && !"RECEPTIONIST".equalsIgnoreCase(userRole)) {
            response.sendRedirect(request.getContextPath() + "/access-denied");
            return;
        }

        try {
            request.setAttribute("dentists", dentistDAO.getAllDentists());
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error loading dentists: " + e.getMessage());
        }
        request.getRequestDispatcher("/WEB-INF/views/create-appointment.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String userRole = (session != null) ? (String) session.getAttribute("userRole") : "";

        if (!"ADMIN".equalsIgnoreCase(userRole) && !"RECEPTIONIST".equalsIgnoreCase(userRole)) {
            response.sendRedirect(request.getContextPath() + "/access-denied");
            return;
        }

        try {
            String fullName = request.getParameter("fullName");
            String address = request.getParameter("address");
            String phone = request.getParameter("phone");
            int dentistId = Integer.parseInt(request.getParameter("dentistId"));
            String treatmentType = request.getParameter("treatmentType");
            String appointmentDate = request.getParameter("appointmentDate");
            String timeSlot = request.getParameter("timeSlot");

            String appointmentNo = appointmentDAO.createAppointmentWithPatient(
                    fullName, address, phone, dentistId, treatmentType, appointmentDate, timeSlot);

            request.setAttribute("successMessage", "Appointment booked successfully! Reference No: " + appointmentNo);
            
            // Reload dentists for the form
            request.setAttribute("dentists", dentistDAO.getAllDentists());
            
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error creating appointment: " + e.getMessage());
            try {
                request.setAttribute("dentists", dentistDAO.getAllDentists());
            } catch (SQLException ex) {
                // Ignore
            }
        }
        
        request.getRequestDispatcher("/WEB-INF/views/create-appointment.jsp").forward(request, response);
    }
}
