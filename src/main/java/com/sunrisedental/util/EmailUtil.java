package com.sunrisedental.util;

import com.sunrisedental.model.Bill;
import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.util.Properties;

public class EmailUtil {

    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String SENDER_EMAIL = System.getenv("SMTP_EMAIL");
    private static final String SENDER_PASSWORD = System.getenv("SMTP_PASSWORD");

    public static boolean sendReceiptEmail(String recipientEmail, Bill bill) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SENDER_EMAIL, SENDER_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(SENDER_EMAIL, "Sunrise Dental Clinic"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            message.setSubject("Payment Receipt - " + bill.getInvoiceNo() + " [Sunrise Dental]");

            String htmlContent = "<h2>SUNRISE DENTAL CLINIC</h2>"
                    + "<p>Dear <strong>" + bill.getPatientName() + "</strong>,</p>"
                    + "<p>Thank you for choosing Sunrise Dental Clinic. Here is your payment receipt summary:</p>"
                    + "<hr style='border: 1px dashed #ccc;'>"
                    + "<p><strong>Invoice No:</strong> " + bill.getInvoiceNo() + "</p>"
                    + "<p><strong>Appointment No:</strong> " + bill.getAppointmentNo() + "</p>"
                    + "<p><strong>Attending Dentist:</strong> " + bill.getDentistName() + "</p>"
                    + "<table border='1' cellpadding='8' cellspacing='0' style='border-collapse: collapse; width: 100%; max-width: 400px;'>"
                    + "  <tr><td>Consultation Fee</td><td align='right'>LKR " + bill.getConsultationFee() + "</td></tr>"
                    + "  <tr><td>Treatment Cost</td><td align='right'>LKR " + bill.getTreatmentCost() + "</td></tr>"
                    + "  <tr><td>Medicine & Extras</td><td align='right'>LKR " + bill.getMedicineCharges() + "</td></tr>"
                    + "  <tr style='font-weight: bold; background: #e0f2fe;'><td>Total Paid</td><td align='right'>LKR " + bill.getTotalAmount() + "</td></tr>"
                    + "</table>"
                    + "<hr style='border: 1px dashed #ccc;'>"
                    + "<p>Wish you a healthy smile!</p>"
                    + "<p><em>Sunrise Dental Clinic Management System</em></p>";

            message.setContent(htmlContent, "text/html; charset=utf-8");

            Transport.send(message);
            System.out.println("Email sent successfully to: " + recipientEmail);
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}