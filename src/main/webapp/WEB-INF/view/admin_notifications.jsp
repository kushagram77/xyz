<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html data-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Seller Notifications - Online Home Decor</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@600;700&display=swap" rel="stylesheet">
    <style>
        /* Reusing the entire CSS from dashboard.jsp */
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

        .header-controls {
            display: flex;
            align-items: center;
            gap: 1rem;
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
            background: rgba(255, 255, 255, 0.1);
        }

        .theme-toggle {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: transform 0.3s ease;
        }

        .theme-toggle:hover {
            transform: scale(1.1);
            background: rgba(255, 255, 255, 0.2);
        }

        .theme-toggle .material-icons {
            color: white;
            font-size: 20px;
        }

        .dashboard-container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
            position: relative;
            z-index: 1;
        }

        .welcome-title {
            font-family: 'Poppins', sans-serif;
            font-size: 2rem;
            margin-bottom: 2rem;
            background: linear-gradient(120deg, var(--primary) 0%, var(--accent) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            animation: fadeInScale 0.8s ease-out;
        }

        .notification-list {
            display: grid;
            gap: 1rem;
        }

        .notification-card {
            background: var(--card-bg);
            border-radius: 16px;
            padding: 1.5rem;
            border: 1px solid var(--border);
            box-shadow: 0 4px 6px var(--shadow);
            transition: transform 0.3s, box-shadow 0.3s;
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .notification-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 15px var(--shadow);
        }

        .notification-icon {
            background: var(--primary);
            color: white;
            border-radius: 50%;
            width: 50px;
            height: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .notification-content {
            flex-grow: 1;
        }

        .notification-content h4 {
            color: var(--primary);
            margin-bottom: 0.5rem;
        }

        .notification-content p {
            color: var(--text-secondary);
        }

        .notification-time {
            color: var(--text-secondary);
            font-size: 0.8rem;
        }

        .back-btn {
            background: var(--primary);
            color: white;
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
            font-weight: 500;
            margin-bottom: 1rem;
        }

        .back-btn:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(124, 58, 237, 0.2);
        }

        @keyframes fadeInScale {
            0% { opacity: 0; transform: scale(0.95); }
            100% { opacity: 1; transform: scale(1); }
        }

        @media (max-width: 768px) {
            .header h1 {
                font-size: 1.2rem;
            }
            .welcome-title {
                font-size: 1.5rem;
            }
            .header {
                padding: 1rem;
            }
            .header-controls {
                gap: 0.5rem;
            }
            .nav-btn span:not(.material-icons) {
                display: none;
            }
        }
    </style>
</head>
<body>
    <header class="header">
        <h1>
            <span class="material-icons">store</span>
            Online Home Decor
        </h1>
        <div class="header-controls">
            <a href="/OHDSpring/xyz" class="nav-btn">
                <span class="material-icons">dashboard</span>
                <span>Back to Dashboard</span>
            </a>
            <a href="/OHDSpring/seller/profile" class="nav-btn">
                <span class="material-icons">account_circle</span>
                <span>Profile</span>
            </a>
            <a href="/OHDSpring/index" class="nav-btn">
                <span class="material-icons">logout</span>
                <span>Logout</span>
            </a>
            <button class="theme-toggle" onclick="toggleTheme()" aria-label="Toggle theme">
                <span class="material-icons">dark_mode</span>
            </button>
        </div>
    </header>

    <div class="dashboard-container">
        <h2 class="welcome-title">Heyyyyy,Dhyan Do ....</h2>



        <div class="notification-list">
            <div class="notification-card">
                <div class="notification-icon">
                    <span class="material-icons">shopping_cart</span>
                </div>
                <div class="notification-content">
                    <h4>New Order Received</h4>
                    <p>Boom in demand for curatains!!!!!</p>
                </div>
                <div class="notification-time">2 hours ago</div>
            </div>

            <div class="notification-card">
                <div class="notification-icon">
                    <span class="material-icons">inventory</span>
                </div>
                <div class="notification-content">
                    <h4>Low Stock Alert!SOFA COVER on low stock!</h4>
                    <p>Decorative Throw Pillows are running low on inventory</p>
                </div>
                <div class="notification-time">5 hours ago</div>
            </div>

            <div class="notification-card">
                <div class="notification-icon">
                    <span class="material-icons">settings</span>
                </div>
                <div class="notification-content">
                    <h4>Profile Update</h4>
                    <p>Dashboard Update coming soon</p>
                </div>
                <div class="notification-time">1 day ago</div>
            </div>

            <div class="notification-card">
                <div class="notification-icon">
                    <span class="material-icons">payments</span>
                </div>
                <div class="notification-content">
                    <h4>Payment Processed</h4>
                    <p>Monthly earnings of ₹5,00,000 have been processed</p>
                </div>
                <div class="notification-time">3 days ago</div>
            </div>
        </div>
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