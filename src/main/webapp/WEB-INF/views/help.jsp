<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Help & Operational Manual - Sunrise Dental</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        body {
            background-color: #f4f7f6;
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #2b2d42;
        }

        .navbar {
            background-color: #ffffff;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            border-bottom: 3px solid #2a9d8f;
        }

        .navbar h1 {
            margin: 0;
            font-size: 1.4rem;
            color: #2a9d8f;
        }

        .container {
            max-width: 1000px;
            margin: 2.5rem auto;
            padding: 0 1.5rem;
        }

        .header-card {
            background: linear-gradient(135deg, #2a9d8f 0%, #264653 100%);
            color: #ffffff;
            padding: 2rem;
            border-radius: 12px;
            margin-bottom: 2rem;
            box-shadow: 0 4px 15px rgba(42, 157, 143, 0.2);
        }

        .header-card h2 {
            margin: 0 0 0.5rem 0;
            font-size: 1.8rem;
        }

        .section-card {
            background: #ffffff;
            padding: 1.8rem;
            border-radius: 10px;
            margin-bottom: 1.5rem;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.04);
            border: 1px solid #e9ecef;
        }

        .section-card h3 {
            margin-top: 0;
            color: #2a9d8f;
            border-bottom: 2px solid #e9ecef;
            padding-bottom: 0.5rem;
        }

        .role-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
        }

        .role-table th, .role-table td {
            padding: 0.75rem;
            text-align: left;
            border-bottom: 1px solid #e9ecef;
        }

        .role-table th {
            background-color: #f8f9fa;
            color: #495057;
        }

        .step-list {
            padding-left: 1.2rem;
            line-height: 1.6;
        }

        .step-list li {
            margin-bottom: 0.5rem;
        }

        .btn-back {
            display: inline-block;
            margin-top: 1rem;
            color: #2a9d8f;
            text-decoration: none;
            font-weight: bold;
        }
    </style>
</head>
<body>

<header class="navbar">
    <h1>Sunrise Dental Clinic</h1>
    <div>
        <span>User: <strong><c:out value="${sessionScope.user}"/></strong></span> |
        <a href="${pageContext.request.contextPath}/logout" style="color: #d90429; font-weight: bold; text-decoration: none; margin-left: 0.5rem;">Logout</a>
    </div>
</header>

<div class="container">
    <div class="header-card">
        <h2>Staff Help & Operational Manual</h2>
        <p>Comprehensive guidelines for clinic workflows, role permissions, and system features.</p>
    </div>

    <!-- Section 1: Role Permissions Matrix -->
    <div class="section-card">
        <h3>1. Role & Access Matrix</h3>
        <p>Access controls are enforced automatically based on assigned user credentials:</p>
        <table class="role-table">
            <thead>
                <tr>
                    <th>Role</th>
                    <th>Module Access</th>
                    <th>Key Responsibilities</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><strong>ADMIN</strong></td>
                    <td>Full System Access</td>
                    <td>Staff registration, appointment management, billing processing, and record deletion.</td>
                </tr>
                <tr>
                    <td><strong>RECEPTIONIST</strong></td>
                    <td>Appointments & Billing</td>
                    <td>Patient intake, appointment booking, invoice calculation, receipt printing, and emailing.</td>
                </tr>
                <tr>
                    <td><strong>DENTIST</strong></td>
                    <td>Search & Lookup</td>
                    <td>View patient appointment histories, consultation details, and daily schedules.</td>
                </tr>
            </tbody>
        </table>
    </div>

    <!-- Section 2: Module Workflows -->
    <div class="section-card">
        <h3>2. Step-by-Step Operations</h3>

        <h4>A. Appointment Booking</h4>
        <ol class="step-list">
            <li>Navigate to <strong>Register Appointment</strong> from the main dashboard.</li>
            <li>Fill in patient details (Full Name, Address, Contact Phone).</li>
            <li>Select attending dentist, treatment type, date, and preferred time slot.</li>
            <li>Submit the form to record the entry and auto-generate an Appointment ID (`APP-XXXXX`).</li>
        </ol>

        <h4>B. Billing & Receipt Generation</h4>
        <ol class="step-list">
            <li>Select <strong>Billing & Invoices</strong> from the dashboard menu.</li>
            <li>Search and select the target appointment from the lookup table.</li>
            <li>Verify consultation fee and treatment costs. Input any additional medicine or material charges.</li>
            <li>Click <strong>Generate & Print Receipt</strong> to issue an invoice (`INV-XXXXX`).</li>
            <li>Use <strong>Download PDF</strong> to save locally or <strong>Send Email</strong> to dispatch an HTML invoice to the patient's inbox.</li>
        </ol>

        <h4>C. Staff Account Provisioning (Admin Only)</h4>
        <ol class="step-list">
            <li>Navigate to <strong>Staff Registration</strong> (`/admin-register`).</li>
            <li>Enter full name, username, and a secure password (minimum 6 characters).</li>
            <li>Select appropriate access role (`ADMIN`, `RECEPTIONIST`, `DENTIST`) and create the account.</li>
        </ol>
    </div>

    <!-- Section 3: Technical Support -->
    <div class="section-card">
        <h3>3. Support & Troubleshooting</h3>
        <p>If you encounter system errors or require database access configuration:</p>
        <ul>
            <li><strong>Database Schema:</strong> Connected to MySQL database `sunrise_dental`.</li>
            <li><strong>SMTP Dispatch:</strong> Invoice emails require active internet connectivity to communicate with Google SMTP (`smtp.gmail.com:587`).</li>
        </ul>
    </div>

    <a href="${pageContext.request.contextPath}/dashboard" class="btn-back">&larr; Return to Dashboard</a>
</div>

</body>
</html>