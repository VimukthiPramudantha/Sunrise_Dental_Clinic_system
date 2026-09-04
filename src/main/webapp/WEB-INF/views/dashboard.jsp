<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sunrise Dental - Staff Dashboard</title>
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
            --danger: #ef4444;
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
        }

        .brand-icon {
            color: var(--secondary);
            font-size: 1.75rem;
        }

        .user-controls {
            display: flex;
            align-items: center;
            gap: 1.5rem;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .role-badge {
            background-color: #e0f2fe;
            color: var(--primary-hover);
            padding: 0.25rem 0.75rem;
            border-radius: 999px;
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .logout-btn {
            background-color: transparent;
            color: var(--text-muted);
            border: 1px solid var(--border);
            padding: 0.5rem 1rem;
            border-radius: 8px;
            text-decoration: none;
            font-size: 0.9rem;
            font-weight: 500;
            transition: all 0.2s ease;
        }

        .logout-btn:hover {
            background-color: #fef2f2;
            color: var(--danger);
            border-color: #fecaca;
        }

        /* Main Container */
        .dashboard-container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 2rem;
        }

        /* Hero Section */
        .hero-banner {
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
            border-radius: 20px;
            padding: 2.5rem;
            color: white;
            margin-bottom: 2.5rem;
            position: relative;
            overflow: hidden;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1);
        }

        .hero-banner::after {
            content: '';
            position: absolute;
            top: -50%;
            right: -10%;
            width: 400px;
            height: 400px;
            background: radial-gradient(circle, rgba(2,132,199,0.4) 0%, transparent 70%);
            border-radius: 50%;
        }

        .hero-title {
            font-size: 2.25rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            position: relative;
            z-index: 10;
        }

        .hero-subtitle {
            font-size: 1.1rem;
            color: #94a3b8;
            position: relative;
            z-index: 10;
        }

        /* Quick Stats */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-bottom: 3rem;
        }

        .stat-card {
            background: var(--surface);
            padding: 1.5rem;
            border-radius: 16px;
            border: 1px solid var(--border);
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.02);
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .stat-label {
            font-size: 0.9rem;
            font-weight: 500;
            color: var(--text-muted);
        }

        .stat-value {
            font-size: 2rem;
            font-weight: 700;
            color: var(--primary);
        }

        /* Modules Grid */
        .section-header {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            color: var(--text-main);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .modules-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 1.5rem;
        }

        .module-card {
            background: var(--surface);
            border-radius: 16px;
            padding: 1.75rem;
            text-decoration: none;
            border: 1px solid var(--border);
            transition: all 0.3s ease;
            display: flex;
            flex-direction: column;
            height: 100%;
        }

        .module-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 20px -8px rgba(0, 0, 0, 0.08);
            border-color: var(--primary);
        }

        .module-icon {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            background-color: #f0f9ff;
            color: var(--primary);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1.25rem;
            font-size: 1.5rem;
        }

        .module-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--text-main);
            margin-bottom: 0.5rem;
        }

        .module-desc {
            font-size: 0.95rem;
            color: var(--text-muted);
            line-height: 1.5;
            flex-grow: 1;
            margin-bottom: 1.5rem;
        }

        .module-action {
            font-size: 0.9rem;
            font-weight: 600;
            color: var(--primary);
            display: flex;
            align-items: center;
            gap: 0.25rem;
        }

        /* Specific card colors */
        .card-purple:hover { border-color: #8b5cf6; }
        .card-purple .module-icon { background-color: #f5f3ff; color: #8b5cf6; }
        .card-purple .module-action { color: #8b5cf6; }

        .card-teal:hover { border-color: #14b8a6; }
        .card-teal .module-icon { background-color: #f0fdfa; color: #14b8a6; }
        .card-teal .module-action { color: #14b8a6; }
    </style>
</head>
<body>

<c:choose>
    <c:when test="${not empty sessionScope.user}">
        <nav class="navbar">
            <div class="brand">
                <span class="brand-icon">✦</span>
                Sunrise Dental
            </div>
            <div class="user-controls">
                <div class="user-info">
                    <span style="font-weight: 500;"><c:out value="${sessionScope.user}"/></span>
                    <span class="role-badge"><c:out value="${sessionScope.userRole}"/></span>
                </div>
                <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Log out</a>
            </div>
        </nav>

        <main class="dashboard-container">
            <div class="hero-banner">
                <h2 class="hero-title">Welcome back, <c:out value="${sessionScope.user}"/>!</h2>
                <p class="hero-subtitle">Here is what's happening at the clinic today.</p>
            </div>

            <c:if test="${not empty stats}">
                <div class="stats-grid">
                    <c:if test="${sessionScope.userRole eq 'ADMIN' or sessionScope.userRole eq 'RECEPTIONIST'}">
                        <div class="stat-card">
                            <span class="stat-label">Today's Appointments</span>
                            <span class="stat-value"><c:out value="${stats.todayAppointments != null ? stats.todayAppointments : 0}"/></span>
                        </div>
                        <div class="stat-card">
                            <span class="stat-label">Total Registered Patients</span>
                            <span class="stat-value"><c:out value="${stats.totalPatients != null ? stats.totalPatients : 0}"/></span>
                        </div>
                    </c:if>
                    
                    <c:if test="${sessionScope.userRole eq 'ADMIN'}">
                        <div class="stat-card">
                            <span class="stat-label">Total Staff Members</span>
                            <span class="stat-value"><c:out value="${stats.totalUsers != null ? stats.totalUsers : 0}"/></span>
                        </div>
                    </c:if>

                    <c:if test="${sessionScope.userRole eq 'DENTIST'}">
                        <div class="stat-card">
                            <span class="stat-label">My Appointments Today</span>
                            <span class="stat-value"><c:out value="${stats.myTodayAppointments != null ? stats.myTodayAppointments : 0}"/></span>
                        </div>
                        <div class="stat-card">
                            <span class="stat-label">My Total Appointments</span>
                            <span class="stat-value"><c:out value="${stats.myTotalAppointments != null ? stats.myTotalAppointments : 0}"/></span>
                        </div>
                    </c:if>
                </div>
            </c:if>

            <h3 class="section-header">Clinic Modules</h3>
            <div class="modules-grid">
                
                <c:if test="${sessionScope.userRole eq 'ADMIN' or sessionScope.userRole eq 'RECEPTIONIST'}">
                    <a href="${pageContext.request.contextPath}/appointments/new" class="module-card">
                        <div class="module-icon">📅</div>
                        <h4 class="module-title">Register Appointment</h4>
                        <p class="module-desc">Schedule new visits, register patient details, and assign treatment slots.</p>
                        <div class="module-action">Open Module &rarr;</div>
                    </a>
                </c:if>

                <a href="${pageContext.request.contextPath}/appointments/search" class="module-card">
                    <div class="module-icon">🔍</div>
                    <h4 class="module-title">Search Appointments</h4>
                    <p class="module-desc">Lookup complete patient medical records and visit history by Appointment ID.</p>
                    <div class="module-action">Open Module &rarr;</div>
                </a>

                <c:if test="${sessionScope.userRole eq 'ADMIN' or sessionScope.userRole eq 'RECEPTIONIST'}">
                    <a href="${pageContext.request.contextPath}/billing" class="module-card">
                        <div class="module-icon">💳</div>
                        <h4 class="module-title">Billing & Invoices</h4>
                        <p class="module-desc">Calculate treatment costs, process consultation fees, and issue printed receipts.</p>
                        <div class="module-action">Open Module &rarr;</div>
                    </a>
                </c:if>

                <c:if test="${sessionScope.userRole eq 'ADMIN'}">
                    <a href="${pageContext.request.contextPath}/admin-register" class="module-card card-purple">
                        <div class="module-icon">👥</div>
                        <h4 class="module-title">Staff Registration</h4>
                        <p class="module-desc">Create new clinic staff accounts and assign system roles and permissions.</p>
                        <div class="module-action">Manage Staff &rarr;</div>
                    </a>
                </c:if>

                <a href="${pageContext.request.contextPath}/help" class="module-card card-teal">
                    <div class="module-icon">📘</div>
                    <h4 class="module-title">Help & Manual</h4>
                    <p class="module-desc">Access step-by-step instructions and user guidelines for clinic staff onboarding.</p>
                    <div class="module-action">View Docs &rarr;</div>
                </a>

            </div>
        </main>
    </c:when>
    <c:otherwise>
        <c:redirect url="/login"/>
    </c:otherwise>
</c:choose>

</body>
</html>