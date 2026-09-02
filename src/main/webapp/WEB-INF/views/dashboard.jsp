<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sunrise Dental Clinic - Staff Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .dashboard-container {
            max-width: 1000px;
            margin: 2rem auto;
            padding: 0 1rem;
        }
        .header-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #ffffff;
            padding: 1.5rem 2rem;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            margin-bottom: 2rem;
        }
        .header-bar h2 {
            margin: 0;
            color: var(--primary-color);
        }
        .user-info {
            display: flex;
            align-items: center;
            gap: 1.5rem;
        }
        .btn-logout {
            background-color: var(--error-color);
            color: white;
            padding: 0.5rem 1.2rem;
            border-radius: 6px;
            text-decoration: none;
            font-weight: bold;
            font-size: 0.9rem;
        }
        .grid-menu {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 1.5rem;
        }
        .card-menu {
            background: #ffffff;
            padding: 1.8rem;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            transition: transform 0.2s, box-shadow 0.2s;
            text-decoration: none;
            color: var(--text-color);
            border-left: 5px solid var(--primary-color);
        }
        .card-menu:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }
        .card-menu h3 {
            margin-top: 0;
            color: var(--primary-color);
        }
        .card-menu p {
            color: #6c757d;
            font-size: 0.9rem;
            margin-bottom: 0;
        }
    </style>
</head>
<body>

<div class="dashboard-container">
    <div class="header-bar">
        <div>
            <h2>Sunrise Dental Clinic</h2>
            <p style="margin: 0.2rem 0 0 0; color: #6c757d;">Patient & Appointment Management Portal</p>
        </div>
        <div class="user-info">
            <span>Logged in as: <strong><c:out value="${sessionScope.user}"/></strong></span>
            <a href="${pageContext.request.contextPath}/logout" class="btn-logout">Logout</a>
        </div>
    </div>

    <div class="grid-menu">
        <a href="${pageContext.request.contextPath}/appointments/new" class="card-menu">
            <h3>Register Appointment</h3>
            <p>Book a new appointment for existing or new clinic patients.</p>
        </a>

        <a href="${pageContext.request.contextPath}/appointments/search" class="card-menu">
            <h3>Search Appointments</h3>
            <p>Lookup complete patient history and scheduled appointments.</p>
        </a>

        <a href="${pageContext.request.contextPath}/billing" class="card-menu">
            <h3>Billing & Invoices</h3>
            <p>Calculate treatment costs and print patient receipts.</p>
        </a>

        <a href="${pageContext.request.contextPath}/help" class="card-menu">
            <h3>Staff Help Guide</h3>
            <p>Step-by-step operational manual for clinic staff.</p>
        </a>
    </div>
</div>

</body>
</html>