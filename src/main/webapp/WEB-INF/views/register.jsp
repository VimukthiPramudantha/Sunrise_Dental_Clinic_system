<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dentist Sign Up - Sunrise Dental</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #0d9488;
            --primary-hover: #0f766e;
            --secondary: #5eead4;
            --bg-body: #f0fdf9;
            --surface: #ffffff;
            --text-main: #0f172a;
            --text-muted: #64748b;
            --border: #e2e8f0;
            --bg-input: #f1f5f9;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Outfit', sans-serif; }

        body {
            background-color: var(--bg-body);
            min-height: 100vh;
            display: flex;
        }

        /* Left Panel */
        .layout-left {
            width: 42%;
            background: linear-gradient(160deg, #0f766e 0%, #134e4a 100%);
            color: white;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: 3rem;
            position: relative;
            overflow: hidden;
        }

        .layout-left::before {
            content: '';
            position: absolute;
            bottom: -80px;
            left: -80px;
            width: 350px;
            height: 350px;
            background: rgba(94, 234, 212, 0.08);
            border-radius: 50%;
        }

        .layout-left::after {
            content: '';
            position: absolute;
            top: -60px;
            right: -60px;
            width: 280px;
            height: 280px;
            background: rgba(94, 234, 212, 0.06);
            border-radius: 50%;
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 0.6rem;
            font-size: 1.4rem;
            font-weight: 700;
            text-decoration: none;
            color: white;
        }

        .brand-icon { font-size: 1.75rem; color: var(--secondary); }

        .hero-text { position: relative; z-index: 1; }

        .hero-title {
            font-size: 2.4rem;
            font-weight: 700;
            line-height: 1.2;
            margin-bottom: 1.25rem;
        }

        .hero-title span { color: var(--secondary); }

        .hero-subtitle { color: #99f6e4; font-size: 1rem; line-height: 1.7; max-width: 320px; }

        .feature-list { list-style: none; margin-top: 2rem; display: flex; flex-direction: column; gap: 0.75rem; }

        .feature-item {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            color: #ccfbf1;
            font-size: 0.95rem;
        }

        .feature-item::before {
            content: '✦';
            color: var(--secondary);
            font-size: 0.7rem;
        }

        .copyright { color: #5eead4; font-size: 0.85rem; opacity: 0.7; position: relative; z-index: 1; }

        /* Right Panel */
        .layout-right {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 3rem 2rem;
        }

        .form-container { width: 100%; max-width: 440px; }

        .role-banner {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            background: #f0fdf4;
            border: 1px solid #bbf7d0;
            border-radius: 12px;
            padding: 1rem 1.25rem;
            margin-bottom: 2rem;
        }

        .role-banner-icon { font-size: 2rem; }

        .role-banner-text strong {
            display: block;
            color: #064e3b;
            font-size: 1rem;
            font-weight: 700;
        }

        .role-banner-text span {
            color: #065f46;
            font-size: 0.85rem;
        }

        .form-header { margin-bottom: 2rem; }

        .form-header h1 {
            font-size: 1.85rem;
            font-weight: 700;
            color: var(--text-main);
            margin-bottom: 0.4rem;
        }

        .form-header p { color: var(--text-muted); font-size: 0.95rem; }

        /* Alerts */
        .alert {
            padding: 1rem 1.25rem;
            border-radius: 10px;
            margin-bottom: 1.5rem;
            font-size: 0.9rem;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .alert-danger { background: #fef2f2; color: #b91c1c; border: 1px solid #fecaca; }
        .alert-success { background: #f0fdf4; color: #15803d; border: 1px solid #bbf7d0; }

        /* Form */
        .form-group { margin-bottom: 1.25rem; }

        .form-group label {
            display: block;
            font-size: 0.9rem;
            font-weight: 500;
            color: var(--text-main);
            margin-bottom: 0.45rem;
        }

        .form-control {
            width: 100%;
            padding: 0.875rem 1.25rem;
            font-size: 1rem;
            color: var(--text-main);
            background-color: var(--bg-input);
            border: 1px solid transparent;
            border-radius: 10px;
            outline: none;
            transition: all 0.2s ease;
            font-family: 'Outfit', sans-serif;
        }

        .form-control:focus {
            background: white;
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(13, 148, 136, 0.12);
        }

        .password-wrapper { position: relative; }

        .password-wrapper .form-control { padding-right: 3rem; }

        .toggle-password {
            position: absolute;
            right: 1rem;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            cursor: pointer;
            color: var(--text-muted);
            display: flex;
            align-items: center;
            padding: 0;
        }

        .toggle-password:hover { color: var(--primary); }

        .password-strength { display: flex; gap: 4px; height: 4px; margin-top: 0.5rem; }

        .strength-bar { flex: 1; border-radius: 2px; background-color: var(--border); transition: background-color 0.3s; }

        .strength-label { font-size: 0.8rem; color: var(--text-muted); margin-top: 0.35rem; }

        /* Hidden role input */
        input[name="role"] { display: none; }

        /* Submit Button */
        .btn-submit {
            width: 100%;
            padding: 1rem;
            background-color: var(--primary);
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
            background-color: var(--primary-hover);
            transform: translateY(-2px);
            box-shadow: 0 10px 20px -5px rgba(13, 148, 136, 0.35);
        }

        .form-footer {
            text-align: center;
            margin-top: 1.5rem;
            font-size: 0.9rem;
            color: var(--text-muted);
        }

        .form-footer a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 600;
        }

        .form-footer a:hover { text-decoration: underline; }

        @media (max-width: 768px) {
            .layout-left { display: none; }
            .layout-right { padding: 2rem 1.5rem; }
        }
    </style>
</head>
<body>

    <%-- Left Decorative Panel --%>
    <div class="layout-left">
        <a href="${pageContext.request.contextPath}/login" class="brand">
            <span class="brand-icon">✦</span>
            Sunrise Dental
        </a>

        <div class="hero-text">
            <h1 class="hero-title">Join Our<br><span>Dental</span><br>Team.</h1>
            <p class="hero-subtitle">Register as a practising dentist and gain access to your appointments, patient schedules, and clinical records.</p>
            <ul class="feature-list">
                <li class="feature-item">View your daily appointment schedule</li>
                <li class="feature-item">Access patient treatment histories</li>
                <li class="feature-item">Coordinate with reception in real-time</li>
                <li class="feature-item">Secure, role-protected access</li>
            </ul>
        </div>

        <div class="copyright">&copy; 2026 Sunrise Dental Clinic. All rights reserved.</div>
    </div>

    <%-- Right Sign-Up Panel --%>
    <div class="layout-right">
        <div class="form-container">

            <%-- Dentist Role Banner --%>
            <div class="role-banner">
                <div class="role-banner-icon">🦷</div>
                <div class="role-banner-text">
                    <strong>Dentist Account Registration</strong>
                    <span>Your account will be registered with Dentist-level access.</span>
                </div>
            </div>

            <div class="form-header">
                <h1>Create your account</h1>
                <p>Fill in your details to get started at Sunrise Dental.</p>
            </div>

            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger">
                    <svg width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                    <c:out value="${errorMessage}"/>
                </div>
            </c:if>

            <c:if test="${not empty successMessage}">
                <div class="alert alert-success">
                    <svg width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path></svg>
                    <c:out value="${successMessage}"/>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/register" method="POST">
                <%-- Hidden field forces role to DENTIST --%>
                <input type="hidden" name="role" value="DENTIST">

                <div class="form-group">
                    <label for="fullName">Full Name</label>
                    <input type="text" id="fullName" name="fullName" class="form-control" placeholder="e.g. Dr. Kasun Perera" required autofocus autocomplete="off">
                </div>

                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" class="form-control" placeholder="e.g. kasun_p" required autocomplete="off">
                </div>

                <div class="form-group">
                    <label for="password">Password <span style="color: var(--text-muted); font-weight: 400;">(min. 6 characters)</span></label>
                    <div class="password-wrapper">
                        <input type="password" id="password" name="password" class="form-control" required minlength="6" placeholder="••••••••" oninput="checkStrength(this.value)">
                        <button type="button" class="toggle-password" onclick="togglePassword()">
                            <svg width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path></svg>
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
                    Register as Dentist
                    <svg width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18 9v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z"></path></svg>
                </button>
            </form>

            <p class="form-footer">
                Already have an account? <a href="${pageContext.request.contextPath}/login">Sign in here</a>
            </p>
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

            const colors = ['#ef4444', '#f59e0b', '#10b981', '#0d9488'];
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