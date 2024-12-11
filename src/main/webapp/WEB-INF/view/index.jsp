<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html data-theme="light">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Online Home Decor</title>
        <link rel="icon" type="image/svg+xml" href="https://img.icons8.com/cute-clipart/64/home.png">

        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@600;700&display=swap" rel="stylesheet">
        <style>
            /* [Previous root styles remain the same] */
            :root[data-theme="light"] {
                --primary: #7C3AED;
                --primary-dark: #6D28D9;
                --bg-primary: #F8F7FF;
                --bg-secondary: #FFFFFF;
                --text-primary: #2D3748;
                --text-secondary: #4A5568;
                --accent: #F59E0B;
                --success: #10B981;
                --error: #EF4444;
                --border: #E2E8F0;
                --card-bg: rgba(255, 255, 255, 0.95);
                --header-bg: linear-gradient(to right, #7C3AED, #6D28D9);
                --input-bg: #FFFFFF;
                --shadow: rgba(0, 0, 0, 0.1);
            }

            :root[data-theme="dark"] {
                --primary: #9F7AEA;
                --primary-dark: #805AD5;
                --bg-primary: #1A202C;
                --bg-secondary: #2D3748;
                --text-primary: #F7FAFC;
                --text-secondary: #E2E8F0;
                --accent: #F6AD55;
                --success: #68D391;
                --error: #FC8181;
                --border: #4A5568;
                --card-bg: rgba(45, 55, 72, 0.95);
                --header-bg: linear-gradient(to right, #6B46C1, #553C9A);
                --input-bg: #2D3748;
                --shadow: rgba(0, 0, 0, 0.3);
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Inter', sans-serif;
                transition: background-color 0.3s, color 0.3s, border-color 0.3s;
            }

            body {
                background: var(--bg-primary);
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 20px;
                position: relative;
                color: var(--text-primary);
            }

            body::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: linear-gradient(45deg,
                    rgba(124, 58, 237, 0.1) 0%,
                    rgba(159, 122, 234, 0.1) 100%);
                z-index: 0;
            }

            .theme-toggle {
                position: fixed;
                top: 20px;
                right: 20px;
                background: var(--card-bg);
                border: 1px solid var(--border);
                border-radius: 50%;
                width: 45px;
                height: 45px;
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
                box-shadow: 0 2px 8px var(--shadow);
                z-index: 1000;
                transition: transform 0.3s ease;
            }

            .theme-toggle:hover {
                transform: scale(1.1);
            }

            .theme-toggle .material-icons {
                color: var(--primary);
                font-size: 24px;
            }

            .main-container {
                background: var(--card-bg);
                width: 100%;
                max-width: 480px;
                border-radius: 24px;
                box-shadow: 0 20px 25px -5px var(--shadow);
                overflow: hidden;
                position: relative;
                backdrop-filter: blur(10px);
                z-index: 1;
                border: 1px solid var(--border);
            }

            .header {
                background: var(--header-bg);
                padding: 28px;
                text-align: center;
                position: relative;
            }

            .header h1 {
                color: white;
                font-size: 24px;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 12px;
                font-family: 'Poppins', sans-serif;
            }

            .content {
                padding: 40px;
                background: var(--card-bg);
            }

            .login-container {
                width: 100%;
                max-width: 400px;
                margin: 0 auto;
            }

            .welcome-back {
                font-family: 'Poppins', sans-serif;
                font-size: 28px;
                font-weight: 700;
                color: var(--primary);
                text-align: center;
                margin-bottom: 30px;
                background: linear-gradient(120deg, var(--primary) 0%, var(--accent) 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                animation: fadeInScale 0.8s ease-out;
            }

            .form-group {
                margin-bottom: 24px;
            }

            .label-with-icon {
                display: flex;
                align-items: center;
                gap: 8px;
                margin-bottom: 8px;
                color: var(--text-secondary);
                font-weight: 500;
            }

            .label-with-icon .material-icons {
                font-size: 20px;
                color: var(--primary);
            }

            .form-group input {
                width: 100%;
                padding: 14px;
                border: 1px solid var(--border);
                border-radius: 12px;
                font-size: 14px;
                color: var(--text-primary);
                background: var(--input-bg);
                transition: all 0.3s ease;
            }

            .form-group input:focus {
                outline: none;
                border-color: var(--primary);
                box-shadow: 0 0 0 4px rgba(124, 58, 237, 0.1);
            }

            .login-btn {
                width: 100%;
                padding: 14px;
                background: var(--header-bg);
                color: white;
                border: none;
                border-radius: 12px;
                font-size: 16px;
                font-weight: 500;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 8px;
                margin-bottom: 20px;
                transition: all 0.3s ease;
            }

            .login-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 15px var(--shadow);
            }

            .register-link {
                text-align: center;
                margin-top: 20px;
            }

            .register-link a {
                color: var(--primary);
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 8px;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .register-link a:hover {
                color: var(--primary-dark);
            }

            .error, .success {
                padding: 12px;
                border-radius: 12px;
                margin-bottom: 20px;
                display: flex;
                align-items: center;
                gap: 8px;
                font-size: 14px;
            }

            .error {
                background-color: var(--error);
                color: white;
            }

            .success {
                background-color: var(--success);
                color: red;
                border-left: 5px solid #2e7d32
            }

            .footer {
                text-align: center;
                padding: 24px;
                color: var(--text-secondary);
                border-top: 1px solid var(--border);
                background: var(--card-bg);
                font-size: 14px;
            }

            @keyframes fadeInScale {
                0% { opacity: 0; transform: scale(0.95); }
                100% { opacity: 1; transform: scale(1); }
            }

            @media (max-width: 640px) {
                .main-container {
                    border-radius: 16px;
                    margin: 10px;
                }
                .content {
                    padding: 20px;
                }
                .welcome-back {
                    font-size: 24px;
                }

                 .form-group {
                                margin-bottom: 24px;
                            }

                            .radio-group {
                                display: flex;
                                gap: 24px;
                                margin-bottom: 24px;
                                padding: 16px;
                                background: var(--bg-primary);
                                border-radius: 12px;
                                border: 1px solid var(--border);
                            }

                            .radio-option {
                                display: flex;
                                align-items: center;
                                gap: 8px;
                                cursor: pointer;
                                padding: 8px 16px;
                                border-radius: 8px;
                                transition: all 0.3s ease;
                            }

                            .radio-option:hover {
                                background: var(--primary-dark);
                                color: white;
                            }

                            .radio-option input[type="radio"] {
                                width: 18px;
                                height: 18px;
                                margin: 0;
                                cursor: pointer;
                                accent-color: var(--primary);
                            }

                            .radio-option label {
                                font-weight: 500;
                                cursor: pointer;
                                user-select: none;
                            }





            }
        </style>
    </head>
    <body>
        <button class="theme-toggle" onclick="toggleTheme()" aria-label="Toggle theme">
            <span class="material-icons">dark_mode</span>
        </button>

        <div class="main-container">
            <header class="header">
                <h1>

                    <span class="material-icons">home</span>
                    Online Home Decor


                   <!-- <a href="<s:url value="/"/>" >
                                            <span class="material-icons">home</span>
                                            Home
                                        </a>--!>
                </h1>
            </header>

            <main class="content">
                <div class="login-container">
                    <h2 class="welcome-back">Sajae Sapno Ka Ashiyana</h2>

                    <c:if test="${err!=null}">
                        <div class="error">
                            <span class="material-icons">error_outline</span>
                            ${err}
                        </div>
                    </c:if>
                    <c:if test="${param.act eq 'lo'}">
                        <div class="success">
                            <span class="material-icons">check_circle_outline</span>
                            Logout Successfully! Thanks for using our application.
                        </div>
                    </c:if>
                      <div class="notification" id="notification">
                               <c:if test="${param.act eq 'reg'}">
                                   <p class="successMsg">Registered successfully</p>
                               </c:if>
                           </div>


                 <!--   <div class="radio-group">
                             <div class="radio-option">
                                      <input type="radio" id="buyer" name="userType" value="buyer" checked>
                                      <label for="buyer">Login as Buyer</label><input type="radio" id="seller" name="userType" value="seller">
                                                                                                                      <label for="seller">Login as Seller</label>
                                      </div>
                                      <div class="radio-option">

                             </div>
                    </div>-----!>

                    <f:form action="loginCheck" modelAttribute="command">
                        <div class="form-group">
                            <div class="label-with-icon">
                                <span class="material-icons">person_outline</span>
                                <label>Email</label>
                            </div>
                            <f:input path="loginName" placeholder="Enter your username"/>
                        </div>

                        <div class="form-group">
                            <div class="label-with-icon">
                                <span class="material-icons">lock_outline</span>
                                <label>Password</label>
                            </div>
                            <f:password path="password" placeholder="Enter your password"/>
                        </div>

                        <button type="submit" class="login-btn">
                            <span class="material-icons">login</span>
                            Sign In
                        </button>

                        <div class="register-link">
                            <a href="<s:url value="/reg_form"/>">
                                <span class="material-icons">person_add</span>
                                Create New Account
                            </a>
                        </div>
                    </f:form>
                </div>
            </main>

            <footer class="footer">
                 <p>&copy; 2024 Online Home Decor. All rights reserved.</p>
            </footer>
        </div>

        <script>
            function toggleTheme() {
                const html = document.documentElement;
                const theme = html.getAttribute('data-theme');
                const newTheme = theme === 'light' ? 'dark' : 'light';
                html.setAttribute('data-theme', newTheme);

                const icon = document.querySelector('.theme-toggle .material-icons');
                icon.textContent = newTheme === 'light' ? 'dark_mode' : 'light_mode';

                localStorage.setItem('theme', newTheme);
            }

            document.addEventListener('DOMContentLoaded', () => {
                const savedTheme = localStorage.getItem('theme') || 'light';
                document.documentElement.setAttribute('data-theme', savedTheme);
                const icon = document.querySelector('.theme-toggle .material-icons');
                icon.textContent = savedTheme === 'light' ? 'dark_mode' : 'light_mode';
            });
        </script>
    </body>
</html>