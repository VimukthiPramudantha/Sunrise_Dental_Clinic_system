<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sunrise Dental - Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<c:choose>
    <c:when test="${not empty sessionScope.user}">
        <div style="padding: 20px;">
            <h2>Welcome, <c:out value="${sessionScope.user}"/>!</h2>
            <p>Role Authorized Access - Sunrise Dental Management System</p>
            <a href="${pageContext.request.contextPath}/logout" class="btn-submit" style="display:inline-block; width:auto; padding:10px 20px; text-decoration:none;">Logout</a>
        </div>
    </c:when>
    <c:otherwise>
        <%-- Redirect unauthorized direct access to login --%>
        <c:redirect url="/login"/>
    </c:otherwise>
</c:choose>

</body>
</html>