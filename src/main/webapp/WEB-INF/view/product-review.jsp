<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html data-theme="light">
<head>
    <meta charset="UTF-8">
    <title>Product Review - Online Home Decor</title>
    <link rel="icon" type="image/svg+xml" href="https://img.icons8.com/cute-clipart/64/home.png">

    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@600;700&display=swap" rel="stylesheet">

    <style>
            /* Root variables */
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
                --navbar-height: 70px;
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
                --navbar-height: 70px;
            }

            /* Base styles */
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
                padding-top: var(--navbar-height);
            }

            /* Navbar styles */
            .navbar {
                background: var(--header-bg) !important;
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                height: var(--navbar-height);
                z-index: 1000;
                padding: 0 !important;
            }

            .custom-nav-btn {
                display: flex;
                align-items: center;
                gap: 8px;
                background: rgba(255, 255, 255, 0.1);
                border-radius: 8px;
                margin: 0 8px;
                padding: 8px 16px !important;
                transition: all 0.3s ease;
                color: white !important;
                font-weight: 500;
            }

            .custom-nav-btn:hover {
                background: rgba(255, 255, 255, 0.2);
                transform: translateY(-2px);
            }

            .theme-toggle-new {
                background: rgba(255, 255, 255, 0.1);
                border: 2px solid rgba(255, 255, 255, 0.2);
                border-radius: 12px;
                width: 44px;
                height: 44px;
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
                transition: all 0.3s ease;
                padding: 0;
                margin-left: 16px;
                color: white;
            }

            /* Success content styles */
            .success-container {
                max-width: 600px;
                margin: 4rem auto;
                padding: 2rem;
                background: var(--card-bg);
                border-radius: 16px;
                text-align: center;
                box-shadow: 0 4px 12px var(--shadow);
            }

            .success-icon {
                font-size: 5rem;
                color: var(--success);
                margin-bottom: 1.5rem;
                animation: scaleIn 0.5s ease-out;
            }

            .success-title {
                font-family: 'Poppins', sans-serif;
                font-size: 2rem;
                color: var(--text-primary);
                margin-bottom: 1rem;
            }

            .success-message {
                color: var(--text-secondary);
                margin-bottom: 2rem;
                font-size: 1.1rem;
                line-height: 1.6;
            }

            .continue-shopping-btn {
                background: var(--primary);
                color: white;
                border: none;
                border-radius: 8px;
                padding: 12px 24px;
                font-size: 1.1rem;
                cursor: pointer;
                transition: all 0.3s ease;
                text-decoration: none;
                display: inline-block;
            }

            .continue-shopping-btn:hover {
                background: var(--primary-dark);
                transform: translateY(-2px);
                color: white;
            }

            @keyframes scaleIn {
                0% {
                    transform: scale(0);
                    opacity: 0;
                }
                100% {
                    transform: scale(1);
                    opacity: 1;
                }
            }

              .action-buttons {
                        display: flex;
                        justify-content: center;
                        gap: 1rem;
                        margin-top: 1.5rem;
                    }

                    .secondary-btn {
                        background: var(--text-secondary);
                        color: white;
                        border: none;
                        border-radius: 8px;
                        padding: 12px 24px;
                        font-size: 1.1rem;
                        cursor: pointer;
                        transition: all 0.3s ease;
                        text-decoration: none;
                        display: inline-flex;
                        align-items: center;
                        gap: 8px;
                    }

                    .secondary-btn:hover {
                        background: var(--text-primary);
                        transform: translateY(-2px);
                        color: white;
                    }
        </style>
    <style>
        /* Reuse the styles from the previous payment success page for consistency */
        <%-- Include the entire CSS from the previous page here --%>

        /* Additional styles for rating */
        .star-rating {
            display: flex;
            flex-direction: row-reverse;
            justify-content: center;
            margin-bottom: 1rem;
        }
        .star-rating input {
            display: none;
        }
        .star-rating label {
            font-size: 2rem;
            color: #ddd;
            cursor: pointer;
            transition: color 0.3s;
        }
        .star-rating input:checked ~ label,
        .star-rating input:hover ~ label,
        .star-rating label:hover,
        .star-rating label:hover ~ label {
            color: var(--accent);
        }
    </style>
</head>
<body>
    <!-- Navbar (same as previous page) -->
    <nav class="navbar navbar-expand-lg navbar-dark">
            <div class="container">
                <a class="navbar-brand" href="/OHDSpring/products">
                    <span class="material-icons">shopping_bag</span>
                    Online Home Decor
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="nav-and-controls d-flex align-items-center">
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav">
                            <li class="nav-item">
                                <a class="nav-link custom-nav-btn" href="/OHDSpring/products/list">
                                    <span class="material-icons">dashboard</span>
                                    Dashboard
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link custom-nav-btn" href="/OHDSpring/index">
                                    <span class="material-icons">logout</span>
                                    Logout
                                </a>
                            </li>
                        </ul>
                    </div>
                    <div class="header-controls">
                        <button class="theme-toggle-new" onclick="toggleTheme()" aria-label="Toggle theme">
                            <span class="material-icons">dark_mode</span>
                        </button>
                    </div>
                </div>
            </div>


        </nav>


    <!-- Review Content -->
    <div class="success-container">
        <h1 class="success-title">Rate Your Experience</h1>

        <form action="/OHDSpring/order/submit-review" method="post">
            <input type="hidden" name="orderId" value="${orderId}">
            <input type="hidden" name="productId" value="${productId}">

            <div class="star-rating">
                <input type="radio" id="star5" name="rating" value="5">
                <label for="star5" class="material-icons">star</label>
                <input type="radio" id="star4" name="rating" value="4">
                <label for="star4" class="material-icons">star</label>
                <input type="radio" id="star3" name="rating" value="3">
                <label for="star3" class="material-icons">star</label>
                <input type="radio" id="star2" name="rating" value="2">
                <label for="star2" class="material-icons">star</label>
                <input type="radio" id="star1" name="rating" value="1">
                <label for="star1" class="material-icons">star</label>
            </div>

            <div class="form-group mb-3">
                <textarea class="form-control" name="reviewText" rows="4"
                          placeholder="Share your experience with this product (optional)"
                          maxlength="500"></textarea>
            </div>

            <button type="submit" class="continue-shopping-btn">
                <span class="material-icons">send</span>
                Submit Review
            </button>
        </form>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

    <script>
        // Theme toggle script from previous page
        function toggleTheme() {
            const html = document.documentElement;
            const theme = html.getAttribute('data-theme');
            const newTheme = theme === 'light' ? 'dark' : 'light';
            html.setAttribute('data-theme', newTheme);

            const icon = document.querySelector('.theme-toggle-new .material-icons');
            icon.textContent = newTheme === 'light' ? 'dark_mode' : 'light_mode';

            localStorage.setItem('theme', newTheme);
        }

        // Set initial theme on page load
        document.addEventListener('DOMContentLoaded', function() {
            const savedTheme = localStorage.getItem('theme') || 'light';
            document.documentElement.setAttribute('data-theme', savedTheme);
            const icon = document.querySelector('.theme-toggle-new .material-icons');
            icon.textContent = savedTheme === 'light' ? 'dark_mode' : 'light_mode';
        });
    </script>
</body>
</html>