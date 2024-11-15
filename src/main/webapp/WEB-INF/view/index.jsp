<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Online Home Decor</title>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Poppins', sans-serif;
            }

            body {
                background: linear-gradient(135deg, #00ffff 0%, #00bfff 100%);
                min-height: 100vh;
                display: flex;
                flex-direction: column;
                align-items: center;
                padding: 20px;
            }

            .main-container {
                background: rgba(255, 255, 255, 0.95);
                width: 90%;
                max-width: 1200px;
                margin: 20px auto;
                border-radius: 20px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                overflow: hidden;
                animation: containerFadeIn 0.8s ease-out;
            }

            @keyframes containerFadeIn {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .header {
                background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%);
                padding: 25px 40px;
                border-bottom: 1px solid rgba(0, 0, 0, 0.1);
                text-align: center;
            }

            .header h1 {
                font-size: 32px;
                color: #2c3e50;
                font-weight: 600;
                text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.1);
                letter-spacing: 0.5px;
            }

            .content {
                padding: 40px;
                display: flex;
                flex-direction: column;
                align-items: center;
                background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%);
            }

            .login-container {
                background: white;
                padding: 40px;
                border-radius: 15px;
                width: 100%;
                max-width: 450px;
                box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
                animation: loginFadeIn 1s ease-out;
            }

            @keyframes loginFadeIn {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .login-container h2 {
                color: #2c3e50;
                margin-bottom: 30px;
                font-size: 28px;
                text-align: center;
                font-weight: 600;
                position: relative;
                padding-bottom: 10px;
            }

            .login-container h2::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 50%;
                transform: translateX(-50%);
                width: 50px;
                height: 3px;
                background: linear-gradient(to right, #00ffff, #00bfff);
                border-radius: 2px;
            }

            .form-group {
                margin-bottom: 25px;
                position: relative;
            }

            .form-group label {
                display: block;
                margin-bottom: 8px;
                color: #34495e;
                font-weight: 500;
                font-size: 0.95rem;
            }

            .form-group input {
                width: 100%;
                padding: 15px;
                border: 2px solid #e1e8ed;
                border-radius: 10px;
                font-size: 16px;
                transition: all 0.3s ease;
                background: #f8f9fa;
            }

            .form-group input:focus {
                border-color: #00bfff;
                outline: none;
                box-shadow: 0 0 0 4px rgba(0, 191, 255, 0.1);
                background: white;
            }

            .login-btn {
                width: 100%;
                padding: 15px;
                background: linear-gradient(135deg, #00bfff 0%, #0099ff 100%);
                color: white;
                border: none;
                border-radius: 10px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                text-transform: uppercase;
                letter-spacing: 1px;
                box-shadow: 0 4px 15px rgba(0, 191, 255, 0.2);
            }

            .login-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(0, 191, 255, 0.3);
                background: linear-gradient(135deg, #0099ff 0%, #0077ff 100%);
            }

            .login-btn:active {
                transform: translateY(0);
            }

            .register-link {
                text-align: center;
                margin-top: 25px;
                padding-top: 20px;
                border-top: 1px solid #e1e8ed;
            }

            .register-link a {
                color: #00bfff;
                text-decoration: none;
                font-weight: 500;
                transition: all 0.3s ease;
                position: relative;
            }

            .register-link a:hover {
                color: #0077ff;
            }

            .register-link a::after {
                content: '';
                position: absolute;
                width: 100%;
                height: 2px;
                bottom: -4px;
                left: 0;
                background: linear-gradient(to right, #00bfff, #0077ff);
                transform: scaleX(0);
                transition: transform 0.3s ease;
            }

            .register-link a:hover::after {
                transform: scaleX(1);
            }

            .error, .success {
                padding: 15px;
                border-radius: 10px;
                margin-bottom: 25px;
                font-size: 0.95rem;
                animation: messageFadeIn 0.5s ease-out;
            }

            @keyframes messageFadeIn {
                from {
                    opacity: 0;
                    transform: translateY(-10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .error {
                color: #dc3545;
                background: #ffe6e6;
                border: 1px solid #ffcccc;
            }

            .success {
                color: #28a745;
                background: #e6ffe6;
                border: 1px solid #ccffcc;
            }

            .footer {
                text-align: center;
                padding: 25px;
                color: #576574;
                background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%);
                border-top: 1px solid rgba(0, 0, 0, 0.1);
                font-size: 0.9rem;
            }

            @media (max-width: 768px) {
                .main-container {
                    width: 95%;
                    margin: 10px auto;
                }

                .header {
                    padding: 20px;
                }

                .header h1 {
                    font-size: 24px;
                }

                .content {
                    padding: 20px;
                }

                .login-container {
                    padding: 25px;
                }
            }

            /* Additional decorative elements */
            .decorative-shape {
                position: absolute;
                background: linear-gradient(135deg, rgba(0, 255, 255, 0.1) 0%, rgba(0, 191, 255, 0.1) 100%);
                border-radius: 50%;
                z-index: -1;
            }

            .shape1 {
                width: 200px;
                height: 200px;
                top: -100px;
                right: -100px;
            }

            .shape2 {
                width: 150px;
                height: 150px;
                bottom: -75px;
                left: -75px;
            }
        </style>
    </head>
    <body>



        <div class="main-container">
            <div class="decorative-shape shape1"></div>
            <div class="decorative-shape shape2"></div>

            <header class="header">
                <h1> Online Home Decor</h1>
            </header>

            <main class="content">
                <div class="login-container">
                    <h2>Welcome</h2>

                    <c:if test="${err!=null}">
                        <div class="error">
                            <i class="fas fa-exclamation-circle"></i> ${err}
                        </div>
                    </c:if>
                    <c:if test="${param.act eq 'lo'}">
                        <div class="success">
                            <i class="fas fa-check-circle"></i> Logout Successfully! Thanks for using our application.
                        </div>
                    </c:if>
                    <c:if test="${param.act eq 'reg'}">
                        <div class="success">
                            <i class="fas fa-check-circle"></i> Registration Successful! Please login to continue.
                        </div>
                    </c:if>

                    <f:form action="login" modelAttribute="command">
                        <div class="form-group">
                            <label>Username</label>
                            <f:input path="loginName" placeholder="Enter your username"/>
                        </div>
                        <div class="form-group">
                            <label>Password</label>
                            <f:password path="password" placeholder="Enter your password"/>
                        </div>
                        <button type="submit" class="login-btn">Sign In</button>
                        <div class="register-link">
                            <a href="<s:url value="/reg_form"/>">Create New Account</a>
                        </div>
                    </f:form>
                </div>
            </main>

            <footer class="footer">
                ©[2024-2025] Copyrights by Yash TECHNOLOGIES | All Rights Reserved
            </footer>
        </div>
    </body>
</html>