<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sunrise Dental Clinic - Staff Login</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #0284c7;
            --primary-hover: #0369a1;
            --text-main: #0f172a;
            --text-muted: #64748b;
            --bg-input: #f1f5f9;
            --border-input: #e2e8f0;
            --error-bg: #fef2f2;
            --error-text: #b91c1c;
            --success-bg: #f0fdf4;
            --success-text: #15803d;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Outfit', sans-serif;
        }

        body {
            min-height: 100vh;
            display: flex;
            background-color: #ffffff;
        }

        /* Split Layout Container */
        .split-layout {
            display: flex;
            width: 100%;
            height: 100vh;
        }

        /* Left Side - Visual/Branding */
        .layout-left {
            flex: 1;
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
            position: relative;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: 4rem;
            color: white;
        }

        /* Abstract shapes for left side background */
        .layout-left::before {
            content: '';
            position: absolute;
            top: -10%;
            left: -10%;
            width: 500px;
            height: 500px;
            background: radial-gradient(circle, rgba(2,132,199,0.3) 0%, transparent 70%);
            border-radius: 50%;
        }
        .layout-left::after {
            content: '';
            position: absolute;
            bottom: -20%;
            right: -10%;
            width: 600px;
            height: 600px;
            background: radial-gradient(circle, rgba(14,165,233,0.2) 0%, transparent 70%);
            border-radius: 50%;
        }

        .brand {
            position: relative;
            z-index: 10;
        }
        
        .brand-logo {
            font-size: 2.5rem;
            font-weight: 700;
            letter-spacing: -1px;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .brand-icon {
            color: #38bdf8;
        }

        .hero-text {
            position: relative;
            z-index: 10;
            margin-bottom: 2rem;
        }

        .hero-title {
            font-size: 3.5rem;
            font-weight: 700;
            line-height: 1.1;
            margin-bottom: 1.5rem;
        }

        .hero-title span {
            color: #38bdf8;
        }

        .hero-subtitle {
            font-size: 1.1rem;
            color: #94a3b8;
            max-width: 80%;
            line-height: 1.6;
        }

        /* Right Side - Login Form */
        .layout-right {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
            background: #ffffff;
        }

        .login-container {
            width: 100%;
            max-width: 440px;
            animation: slideUp 0.6s ease-out forwards;
            opacity: 0;
            transform: translateY(20px);
        }

        @keyframes slideUp {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .header {
            margin-bottom: 2.5rem;
        }

        .title {
            font-size: 2rem;
            font-weight: 700;
            color: var(--text-main);
            margin-bottom: 0.5rem;
        }

        .subtitle {
            font-size: 1rem;
            color: var(--text-muted);
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            font-size: 0.9rem;
            font-weight: 500;
            color: var(--text-main);
            margin-bottom: 0.5rem;
        }

        .form-control {
            width: 100%;
            padding: 1rem 1.25rem;
            font-size: 1rem;
            color: var(--text-main);
            background-color: var(--bg-input);
            border: 1px solid transparent;
            border-radius: 12px;
            transition: all 0.2s ease;
            outline: none;
        }

        .form-control:focus {
            background-color: #ffffff;
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(2, 132, 199, 0.1);
        }

        .form-control::placeholder {
            color: #94a3b8;
        }

        .btn-submit {
            width: 100%;
            padding: 1rem;
            background-color: var(--text-main);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 1rem;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-submit:hover {
            background-color: #000000;
            transform: translateY(-2px);
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1), 0 8px 10px -6px rgba(0, 0, 0, 0.1);
        }

        .btn-submit:active {
            transform: translateY(0);
        }

        .alert {
            padding: 1rem 1.25rem;
            border-radius: 12px;
            margin-bottom: 1.5rem;
            font-size: 0.95rem;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .alert-success {
            background-color: var(--success-bg);
            color: var(--success-text);
            border: 1px solid #bbf7d0;
        }

        .alert-danger {
            background-color: var(--error-bg);
            color: var(--error-text);
            border: 1px solid #fecaca;
        }

        .footer-link {
            text-align: center;
            margin-top: 2rem;
            font-size: 0.95rem;
            color: var(--text-muted);
        }

        .footer-link a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 600;
            transition: color 0.2s ease;
        }

        .footer-link a:hover {
            color: var(--primary-hover);
        }

        /* Responsive */
        @media (max-width: 900px) {
            .layout-left {
                display: none;
            }
        }
    </style>
</head>
<body>

<div class="split-layout">
    <!-- Left Side: Branding -->
    <div class="layout-left">
        <div class="brand">
            <div class="brand-logo">
                <span class="brand-icon">✦</span>
                Sunrise
            </div>
        </div>
        
        <div class="hero-text">
            <h1 class="hero-title">Redefining<br><span>Dental Care</span><br>Management.</h1>
            <p class="hero-subtitle">Access your schedule, manage patient records, and streamline clinic operations all from one secure portal.</p>
        </div>
        
        <div class="brand" style="color: #64748b; font-size: 0.9rem;">
            &copy; 2026 Sunrise Dental Clinic. All rights reserved.
        </div>
    </div>

    <!-- Right Side: Login Form -->
    <div class="layout-right">
        <div class="login-container">
            <div class="header">
                <h2 class="title">Welcome back</h2>
                <p class="subtitle">Please enter your details to sign in.</p>
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

            <form action="${pageContext.request.contextPath}/login" method="POST">
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" class="form-control" required placeholder="Enter your username" autofocus autocomplete="username">
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" class="form-control" required placeholder="••••••••" autocomplete="current-password">
                </div>

                <button type="submit" class="btn-submit">
                    Sign In
                    <svg width="18" height="18" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 5l7 7m0 0l-7 7m7-7H3"></path></svg>
                </button>
            </form>

            <div class="footer-link">
                Don't have an account? <a href="${pageContext.request.contextPath}/register">Register here</a>
            </div>
        </div>
    </div>
</div>

</body>
</html>