<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sunrise Dental Clinic - Staff Login</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<div class="login-card">
    <h2>Sunrise Dental Clinic</h2>
    <p class="subtitle">Enter credentials to access the management portal</p>

    <%-- Success message after dynamic registration --%>
    <c:if test="${not empty successMessage}">
        <div style="background-color: #d4edda; color: #155724; padding: 0.75rem; border-radius: 6px; margin-bottom: 1.5rem; font-size: 0.9rem; border: 1px solid #c3e6cb;">
            <c:out value="${successMessage}"/>
        </div>
    </c:if>

    <%-- Error message if login fails --%>
    <c:if test="${not empty errorMessage}">
        <div class="alert-danger">
            <c:out value="${errorMessage}"/>
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/login" method="POST">
        <div class="form-group">
            <label for="username">Username</label>
            <input type="text" id="username" name="username" required placeholder="e.g. admin" autofocus>
        </div>

        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required placeholder="••••••••">
        </div>

        <button type="submit" class="btn-submit">Login to System</button>
    </form>

    <p style="text-align: center; margin-top: 1.5rem; font-size: 0.9rem;">
        New staff member? <a href="${pageContext.request.contextPath}/register" style="color: var(--primary-color); text-decoration: none; font-weight: bold;">Register here</a>
    </p>
</div>

</body>
</html>