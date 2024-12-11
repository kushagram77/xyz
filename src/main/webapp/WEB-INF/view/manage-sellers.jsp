<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html data-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Sellers - Online Home Decor</title>
    <link rel="icon" type="image/svg+xml" href="https://img.icons8.com/cute-clipart/64/home.png">

    <!-- Material Icons -->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <!-- Google Fonts -->
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
            --table-stripe: #F8F7FF;
            --danger: #DC2626;
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
            --table-stripe: #2D3748;
            --danger: #EF4444;
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
            text-decoration: none;
        }

        .header-controls {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .header .logout-btn {
            color: white;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            transition: background-color 0.3s;
            font-weight: 500;
        }

        .header .logout-btn:hover {
            background: rgba(255, 255, 255, 0.1);
        }

        .theme-toggle {
            position: static;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: transform 0.3s ease, background-color 0.3s;
            z-index: 1001;
        }

        .theme-toggle:hover {
            transform: scale(1.1);
            background: rgba(255, 255, 255, 0.2);
        }

        .theme-toggle .material-icons {
            color: white;
            font-size: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
            position: relative;
            z-index: 1;
        }

        .page-title {
            font-family: 'Poppins', sans-serif;
            font-size: 2rem;
            margin-bottom: 2rem;
            color: var(--primary);
            background: linear-gradient(120deg, var(--primary) 0%, var(--accent) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .table {
            width: 100%;
            background: var(--card-bg);
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 4px 6px var(--shadow);
            border: 1px solid var(--border);
            margin-bottom: 2rem;
        }

        .table th,
        .table td {
            padding: 1rem;
            color: var(--text-primary);
            border-bottom: 1px solid var(--border);
        }

        .table th {
            background: var(--primary);
            color: white;
            font-weight: 600;
            text-align: left;
        }

        .table tr:nth-child(even) {
            background: var(--table-stripe);
        }

        .btn {
            padding: 0.5rem 1rem;
            border-radius: 8px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
            font-weight: 500;
            border: none;
            cursor: pointer;
        }

        .btn-success {
            background: var(--success);
            color: white;
        }

        .btn-danger {
            background: var(--danger);
            color: white;
        }

        .btn:hover {
            transform: translateY(-2px);
        }

        @media (max-width: 768px) {
            .header {
                padding: 1rem;
            }
            .header-controls {
                gap: 0.5rem;
            }
            .logout-btn span:not(.material-icons) {
                display: none;
            }
            .table {
                display: block;
                overflow-x: auto;
            }
        }

        .header .nav-btn {
                                        color: white;
                                        text-decoration: none;
                                        display: flex;
                                        align-items: center;
                                        gap: 0.5rem;
                                        padding: 0.5rem 1rem;
                                        border-radius: 8px;
                                        transition: background-color 0.3s;
                                        font-weight: 500;
                                    }
    </style>
</head>
<body>
    <header class="header">
        <a href="/admin/dashboard" class="h1" style="text-decoration: none;">
            <h1>
                <span class="material-icons">dashboard</span>
                Admin Dashboard
            </h1>
        </a>
        <div class="header-controls">

            <a href="/OHDSpring/admin/dashboard" class="nav-btn">
                                        <span class="material-icons">dashboard</span>
                                        <span>Dashboard</span>
                                    </a>
            <a href="/OHDSpring/index" class="logout-btn">
                <span class="material-icons">logout</span>
                <span>Logout</span>
            </a>
            <button class="theme-toggle" onclick="toggleTheme()" aria-label="Toggle theme">
                <span class="material-icons">dark_mode</span>
            </button>
        </div>
    </header>

    <div class="container">
        <h2 class="page-title">Manage Sellers</h2>

        <%-- Add this below the existing page-title --%>
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success" style="background: var(--success); color: white; padding: 1rem; border-radius: 8px; margin-bottom: 1rem;">
                ${successMessage}
            </div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger" style="background: var(--danger); color: white; padding: 1rem; border-radius: 8px; margin-bottom: 1rem;">
                ${errorMessage}
            </div>
        </c:if>
<table class="table">
    <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Status</th>
            <th>Actions</th>

        </tr>
    </thead>
    <tbody>
        <c:forEach items="${sellers}" var="seller">
            <tr>
                <td>${seller.id}</td>
                <td>${seller.name}</td>
                <td>${seller.email}</td>
                <td>
                    <c:choose>
                        <c:when test="${seller.role == 'REQUESTEDSELLER'}">
                            <span style="color: var(--accent);">Pending Approval</span>
                        </c:when>
                        <c:when test="${seller.role == 'SELLER'}">
                            <span style="color: var(--success);">Approved</span>
                        </c:when>
                    </c:choose>
                </td>
                <td>
                    <c:if test="${seller.role == 'REQUESTEDSELLER'}">
                        <c:url value="/admin/sellers/${seller.id}/approve" var="approveUrl" />
                        <c:url value="/admin/sellers/${seller.id}/reject" var="rejectUrl" />
                        <a href="${approveUrl}" class="btn btn-success">
                            <span class="material-icons">check_circle</span>
                            Approve
                        </a>
                        <a href="${rejectUrl}" class="btn btn-danger" style="margin-left: 10px;">
                            <span class="material-icons">cancel</span>
                            Reject
                        </a>
                    </c:if>
                    <c:if test="${seller.role == 'SELLER'}">
                        <span style="color: var(--text-secondary);">Approved</span>
                        <c:url value="/admin/sellers/${seller.id}/block" var="blockUrl" />
                        <a href="${blockUrl}" class="btn btn-danger" style="margin-left: 10px;"
                           onclick="return confirm('Are you sure you want to block this seller? This action cannot be undone.')">
                            <span class="material-icons">block</span>
                            Block
                        </a>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
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