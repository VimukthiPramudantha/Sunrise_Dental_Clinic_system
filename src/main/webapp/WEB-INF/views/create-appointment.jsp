<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Book Appointment - Sunrise Dental</title>
    <style>
        .form-container { max-width: 600px; margin: 2rem auto; font-family: sans-serif; }
        .form-group { margin-bottom: 1rem; }
        .form-group label { display: block; margin-bottom: .5rem; font-weight: bold; }
        .form-group input, .form-group select, .form-group textarea {
            width: 100%; padding: 0.5rem; box-sizing: border-box;
        }
        .alert-error { color: #721c24; background-color: #f8d7da; padding: 0.75rem; margin-bottom: 1rem; }
        .alert-success { color: #155724; background-color: #d4edda; padding: 0.75rem; margin-bottom: 1rem; }
    </style>
</head>
<body>

<div class="form-container">
    <h2>Patient Registration & Appointment Booking</h2>

    <c:if test="${not empty errorMessage}">
        <div class="alert-error">${errorMessage}</div>
    </c:if>
    <c:if test="${not empty successMessage}">
        <div class="alert-success">${successMessage}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/appointments/create" method="POST" onsubmit="return validateForm()">

        <h3>Patient Information</h3>
        <div class="form-group">
            <label for="fullName">Full Name</label>
            <input type="text" id="fullName" name="fullName" required placeholder="John Doe">
        </div>

        <div class="form-group">
            <label for="address">Address</label>
            <textarea id="address" name="address" rows="2" required></textarea>
        </div>

        <div class="form-group">
            <label for="phone">Contact Number (10 Digits)</label>
            <input type="tel" id="phone" name="phone" required
                   pattern="^(\+\d{1,3}[- ]?)?\d{10}$"
                   placeholder="0771234567 or +94771234567">
        </div>

        <h3>Appointment Details</h3>
        <div class="form-group">
            <label for="dentistId">Assign Dentist</label>
            <select id="dentistId" name="dentistId" required>
                <option value="">-- Select Dentist --</option>
                <c:forEach var="dentist" items="${dentists}">
                    <option value="${dentist.id}">
                        ${dentist.fullName} (${dentist.specialization}) — Rs. ${dentist.consultationFee}
                    </option>
                </c:forEach>
                <c:if test="${empty dentists}">
                    <option disabled>No dentists available</option>
                </c:if>
            </select>
        </div>

        <div class="form-group">
            <label for="treatmentType">Treatment Type</label>
            <select id="treatmentType" name="treatmentType" required>
                <option value="Cleaning">Teeth Cleaning</option>
                <option value="Extraction">Tooth Extraction</option>
                <option value="Root Canal">Root Canal</option>
                <option value="Consultation">General Consultation</option>
            </select>
        </div>

        <div class="form-group">
            <label for="appointmentDate">Date</label>
            <input type="date" id="appointmentDate" name="appointmentDate" required>
        </div>

        <div class="form-group">
            <label for="timeSlot">Time Slot</label>
            <select id="timeSlot" name="timeSlot" required>
                <option value="09:00 AM - 10:00 AM">09:00 AM - 10:00 AM</option>
                <option value="10:00 AM - 11:00 AM">10:00 AM - 11:00 AM</option>
                <option value="02:00 PM - 03:00 PM">02:00 PM - 03:00 PM</option>
                <option value="03:00 PM - 04:00 PM">03:00 PM - 04:00 PM</option>
            </select>
        </div>

        <button type="submit" style="padding: 0.75rem 1.5rem; background: #007bff; color: white; border: none; cursor: pointer;">
            Book Appointment
        </button>
    </form>
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