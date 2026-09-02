<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<<<<<<< HEAD
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
=======
    <title>Sunrise Dental - Staff Dashboard</title>
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
            border-bottom: 3px solid var(--primary-color, #0077b6);
        }

        .navbar .brand {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .navbar h1 {
            margin: 0;
            font-size: 1.4rem;
            color: var(--primary-color, #0077b6);
        }

        .navbar .user-badge {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .role-pill {
            background-color: #e0f2fe;
            color: #0369a1;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            text-transform: uppercase;
        }

        .btn-logout-alt {
            background-color: #d90429;
            color: #ffffff;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.9rem;
            transition: background-color 0.2s;
        }

        .btn-logout-alt:hover {
            background-color: #b8001f;
        }

        .dashboard-container {
            max-width: 1100px;
            margin: 2.5rem auto;
            padding: 0 1.5rem;
        }

        .welcome-hero {
            background: linear-gradient(135deg, #0077b6 0%, #023e8a 100%);
            color: #ffffff;
            padding: 2rem;
            border-radius: 12px;
            margin-bottom: 2rem;
            box-shadow: 0 4px 15px rgba(0, 119, 182, 0.2);
        }

        .welcome-hero h2 {
            margin: 0 0 0.5rem 0;
            font-size: 1.8rem;
        }

        .welcome-hero p {
            margin: 0;
            opacity: 0.9;
            font-size: 1rem;
        }

        .section-title {
            font-size: 1.2rem;
            font-weight: 700;
            margin-bottom: 1rem;
            color: #495057;
        }

        .grid-menu {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            gap: 1.5rem;
        }

        .card-menu {
            background: #ffffff;
            border-radius: 10px;
            padding: 1.5rem;
            text-decoration: none;
            color: inherit;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.04);
            border: 1px solid #e9ecef;
            border-top: 4px solid var(--primary-color, #0077b6);
            transition: transform 0.2s, box-shadow 0.2s;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .card-menu:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
        }

        .card-menu h3 {
            margin: 0 0 0.5rem 0;
            font-size: 1.2rem;
            color: var(--primary-color, #0077b6);
        }

        .card-menu p {
            margin: 0;
            font-size: 0.9rem;
            color: #6c757d;
            line-height: 1.4;
        }

        .card-footer {
            margin-top: 1.5rem;
            font-size: 0.85rem;
            font-weight: 700;
            color: var(--primary-color, #0077b6);
            display: flex;
            align-items: center;
            gap: 0.25rem;
>>>>>>> 599ed04e5f73942cf7e5131b795bc5c74c7884e8
        }
    </style>
</head>
<body>

<<<<<<< HEAD
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
=======
<c:choose>
    <c:when test="${not empty sessionScope.user}">
        <%-- Top Navigation Bar --%>
        <header class="navbar">
            <div class="brand">
                <h1>Sunrise Dental Clinic</h1>
            </div>
            <div class="user-badge">
                <span>User: <strong><c:out value="${sessionScope.user}"/></strong></span>
                <span class="role-pill"><c:out value="${sessionScope.userRole}"/></span>
                <a href="${pageContext.request.contextPath}/logout" class="btn-logout-alt">Logout</a>
            </div>
        </header>

        <%-- Main Dashboard Content --%>
        <main class="dashboard-container">
            <div class="welcome-hero">
                <h2>Welcome Back, <c:out value="${sessionScope.user}"/>!</h2>
                <p>Role Authorized Portal — Select a module below to begin operations.</p>
            </div>

            <div class="section-title">System Modules</div>

            <div class="grid-menu">
                <%-- Visible to ADMIN & RECEPTIONIST --%>
                <c:if test="${sessionScope.userRole eq 'ADMIN' or sessionScope.userRole eq 'RECEPTIONIST'}">
                    <a href="${pageContext.request.contextPath}/appointments/new" class="card-menu">
                        <div>
                            <h3>Register Appointment</h3>
                            <p>Schedule new visits, register patient details, and assign treatment slots.</p>
                        </div>
                        <div class="card-footer">Open Module &rarr;</div>
                    </a>
                </c:if>

                <%-- Visible to ALL Roles (ADMIN, RECEPTIONIST, DENTIST) --%>
                <a href="${pageContext.request.contextPath}/appointments/search" class="card-menu">
                    <div>
                        <h3>Search Appointments</h3>
                        <p>Lookup complete patient medical records and visit history by Appointment ID.</p>
                    </div>
                    <div class="card-footer">Open Module &rarr;</div>
                </a>

                <%-- Visible to ADMIN & RECEPTIONIST --%>
                <c:if test="${sessionScope.userRole eq 'ADMIN' or sessionScope.userRole eq 'RECEPTIONIST'}">
                    <a href="${pageContext.request.contextPath}/billing" class="card-menu">
                        <div>
                            <h3>Billing & Invoices</h3>
                            <p>Calculate treatment costs, process consultation fees, and issue printed receipts.</p>
                        </div>
                        <div class="card-footer">Open Module &rarr;</div>
                    </a>
                </c:if>

                <%-- Visible to ADMIN ONLY --%>
                <c:if test="${sessionScope.userRole eq 'ADMIN'}">
                    <a href="${pageContext.request.contextPath}/register" class="card-menu" style="border-top-color: #7209b7;">
                        <div>
                            <h3 style="color: #7209b7;">Staff Registration</h3>
                            <p>Create new clinic staff accounts and assign system roles and permissions.</p>
                        </div>
                        <div class="card-footer" style="color: #7209b7;">Manage Staff &rarr;</div>
                    </a>
                </c:if>

                <%-- Visible to ALL Roles --%>
                <a href="${pageContext.request.contextPath}/help" class="card-menu" style="border-top-color: #2a9d8f;">
                    <div>
                        <h3 style="color: #2a9d8f;">Help & Manual</h3>
                        <p>Access step-by-step instructions and user guidelines for clinic staff onboarding.</p>
                    </div>
                    <div class="card-footer" style="color: #2a9d8f;">View Documentation &rarr;</div>
                </a>
            </div>
        </main>
    </c:when>
    <c:otherwise>
        <%-- Redirect unauthorized direct access to login --%>
        <c:redirect url="/login"/>
    </c:otherwise>
</c:choose>
>>>>>>> 599ed04e5f73942cf7e5131b795bc5c74c7884e8

</body>
</html>