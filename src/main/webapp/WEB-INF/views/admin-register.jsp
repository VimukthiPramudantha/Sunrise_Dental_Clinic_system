<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register New Staff - Sunrise Dental</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #0284c7;
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

        .brand-icon { color: var(--secondary); font-size: 1.75rem; }

        .btn-back {
            color: var(--text-muted);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-weight: 500;
            transition: color 0.2s;
        }

        .btn-back:hover { color: var(--primary); }

        /* Page Layout */
        .main-container {
            max-width: 600px;
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

        /* Role Selector Cards */
        .role-selector {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 0.75rem;
            margin-bottom: 1.5rem;
        }

        .role-option {
            display: none;
        }

        .role-label {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 0.5rem;
            padding: 1rem 0.5rem;
            border: 2px solid var(--border);
            border-radius: 10px;
            cursor: pointer;
            text-align: center;
            transition: all 0.2s ease;
            background: var(--bg-input);
        }

        .role-label:hover {
            border-color: var(--primary);
            background: #f0f9ff;
        }

        .role-option:checked + .role-label {
            border-color: var(--primary);
            background: #e0f2fe;
            color: var(--primary);
        }

        .role-icon {
            font-size: 1.75rem;
        }

        .role-name {
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .role-desc {
            font-size: 0.75rem;
            color: var(--text-muted);
            line-height: 1.3;
        }

        /* Form Elements */
        .form-group {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
            margin-bottom: 1.25rem;
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
            font-family: 'Outfit', sans-serif;
        }

        .form-control:focus {
            background-color: #ffffff;
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(2, 132, 199, 0.1);
        }

        .password-wrapper {
            position: relative;
        }

        .password-wrapper .form-control {
            padding-right: 3rem;
        }

        .toggle-password {
            position: absolute;
            right: 1rem;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            cursor: pointer;
            color: var(--text-muted);
            padding: 0;
            display: flex;
            align-items: center;
        }

        .toggle-password:hover { color: var(--primary); }

        .password-strength {
            display: flex;
            gap: 4px;
            height: 4px;
            margin-top: 0.5rem;
        }

        .strength-bar {
            flex: 1;
            border-radius: 2px;
            background-color: var(--border);
            transition: background-color 0.3s;
        }

        .strength-label {
            font-size: 0.8rem;
            color: var(--text-muted);
            margin-top: 0.35rem;
        }

        .section-divider {
            border: none;
            border-top: 1px dashed var(--border);
            margin: 1.75rem 0;
        }

        .section-label {
            font-size: 0.85rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: var(--text-muted);
            margin-bottom: 1.25rem;
        }

        /* Alerts */
        .alert {
            padding: 1rem 1.25rem;
            border-radius: 10px;
            margin-bottom: 1.5rem;
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

        /* Submit Button */
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
            margin-top: 0.5rem;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 0.5rem;
            font-family: 'Outfit', sans-serif;
        }

        .btn-submit:hover {
            background-color: var(--primary);
            transform: translateY(-2px);
            box-shadow: 0 10px 20px -5px rgba(2, 132, 199, 0.3);
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
            <h1 class="page-title">Register New Staff</h1>
            <p class="page-subtitle">Admin-controlled provisioning. Create user accounts and set access levels.</p>
        </div>

        <c:if test="${not empty successMessage}">
            <div class="alert alert-success">
                <svg width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path></svg>
                <c:out value="${successMessage}"/>
            </div>
        </c:if>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger">
                <svg width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                <c:out value="${errorMessage}"/>
            </div>
        </c:if>

        <div class="form-card">
            <form action="${pageContext.request.contextPath}/register" method="POST">

                <p class="section-label">1. Assign a Role</p>

                <div class="role-selector">
                    <div>
                        <input type="radio" id="role-admin" name="role" value="ADMIN" class="role-option" required>
                        <label for="role-admin" class="role-label">
                            <span class="role-icon">🛡️</span>
                            <span class="role-name">Admin</span>
                            <span class="role-desc">Full system access</span>
                        </label>
                    </div>
                    <div>
                        <input type="radio" id="role-receptionist" name="role" value="RECEPTIONIST" class="role-option">
                        <label for="role-receptionist" class="role-label">
                            <span class="role-icon">🗓️</span>
                            <span class="role-name">Receptionist</span>
                            <span class="role-desc">Appts & Billing</span>
                        </label>
                    </div>
                    <div>
                        <input type="radio" id="role-dentist" name="role" value="DENTIST" class="role-option">
                        <label for="role-dentist" class="role-label">
                            <span class="role-icon">🦷</span>
                            <span class="role-name">Dentist</span>
                            <span class="role-desc">Medical records</span>
                        </label>
                    </div>
                </div>

                <hr class="section-divider">

                <p class="section-label">2. Staff Details</p>

                <div class="form-group">
                    <label for="fullName">Full Name</label>
                    <input type="text" id="fullName" name="fullName" class="form-control" placeholder="e.g. Dr. Kasun Rajakaruna" required autocomplete="off">
                </div>

                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" class="form-control" placeholder="e.g. kasun_r" required autocomplete="off">
                </div>

                <div class="form-group">
                    <label for="password">Password <span style="color: var(--text-muted); font-weight: 400;">(min. 6 characters)</span></label>
                    <div class="password-wrapper">
                        <input type="password" id="password" name="password" class="form-control" required minlength="6" oninput="checkStrength(this.value)">
                        <button type="button" class="toggle-password" onclick="togglePassword()" id="toggleBtn">
                            <svg id="eye-icon" width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path></svg>
                        </button>
                    </div>
                    <div class="password-strength">
                        <div class="strength-bar" id="bar1"></div>
                        <div class="strength-bar" id="bar2"></div>
                        <div class="strength-bar" id="bar3"></div>
                        <div class="strength-bar" id="bar4"></div>
                    </div>
                    <span class="strength-label" id="strength-label"></span>
                </div>

                <button type="submit" class="btn-submit">
                    Create Staff Account
                    <svg width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18 9v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z"></path></svg>
                </button>
            </form>
        </div>
    </div>

    <script>
        function togglePassword() {
            const input = document.getElementById('password');
            input.type = input.type === 'password' ? 'text' : 'password';
        }

        function checkStrength(val) {
            const bars = [document.getElementById('bar1'), document.getElementById('bar2'),
                          document.getElementById('bar3'), document.getElementById('bar4')];
            const label = document.getElementById('strength-label');

            let strength = 0;
            if (val.length >= 6) strength++;
            if (val.length >= 10) strength++;
            if (/[A-Z]/.test(val) && /[a-z]/.test(val)) strength++;
            if (/[^A-Za-z0-9]/.test(val) || /[0-9]/.test(val)) strength++;

            const colors = ['#ef4444', '#f59e0b', '#10b981', '#0284c7'];
            const labels = ['', 'Weak', 'Fair', 'Good', 'Strong'];

            bars.forEach((bar, i) => {
                bar.style.backgroundColor = i < strength ? colors[strength - 1] : '#e2e8f0';
            });

            label.textContent = val.length > 0 ? labels[strength] : '';
            label.style.color = strength > 0 ? colors[strength - 1] : 'var(--text-muted)';
        }
    </script>
</body>
</html>