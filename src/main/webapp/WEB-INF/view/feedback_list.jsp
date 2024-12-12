<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html data-theme="light">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Feedback List - Online Home Decor</title>
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
                color: var(--text-primary);
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
                max-width: 1200px;
                margin: 40px auto;
                background: var(--card-bg);
                border-radius: 24px;
                box-shadow: 0 20px 25px -5px var(--shadow);
                overflow: hidden;
                position: relative;
                backdrop-filter: blur(10px);
                z-index: 1;
                border: 1px solid var(--border);
                padding: 0 0 20px 0;
            }

            .header {
                background: var(--header-bg);
                padding: 28px;
                margin-bottom: 40px;
            }

            .header h1 {
                color: white;
                font-size: 24px;
                display: flex;
                align-items: center;
                gap: 12px;
                font-family: 'Poppins', sans-serif;
            }

            .home-link {
                margin-left: auto;
                color: white;
                text-decoration: none;
                display: flex;
                align-items: center;
                gap: 8px;
                font-size: 16px;
                opacity: 0.9;
                transition: opacity 0.3s ease;
            }

            .home-link:hover {
                opacity: 1;
            }

            .content {
                padding: 0 40px;
            }

            .feedback-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 30px;
            }

            .welcome-back {
                font-family: 'Poppins', sans-serif;
                font-size: 28px;
                color: var(--primary);
                background: linear-gradient(120deg, var(--primary) 0%, var(--accent) 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
            }

            .add-feedback-btn {
                background: var(--primary);
                color: white;
                text-decoration: none;
                padding: 12px 24px;
                border-radius: 12px;
                display: flex;
                align-items: center;
                gap: 8px;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .add-feedback-btn:hover {
                background: var(--primary-dark);
                transform: translateY(-2px);
            }

            .feedback-list {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
                margin: 20px 0;
            }

            .feedback-list th,
            .feedback-list td {
                padding: 16px;
                text-align: left;
                border-bottom: 1px solid var(--border);
            }

            .feedback-list th {
                background: var(--primary);
                color: white;
                font-weight: 600;
            }

            .feedback-list th:first-child {
                border-top-left-radius: 12px;
            }

            .feedback-list th:last-child {
                border-top-right-radius: 12px;
            }

            .feedback-list tr:hover {
                background: var(--bg-primary);
            }

            .status-badge {
                padding: 6px 12px;
                border-radius: 20px;
                font-size: 14px;
                font-weight: 500;
                text-transform: capitalize;
                display: inline-block;
            }

            .status-pending {
                background: var(--accent);
                color: white;
            }

            .status-resolved {
                background: var(--success);
                color: white;
            }

            .action-buttons {
                display: flex;
                gap: 8px;
            }

            .action-btn {
                padding: 8px 16px;
                border-radius: 8px;
                font-size: 14px;
                text-decoration: none;
                display: flex;
                align-items: center;
                gap: 4px;
                transition: all 0.3s ease;
            }

            .view-btn {
                background: var(--primary);
                color: white;
            }

            .view-btn:hover {
                background: var(--primary-dark);
                transform: translateY(-2px);
            }

            .success-message {
                background: var(--success);
                color: white;
                padding: 16px;
                border-radius: 12px;
                margin-bottom: 20px;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .footer {
                text-align: center;
                padding: 24px;
                color: var(--text-secondary);
                border-top: 1px solid var(--border);
                margin-top: 40px;
            }

            @media (max-width: 768px) {
                .main-container {
                    margin: 20px;
                    border-radius: 16px;
                }

                .content {
                    padding: 0 20px;
                }

                .feedback-header {
                    flex-direction: column;
                    gap: 20px;
                    text-align: center;
                }

                .welcome-back {
                    font-size: 24px;
                }

                .feedback-list {
                    display: block;
                    overflow-x: auto;
                }
            }

            .status-badge {
                        padding: 6px 12px;
                        border-radius: 20px;
                        font-size: 14px;
                        font-weight: 500;
                        text-transform: capitalize;
                        display: inline-block;
                        cursor: pointer;
                        transition: all 0.3s ease;
                    }

                    .status-pending {
                        background: var(--accent);
                        color: white;
                    }

                    .status-approved {
                        background: var(--success);
                        color: white;
                    }

                    .status-badge:hover {
                        opacity: 0.9;
                        transform: translateY(-1px);
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
                    <span class="material-icons">feedback</span>
                    Query List
                    <a href="<s:url value="/admin/dashboard"/>" class="home-link">
                        <span class="material-icons">home</span>
                        Dashboard
                    </a>
                </h1>
            </header>

            <main class="content">
                <div class="feedback-header">
                    <h2 class="welcome-back">Customer Queries List</h2>

                </div>

                <c:if test="${param.act eq 'sv'}">
                    <div class="success-message">
                        <span class="material-icons">check_circle_outline</span>
                        Feedback submitted successfully!
                    </div>
                </c:if>

                <table class="feedback-list">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Subject</th>
                            <th>Message</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                      <tbody>
                                <c:forEach var="f" items="${feedbackList}">
                                    <tr>
                                        <td>${f.id}</td>
                                        <td>${f.name}</td>
                                        <td>${f.subject}</td>
                                        <td>${f.message}</td>
                                        <td>
                                            <span class="status-badge status-${f.status.toLowerCase()}"
                                                  onclick="toggleStatus(this)"
                                                  data-feedback-id="${f.id}">
                                                ${f.status}
                                            </span>
                                        </td>
                                        <td class="action-buttons">
                                            <a href="#" class="action-btn view-btn">
                                                <span class="material-icons">visibility</span>
                                                View
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                </table>
            </main>

            <footer class="footer">
                © [2024-2025] Copyrights by Yash TECHNOLOGIES | All Rights Reserved
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


             function toggleStatus(element) {
                            const isPending = element.classList.contains('status-pending');

                            if (isPending) {
                                // Remove pending class and add approved class
                                element.classList.remove('status-pending');
                                element.classList.add('status-approved');
                                element.textContent = 'Resolved';

                                // You can add an API call here to update the status in the backend
                                const feedbackId = element.getAttribute('data-feedback-id');
                                console.log(`Status updated for feedback ID: ${feedbackId}`);
                            }
                        }


        </script>
    </body>
</html>