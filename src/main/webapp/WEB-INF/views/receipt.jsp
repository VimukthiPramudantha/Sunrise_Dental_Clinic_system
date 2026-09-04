<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Receipt - ${bill.invoiceNo}</title>
    <!-- Include html2pdf library for instant PDF generation -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&family=Space+Mono:wght@400;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #0284c7;
            --primary-hover: #0369a1;
            --secondary: #38bdf8;
            --bg-body: #f8fafc;
            --surface: #ffffff;
            --text-main: #0f172a;
            --text-muted: #64748b;
            --border: #e2e8f0;
            --success: #10b981;
        }

        body { 
            font-family: 'Outfit', sans-serif; 
            background: var(--bg-body); 
            margin: 0; 
            padding: 40px 20px; 
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        /* Action Bar */
        .action-bar { 
            width: 100%;
            max-width: 500px; 
            margin-bottom: 20px; 
            display: flex; 
            flex-direction: column; 
            gap: 15px; 
        }

        .btn-group { 
            display: flex; 
            gap: 12px; 
        }

        .btn-action { 
            flex: 1; 
            padding: 0.875rem; 
            border: none; 
            border-radius: 10px; 
            font-weight: 600; 
            cursor: pointer; 
            text-align: center; 
            text-decoration: none; 
            font-size: 0.95rem; 
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            font-family: 'Outfit', sans-serif;
        }

        .btn-pdf { 
            background-color: var(--text-main); 
            color: #fff; 
        }
        .btn-pdf:hover { background-color: #000; transform: translateY(-2px); box-shadow: 0 4px 12px rgba(0,0,0,0.1); }

        .btn-email { 
            background-color: #f1f5f9; 
            color: var(--primary); 
            border: 1px solid var(--border);
        }
        .btn-email:hover { background-color: #e0f2fe; border-color: #bae6fd; transform: translateY(-2px); box-shadow: 0 4px 12px rgba(0,0,0,0.05); }

        .btn-back { 
            background-color: transparent; 
            color: var(--text-muted); 
            border: 1px solid var(--border);
        }
        .btn-back:hover { background-color: #f1f5f9; color: var(--text-main); }

        /* Email Form */
        .email-form-container {
            background: var(--surface); 
            padding: 20px; 
            border-radius: 12px; 
            border: 1px solid var(--border);
            box-shadow: 0 4px 15px rgba(0,0,0,0.03);
            display: none;
            animation: slideDown 0.3s ease-out;
        }

        @keyframes slideDown {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .email-form { 
            display: flex; 
            gap: 10px; 
        }

        .email-input { 
            flex: 1; 
            padding: 0.75rem 1rem; 
            border: 1px solid var(--border); 
            border-radius: 8px; 
            font-family: 'Outfit', sans-serif;
            outline: none;
            transition: border-color 0.2s;
        }
        .email-input:focus { border-color: var(--primary); box-shadow: 0 0 0 3px rgba(2, 132, 199, 0.1); }

        .email-btn { 
            padding: 0.75rem 1.25rem; 
            background: var(--primary); 
            color: white; 
            border: none; 
            border-radius: 8px; 
            cursor: pointer; 
            font-weight: 600; 
            font-family: 'Outfit', sans-serif;
            transition: background 0.2s;
        }
        .email-btn:hover { background: var(--primary-hover); }

        .alert-success {
            background-color: #f0fdf4; 
            color: #15803d; 
            padding: 12px; 
            border-radius: 8px; 
            text-align: center;
            border: 1px solid #bbf7d0;
            font-weight: 500;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        /* Receipt Card */
        .receipt-card { 
            width: 100%;
            max-width: 500px; 
            background: #fff; 
            padding: 40px 40px 30px; 
            border-radius: 16px; 
            box-shadow: 0 10px 30px rgba(0,0,0,0.08), 0 1px 3px rgba(0,0,0,0.04); 
            position: relative;
            overflow: hidden;
        }

        /* Receipt decorative top edge */
        .receipt-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 6px;
            background: linear-gradient(90deg, var(--primary) 0%, var(--secondary) 100%);
        }

        .clinic-header { 
            text-align: center; 
            margin-bottom: 25px;
        }
        
        .clinic-logo {
            font-size: 2.5rem;
            color: var(--primary);
            margin-bottom: 5px;
        }

        .clinic-name {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--text-main);
            letter-spacing: -0.5px;
            margin: 0 0 5px 0;
        }

        .clinic-address {
            font-size: 0.9rem;
            color: var(--text-muted);
            line-height: 1.5;
            margin: 0;
        }

        .divider { 
            border-top: 1px dashed #cbd5e1; 
            margin: 20px 0; 
        }

        /* Receipt Details (Mono Font for data) */
        .receipt-meta {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
            margin-bottom: 25px;
        }

        .meta-item {
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

        .meta-label {
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            color: var(--text-muted);
            letter-spacing: 0.5px;
        }

        .meta-value {
            font-size: 0.95rem;
            font-weight: 500;
            color: var(--text-main);
        }
        
        .meta-value-mono {
            font-family: 'Space Mono', monospace;
            font-size: 0.9rem;
        }

        /* Items Table */
        .receipt-table { 
            width: 100%; 
            text-align: left; 
            border-collapse: collapse; 
        }

        .receipt-table th {
            padding: 8px 0;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            color: var(--text-muted);
            border-bottom: 1px solid #e2e8f0;
        }

        .receipt-table td { 
            padding: 12px 0; 
            color: var(--text-main);
            font-weight: 500;
            border-bottom: 1px dashed #f1f5f9;
        }
        
        .receipt-table tr:last-child td { border-bottom: none; }

        .amt-col {
            text-align: right;
            font-family: 'Space Mono', monospace;
        }

        /* Total Section */
        .total-section {
            background: #f8fafc;
            border-radius: 8px;
            padding: 15px 20px;
            margin-top: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .total-label { 
            font-weight: 700; 
            font-size: 1.1rem; 
            color: var(--text-main);
        }

        .total-amt {
            font-weight: 700; 
            font-size: 1.4rem; 
            color: var(--primary);
            font-family: 'Space Mono', monospace;
        }

        .footer-note { 
            text-align: center; 
            margin-top: 30px;
            color: var(--text-muted);
            font-size: 0.85rem;
        }

        .footer-note p { margin: 4px 0; }
        .heart { color: #ef4444; }

    </style>
    <script>
        function downloadPDF() {
            const element = document.getElementById('receipt-content');
            // Hide box shadow for clean PDF print
            element.style.boxShadow = 'none';
            element.style.border = '1px solid #e2e8f0';
            
            const opt = {
                margin:       10,
                filename:     'Sunrise_Dental_Receipt_${bill.invoiceNo}.pdf',
                image:        { type: 'jpeg', quality: 0.98 },
                html2canvas:  { scale: 2 },
                jsPDF:        { unit: 'mm', format: 'a4', orientation: 'portrait' }
            };
            
            html2pdf().set(opt).from(element).save().then(() => {
                // Restore styles
                element.style.boxShadow = '';
                element.style.border = '';
            });
        }

        function toggleEmailForm() {
            const form = document.getElementById('emailFormContainer');
            form.style.display = form.style.display === 'block' ? 'none' : 'block';
        }
    </script>
</head>
<body>

<%-- Action Bar above Receipt --%>
<div class="action-bar no-print">
    <c:if test="${param.emailSent != null}">
        <div class="alert-success">
            <svg width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path></svg>
            Receipt successfully sent to email!
        </div>
    </c:if>

    <div class="btn-group">
        <button onclick="downloadPDF()" class="btn-action btn-pdf">
            <svg width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4"></path></svg>
            Download PDF
        </button>
        <button onclick="toggleEmailForm()" class="btn-action btn-email">
            <svg width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"></path></svg>
            Send via Email
        </button>
    </div>

    <%-- Hidden Inline Email Form --%>
    <div id="emailFormContainer" class="email-form-container">
        <form action="${pageContext.request.contextPath}/billing/email" method="POST" class="email-form">
            <input type="hidden" name="invoiceNo" value="${bill.invoiceNo}">
            <input type="email" name="email" class="email-input" placeholder="Enter patient email..." required>
            <button type="submit" class="email-btn">Send Receipt</button>
        </form>
    </div>
</div>

<div class="receipt-card" id="receipt-content">
    <div class="clinic-header">
        <div class="clinic-logo">✦</div>
        <h2 class="clinic-name">SUNRISE DENTAL</h2>
        <p class="clinic-address">123 Clinic Road, Colombo, Sri Lanka<br>Tel: +94 11 234 5678</p>
    </div>

    <div class="divider"></div>

    <div class="receipt-meta">
        <div class="meta-item">
            <span class="meta-label">Invoice No</span>
            <span class="meta-value meta-value-mono">#<c:out value="${bill.invoiceNo}"/></span>
        </div>
        <div class="meta-item">
            <span class="meta-label">Date Issued</span>
            <span class="meta-value meta-value-mono"><c:out value="${bill.createdAt}"/></span>
        </div>
        <div class="meta-item">
            <span class="meta-label">Patient Name</span>
            <span class="meta-value"><c:out value="${bill.patientName}"/></span>
        </div>
        <div class="meta-item">
            <span class="meta-label">Attending Dentist</span>
            <span class="meta-value">Dr. <c:out value="${bill.dentistName}"/></span>
        </div>
    </div>

    <table class="receipt-table">
        <thead>
            <tr>
                <th>Description</th>
                <th class="amt-col">Amount</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>Consultation Fee</td>
                <td class="amt-col">LKR <c:out value="${bill.consultationFee}"/></td>
            </tr>
            <tr>
                <td>Treatment Services</td>
                <td class="amt-col">LKR <c:out value="${bill.treatmentCost}"/></td>
            </tr>
            <tr>
                <td>Medicine & Extras</td>
                <td class="amt-col">LKR <c:out value="${bill.medicineCharges}"/></td>
            </tr>
        </tbody>
    </table>

    <div class="total-section">
        <div class="total-label">Total Paid</div>
        <div class="total-amt">LKR <c:out value="${bill.totalAmount}"/></div>
    </div>

    <div class="footer-note">
        <p>Thank you for choosing Sunrise Dental!</p>
        <p>Wish you a healthy smile <span class="heart">❤</span></p>
    </div>
</div>

<div class="action-bar no-print" style="margin-top: 10px;">
    <a href="${pageContext.request.contextPath}/dashboard" class="btn-action btn-back">
        &larr; Return to Dashboard
    </a>
</div>

</body>
</html>