<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Billing & Invoicing - Sunrise Dental</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .container { max-width: 1100px; margin: 2rem auto; padding: 0 1rem; }
        .grid { display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; }
        .card { background: #fff; padding: 1.5rem; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 0.75rem; text-align: left; border-bottom: 1px solid #eee; }
        th { background: #0077b6; color: #fff; }
        .form-group { margin-bottom: 1rem; }
        .form-group label { display: block; font-weight: bold; margin-bottom: 0.3rem; }
        .form-group input { width: 100%; padding: 0.6rem; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        .total-box { background: #e0f2fe; padding: 1rem; border-radius: 6px; font-size: 1.2rem; font-weight: bold; color: #0369a1; text-align: right; }
    </style>
    <script>
        function calculateTotal() {
            let consultation = parseFloat(document.getElementById("consultationFee").value) || 0;
            let treatment = parseFloat(document.getElementById("treatmentCost").value) || 0;
            let medicine = parseFloat(document.getElementById("medicineCharges").value) || 0;
            let total = consultation + treatment + medicine;
            document.getElementById("totalDisplay").innerText = "LKR " + total.toFixed(2);
        }
    </script>
</head>
<body>

<div class="container">
    <h2>Billing & Invoice Engine</h2>

    <div class="grid">
        <%-- Left Column: Search & Select Appointment --%>
        <div class="card">
            <h3>1. Select Appointment</h3>
            <form action="${pageContext.request.contextPath}/billing" method="GET" style="display:flex; gap:0.5rem; margin-bottom:1rem;">
                <input type="text" name="query" value="<c:out value='${query}'/>" placeholder="Search Appt No or Patient..." style="flex:1; padding:0.5rem;">
                <button type="submit" class="btn-submit" style="width:auto;">Search</button>
            </form>

            <div style="max-height: 350px; overflow-y: auto;">
                <table>
                    <thead>
                        <tr>
                            <th>Appt No</th>
                            <th>Patient</th>
                            <th>Dentist</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="a" items="${appointments}">
                            <tr>
                                <td><strong><c:out value="${a.appointmentNo}"/></strong></td>
                                <td><c:out value="${a.patientName}"/></td>
                                <td><c:out value="${a.dentistName}"/></td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/billing?selectId=${a.id}&query=${query}" class="btn-submit" style="padding:0.25rem 0.5rem; font-size:0.8rem; text-decoration:none;">Select</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <%-- Right Column: Invoice Calculation Form --%>
        <div class="card">
            <h3>2. Generate Receipt</h3>
            <c:choose>
                <c:when test="${not empty selectedAppt}">
                    <form action="${pageContext.request.contextPath}/billing/generate" method="POST">
                        <input type="hidden" name="appointmentId" value="${selectedAppt.id}">

                        <div class="form-group">
                            <label>Appointment No</label>
                            <input type="text" value="${selectedAppt.appointmentNo}" readonly style="background:#f0f0f0;">
                        </div>

                        <div class="form-group">
                            <label>Patient Name</label>
                            <input type="text" value="${selectedAppt.patientName}" readonly style="background:#f0f0f0;">
                        </div>

                        <div class="form-group">
                            <label>Dentist</label>
                            <input type="text" value="${selectedAppt.dentistName}" readonly style="background:#f0f0f0;">
                        </div>

                        <div class="form-group">
                            <label>Consultation Fee (LKR)</label>
                            <input type="number" step="0.01" id="consultationFee" name="consultationFee" value="2500.00" oninput="calculateTotal()" required>
                        </div>

                        <div class="form-group">
                            <label>Treatment Cost (${selectedAppt.treatmentType}) (LKR)</label>
                            <input type="number" step="0.01" id="treatmentCost" name="treatmentCost" value="5000.00" oninput="calculateTotal()" required>
                        </div>

                        <div class="form-group">
                            <label>Additional / Medicine Charges (LKR)</label>
                            <input type="number" step="0.01" id="medicineCharges" name="medicineCharges" value="0.00" oninput="calculateTotal()">
                        </div>

                        <div class="total-box" id="totalDisplay">LKR 7500.00</div>

                        <button type="submit" class="btn-submit" style="margin-top:1rem;">Generate & Print Receipt</button>
                    </form>
                </c:when>
                <c:otherwise>
                    <p style="color:#888; text-align:center; margin-top:3rem;">Select an appointment from the left table to process billing.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <p style="margin-top:2rem;"><a href="${pageContext.request.contextPath}/dashboard">&larr; Back to Dashboard</a></p>
</div>

</body>
</html>