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
        <title>Seller Orders - Online Home Decor</title>
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

            .header {
                background: var(--header-bg);
                padding: 28px;
                text-align: center;
                position: relative;
                margin-bottom: 40px;
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

            .main-container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 20px;
            }

            .orders-table {
                width: 100%;
                background: var(--card-bg);
                border-radius: 16px;
                overflow: hidden;
                box-shadow: 0 4px 6px var(--shadow);
                border: 1px solid var(--border);
                margin-bottom: 40px;
            }

            .orders-table thead {
                background: var(--primary);
                color: white;
            }

            .orders-table th {
                padding: 16px;
                text-align: left;
                font-weight: 600;
            }

            .orders-table td {
                padding: 16px;
                border-bottom: 1px solid var(--border);
                color: var(--text-primary);
            }

            .orders-table tr:last-child td {
                border-bottom: none;
            }

            .status-form {
                display: flex;
                gap: 12px;
                align-items: center;
            }

            .status-select {
                padding: 8px 12px;
                border-radius: 8px;
                border: 1px solid var(--border);
                background: var(--input-bg);
                color: var(--text-primary);
                font-size: 14px;
                min-width: 140px;
            }

            .update-btn {
                padding: 8px 16px;
                background: var(--primary);
                color: white;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                font-weight: 500;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .update-btn:hover {
                background: var(--primary-dark);
                transform: translateY(-1px);
            }

            .alert {
                padding: 16px;
                border-radius: 12px;
                margin-bottom: 24px;
                display: flex;
                align-items: center;
                gap: 12px;
            }

            .alert.success {
                background: var(--success);
                color: white;
            }

            .alert.error {
                background: var(--error);
                color: white;
            }

            .footer {
                text-align: center;
                padding: 24px;
                color: var(--text-secondary);
                border-top: 1px solid var(--border);
                margin-top: 40px;
            }

            @media (max-width: 768px) {
                .orders-table {
                    display: block;
                    overflow-x: auto;
                }

                .status-form {
                    flex-direction: column;
                    align-items: stretch;
                }

                .status-select {
                    width: 100%;
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
            }
            .header {
                            background: var(--header-bg);
                            padding: 28px;
                            text-align: center;
                            position: relative;
                            margin-bottom: 40px;
                            display: flex;
                            align-items: center;
                            justify-content: space-between;
                        }

                        .header h1 {
                            color: white;
                            font-size: 24px;
                            display: flex;
                            align-items: center;
                            gap: 12px;
                            font-family: 'Poppins', sans-serif;
                            margin: 0 auto;
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

                        .header .nav-btn:hover {
                            background-color: rgba(255, 255, 255, 0.2);
                        }

                        @media (max-width: 768px) {
                            .header {
                                flex-direction: column;
                                align-items: center;
                            }

                            .header .nav-btn {
                                margin-top: 1rem;
                            }
                        }
        </style>
    </head>
    <body>
        <button class="theme-toggle" onclick="toggleTheme()" aria-label="Toggle theme">
            <span class="material-icons">dark_mode</span>
        </button>


        <header class="header">
            <h1>
                <span class="material-icons">shopping_bag</span>
                Seller Orders
            </h1>
            <a href="/OHDSpring/admin/dashboard" class="nav-btn">
                                                                                <span class="material-icons">dashboard</span>
                                                                                <span>Dashboard</span>
                                                                            </a>

        </header>

        <div class="main-container">
            <c:if test="${not empty message}">
                <div class="alert ${messageType}">
                    <span class="material-icons">
                        ${messageType == 'success' ? 'check_circle' : 'error'}
                    </span>
                    ${message}
                </div>
            </c:if>

            <table class="orders-table">
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Customer Name</th>
                        <th>Order Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="order" items="${orders}">
                        <tr>
                            <td>${order.id}</td>
                            <td>${order.customerName}</td>
                            <td>${order.status}</td>
                            <td>
                                <form action="<c:url value='/seller/orders/${order.id}/status'/>" method="post" class="status-form">
                                    <select name="status" class="status-select">
                                        <option value="Pending" <c:if test="${order.status == 'Pending'}">selected</c:if>>Pending</option>
                                        <option value="Shipped" <c:if test="${order.status == 'Shipped'}">selected</c:if>>Shipped</option>
                                        <option value="Delivered" <c:if test="${order.status == 'Delivered'}">selected</c:if>>Delivered</option>
                                        <option value="Cancelled" <c:if test="${order.status == 'Cancelled'}">selected</c:if>>Cancelled</option>
                                    </select>
                                    <button type="submit" class="update-btn">
                                        <span class="material-icons">update</span>
                                        Update Status
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <footer class="footer">
            © [2024-2025] Copyrights by Yash TECHNOLOGIES | All Rights Reserved
        </footer>

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
