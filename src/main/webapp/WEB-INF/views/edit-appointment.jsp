<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Appointment - Sunrise Dental</title>
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
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            border-bottom: 3px solid #0077b6;
        }
        .navbar h1 { margin: 0; font-size: 1.4rem; color: #0077b6; }
        .navbar .user-badge { display: flex; align-items: center; gap: 1rem; }
        .role-pill {
            background-color: #e0f2fe; color: #0369a1;
            padding: 0.25rem 0.75rem; border-radius: 20px;
            font-size: 0.85rem; font-weight: 600; text-transform: uppercase;
        }
        .btn-logout-alt {
            background-color: #d90429; color: #fff;
            padding: 0.5rem 1rem; border-radius: 6px;
            text-decoration: none; font-weight: 600; font-size: 0.9rem;
            transition: background-color 0.2s;
        }
        .btn-logout-alt:hover { background-color: #b8001f; }

        .page-container {
            max-width: 720px;
            margin: 2.5rem auto;
            padding: 0 1.5rem;
        }

        .breadcrumb {
            font-size: 0.88rem;
            color: #6c757d;
            margin-bottom: 1.25rem;
        }
        .breadcrumb a { color: #0077b6; text-decoration: none; }
        .breadcrumb a:hover { text-decoration: underline; }
        .breadcrumb span { margin: 0 0.4rem; }

        .card {
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.07);
            overflow: hidden;
        }
        .card-header {
            background: linear-gradient(135deg, #0077b6 0%, #023e8a 100%);
            padding: 1.5rem 2rem;
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        .card-header .icon {
            width: 48px; height: 48px;
            background: rgba(255,255,255,0.2);
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.4rem;
        }
        .card-header h2 { margin: 0; color: #fff; font-size: 1.4rem; }
        .card-header p  { margin: 0.25rem 0 0; color: rgba(255,255,255,0.8); font-size: 0.9rem; }

        .card-body { padding: 2rem; }

        .info-badge {
            background: #f0f9ff;
            border: 1px solid #bae6fd;
            border-radius: 8px;
            padding: 1rem 1.25rem;
            margin-bottom: 1.75rem;
            display: flex;
            gap: 2rem;
            flex-wrap: wrap;
        }
        .info-badge .info-item label {
            display: block;
            font-size: 0.78rem;
            font-weight: 700;
            color: #0369a1;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            margin-bottom: 0.2rem;
        }
        .info-badge .info-item span {
            font-size: 1rem;
            font-weight: 600;
            color: #1e3a5f;
        }

        .section-heading {
            font-size: 0.78rem;
            font-weight: 700;
            color: #6c757d;
            text-transform: uppercase;
            letter-spacing: 0.07em;
            border-bottom: 1px solid #e9ecef;
            padding-bottom: 0.5rem;
            margin: 0 0 1.25rem;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.25rem;
            margin-bottom: 1.5rem;
        }
        .form-grid.full { grid-template-columns: 1fr; }

        .form-group { display: flex; flex-direction: column; }
        .form-group label {
            font-size: 0.85rem;
            font-weight: 600;
            color: #495057;
            margin-bottom: 0.4rem;
        }
        .form-group input,
        .form-group select {
            padding: 0.6rem 0.85rem;
            border: 1.5px solid #dee2e6;
            border-radius: 7px;
            font-size: 0.95rem;
            color: #2b2d42;
            background: #fff;
            transition: border-color 0.2s, box-shadow 0.2s;
            width: 100%;
            box-sizing: border-box;
        }
        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #0077b6;
            box-shadow: 0 0 0 3px rgba(0,119,182,0.12);
        }

        .alert {
            padding: 0.85rem 1.1rem;
            border-radius: 7px;
            margin-bottom: 1.25rem;
            font-size: 0.92rem;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.6rem;
        }
        .alert-error   { background: #fff0f0; color: #c0392b; border: 1px solid #f5c6cb; }
        .alert-success { background: #f0fff4; color: #1a7a4a; border: 1px solid #c3e6cb; }

        .form-actions {
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
            margin-top: 2rem;
            padding-top: 1.5rem;
            border-top: 1px solid #e9ecef;
        }
        .btn {
            padding: 0.65rem 1.5rem;
            border-radius: 7px;
            font-size: 0.95rem;
            font-weight: 600;
            cursor: pointer;
            border: none;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
            transition: opacity 0.2s, transform 0.15s;
        }
        .btn:hover { opacity: 0.88; transform: translateY(-1px); }
        .btn-primary { background: #0077b6; color: #fff; }
        .btn-secondary {
            background: transparent;
            color: #6c757d;
            border: 1.5px solid #dee2e6;
        }
        .btn-secondary:hover { background: #f8f9fa; }
    </style>
</head>
<body>

<header class="navbar">
    <div>
        <h1>☀ Sunrise Dental Clinic</h1>
    </div>
    <div class="user-badge">
        <span>User: <strong><c:out value="${sessionScope.user}"/></strong></span>
        <span class="role-pill"><c:out value="${sessionScope.userRole}"/></span>
        <a href="${pageContext.request.contextPath}/logout" class="btn-logout-alt">Logout</a>
    </div>
</header>

<main class="page-container">

    <div class="breadcrumb">
        <a href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
        <span>›</span>
        <a href="${pageContext.request.contextPath}/appointments/search">Search Appointments</a>
        <span>›</span>
        Edit Appointment
    </div>

    <div class="card">
        <div class="card-header">
            <div class="icon">✏️</div>
            <div>
                <h2>Edit Appointment</h2>
                <p>Update dentist, treatment, date, or time slot for this appointment.</p>
            </div>
        </div>

        <div class="card-body">

            <c:if test="${not empty errorMessage}">
                <div class="alert alert-error">⚠ <c:out value="${errorMessage}"/></div>
            </c:if>
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success">✔ <c:out value="${successMessage}"/></div>
            </c:if>

            <div class="info-badge">
                <div class="info-item">
                    <label>Appointment No.</label>
                    <span><c:out value="${appointment.appointmentNo}"/></span>
                </div>
                <div class="info-item">
                    <label>Patient</label>
                    <span><c:out value="${appointment.patientName}"/></span>
                </div>
                <div class="info-item">
                    <label>Phone</label>
                    <span><c:out value="${appointment.patientPhone}"/></span>
                </div>
            </div>

            <form id="editForm"
                  action="${pageContext.request.contextPath}/appointments/edit"
                  method="POST">
                <input type="hidden" name="id" value="${appointment.id}">

                <p class="section-heading">Appointment Details</p>

                <div class="form-grid full">
                    <div class="form-group">
                        <label for="dentistId">Assign Dentist</label>
                        <select id="dentistId" name="dentistId" required>
                            <option value="">-- Select Dentist --</option>
                            <c:forEach var="dentist" items="${dentists}">
                                <option value="${dentist.userId}"
                                    <c:if test="${dentist.userId == appointment.dentistId}">selected</c:if>>
                                    <c:out value="${dentist.fullName}"/>
                                </option>
                            </c:forEach>
                            <c:if test="${empty dentists}">
                                <option disabled>No dentists available</option>
                            </c:if>
                        </select>
                    </div>
                </div>

                <div class="form-grid full">
                    <div class="form-group">
                        <label for="treatmentType">Treatment Type</label>
                        <select id="treatmentType" name="treatmentType" required>
                            <c:set var="t" value="${appointment.treatmentType}"/>
                            <option value="Cleaning"     <c:if test="${t == 'Cleaning'    }">selected</c:if>>Teeth Cleaning</option>
                            <option value="Extraction"   <c:if test="${t == 'Extraction'  }">selected</c:if>>Tooth Extraction</option>
                            <option value="Root Canal"   <c:if test="${t == 'Root Canal'  }">selected</c:if>>Root Canal</option>
                            <option value="Consultation" <c:if test="${t == 'Consultation'}">selected</c:if>>General Consultation</option>
                            <c:if test="${t != 'Cleaning' and t != 'Extraction' and t != 'Root Canal' and t != 'Consultation' and not empty t}">
                                <option value="${t}" selected><c:out value="${t}"/></option>
                            </c:if>
                        </select>
                    </div>
                </div>

                <div class="form-grid">
                    <div class="form-group">
                        <label for="appointmentDate">Date</label>
                        <input type="date"
                               id="appointmentDate"
                               name="appointmentDate"
                               value="${appointment.appointmentDate}"
                               required>
                    </div>

                    <div class="form-group">
                        <label for="timeSlot">Time Slot</label>
                        <select id="timeSlot" name="timeSlot" required>
                            <c:set var="ts" value="${appointment.timeSlot}"/>
                            <option value="09:00 AM - 10:00 AM" <c:if test="${ts == '09:00 AM - 10:00 AM'}">selected</c:if>>09:00 AM – 10:00 AM</option>
                            <option value="10:00 AM - 11:00 AM" <c:if test="${ts == '10:00 AM - 11:00 AM'}">selected</c:if>>10:00 AM – 11:00 AM</option>
                            <option value="02:00 PM - 03:00 PM" <c:if test="${ts == '02:00 PM - 03:00 PM'}">selected</c:if>>02:00 PM – 03:00 PM</option>
                            <option value="03:00 PM - 04:00 PM" <c:if test="${ts == '03:00 PM - 04:00 PM'}">selected</c:if>>03:00 PM – 04:00 PM</option>
                        </select>
                    </div>
                </div>

                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/appointments/search"
                       class="btn btn-secondary">Cancel</a>
                    <button type="submit" class="btn btn-primary" id="saveBtn">
                        💾 Save Changes
                    </button>
                </div>

            </form>
        </div>
    </div>

</main>

<script>
    const dateInput = document.getElementById('appointmentDate');
    const today = new Date().toISOString().split('T')[0];
    dateInput.setAttribute('min', today);
    document.getElementById('editForm').addEventListener('submit', function () {
        const btn = document.getElementById('saveBtn');
        btn.disabled = true;
        btn.textContent = 'Saving…';
    });
</script>

</body>
</html>
