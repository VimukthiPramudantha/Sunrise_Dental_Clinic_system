<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sunrise Dental - 403 Access Denied</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<div class="login-card" style="text-align: center;">
    <h2 style="color: var(--error-color);">403 - Access Denied</h2>
    <p class="subtitle">Your role (<strong><c:out value="${sessionScope.userRole}"/></strong>) does not have permission to access this module.</p>

    <a href="${pageContext.request.contextPath}/dashboard" class="btn-submit" style="display:inline-block; text-decoration:none; margin-top: 1rem;">Return to Dashboard</a>
</div>

</body>
</html>