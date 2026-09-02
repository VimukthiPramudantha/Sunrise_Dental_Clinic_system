package com.sunrisedental.controller;

import com.sunrisedental.dao.AppointmentDAO;
import com.sunrisedental.dao.DentistDAO;
import com.sunrisedental.model.Dentist;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.Collections;
import java.util.List;
import java.util.regex.Pattern;

@WebServlet(urlPatterns = {"/appointments/create", "/appointments/new"})
public class AppointmentServlet extends HttpServlet {

    private static final Pattern PHONE_REGEX = Pattern.compile("^(\\+\\d{1,3}[- ]?)?\\d{10}$");
    private final AppointmentDAO appointmentDAO = new AppointmentDAO();
    private final DentistDAO dentistDAO = new DentistDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        loadDentistsIntoRequest(req);
        req.getRequestDispatcher("/WEB-INF/views/create-appointment.jsp").forward(req, resp);
    }

    private void loadDentistsIntoRequest(HttpServletRequest req) throws ServletException {
        try {
            List<Dentist> dentists = dentistDAO.getAllDentists();
            req.setAttribute("dentists", dentists);
        } catch (SQLException e) {
            req.setAttribute("dentists", Collections.emptyList());
            req.setAttribute("errorMessage", "Unable to load dentist list: " + e.getMessage());
        }
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
            loadDentistsIntoRequest(req);
            req.getRequestDispatcher("/WEB-INF/views/create-appointment.jsp").forward(req, resp);
            return;
        }

        try {
            LocalDate selectedDate = LocalDate.parse(appointmentDate);
            if (selectedDate.isBefore(LocalDate.now())) {
                req.setAttribute("errorMessage", "Appointment date cannot be in the past.");
                loadDentistsIntoRequest(req);
                req.getRequestDispatcher("/WEB-INF/views/create-appointment.jsp").forward(req, resp);
                return;
            }

            int dentistId = Integer.parseInt(dentistIdStr);
            String apptNo = appointmentDAO.createAppointmentWithPatient(
                    fullName, address, phone, dentistId, treatmentType, appointmentDate, timeSlot
            );

            loadDentistsIntoRequest(req);
            req.setAttribute("successMessage", "Appointment booked successfully! Reference No: " + apptNo);
            req.getRequestDispatcher("/WEB-INF/views/create-appointment.jsp").forward(req, resp);

        } catch (Exception e) {
            loadDentistsIntoRequest(req);
            req.setAttribute("errorMessage", "Error booking appointment: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/create-appointment.jsp").forward(req, resp);
        }
    }
}