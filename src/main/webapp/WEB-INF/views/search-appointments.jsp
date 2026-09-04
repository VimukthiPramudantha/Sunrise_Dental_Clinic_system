<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search & Manage Appointments - Sunrise Dental</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
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
            --bg-input: #f1f5f9;
            --danger: #ef4444;
            --success: #10b981;
            --warning: #f59e0b;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Outfit', sans-serif;
        }

        body {
            background-color: var(--bg-body);
            color: var(--text-main);
            min-height: 100vh;
        }

        /* Navbar */
        .navbar {
            background-color: var(--surface);
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid var(--border);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--text-main);
            text-decoration: none;
        }

        .brand-icon {
            color: var(--secondary);
            font-size: 1.75rem;
        }
        
        .btn-back {
            color: var(--text-muted);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-weight: 500;
            transition: color 0.2s;
        }
        
        .btn-back:hover {
            color: var(--primary);
        }

        /* Container */
        .main-container {
            max-width: 1200px;
            margin: 3rem auto;
            padding: 0 2rem;
        }
        
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            margin-bottom: 2rem;
        }
        
        .page-title {
            font-size: 2rem;
            font-weight: 700;
            color: var(--text-main);
            margin-bottom: 0.5rem;
        }
        
        .page-subtitle {
            color: var(--text-muted);
            font-size: 1.05rem;
        }

        /* Search Box */
        .search-card {
            background: var(--surface);
            border-radius: 16px;
            padding: 1.5rem;
            border: 1px solid var(--border);
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.02);
            margin-bottom: 2rem;
        }

        .search-form {
            display: flex;
            gap: 1rem;
            width: 100%;
        }

        .search-input-wrapper {
            flex-grow: 1;
            position: relative;
        }

        .search-icon {
            position: absolute;
            left: 1.25rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-muted);
            width: 20px;
            height: 20px;
        }

        .form-control {
            width: 100%;
            padding: 0.875rem 1.25rem 0.875rem 3rem;
            font-size: 1rem;
            color: var(--text-main);
            background-color: var(--bg-input);
            border: 1px solid transparent;
            border-radius: 10px;
            transition: all 0.2s ease;
            outline: none;
        }

        .form-control:focus {
            background-color: #ffffff;
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(2, 132, 199, 0.1);
        }

        .btn-search {
            padding: 0 2rem;
            background-color: var(--text-main);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .btn-search:hover {
            background-color: var(--primary);
        }

        /* Table Design */
        .table-container {
            background: var(--surface);
            border-radius: 16px;
            border: 1px solid var(--border);
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.02);
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
        }

        th, td {
            padding: 1.25rem 1.5rem;
        }

        th {
            background-color: #f8fafc;
            color: var(--text-muted);
            font-weight: 600;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 1px solid var(--border);
        }
        
        th:first-child { border-top-left-radius: 16px; }
        th:last-child { border-top-right-radius: 16px; }

        td {
            border-bottom: 1px solid var(--border);
            font-size: 0.95rem;
            color: var(--text-main);
            vertical-align: middle;
        }

        tr:last-child td {
            border-bottom: none;
        }

        tr:hover td {
            background-color: #f8fafc;
        }

        /* Pills and Badges */
        .appt-no {
            font-weight: 600;
            color: var(--primary);
            background-color: #e0f2fe;
            padding: 0.35rem 0.75rem;
            border-radius: 6px;
            font-size: 0.85rem;
            display: inline-block;
        }
        
        .dentist-name {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .avatar-sm {
            width: 28px;
            height: 28px;
            background: #e2e8f0;
            color: #475569;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.75rem;
            font-weight: 700;
        }

        /* Actions */
        .action-group {
            display: flex;
            gap: 0.5rem;
            align-items: center;
        }

        .btn-action {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 0.4rem 0.75rem;
            border-radius: 6px;
            text-decoration: none;
            font-size: 0.85rem;
            font-weight: 600;
            transition: all 0.2s;
        }

        .btn-edit {
            background-color: #f1f5f9;
            color: var(--primary);
            border: 1px solid transparent;
        }

        .btn-edit:hover {
            background-color: #e0f2fe;
            border-color: #bae6fd;
        }

        .btn-delete {
            background-color: #fef2f2;
            color: var(--danger);
            border: 1px solid transparent;
        }

        .btn-delete:hover {
            background-color: #fee2e2;
            border-color: #fecaca;
        }

        /* Alerts */
        .alert {
            padding: 1rem 1.25rem;
            border-radius: 10px;
            margin-bottom: 2rem;
            font-size: 0.95rem;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .alert-success {
            background-color: #f0fdf4;
            color: #15803d;
            border: 1px solid #bbf7d0;
        }
        
        .empty-state {
            padding: 4rem 2rem;
            text-align: center;
            color: var(--text-muted);
        }
        
        .empty-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
            opacity: 0.5;
        }
    </style>
</head>
<body>

    <nav class="navbar">
        <a href="${pageContext.request.contextPath}/dashboard" class="brand">
            <span class="brand-icon">✦</span>
            Sunrise Dental
        </a>
        <a href="${pageContext.request.contextPath}/dashboard" class="btn-back">
            &larr; Back to Dashboard
        </a>
    </nav>

    <div class="main-container">
        
        <div class="page-header">
            <div>
                <h1 class="page-title">Search & Manage Appointments</h1>
                <p class="page-subtitle">View and manage all patient schedules across the clinic.</p>
            </div>
            
            <c:if test="${sessionScope.userRole eq 'ADMIN' or sessionScope.userRole eq 'RECEPTIONIST'}">
                <a href="${pageContext.request.contextPath}/appointments/new" style="background: var(--primary); color: white; padding: 0.75rem 1.25rem; border-radius: 8px; text-decoration: none; font-weight: 600; display: inline-flex; align-items: center; gap: 0.5rem; transition: background 0.2s;">
                    <svg width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path></svg>
                    New Booking
                </a>
            </c:if>
        </div>

        <c:if test="${param.success != null}">
            <div class="alert alert-success">
                <svg width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path></svg>
                <c:out value="${param.success}"/>
            </div>
        </c:if>

        <div class="search-card">
            <form action="${pageContext.request.contextPath}/appointments/search" method="GET" class="search-form">
                <div class="search-input-wrapper">
                    <svg class="search-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path></svg>
                    <input type="text" name="query" value="<c:out value='${query}'/>" class="form-control" placeholder="Search by Appt No, Patient Name, Phone, or Dentist..." autocomplete="off">
                </div>
                <button type="submit" class="btn-search">Search Records</button>
            </form>
        </div>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Appt. No</th>
                        <th>Patient Info</th>
                        <th>Dentist</th>
                        <th>Treatment</th>
                        <th>Date & Time</th>
                        <th style="text-align: right;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="a" items="${appointments}">
                        <tr>
                            <td>
                                <span class="appt-no"><c:out value="${a.appointmentNo}"/></span>
                            </td>
                            <td>
                                <div style="font-weight: 600; color: var(--text-main);"><c:out value="${a.patientName}"/></div>
                                <div style="font-size: 0.85rem; color: var(--text-muted);"><c:out value="${a.patientPhone}"/></div>
                            </td>
                            <td>
                                <div class="dentist-name">
                                    <div class="avatar-sm">Dr</div>
                                    <c:out value="${a.dentistName}"/>
                                </div>
                            </td>
                            <td>
                                <span style="background: #f1f5f9; padding: 0.25rem 0.6rem; border-radius: 4px; font-size: 0.85rem; border: 1px solid #e2e8f0;">
                                    <c:out value="${a.treatmentType}"/>
                                </span>
                            </td>
                            <td>
                                <div style="font-weight: 500;"><c:out value="${a.appointmentDate}"/></div>
                                <div style="font-size: 0.85rem; color: var(--text-muted);"><c:out value="${a.timeSlot}"/></div>
                            </td>
                            <td>
                                <div class="action-group" style="justify-content: flex-end;">
                                    <a href="${pageContext.request.contextPath}/appointments/edit?id=${a.id}" class="btn-action btn-edit">Edit</a>
                                    <c:if test="${sessionScope.userRole eq 'ADMIN'}">
                                        <a href="${pageContext.request.contextPath}/appointments/delete?id=${a.id}"
                                           class="btn-action btn-delete"
                                           onclick="return confirm('Are you sure you want to delete this appointment? This action cannot be undone.');">Delete</a>
                                    </c:if>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty appointments}">
                        <tr>
                            <td colspan="6">
                                <div class="empty-state">
                                    <div class="empty-icon">📭</div>
                                    <h3 style="color: var(--text-main); font-weight: 600; margin-bottom: 0.5rem;">No appointments found</h3>
                                    <p>No records matched your search criteria. Try using different keywords.</p>
                                </div>
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>

    </div>

</body>
</html>