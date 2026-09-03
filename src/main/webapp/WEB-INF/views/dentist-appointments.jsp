<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Scheduled Appointments - Sunrise Dental</title>
    <style>
        body { font-family: sans-serif; margin: 2rem; }
        table { width: 100%; border-collapse: collapse; margin-top: 1rem; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        th { background-color: #f4f4f4; }
        .no-data { text-align: center; color: #666; font-style: italic; margin-top: 2rem; }
    </style>
</head>
<body>

    <h2>My Appointments</h2>

    <c:choose>
        <%-- Check if the database returned no appointments for this dentist --%>
        <c:when test="${empty appointments}">
            <div class="no-data">
                <p>No appointments scheduled for you at this time.</p>
            </div>
        </c:when>

        <%-- Display table only if appointments exist --%>
        <c:otherwise>
            <table>
                <thead>
                    <tr>
                        <th>Appt No</th>
                        <th>Patient Name</th>
                        <th>Contact Number</th>
                        <th>Treatment</th>
                        <th>Date</th>
                        <th>Time Slot</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="appt" items="${appointments}">
                        <tr>
                            <td>${appt.appointmentNo}</td>
                            <td>${appt.patientName}</td>
                            <td>${appt.patientPhone}</td>
                            <td>${appt.treatmentType}</td>
                            <td>${appt.appointmentDate}</td>
                            <td>${appt.timeSlot}</td>
                            <td>${appt.status}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>

</body>
</html>