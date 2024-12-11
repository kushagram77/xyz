<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html data-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile - Online Home Decor</title>
    <link rel="icon" type="image/svg+xml" href="https://img.icons8.com/cute-clipart/64/home.png">

    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@600;700&display=swap" rel="stylesheet">
    <style>
        /* Reuse the theme and base styles from the dashboard page */
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
            color: var(--text-primary);
            padding-top: 80px;
            position: relative;
        }

        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(45deg,
                rgba(124, 58, 237, 0.1) 0%,
                rgba(159, 122, 234, 0.1) 100%);
            z-index: 0;
            pointer-events: none;
        }

        .header {
            background: var(--header-bg);
            padding: 1rem 2rem;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px var(--shadow);
        }

        .header h1 {
            color: white;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-family: 'Poppins', sans-serif;
            font-size: 1.5rem;
        }

        .profile-container {
            max-width: 600px;
            margin: 2rem auto;
            padding: 0 1rem;
            position: relative;
            z-index: 1;
        }

        .profile-card {
            background: var(--card-bg);
            border-radius: 16px;
            padding: 2rem;
            border: 1px solid var(--border);
            box-shadow: 0 4px 6px var(--shadow);
            backdrop-filter: blur(10px);
        }

        .profile-title {
            font-family: 'Poppins', sans-serif;
            font-size: 1.8rem;
            margin-bottom: 1.5rem;
            color: var(--primary);
            text-align: center;
        }

        .form-group {
            margin-bottom: 1rem;
        }

        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            color: var(--text-secondary);
            font-weight: 500;
        }

        .form-input {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid var(--border);
            border-radius: 8px;
            background: var(--input-bg);
            color: var(--text-primary);
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        .form-input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(124, 58, 237, 0.1);
        }

        .btn-primary {
            width: 100%;
            padding: 0.75rem;
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s, transform 0.3s;
            margin-top: 1rem;
        }

        .btn-primary:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
        }

        .error-message {
            color: var(--error);
            margin-bottom: 1rem;
            text-align: center;
        }

        .success-message {
            color: var(--success);
            margin-bottom: 1rem;
            text-align: center;
        }

        @media (max-width: 768px) {
            .profile-container {
                padding: 0 0.5rem;
            }
            .profile-card {
                padding: 1.5rem;
            }
        }

        /*for back to dashboard*/
                     .header-actions {
                       display: flex;
                       align-items: center;
                       gap: 12px;
                       margin-left: auto;
                     }

                     .back-dashboard-btn {
                       background: rgba(255, 255, 255, 0.2);
                       border: 1px solid rgba(255, 255, 255, 0.3);
                       color: white;
                       border-radius: 8px;
                       padding: 6px 12px;
                       display: inline-flex;
                       align-items: center;
                       gap: 6px;
                       text-decoration: none;
                       transition: all 0.3s ease;
                       font-size: 14px;
                     }

                     .back-dashboard-btn:hover {
                       background: rgba(255, 255, 255, 0.3);
                       transform: translateY(-1px);
                     }

                     .back-dashboard-btn .material-icons {
                       font-size: 18px;
                     }
                     .hidden-class {
                        color: var(--header-bg);
                     }





    </style>
</head>
<body>
    <header class="header">
        <h1>
            <span class="material-icons">account_circle</span>
            Edit Profile
        </h1>

        <!-- Back to Dashboard Button -->
                          <a href="${pageContext.request.contextPath}/xyz" class="back-dashboard-btn">
                            <span class="material-icons">arrow_back</span>
                            Back to Dashboard
                          </a>

    </header>

    <div class="profile-container">
        <f:form cssClass="profile-card" action="${pageContext.request.contextPath}/seller/profile/update" method="post" modelAttribute="user">
            <h2 class="profile-title">Update Your Profile</h2>

            <c:if test="${not empty errorMessage}">
                <div class="error-message">${errorMessage}</div>
            </c:if>

            <c:if test="${not empty successMessage}">
                <div class="success-message">${successMessage}</div>
            </c:if>

            <div class="form-group">
                <label class="form-label" for="name">Full Name</label>
                <f:input path="name" cssClass="form-input" required="true" />
            </div>

            <div class="form-group">
                <label class="form-label" for="email">Email Address</label>
                <f:input path="email" type="email" cssClass="form-input" required="true" />
            </div>


            <div class="form-group">
                <label class="form-label" for="address">Address</label>
                <f:textarea path="address" cssClass="form-input" rows="3" required="true"></f:textarea>
            </div>

            <div class="form-group">
                <label class="form-label" for="password">New Password (Optional)</label>
                <f:password path="password" cssClass="form-input" />
            </div>

            <button type="submit" class="btn-primary">Update Profile</button>
        </f:form>
    </div>

    <script>
        // Theme toggle script (same as in dashboard)
        function toggleTheme() {
            const html = document.documentElement;
            const theme = html.getAttribute('data-theme');
            const newTheme = theme === 'light' ? 'dark' : 'light';
            html.setAttribute('data-theme', newTheme);
            localStorage.setItem('theme', newTheme);
        }

        document.addEventListener('DOMContentLoaded', () => {
            const savedTheme = localStorage.getItem('theme') || 'light';
            document.documentElement.setAttribute('data-theme', savedTheme);
        });
    </script>
</body>
</html>