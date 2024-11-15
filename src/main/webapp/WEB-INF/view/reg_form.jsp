<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Registration - Contact Application</title>
    <s:url var="url_css" value="/static/css/style.css"/>
    <link href="${url_css}" rel="stylesheet" type="text/css"/>
    <s:url var="url_jqlib" value="/static/js/jquery-3.2.1.min.js" />
    <script src="${url_jqlib}"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);

            min-height: 100vh;
            line-height: 1.6;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            margin: 20px auto;
        }

        .header {
            background: #2c3e50;
            color: white;
            padding: 20px;
            text-align: center;
        }

        .menu {
            background: #34495e;
            color: white;
            padding: 10px;
        }

        .content {
            padding: 30px;
            background: white;
        }

        .footer {
            background: #2c3e50;
            color: white;
            padding: 10px;
            text-align: center;
        }

        h3 {
            color: #2c3e50;
            margin-bottom: 25px;
            text-align: center;
            font-size: 24px;
            font-weight: 600;
        }

        .form-container {
            max-width: 600px;
            margin: 0 auto;
            background: #f8f9fa;
            padding: 30px;
            border-radius: 8px;
        }

        .form-group {
            margin-bottom: 20px;
            animation: fadeIn 0.5s ease-out forwards;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #2c3e50;
            font-weight: 500;
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e1e1e1;
            border-radius: 5px;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: #3498db;
            outline: none;
            box-shadow: 0 0 5px rgba(52, 152, 219, 0.3);
        }

        textarea.form-control {
            min-height: 100px;
            resize: vertical;
        }

        select.form-control {
            background-color: white;
            cursor: pointer;
        }

        .btn-submit {
            background-color: #3498db;
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 500;
            transition: background-color 0.3s ease;
            width: 100%;
            margin-top: 20px;
        }

        .btn-submit:hover {
            background-color: #2980b9;
        }

        .error {
            background-color: #ffebee;
            color: #c62828;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                padding: 10px;
            }

            .form-container {
                padding: 20px;
            }

            .content {
                padding: 20px;
            }
        }

        @media (max-width: 480px) {
            .form-container {
                padding: 15px;
            }

            .btn-submit {
                padding: 10px 20px;
            }
        }
    </style>



    <script>
            function validateForm() {
                const email = document.querySelector('input[name="user.email"]').value;
                const password = document.querySelector('input[name="user.password"]').value;
                const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/; // Basic email pattern
                const passwordMinLength = 6; // Minimum password length

                let valid = true;
                let errorMessage = '';

                // Validate email
                if (!emailPattern.test(email)) {
                    valid = false;
                    errorMessage += 'Please enter a valid email address.\n';
                }

                // Validate password
                if (password.length < passwordMinLength) {
                    valid = false;
                    errorMessage += `Password must be at least ${passwordMinLength} characters long.\n`;
                }

                if (!valid) {
                    alert(errorMessage);
                }

                return valid; // Return false to prevent form submission if invalid
            }
        </script>



</head>
<body style="background-color:cyan;">
    <div class="container">
        <div class="card">
            <div class="header">
                <jsp:include page="include/header.jsp"/>
            </div>

            <div class="menu">
                <jsp:include page="include/menu.jsp"/>
            </div>

            <div class="content">
                <h3>User Registration</h3>

                <c:if test="${err!=null}">
                    <div class="error">${err}</div>
                </c:if>

                <div class="form-container">
                    <f:form action="register" modelAttribute="userCommand">
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

                        <button type="submit" class="btn-submit">Register</button>
                    </f:form>
                </div>
            </div>

            <div class="footer">
                <jsp:include page="include/footer.jsp"/>
            </div>
        </div>
    </div>




</body>
</html>