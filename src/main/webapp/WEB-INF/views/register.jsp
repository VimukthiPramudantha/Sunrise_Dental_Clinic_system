<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sunrise Dental Clinic - Staff Sign Up</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<div class="login-card">
    <h2>Staff Registration</h2>
    <p class="subtitle">Create a new account for Sunrise Dental Clinic staff</p>

    <%-- Error message rendering --%>
    <c:if test="${not empty errorMessage}">
        <div class="alert-danger">
            <c:out value="${errorMessage}"/>
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/register" method="POST">
        <div class="form-group">
            <label for="fullName">Full Name</label>
            <input type="text" id="fullName" name="fullName" required placeholder="e.g. Dr. Jane Smith" autofocus>
        </div>

        <div class="form-group">
            <label for="username">Username</label>
            <input type="text" id="username" name="username" required placeholder="e.g. janesmith">
        </div>

        <div class="form-group">
            <label for="password">Password (Min. 6 characters)</label>
            <input type="password" id="password" name="password" required minlength="6" placeholder="••••••••">
        </div>

        <div class="form-group">
            <label for="role">Assign Role</label>
            <select id="role" name="role" required style="width: 100%; padding: 0.75rem; border: 1px solid #ced4da; border-radius: 6px; font-size: 1rem; background-color: white;">
                <option value="RECEPTIONIST">Receptionist</option>
                <option value="DENTIST">Dentist</option>
                <option value="ADMIN">Administrator</option>
            </select>
        </div>

        <button type="submit" class="btn-submit">Register Account</button>
    </form>

    <p style="text-align: center; margin-top: 1.5rem; font-size: 0.9rem;">
        Already have an account? <a href="${pageContext.request.contextPath}/login" style="color: var(--primary-color); text-decoration: none; font-weight: bold;">Login here</a>
    </p>
</div>

</body>
</html>