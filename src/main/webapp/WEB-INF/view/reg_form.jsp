<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html data-theme="light">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>User Registration - Online Home Decor</title>
        <link rel="icon" type="image/svg+xml" href="https://img.icons8.com/cute-clipart/64/home.png">

        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@600;700&display=swap" rel="stylesheet">
        <style>
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
                padding-top: 80px; /* Added to account for fixed header */
            }

            body::before {
                content: '';
                position: fixed; /* Changed to fixed */
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
                top: 16px;
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
                z-index: 1001;
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
                max-width: 1200px;
                border-radius: 24px;
                box-shadow: 0 20px 25px -5px var(--shadow);
                overflow: hidden;
                position: relative;
                backdrop-filter: blur(10px);
                z-index: 1;
                border: 1px solid var(--border);
                margin-top: 20px; /* Adjusted for fixed header */
            }

            .header {
                background: var(--header-bg);
                padding: 20px;
                text-align: center;
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                z-index: 1000;
                box-shadow: 0 2px 10px var(--shadow);
            }

            .header h1 {
                color: white;
                font-size: 28px;
                font-weight: 600;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 12px;
                font-family: 'Poppins', sans-serif;
                max-width: 1200px;
                margin: 0 auto;
            }

            .content {
                padding: 40px;
                background: var(--card-bg);
                position: relative;
                z-index: 1;
            }

            .form-container {
                max-width: 600px;
                margin: 0 auto;
                animation: fadeInScale 0.8s ease-out;
            }

            .form-group {
                margin-bottom: 24px;
                position: relative;
            }

            .form-group label {
                display: block;
                margin-bottom: 8px;
                color: var(--text-primary);
                font-weight: 500;
                font-size: 14px;
            }

            .form-group input,
            .form-group textarea,
            .form-group select {
                width: 100%;
                padding: 14px;
                border: 1px solid var(--border);
                border-radius: 12px;
                font-size: 14px;
                color: var(--text-primary);
                background: var(--input-bg);
                transition: all 0.3s ease;
            }

            .form-group input:focus,
            .form-group textarea:focus,
            .form-group select:focus {
                outline: none;
                border-color: var(--primary);
                box-shadow: 0 0 0 4px rgba(124, 58, 237, 0.1);
            }

            textarea.form-control {
                min-height: 100px;
                resize: vertical;
            }

            .btn-submit {
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
                transition: all 0.3s ease;
            }

            .btn-submit:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 15px var(--shadow);
            }

            .error {
                background-color: var(--error);
                color: white;
                padding: 12px;
                border-radius: 12px;
                margin-bottom: 20px;
                display: flex;
                align-items: center;
                gap: 8px;
                font-size: 14px;
            }

            .footer {
                text-align: center;
                padding: 24px;
                color: var(--text-secondary);
                border-top: 1px solid var(--border);
                background: var(--card-bg);
            }

            @keyframes fadeInScale {
                0% { opacity: 0; transform: scale(0.95); }
                100% { opacity: 1; transform: scale(1); }
            }

            @media (max-width: 768px) {
                .main-container {
                    margin: 10px;
                    border-radius: 16px;
                }

                .content {
                    padding: 20px;
                }

                .header {
                    padding: 15px;
                }

                .header h1 {
                    font-size: 24px;
                }
            }

            @media (max-width: 480px) {
                .content {
                    padding: 15px;
                }

                .btn-submit {
                    padding: 12px;
                }
            }

            /* Success message styles */
            .success {
                background-color: var(--success);
                color: white;
                padding: 16px;
                border-radius: 12px;
                margin-bottom: 20px;
                display: flex;
                align-items: center;
                gap: 12px;
                font-size: 14px;
                animation: slideDown 0.5s ease-out;
            }

            .success .material-icons {
                font-size: 20px;
            }

            @keyframes slideDown {
                0% {
                    opacity: 0;
                    transform: translateY(-20px);
                }
                100% {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
        </style>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <script>
        // Add this to your existing script section
        document.addEventListener('DOMContentLoaded', function() {
            // Auto-hide success message after 5 seconds
            const successMessage = document.querySelector('.success');
            if (successMessage) {
                setTimeout(function() {
                    successMessage.style.transition = 'opacity 0.5s ease-out';
                    successMessage.style.opacity = '0';
                    setTimeout(function() {
                        successMessage.style.display = 'none';
                    }, 500);
                }, 5000);
            }
        });
        </script>
        <script>
                    $(document).ready(function (){


                        // Live validation
                        function validateField(field, validationFunc) {
                            const value = $(field).val();
                            const errorDiv = $(field).next('.error');
                            errorDiv.remove(); // Clear previous error message

                            const errorMessage = validationFunc(value);
                            if (errorMessage) {
                                $(field).after('<div class="error" style="color: white; margin-top: 5px; font-weight: 500;">' + errorMessage + '</div>');
                                return false;
                            }
                            return true;
                        }

                        // Validation functions
                        function validateName(name) {
                            if (name.trim() === "") {
                                return "Name is required.";
                            }
                            if (!/^[A-Za-z\s]+$/.test(name)) {
                                return "Name can only contain letters and spaces.";
                            }
                            return null;
                        }


                        function validateEmail(email) {
                            if (email.trim() === "") {
                                return "Email is required.";
                            }
                            const validDomainPattern = /^[a-zA-Z0-9._%+-]+@(yash\.com|gmail\.com)$/;
                            if (!validDomainPattern.test(email)) {
                                return "Email must be from either yash.com or gmail.com domain.";
                            }
                            return null;
                        }



                        function validatePassword(password) {
                            console.log("password::" , password);
                            if (password.trim() === "") {
                                return "Password is required.";
                            }

                            const minLength = 6;
                            const hasUpperCase = /[A-Z]/.test(password);
                            const hasLowerCase = /[a-z]/.test(password);
                            const hasNumbers = /\d/.test(password);
                            const hasSpecialChar = /[!@#$%^&*(),.?":{}|<>]/.test(password);

                            let errors = [];

                            if (password.length < minLength) {
                                errors.push("at least 6 characters");
                            }
                            if (!hasUpperCase) {
                                errors.push("one uppercase letter");
                            }
                            if (!hasLowerCase) {
                                errors.push("one lowercase letter");
                            }
                            if (!hasNumbers) {
                                errors.push("one number");
                            }
                            if (!hasSpecialChar) {
                                errors.push("one special character");
                            }

                            if (errors.length > 0) {
                                return "Password must contain " + errors.join(", ");
                            }

                            return null;
                        }

                        function validateAddress(address) {
                            if (address.trim() === "") {
                                return "Address is required.";
                            }
                            return null;
                        }



                        // Add password strength indicator
                        function updatePasswordStrength(password) {
                            const strengthIndicator = $("#password-strength");
                            if (!strengthIndicator.length) {
                                $("input[name='user.password']").after('<div id="password-strength" style="margin-top: 5px;"></div>');
                            }
                        }



                        // Prevent numeric input in name field
                        $("input[name='user.name']").on('keypress', function(e) {
                            var char = String.fromCharCode(e.which);
                            if (!/^[A-Za-z\s]$/.test(char)) {
                                e.preventDefault();
                            }
                        });

                        // Attach keyup event for live validation
                        $("input[name='user.name']").on('keyup', function() {
                            validateField(this, validateName);
                        });



                        $("input[name='user.email']").on('keyup', function() {
                            validateField(this, validateEmail);
                        });

                        $("textarea[name='user.address']").on('keyup', function() {
                            validateField(this, validateAddress);
                        });

                        $("input[name='user.password']").on('keyup', function() {
                            validateField(this, validatePassword);
                        });

                        // Add requirement notes under password field

                        // Form submission validation
                        $("form").submit(function(event) {
                            let isValid = true;

                            // Validate all fields
                            isValid &= validateField($("input[name='user.name']"), validateName);

                            isValid &= validateField($("input[name='user.email']"), validateEmail);

                            isValid &= validateField($("textarea[name='user.address']"), validateAddress);


                            if (!isValid) {
                                event.preventDefault(); // Prevent form submission
                            }
                        });
                    });
                   </script>

    </head>
    <body>
        <!-- Theme Toggle Button -->
        <button class="theme-toggle" onclick="toggleTheme()" aria-label="Toggle theme">
            <span class="material-icons">dark_mode</span>
        </button>



        <!-- Fixed Header -->
        <div class="header">
            <h1>
                <span class="material-icons">how_to_reg</span>
                User Registration

                <a href="<s:url value="/"/>" class="home-button" style="position: absolute; left: 20px; color: white; text-decoration: none;">
                                    <span class="material-icons">home</span>
                                    Home
                </a>
            </h1>


        </div>

        <div class="main-container">
            <div class="content">
               <!-- Add this temporarily at the top of your content div for debugging -->
               <div style="display: none">
                   Debug - Success Message: ${successMessage}
                   Debug - Error Message: ${err}
               </div>
                        <!-- Success Message -->
                        <c:if test="${not empty successMessage}">
                            <div class="success" style="margin-bottom: 20px;">
                                <span class="material-icons">check_circle</span>
                                <span>${successMessage}</span>
                            </div>
                        </c:if>

                        <!-- Error Message -->
                        <c:if test="${not empty err}">
                            <div class="error" style="margin-bottom: 20px;">
                                <span class="material-icons">error_outline</span>
                                <span>${err}</span>
                            </div>
                        </c:if>



                <div class="form-container">
                    <f:form action="register" modelAttribute="userCommand" onsubmit="return validateForm()">
                        <div class="form-group">
                            <label for="name">Name</label>
                            <f:input path="user.name" cssClass="form-control" />
                        </div>

                        <div class="form-group">
                            <label for="email">Email</label>
                            <f:input path="user.email" cssClass="form-control" />
                        </div>

                        <div class="form-group">
                            <label for="address">Address</label>
                            <f:textarea path="user.address" cssClass="form-control" />
                        </div>

                        <div class="form-group">
                            <label for="password">Password</label>
                            <f:password path="user.password" cssClass="form-control" />
                        </div>

                        <div class="form-group">
                            <label for="role">Role</label>
                            <f:select path="user.role" cssClass="form-control">
                                <f:option value="BUYER">Buyer</f:option>
                                <f:option value="SELLER">Seller</f:option>
                            </f:select>
                        </div>

                        <button type="submit" class="btn-submit">
                            <span class="material-icons">person_add</span>
                            Register
                        </button>
                    </f:form>
                </div>
            </div>
            <!----------Suceess message-----------!>
            <div>
            <c:if test="${successMessage != null}">
                            <div class="success">
                                <span class="material-icons">check_circle</span>
                                ${successMessage}
                            </div>
                        </c:if>

                        <!-- Existing error message -->
                        <c:if test="${err != null}">
                            <div class="error">
                                <span class="material-icons">error_outline</span>
                                ${err}
                            </div>
                        </c:if>
            <div class="footer">
                © [2024-2025] Copyrights by Yash TECHNOLOGIES | All Rights Reserved
            </div>
        </div>

        <script>
            // Theme toggle functionality
            function toggleTheme() {
                const html = document.documentElement;
                const theme = html.getAttribute('data-theme');
                const newTheme = theme === 'light' ? 'dark' : 'light';
                html.setAttribute('data-theme', newTheme);

                // Update theme toggle icon
                const icon = document.querySelector('.theme-toggle .material-icons');
                icon.textContent = newTheme === 'light' ? 'dark_mode' : 'light_mode';

                // Save theme preference
                localStorage.setItem('theme', newTheme);
            }

            // Set initial theme based on user preference
            document.addEventListener('DOMContentLoaded', () => {
                const savedTheme = localStorage.getItem('theme') || 'light';
                document.documentElement.setAttribute('data-theme', savedTheme);
                const icon = document.querySelector('.theme-toggle .material-icons');
                icon.textContent = savedTheme === 'light' ? 'dark_mode' : 'light_mode';
            });


        </script>
    </body>
</html>