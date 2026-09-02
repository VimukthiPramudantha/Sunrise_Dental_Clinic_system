package com.sunrisedental.controller;

import com.sunrisedental.dao.AppointmentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.util.regex.Pattern;

@WebServlet(urlPatterns = {"/appointments/create", "/appointments/new"})
public class AppointmentServlet extends HttpServlet {

    private static final Pattern PHONE_REGEX = Pattern.compile("^(\\+\\d{1,3}[- ]?)?\\d{10}$");
    private final AppointmentDAO appointmentDAO = new AppointmentDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/create-appointment.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String fullName = req.getParameter("fullName");
        String address = req.getParameter("address");
        String phone = req.getParameter("phone");
        String dentistIdStr = req.getParameter("dentistId");
        String treatmentType = req.getParameter("treatmentType");
        String appointmentDate = req.getParameter("appointmentDate");
        String timeSlot = req.getParameter("timeSlot");

        if (fullName == null || fullName.trim().isEmpty() ||
                address == null || address.trim().isEmpty() ||
                phone == null || !PHONE_REGEX.matcher(phone).matches()) {

            req.setAttribute("errorMessage", "Invalid patient contact information or phone format.");
            req.getRequestDispatcher("/WEB-INF/views/create-appointment.jsp").forward(req, resp);
            return;
        }

        try {
            LocalDate selectedDate = LocalDate.parse(appointmentDate);
            if (selectedDate.isBefore(LocalDate.now())) {
                req.setAttribute("errorMessage", "Appointment date cannot be in the past.");
                req.getRequestDispatcher("/WEB-INF/views/create-appointment.jsp").forward(req, resp);
                return;
            }

            int dentistId = Integer.parseInt(dentistIdStr);
            String apptNo = appointmentDAO.createAppointmentWithPatient(
                    fullName, address, phone, dentistId, treatmentType, appointmentDate, timeSlot
            );

            req.setAttribute("successMessage", "Appointment booked successfully! Reference No: " + apptNo);
            req.getRequestDispatcher("/WEB-INF/views/create-appointment.jsp").forward(req, resp);

        } catch (Exception e) {
            req.setAttribute("errorMessage", "Error booking appointment: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/create-appointment.jsp").forward(req, resp);
        }
    }
}