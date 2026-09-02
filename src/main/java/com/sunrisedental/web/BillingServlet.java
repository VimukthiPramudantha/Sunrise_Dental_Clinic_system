package com.sunrisedental.web;

import com.sunrisedental.dao.AppointmentDAO;
import com.sunrisedental.dao.BillingDAO;
import com.sunrisedental.model.Appointment;
import com.sunrisedental.model.Bill;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "BillingServlet", urlPatterns = {"/billing", "/billing/generate", "/billing/receipt", "/billing/email"})
public class BillingServlet extends HttpServlet {

    private AppointmentDAO appointmentDAO;
    private BillingDAO billingDAO;

    @Override
    public void init() {
        this.appointmentDAO = new AppointmentDAO();
        this.billingDAO = new BillingDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        try {
            if ("/billing/receipt".equals(path)) {
                String invoiceNo = request.getParameter("invoiceNo");
                Bill bill = billingDAO.getBillByInvoiceNo(invoiceNo);
                request.setAttribute("bill", bill);
                request.getRequestDispatcher("/WEB-INF/views/receipt.jsp").forward(request, response);
            } else {
                String query = request.getParameter("query");
                List<Appointment> appointments = appointmentDAO.searchAppointments(query);

                String selectId = request.getParameter("selectId");
                if (selectId != null && !selectId.isEmpty()) {
                    Appointment selectedAppt = appointmentDAO.getAppointmentById(Integer.parseInt(selectId));
                    request.setAttribute("selectedAppt", selectedAppt);
                }

                request.setAttribute("appointments", appointments);
                request.setAttribute("query", query);
                request.getRequestDispatcher("/WEB-INF/views/billing.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException("Database error handling billing operation", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        if ("/billing/generate".equals(path)) {
            try {
                int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
                BigDecimal consultationFee = new BigDecimal(request.getParameter("consultationFee"));
                BigDecimal treatmentCost = new BigDecimal(request.getParameter("treatmentCost"));

                String medStr = request.getParameter("medicineCharges");
                BigDecimal medicineCharges = (medStr != null && !medStr.isEmpty()) ? new BigDecimal(medStr) : BigDecimal.ZERO;

                String invoiceNo = billingDAO.generateInvoice(appointmentId, consultationFee, treatmentCost, medicineCharges);

                response.sendRedirect(request.getContextPath() + "/billing/receipt?invoiceNo=" + invoiceNo);

            } catch (SQLException e) {
                request.setAttribute("errorMessage", "Error generating invoice: " + e.getMessage());
                doGet(request, response);
            }
        } else if ("/billing/email".equals(path)) {
            try {
                String invoiceNo = request.getParameter("invoiceNo");
                String recipientEmail = request.getParameter("email");

                Bill bill = billingDAO.getBillByInvoiceNo(invoiceNo);
                if (bill != null && recipientEmail != null && !recipientEmail.trim().isEmpty()) {
                    com.sunrisedental.util.EmailUtil.sendReceiptEmail(recipientEmail.trim(), bill);
                    response.sendRedirect(request.getContextPath() + "/billing/receipt?invoiceNo=" + invoiceNo + "&emailSent=true");
                } else {
                    response.sendRedirect(request.getContextPath() + "/billing/receipt?invoiceNo=" + invoiceNo + "&emailError=true");
                }
            } catch (SQLException e) {
                throw new ServletException("Error retrieving invoice for email", e);
            }
        }
    }
}