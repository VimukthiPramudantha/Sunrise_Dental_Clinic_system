<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Help & Operational Manual - Sunrise Dental</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #0284c7;
            --secondary: #38bdf8;
            --bg-body: #f8fafc;
            --surface: #ffffff;
            --text-main: #0f172a;
            --text-muted: #64748b;
            --border: #e2e8f0;
            --bg-input: #f1f5f9;
            --admin-color: #7c3aed;
            --receptionist-color: #0284c7;
            --dentist-color: #0d9488;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Outfit', sans-serif; }

        body { background-color: var(--bg-body); color: var(--text-main); min-height: 100vh; }

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

        .brand { display: flex; align-items: center; gap: 0.5rem; font-size: 1.5rem; font-weight: 700; color: var(--text-main); text-decoration: none; }
        .brand-icon { color: var(--secondary); font-size: 1.75rem; }

        .nav-right { display: flex; align-items: center; gap: 1.25rem; }
        .nav-user { font-size: 0.9rem; color: var(--text-muted); }
        .nav-user strong { color: var(--text-main); }

        .btn-back { color: var(--text-muted); text-decoration: none; display: flex; align-items: center; gap: 0.5rem; font-weight: 500; transition: color 0.2s; }
        .btn-back:hover { color: var(--primary); }

        .btn-logout { color: #ef4444; text-decoration: none; font-weight: 600; font-size: 0.9rem; transition: opacity 0.2s; }
        .btn-logout:hover { opacity: 0.7; }

        /* Container */
        .main-container { max-width: 960px; margin: 3rem auto; padding: 0 2rem; }

        /* Hero Banner */
        .hero-banner {
            background: linear-gradient(135deg, var(--text-main) 0%, #1e293b 100%);
            color: white;
            padding: 2.5rem 3rem;
            border-radius: 20px;
            margin-bottom: 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            overflow: hidden;
            position: relative;
        }

        .hero-banner::before {
            content: '';
            position: absolute;
            top: -50px;
            right: -50px;
            width: 250px;
            height: 250px;
            background: rgba(56, 189, 248, 0.1);
            border-radius: 50%;
        }

        .hero-title { font-size: 1.75rem; font-weight: 700; margin-bottom: 0.5rem; }
        .hero-subtitle { color: #94a3b8; font-size: 1rem; }

        .role-badge {
            padding: 0.5rem 1.25rem;
            border-radius: 50px;
            font-weight: 700;
            font-size: 0.9rem;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            white-space: nowrap;
        }
        .badge-admin { background: rgba(124, 58, 237, 0.2); color: #c4b5fd; border: 1px solid rgba(124, 58, 237, 0.4); }
        .badge-receptionist { background: rgba(2, 132, 199, 0.2); color: #7dd3fc; border: 1px solid rgba(2, 132, 199, 0.4); }
        .badge-dentist { background: rgba(13, 148, 136, 0.2); color: #5eead4; border: 1px solid rgba(13, 148, 136, 0.4); }

        /* Tabs */
        .tabs-bar {
            display: flex;
            gap: 0.5rem;
            margin-bottom: 2rem;
            background: var(--surface);
            padding: 0.5rem;
            border-radius: 12px;
            border: 1px solid var(--border);
        }

        .tab-btn {
            flex: 1;
            padding: 0.75rem 1rem;
            border: none;
            border-radius: 8px;
            background: transparent;
            cursor: pointer;
            font-family: 'Outfit', sans-serif;
            font-size: 0.9rem;
            font-weight: 500;
            color: var(--text-muted);
            transition: all 0.2s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .tab-btn:hover { background: var(--bg-input); color: var(--text-main); }
        .tab-btn.active { background: var(--text-main); color: white; font-weight: 600; }

        /* Section Cards */
        .section-card {
            background: var(--surface);
            border-radius: 16px;
            padding: 2rem;
            border: 1px solid var(--border);
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.02);
            margin-bottom: 1.5rem;
            display: none;
        }

        .section-card.active { display: block; }

        .section-card h3 {
            font-size: 1.2rem;
            font-weight: 700;
            color: var(--text-main);
            margin-bottom: 1.25rem;
            display: flex;
            align-items: center;
            gap: 0.6rem;
        }

        .section-card h3 .icon { font-size: 1.4rem; }

        /* Workflow Steps */
        .workflow-block { margin-bottom: 2rem; }
        .workflow-block:last-child { margin-bottom: 0; }

        .workflow-title {
            font-size: 1rem;
            font-weight: 600;
            color: var(--primary);
            margin-bottom: 1rem;
            padding-bottom: 0.5rem;
            border-bottom: 1px dashed var(--border);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .step-list { list-style: none; padding: 0; }

        .step-item {
            display: flex;
            gap: 1rem;
            align-items: flex-start;
            margin-bottom: 0.75rem;
        }

        .step-num {
            min-width: 28px;
            height: 28px;
            background: var(--bg-input);
            color: var(--primary);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.8rem;
            font-weight: 700;
            flex-shrink: 0;
        }

        .step-text { font-size: 0.95rem; color: var(--text-main); line-height: 1.6; padding-top: 2px; }
        .step-text code { background: #f1f5f9; padding: 0.1rem 0.4rem; border-radius: 4px; font-size: 0.85rem; color: var(--primary); font-family: monospace; }

        /* Access Table */
        .access-table { width: 100%; border-collapse: collapse; }
        .access-table th {
            background: var(--bg-input);
            padding: 0.875rem 1rem;
            text-align: left;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: var(--text-muted);
            border-bottom: 1px solid var(--border);
        }
        .access-table td {
            padding: 1rem;
            border-bottom: 1px solid var(--border);
            font-size: 0.92rem;
            vertical-align: middle;
        }
        .access-table tr:last-child td { border-bottom: none; }
        .access-table tr:hover td { background: #f8fafc; }

        .pill {
            display: inline-block;
            padding: 0.3rem 0.75rem;
            border-radius: 50px;
            font-size: 0.8rem;
            font-weight: 700;
        }

        .pill-admin { background: #ede9fe; color: var(--admin-color); }
        .pill-receptionist { background: #e0f2fe; color: var(--receptionist-color); }
        .pill-dentist { background: #ccfbf1; color: var(--dentist-color); }

        .check { color: #10b981; font-size: 1.1rem; }
        .cross { color: #cbd5e1; font-size: 1.1rem; }

        /* Tips */
        .tip-box {
            background: #fffbeb;
            border: 1px solid #fde68a;
            border-radius: 10px;
            padding: 1rem 1.25rem;
            margin-top: 1.5rem;
            display: flex;
            gap: 0.75rem;
            align-items: flex-start;
            font-size: 0.9rem;
            color: #78350f;
        }

        .warning-box {
            background: #fef2f2;
            border: 1px solid #fecaca;
            border-radius: 10px;
            padding: 1rem 1.25rem;
            margin-top: 1rem;
            display: flex;
            gap: 0.75rem;
            align-items: flex-start;
            font-size: 0.9rem;
            color: #7f1d1d;
        }

        /* Role-specific visibility */
        .show-admin, .show-receptionist, .show-dentist { display: none; }
        <c:if test="${sessionScope.userRole eq 'ADMIN'}">
        .show-admin { display: block; }
        </c:if>
        <c:if test="${sessionScope.userRole eq 'RECEPTIONIST'}">
        .show-receptionist { display: block; }
        </c:if>
        <c:if test="${sessionScope.userRole eq 'DENTIST'}">
        .show-dentist { display: block; }
        </c:if>
    </style>
</head>
<body>

<nav class="navbar">
    <a href="${pageContext.request.contextPath}/dashboard" class="brand">
        <span class="brand-icon">✦</span>
        Sunrise Dental
    </a>
    <div class="nav-right">
        <span class="nav-user">Logged in as <strong><c:out value="${sessionScope.user}"/></strong></span>
        <a href="${pageContext.request.contextPath}/dashboard" class="btn-back">&larr; Dashboard</a>
        <a href="${pageContext.request.contextPath}/logout" class="btn-logout">Logout</a>
    </div>
</nav>

<div class="main-container">

    <%-- Hero Banner --%>
    <div class="hero-banner">
        <div>
            <h1 class="hero-title">Staff Help & Operational Manual</h1>
            <p class="hero-subtitle">Guides, workflows, and system references tailored to your role.</p>
        </div>
        <div>
            <c:choose>
                <c:when test="${sessionScope.userRole eq 'ADMIN'}">
                    <span class="role-badge badge-admin">🛡️ &nbsp;Admin</span>
                </c:when>
                <c:when test="${sessionScope.userRole eq 'RECEPTIONIST'}">
                    <span class="role-badge badge-receptionist">🗓️ &nbsp;Receptionist</span>
                </c:when>
                <c:when test="${sessionScope.userRole eq 'DENTIST'}">
                    <span class="role-badge badge-dentist">🦷 &nbsp;Dentist</span>
                </c:when>
            </c:choose>
        </div>
    </div>

    <%-- Tab Navigation --%>
    <div class="tabs-bar">
        <button class="tab-btn active" onclick="showTab('workflows', this)">
            <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"></path></svg>
            My Workflows
        </button>
        <button class="tab-btn" onclick="showTab('access', this)">
            <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"></path></svg>
            Access Matrix
        </button>
        <button class="tab-btn" onclick="showTab('support', this)">
            <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18.364 5.636l-3.536 3.536m0 5.656l3.536 3.536M9.172 9.172L5.636 5.636m3.536 9.192l-3.536 3.536M21 12a9 9 0 11-18 0 9 9 0 0118 0zm-5 0a4 4 0 11-8 0 4 4 0 018 0z"></path></svg>
            Support
        </button>
    </div>

    <%-- TAB 1: Workflows (Role-Specific) --%>
    <div id="tab-workflows" class="section-card active">
        <h3><span class="icon">📋</span> My Step-by-Step Workflows</h3>

        <%-- ADMIN WORKFLOWS --%>
        <div class="show-admin">
            <div class="workflow-block">
                <div class="workflow-title">🗓️ Booking an Appointment</div>
                <ol class="step-list">
                    <li class="step-item"><div class="step-num">1</div><div class="step-text">Go to <strong>Book New Appointment</strong> from the dashboard.</div></li>
                    <li class="step-item"><div class="step-num">2</div><div class="step-text">Enter patient details: Full Name, Address, and Contact Number.</div></li>
                    <li class="step-item"><div class="step-num">3</div><div class="step-text">Select an attending dentist, treatment type, date, and time slot.</div></li>
                    <li class="step-item"><div class="step-text step-num">4</div><div class="step-text">Click <strong>Confirm Booking</strong>. An Appointment ID (<code>APP-XXXXX</code>) is auto-generated.</div></li>
                </ol>
            </div>
            <div class="workflow-block">
                <div class="workflow-title">🧾 Generating a Bill & Receipt</div>
                <ol class="step-list">
                    <li class="step-item"><div class="step-num">1</div><div class="step-text">Open <strong>Billing & Invoice Engine</strong> from the dashboard.</div></li>
                    <li class="step-item"><div class="step-num">2</div><div class="step-text">Search by appointment number or patient name and click <strong>Select</strong>.</div></li>
                    <li class="step-item"><div class="step-num">3</div><div class="step-text">Confirm or adjust the consultation fee, treatment cost, and any extras.</div></li>
                    <li class="step-item"><div class="step-num">4</div><div class="step-text">Click <strong>Generate & Print Receipt</strong> to create an invoice (<code>INV-XXXXX</code>). Download as PDF or send via email.</div></li>
                </ol>
            </div>
            <div class="workflow-block">
                <div class="workflow-title">👤 Registering a New Staff Member</div>
                <ol class="step-list">
                    <li class="step-item"><div class="step-num">1</div><div class="step-text">Navigate to <strong>Register New Staff</strong> from the dashboard (Admin-only).</div></li>
                    <li class="step-item"><div class="step-num">2</div><div class="step-text">Select the appropriate role card: <strong>Admin</strong>, <strong>Receptionist</strong>, or <strong>Dentist</strong>.</div></li>
                    <li class="step-item"><div class="step-num">3</div><div class="step-text">Enter full name, a unique username, and a strong password (min. 6 characters).</div></li>
                    <li class="step-item"><div class="step-num">4</div><div class="step-text">Click <strong>Create Staff Account</strong>. The staff member can now log in immediately.</div></li>
                </ol>
            </div>
            <div class="workflow-block">
                <div class="workflow-title">🗑️ Deleting an Appointment</div>
                <ol class="step-list">
                    <li class="step-item"><div class="step-num">1</div><div class="step-text">Go to <strong>Search & Manage Appointments</strong>.</div></li>
                    <li class="step-item"><div class="step-num">2</div><div class="step-text">Locate the appointment to delete using the search bar.</div></li>
                    <li class="step-item"><div class="step-num">3</div><div class="step-text">Click the red <strong>Delete</strong> button and confirm the prompt. This action is permanent and cannot be undone.</div></li>
                </ol>
            </div>
            <div class="warning-box">
                ⚠️ <div>As an <strong>Admin</strong>, you have full delete access. Always confirm before deleting patient records.</div>
            </div>
        </div>

        <%-- RECEPTIONIST WORKFLOWS --%>
        <div class="show-receptionist">
            <div class="workflow-block">
                <div class="workflow-title">🗓️ Booking an Appointment</div>
                <ol class="step-list">
                    <li class="step-item"><div class="step-num">1</div><div class="step-text">Go to <strong>Book New Appointment</strong> from the dashboard.</div></li>
                    <li class="step-item"><div class="step-num">2</div><div class="step-text">Enter patient details: Full Name, Address, and Contact Number.</div></li>
                    <li class="step-item"><div class="step-num">3</div><div class="step-text">Select an attending dentist, treatment type, date, and time slot.</div></li>
                    <li class="step-item"><div class="step-num">4</div><div class="step-text">Click <strong>Confirm Booking</strong>. An Appointment ID (<code>APP-XXXXX</code>) is auto-generated.</div></li>
                </ol>
            </div>
            <div class="workflow-block">
                <div class="workflow-title">🧾 Generating a Bill & Receipt</div>
                <ol class="step-list">
                    <li class="step-item"><div class="step-num">1</div><div class="step-text">Open <strong>Billing & Invoice Engine</strong> from the dashboard.</div></li>
                    <li class="step-item"><div class="step-num">2</div><div class="step-text">Search and select the appointment using the patient name or appointment number.</div></li>
                    <li class="step-item"><div class="step-num">3</div><div class="step-text">Verify and adjust fees if necessary. Click <strong>Generate & Print Receipt</strong>.</div></li>
                    <li class="step-item"><div class="step-num">4</div><div class="step-text">Download the PDF for your records or use <strong>Send Email</strong> to dispatch it to the patient directly.</div></li>
                </ol>
            </div>
            <div class="workflow-block">
                <div class="workflow-title">✏️ Editing an Appointment</div>
                <ol class="step-list">
                    <li class="step-item"><div class="step-num">1</div><div class="step-text">Go to <strong>Search & Manage Appointments</strong>.</div></li>
                    <li class="step-item"><div class="step-num">2</div><div class="step-text">Find the appointment and click <strong>Edit</strong>.</div></li>
                    <li class="step-item"><div class="step-num">3</div><div class="step-text">Update the required fields (date, time slot, treatment) and save changes.</div></li>
                </ol>
            </div>
            <div class="tip-box">
                💡 <div>You can only <strong>edit</strong> appointments, not delete them. Contact an Admin if a record needs to be permanently removed.</div>
            </div>
        </div>

        <%-- DENTIST WORKFLOWS --%>
        <div class="show-dentist">
            <div class="workflow-block">
                <div class="workflow-title">🔍 Viewing My Daily Schedule</div>
                <ol class="step-list">
                    <li class="step-item"><div class="step-num">1</div><div class="step-text">From the dashboard, click <strong>My Appointment Schedule</strong>.</div></li>
                    <li class="step-item"><div class="step-num">2</div><div class="step-text">Your upcoming and past appointments will be listed automatically based on your logged-in account.</div></li>
                    <li class="step-item"><div class="step-num">3</div><div class="step-text">Review patient names, treatment types, and time slots for each appointment.</div></li>
                </ol>
            </div>
            <div class="workflow-block">
                <div class="workflow-title">🔎 Searching for a Patient Record</div>
                <ol class="step-list">
                    <li class="step-item"><div class="step-num">1</div><div class="step-text">Go to <strong>Search & Manage Appointments</strong>.</div></li>
                    <li class="step-item"><div class="step-num">2</div><div class="step-text">Enter the patient name, phone number, or appointment number in the search bar.</div></li>
                    <li class="step-item"><div class="step-num">3</div><div class="step-text">Browse the results to view appointment history and treatment types.</div></li>
                </ol>
            </div>
            <div class="tip-box">
                💡 <div>As a <strong>Dentist</strong>, you have read-only access to appointments. To book or edit an appointment, please contact the Reception desk.</div>
            </div>
        </div>
    </div>

    <%-- TAB 2: Access Matrix --%>
    <div id="tab-access" class="section-card">
        <h3><span class="icon">🔐</span> System Access & Permissions Matrix</h3>
        <table class="access-table">
            <thead>
                <tr>
                    <th>Feature / Module</th>
                    <th><span class="pill pill-admin">Admin</span></th>
                    <th><span class="pill pill-receptionist">Receptionist</span></th>
                    <th><span class="pill pill-dentist">Dentist</span></th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Dashboard</td>
                    <td><span class="check">✔</span></td>
                    <td><span class="check">✔</span></td>
                    <td><span class="check">✔</span></td>
                </tr>
                <tr>
                    <td>Book New Appointment</td>
                    <td><span class="check">✔</span></td>
                    <td><span class="check">✔</span></td>
                    <td><span class="cross">—</span></td>
                </tr>
                <tr>
                    <td>Search & Manage Appointments</td>
                    <td><span class="check">✔</span></td>
                    <td><span class="check">✔</span></td>
                    <td><span class="check">✔ (read-only)</span></td>
                </tr>
                <tr>
                    <td>Edit Appointment</td>
                    <td><span class="check">✔</span></td>
                    <td><span class="check">✔</span></td>
                    <td><span class="cross">—</span></td>
                </tr>
                <tr>
                    <td><strong>Delete Appointment</strong></td>
                    <td><span class="check">✔ (Admin only)</span></td>
                    <td><span class="cross">—</span></td>
                    <td><span class="cross">—</span></td>
                </tr>
                <tr>
                    <td>Billing & Invoice Engine</td>
                    <td><span class="check">✔</span></td>
                    <td><span class="check">✔</span></td>
                    <td><span class="cross">—</span></td>
                </tr>
                <tr>
                    <td>View & Download Receipts</td>
                    <td><span class="check">✔</span></td>
                    <td><span class="check">✔</span></td>
                    <td><span class="cross">—</span></td>
                </tr>
                <tr>
                    <td>Register New Staff</td>
                    <td><span class="check">✔ (Admin only)</span></td>
                    <td><span class="cross">—</span></td>
                    <td><span class="cross">—</span></td>
                </tr>
                <tr>
                    <td>My Appointment Schedule</td>
                    <td><span class="cross">—</span></td>
                    <td><span class="cross">—</span></td>
                    <td><span class="check">✔</span></td>
                </tr>
            </tbody>
        </table>
    </div>

    <%-- TAB 3: Support --%>
    <div id="tab-support" class="section-card">
        <h3><span class="icon">🛠️</span> Support & Troubleshooting</h3>

        <div class="workflow-block">
            <div class="workflow-title">Common Issues & Resolutions</div>
            <ol class="step-list">
                <li class="step-item">
                    <div class="step-num">❓</div>
                    <div class="step-text"><strong>Receipt shows blank data</strong> — This usually means the appointment's billing record failed to save. Ask the receptionist to regenerate the invoice from the Billing page.</div>
                </li>
                <li class="step-item">
                    <div class="step-num">❓</div>
                    <div class="step-text"><strong>Email not sending</strong> — Ensure the server has active internet access and that SMTP credentials are configured in <code>EmailUtil.java</code>. SMTP host: <code>smtp.gmail.com:587</code>.</div>
                </li>
                <li class="step-item">
                    <div class="step-num">❓</div>
                    <div class="step-text"><strong>Cannot find a dentist in the dropdown</strong> — The dentist account may not be registered yet. Ask an Admin to register them under <strong>Register New Staff</strong>.</div>
                </li>
                <li class="step-item">
                    <div class="step-num">❓</div>
                    <div class="step-text"><strong>Access Denied errors</strong> — You are trying to access a module outside your role permissions. Contact your system administrator.</div>
                </li>
            </ol>
        </div>

        <div class="workflow-block">
            <div class="workflow-title">System Information</div>
            <ol class="step-list">
                <li class="step-item">
                    <div class="step-num">ℹ️</div>
                    <div class="step-text"><strong>Database:</strong> Connected to MySQL — <code>sunrise_dental</code> database (localhost:3306).</div>
                </li>
                <li class="step-item">
                    <div class="step-num">ℹ️</div>
                    <div class="step-text"><strong>Server:</strong> Apache Tomcat — Jakarta EE 10 (Servlet 6.0).</div>
                </li>
                <li class="step-item">
                    <div class="step-num">ℹ️</div>
                    <div class="step-text"><strong>Passwords:</strong> All passwords are encrypted using BCrypt before being stored. They cannot be recovered — only reset by an Admin.</div>
                </li>
            </ol>
        </div>

        <div class="tip-box">
            💡 <div>For urgent system issues, contact your IT administrator or refer to the application deployment logs in the Tomcat <code>logs/</code> directory.</div>
        </div>
    </div>

</div>

<script>
    function showTab(tabId, btn) {
        // Hide all tab panes
        document.querySelectorAll('.section-card').forEach(card => card.classList.remove('active'));
        // Deactivate all tab buttons
        document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));

        // Activate selected
        document.getElementById('tab-' + tabId).classList.add('active');
        btn.classList.add('active');
    }
</script>

</body>
</html>