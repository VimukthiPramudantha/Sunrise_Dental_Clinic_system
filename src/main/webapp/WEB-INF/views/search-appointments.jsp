<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Search & Manage Appointments - Sunrise Dental</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .container { max-width: 1100px; margin: 2rem auto; padding: 0 1rem; }
        .search-box { display: flex; gap: 1rem; margin-bottom: 1.5rem; }
        .search-box input { flex: 1; padding: 0.75rem; border: 1px solid #ccc; border-radius: 6px; }
        table { width: 100%; border-collapse: collapse; background: #fff; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        th, td { padding: 0.9rem 1rem; text-align: left; border-bottom: 1px solid #eee; }
        th { background-color: var(--primary-color, #0077b6); color: #fff; }
        .btn-edit { background: #0284c7; color: #fff; padding: 0.35rem 0.75rem; border-radius: 4px; text-decoration: none; font-size: 0.85rem; }
        .btn-delete { background: #d90429; color: #fff; padding: 0.35rem 0.75rem; border-radius: 4px; text-decoration: none; font-size: 0.85rem; }
    </style>
</head>
<body>

<div class="container">
    <h2>Search & Manage Appointments</h2>

    <c:if test="${param.success != null}">
        <div style="background:#d4edda; color:#155724; padding:0.75rem; border-radius:6px; margin-bottom:1rem;">
            <c:out value="${param.success}"/>
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/appointments/search" method="GET" class="search-box">
        <input type="text" name="query" value="<c:out value='${query}'/>" placeholder="Search by Appt No, Patient Name, Phone, or Dentist...">
        <button type="submit" class="btn-submit" style="width: auto;">Search</button>
    </form>

    <table>
        <thead>
            <tr>
                <th>Appt No</th>
                <th>Patient</th>
                <th>Phone</th>
                <th>Dentist</th>
                <th>Treatment</th>
                <th>Date</th>
                <th>Slot</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="a" items="${appointments}">
                <tr>
                    <td><strong><c:out value="${a.appointmentNo}"/></strong></td>
                    <td><c:out value="${a.patientName}"/></td>
                    <td><c:out value="${a.patientPhone}"/></td>
                    <td><c:out value="${a.dentistName}"/></td>
                    <td><c:out value="${a.treatmentType}"/></td>
                    <td><c:out value="${a.appointmentDate}"/></td>
                    <td><c:out value="${a.timeSlot}"/></td>
                    <td>
                        <a href="${pageContext.request.contextPath}/appointments/edit?id=${a.id}" class="btn-edit">Edit</a>
                        <c:if test="${sessionScope.userRole eq 'ADMIN'}">
                            <a href="${pageContext.request.contextPath}/appointments/delete?id=${a.id}"
                               class="btn-delete"
                               onclick="return confirm('Are you sure you want to delete this appointment?');">Delete</a>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty appointments}">
                <tr><td colspan="8" style="text-align:center; color:#888;">No appointments found.</td></tr>
            </c:if>
        </tbody>
    </table>

    <p><a href="${pageContext.request.contextPath}/dashboard">&larr; Back to Dashboard</a></p>
</div>

</body>
</html>