<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Appointment - Sunrise Dental</title>
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
            max-width: 800px;
            margin: 3rem auto;
            padding: 0 2rem;
        }
        
        .page-header {
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

        /* Form Card */
        .form-card {
            background: var(--surface);
            border-radius: 16px;
            padding: 2.5rem;
            border: 1px solid var(--border);
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05);
        }

        .section-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--primary);
            margin-bottom: 1.5rem;
            padding-bottom: 0.75rem;
            border-bottom: 1px solid var(--border);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
            margin-bottom: 1.5rem;
        }
        
        .form-group {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }
        
        .form-group.full-width {
            grid-column: span 2;
        }

        .form-group label {
            font-size: 0.9rem;
            font-weight: 500;
            color: var(--text-main);
        }

        .form-control {
            width: 100%;
            padding: 0.875rem 1.25rem;
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
        
        textarea.form-control {
            resize: vertical;
            min-height: 100px;
        }

        .btn-submit {
            width: 100%;
            padding: 1rem;
            background-color: var(--text-main);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1.05rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 1rem;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-submit:hover {
            background-color: var(--primary);
            transform: translateY(-2px);
            box-shadow: 0 10px 20px -5px rgba(2, 132, 199, 0.3);
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

        .alert-danger {
            background-color: #fef2f2;
            color: #b91c1c;
            border: 1px solid #fecaca;
        }
        
        @media (max-width: 768px) {
            .form-row { grid-template-columns: 1fr; }
            .form-group.full-width { grid-column: span 1; }
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
            <h1 class="page-title">Book New Appointment</h1>
            <p class="page-subtitle">Register a patient and assign a treatment slot instantly.</p>
        </div>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger">
                <svg width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                <c:out value="${errorMessage}"/>
            </div>
        </c:if>
        
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success">
                <svg width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path></svg>
                <c:out value="${successMessage}"/>
            </div>
        </c:if>

        <div class="form-card">
            <form action="${pageContext.request.contextPath}/appointments/create" method="POST" onsubmit="return validateForm()">
                
                <h3 class="section-title">
                    <svg width="24" height="24" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path></svg>
                    Patient Information
                </h3>
                
                <div class="form-row">
                    <div class="form-group full-width">
                        <label for="fullName">Full Name</label>
                        <input type="text" id="fullName" name="fullName" class="form-control" required placeholder="e.g. John Doe">
                    </div>

                    <div class="form-group full-width">
                        <label for="address">Address</label>
                        <textarea id="address" name="address" class="form-control" required placeholder="Enter complete residential address"></textarea>
                    </div>

                    <div class="form-group full-width">
                        <label for="phone">Contact Number</label>
                        <input type="tel" id="phone" name="phone" class="form-control" required pattern="^(\+\d{1,3}[- ]?)?\d{10}$" placeholder="0771234567 or +94771234567">
                        <small style="color: var(--text-muted); font-size: 0.8rem; margin-top: 0.25rem;">Must be a valid 10-digit number</small>
                    </div>
                </div>

                <h3 class="section-title" style="margin-top: 2rem;">
                    <svg width="24" height="24" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path></svg>
                    Appointment Details
                </h3>

                <div class="form-row">
                    <div class="form-group">
                        <label for="dentistId">Assign Dentist</label>
                        <select id="dentistId" name="dentistId" class="form-control" required>
                            <option value="">-- Select Dentist --</option>
                            <c:forEach var="dentist" items="${dentists}">
                                <option value="${dentist.userId}">
                                    Dr. ${dentist.fullName}
                                </option>
                            </c:forEach>
                            <c:if test="${empty dentists}">
                                <option disabled>No dentists available</option>
                            </c:if>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="treatmentType">Treatment Type</label>
                        <select id="treatmentType" name="treatmentType" class="form-control" required>
                            <option value="Cleaning">Teeth Cleaning</option>
                            <option value="Extraction">Tooth Extraction</option>
                            <option value="Root Canal">Root Canal</option>
                            <option value="Consultation">General Consultation</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="appointmentDate">Date</label>
                        <input type="date" id="appointmentDate" name="appointmentDate" class="form-control" required>
                    </div>

                    <div class="form-group">
                        <label for="timeSlot">Time Slot</label>
                        <select id="timeSlot" name="timeSlot" class="form-control" required>
                            <option value="09:00 AM - 10:00 AM">09:00 AM - 10:00 AM</option>
                            <option value="10:00 AM - 11:00 AM">10:00 AM - 11:00 AM</option>
                            <option value="02:00 PM - 03:00 PM">02:00 PM - 03:00 PM</option>
                            <option value="03:00 PM - 04:00 PM">03:00 PM - 04:00 PM</option>
                        </select>
                    </div>
                </div>

                <button type="submit" class="btn-submit">
                    Confirm Booking
                    <svg width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                </button>
            </form>
        </div>
    </div>

    <script>
        const dateInput = document.getElementById('appointmentDate');
        const today = new Date().toISOString().split('T')[0];
        dateInput.setAttribute('min', today);

        function validateForm() {
            const phone = document.getElementById('phone').value;
            const phoneRegex = /^(\+\d{1,3}[- ]?)?\d{10}$/;

            if (!phoneRegex.test(phone)) {
                alert('Please enter a valid 10-digit phone number.');
                return false;
            }
            return true;
        }
    </script>
</body>
</html>