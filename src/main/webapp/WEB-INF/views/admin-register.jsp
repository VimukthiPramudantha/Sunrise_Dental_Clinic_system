<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff Registration - Sunrise Dental</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .form-container {
            max-width: 500px;
            margin: 3rem auto;
            background: #ffffff;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            border-top: 4px solid #7209b7;
        }
        .form-container h2 {
            margin-top: 0;
            color: #7209b7;
        }
        .form-group {
            margin-bottom: 1.2rem;
        }
        .form-group label {
            display: block;
            margin-bottom: 0.4rem;
            font-weight: bold;
            color: #2b2d42;
        }
        .form-group input, .form-group select {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #ccc;
            border-radius: 6px;
            box-sizing: border-box;
            font-size: 0.95rem;
        }
        .alert-success {
            background-color: #d4edda;
            color: #155724;
            padding: 0.8rem;
            border-radius: 6px;
            margin-bottom: 1rem;
        }
        .alert-error {
            background-color: #f8d7da;
            color: #721c24;
            padding: 0.8rem;
            border-radius: 6px;
            margin-bottom: 1rem;
        }
        .btn-register {
            background-color: #7209b7;
            color: #ffffff;
            padding: 0.75rem;
            border: none;
            border-radius: 6px;
            width: 100%;
            font-size: 1rem;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.2s;
        }
        .btn-register:hover {
            background-color: #5c0792;
        }
    </style>
</head>
<body>

<div class="form-container">
    <h2>Register New Staff Member</h2>
    <p style="color: #6c757d; font-size: 0.9rem; margin-bottom: 1.5rem;">Admin Controlled Provisioning — Create user accounts and set access levels.</p>

    <c:if test="${not empty successMessage}">
        <div class="alert-success"><c:out value="${successMessage}"/></div>
    </c:if>

    <c:if test="${not empty errorMessage}">
        <div class="alert-error"><c:out value="${errorMessage}"/></div>
    </c:if>

    <form action="${pageContext.request.contextPath}/register" method="POST">
        <div class="form-group">
            <label for="fullName">Full Name</label>
            <input type="text" id="fullName" name="fullName" placeholder="e.g. Dr. Kasun Rajakaruna" required>
        </div>

        <div class="form-group">
            <label for="username">Username</label>
            <input type="text" id="username" name="username" placeholder="e.g. kasun_r" required>
        </div>

        <div class="form-group">
            <label for="password">Password (Min. 6 characters)</label>
            <input type="password" id="password" name="password" required>
        </div>

        <div class="form-group">
            <label for="role">Assign System Role</label>
            <select id="role" name="role" required>
                <option value="" disabled selected>-- Select Access Role --</option>
                <option value="ADMIN">ADMIN (Full Access)</option>
                <option value="RECEPTIONIST">RECEPTIONIST (Appointments & Billing)</option>
                <option value="DENTIST">DENTIST (Medical Records Lookup)</option>
            </select>
        </div>

        <button type="submit" class="btn-register">Create Staff Account</button>
    </form>

    <p style="margin-top: 1.5rem; text-align: center;">
        <a href="${pageContext.request.contextPath}/dashboard" style="color: #7209b7; text-decoration: none;">&larr; Return to Dashboard</a>
    </p>
</div>

</body>
</html>