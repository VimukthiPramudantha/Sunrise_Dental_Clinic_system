<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Receipt - ${bill.invoiceNo}</title>
    <!-- Include html2pdf library for instant PDF generation -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f4f7f6; margin: 0; padding: 20px; }
        .receipt-card { max-width: 480px; margin: 0 auto; background: #fff; padding: 30px; border: 1px solid #ddd; border-radius: 8px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
        .text-center { text-align: center; }
        .divider { border-top: 1px dashed #000; margin: 15px 0; }
        table { width: 100%; text-align: left; border-collapse: collapse; }
        td { padding: 6px 0; }
        .total-row td { font-weight: bold; font-size: 1.1rem; border-top: 1px solid #000; padding-top: 10px; }

        .action-bar { max-width: 480px; margin: 20px auto 0 auto; display: flex; flex-direction: column; gap: 10px; }
        .btn-group { display: flex; gap: 10px; }
        .btn-action { flex: 1; padding: 12px; border: none; border-radius: 6px; font-weight: bold; cursor: pointer; text-align: center; text-decoration: none; font-size: 0.95rem; }
        .btn-pdf { background-color: #0284c7; color: #fff; }
        .btn-email { background-color: #2a9d8f; color: #fff; }
        .btn-back { background-color: #6c757d; color: #fff; }

        .email-form { background: #fff; padding: 15px; border-radius: 8px; border: 1px solid #ddd; margin-top: 10px; display: none; }
        .email-form input { width: 70%; padding: 8px; border: 1px solid #ccc; border-radius: 4px; }
        .email-form button { padding: 8px 12px; background: #2a9d8f; color: white; border: none; border-radius: 4px; cursor: pointer; font-weight: bold; }
    </style>
    <script>
        function downloadPDF() {
            const element = document.getElementById('receipt-content');
            const opt = {
                margin:       10,
                filename:     'Receipt_${bill.invoiceNo}.pdf',
                image:        { type: 'jpeg', quality: 0.98 },
                html2canvas:  { scale: 2 },
                jsPDF:        { unit: 'mm', format: 'a4', orientation: 'portrait' }
            };
            html2pdf().set(opt).from(element).save();
        }

        function toggleEmailForm() {
            const form = document.getElementById('emailForm');
            form.style.display = form.style.display === 'block' ? 'none' : 'block';
        }
    </script>
</head>
<body>

<%-- Action Bar above Receipt --%>
<div class="action-bar no-print">
    <c:if test="${param.emailSent != null}">
        <div style="background-color: #d4edda; color: #155724; padding: 10px; border-radius: 6px; text-align: center;">
            Receipt successfully sent to email!
        </div>
    </c:if>

    <div class="btn-group">
        <button onclick="downloadPDF()" class="btn-action btn-pdf">Download PDF</button>
        <button onclick="toggleEmailForm()" class="btn-action btn-email">Send Email</button>
    </div>

    <%-- Hidden Inline Email Form --%>
    <div id="emailForm" class="email-form">
        <form action="${pageContext.request.contextPath}/billing/email" method="POST" style="display: flex; gap: 8px; justify-content: space-between;">
            <input type="hidden" name="invoiceNo" value="${bill.invoiceNo}">
            <input type="email" name="email" placeholder="Enter patient email address..." required>
            <button type="submit">Send</button>
        </form>
    </div>
</div>

<br>

<%-- Printable / Convertible Receipt Area --%>
<div class="receipt-card" id="receipt-content">
    <div class="text-center">
        <h2>SUNRISE DENTAL CLINIC</h2>
        <p>123 Clinic Road, Colombo, Sri Lanka<br>Tel: +94 11 234 5678</p>
    </div>

    <div class="divider"></div>

    <p><strong>INVOICE NO:</strong> <c:out value="${bill.invoiceNo}"/></p>
    <p><strong>DATE:</strong> <c:out value="${bill.createdAt}"/></p>
    <p><strong>APPOINTMENT NO:</strong> <c:out value="${bill.appointmentNo}"/></p>
    <p><strong>PATIENT:</strong> <c:out value="${bill.patientName}"/></p>
    <p><strong>DENTIST:</strong> <c:out value="${bill.dentistName}"/></p>

    <div class="divider"></div>

    <table>
        <tr>
            <td>Consultation Fee</td>
            <td style="text-align:right;">LKR <c:out value="${bill.consultationFee}"/></td>
        </tr>
        <tr>
            <td>Treatment Cost</td>
            <td style="text-align:right;">LKR <c:out value="${bill.treatmentCost}"/></td>
        </tr>
        <tr>
            <td>Medicine & Extras</td>
            <td style="text-align:right;">LKR <c:out value="${bill.medicineCharges}"/></td>
        </tr>
        <tr class="total-row">
            <td>TOTAL AMOUNT</td>
            <td style="text-align:right;">LKR <c:out value="${bill.totalAmount}"/></td>
        </tr>
    </table>

    <div class="divider"></div>

    <div class="text-center">
        <p>Thank you for choosing Sunrise Dental!</p>
        <p>*** Wish you a healthy smile ***</p>
    </div>
</div>

<div class="action-bar no-print" style="margin-top: 15px;">
    <a href="${pageContext.request.contextPath}/dashboard" class="btn-action btn-back">Return to Dashboard</a>
</div>

</body>
</html>