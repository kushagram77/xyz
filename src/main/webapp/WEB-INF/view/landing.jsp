<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html data-theme="light">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Online Home Decor</title>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@600;700&display=swap" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
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
            }

            body {
                background: var(--bg-primary);
                color: var(--text-primary);
                min-height: 100vh;
            }

            .header {
                background: var(--header-bg);
                padding: 1rem 2rem;
                position: fixed;
                width: 100%;
                top: 0;
                z-index: 1000;
                box-shadow: 0 2px 10px var(--shadow);
            }



            .logo {
                color: white;
                font-family: 'Poppins', sans-serif;
                font-size: 1.5rem;
                display: flex;
                align-items: center;
                gap: 0.5rem;
                text-decoration: none;
            }



            .button {
                padding: 0.75rem 1.5rem;
                border-radius: 8px;
                font-weight: 500;
                text-decoration: none;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .login-btn {
                background: white;
                color: var(--primary);
            }

            .login-btn:hover {
                background: var(--bg-secondary);
                transform: translateY(-2px);
            }

            .register-btn {
                background: var(--accent);
                color: white;
            }

            .register-btn:hover {
                background: #E3A008;
                transform: translateY(-2px);
            }

            .hero-section {
                margin-top: 76px;
                padding: 2rem;
                background: linear-gradient(45deg,
                    rgba(124, 58, 237, 0.1) 0%,
                    rgba(159, 122, 234, 0.1) 100%);
                text-align: center;
            }

            .hero-content {
                max-width: 800px;
                margin: 0 auto;
                text-align: center;
                animation: fadeInUp 1s ease-out;
            }

            .hero-title {
                font-family: 'Poppins', sans-serif;
                font-size: 3rem;
                margin-bottom: 1.5rem;
                background: linear-gradient(120deg, var(--primary) 0%, var(--accent) 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
            }

            .hero-subtitle {
                font-size: 1.25rem;
                color: var(--text-secondary);
                margin-bottom: 2rem;
                line-height: 1.6;
            }

            /* Product Card Styles */
            .product-section {
                padding: 2rem;
                max-width: 1200px;
                margin: 0 auto;
            }

            .product-card {
                background: var(--card-bg);
                border: 1px solid var(--border);
                border-radius: 16px;
                padding: 24px;
                margin: 16px;
                transition: all 0.3s ease;
                box-shadow: 0 4px 12px var(--shadow);
            }

            .product-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 24px var(--shadow);
            }

            .product-image {
                width: 100%;
                height: 200px;
                object-fit: cover;
                border-radius: 8px;
                margin-bottom: 16px;
            }

            .image-placeholder {
                width: 100%;
                height: 200px;
                background-color: var(--border);
                border-radius: 8px;
                margin-bottom: 16px;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .product-title {
                color: var(--text-primary);
                font-family: 'Poppins', sans-serif;
                font-weight: 600;
                margin-bottom: 12px;
            }

            .product-description {
                color: var(--text-secondary);
                margin-bottom: 16px;
            }

            .product-price {
                color: var(--primary);
                font-size: 1.25rem;
                font-weight: 600;
                margin-bottom: 16px;
            }
            /* Update or add these styles for the login-to-purchase button */
            .product-card .login-btn {
                background: var(--primary);
                color: white !important; /* Force white text */
                width: 100%;
                padding: 0.75rem 1.5rem;
                border: none;
                border-radius: 8px;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 0.5rem;
                font-weight: 500;
                transition: all 0.3s ease;
                text-decoration: none;
            }

            .product-card .login-btn:hover {
                background: var(--primary-dark);
                transform: translateY(-2px);
                box-shadow: 0 4px 12px var(--shadow);
            }

            .product-card .login-btn .material-icons {
                color: white; /* Ensure icon is also white */
            }

            .header-content {
                max-width: 1200px;
                margin: 0 auto;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .nav-buttons {
                display: flex;
                gap: 1rem;
                align-items: center;  /* Added to vertically align buttons */
            }

            .theme-toggle {
                position: static; /* Change from fixed to static */
                width: 45px;
                height: 45px;
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
                background: var(--card-bg);
                border: 1px solid var(--border);
                border-radius: 50%;
                box-shadow: 0 2px 8px var(--shadow);
                color: var(--text-primary);
                transition: all 0.3s ease;
                margin-left: 1rem; /* Add spacing between register button and theme toggle */
            }

            /* For mobile responsiveness, adjust the position on smaller screens */
            @media (max-width: 640px) {
                .theme-toggle {
                    right: 160px; /* Adjust for smaller screens */
                    top: 15px;
                    width: 35px;
                    height: 35px;
                }

            .theme-toggle:hover {
                transform: scale(1.1);
                box-shadow: 0 4px 12px var(--shadow);
            }

            .notification {
                position: fixed;
                top: 96px;
                right: 20px;
                padding: 15px 25px;
                border-radius: 12px;
                color: white;
                display: none;
                z-index: 10000;
                background: var(--success);
                box-shadow: 0 4px 12px var(--shadow);
                text-align: center;
            }

            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            @media (max-width: 640px) {
                .hero-title {
                    font-size: 2rem;
                }
                .hero-subtitle {
                    font-size: 1rem;
                }
                .nav-buttons {
                    gap: 0.5rem;
                }
                .button {
                    padding: 0.5rem 1rem;
                }
                .product-card {
                    margin: 8px;
                }
            }


        </style>

        <style>
        .footer {
            background: var(--bg-secondary);
            padding: 3rem 0 1rem;
            margin-top: 2rem;
            border-top: 1px solid var(--border);
        }

        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 2rem;
        }

        .footer-section {
            margin-bottom: 2rem;
        }

        .footer-title {
            font-family: 'Poppins', sans-serif;
            font-size: 2rem;
            margin-bottom: 1.5rem;
            font-weight: 600;
        }

        .social-links {
            display: flex;
            gap: 1.5rem;
            justify-content: center;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .social-link {
            color: var(--text-primary);
            text-decoration: none;
            transition: color 0.3s ease, transform 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: var(--bg-primary);
            border: 1px solid var(--border);
        }

        .social-link:hover {
            color: var(--primary);
            transform: translateY(-3px);
        }

        .social-link .material-icons {
            font-size: 24px;
        }

        .footer-bottom {
            padding-top: 1rem;
            border-top: 1px solid var(--border);
            color: var(--text-secondary);
            font-size: 0.875rem;
        }

        @media (max-width: 640px) {
            .footer {
                padding: 2rem 0 1rem;
            }

            .footer-title {
                font-size: 1.5rem;
            }

            .social-links {
                gap: 1rem;
            }

            .social-link {
                width: 40px;
                height: 40px;
            }

            .social-link .material-icons {
                font-size: 20px;
            }
        }

        .help-btn {
            background: var(--bg-secondary);
            color: var(--primary);
            border: 1px solid var(--primary);
        }

        .help-btn:hover {
            background: var(--primary);
            color: white;
            transform: translateY(-2px);
        }
        .successMsg {
            position: fixed;
            padding-top: 40px;
            color: green;
            text-align: center;
        }
        </style>
    </head>
    <body>
        <button class="theme-toggle" onclick="toggleTheme()" aria-label="Toggle theme">
            <span class="material-icons">dark_mode</span>
        </button>

        <header class="header">


            <div class="header-content">
                <a href="#" class="logo">
                    <span class="material-icons">home</span>
                    Online Home Decor
                </a>
                <nav class="nav-buttons">
                    <a href="<s:url value="/help"/>" class="button help-btn">
                                            <span class="material-icons">help</span>
                                            Help
                                        </a>
                    <a href="<s:url value="/login"/>" class="button login-btn">
                        <span class="material-icons">login</span>
                        Login
                    </a>
                    <a href="<s:url value="/reg_form"/>" class="button register-btn">
                        <span class="material-icons">person_add</span>
                        Register
                    </a>



                    <button class="theme-toggle" onclick="toggleTheme()" aria-label="Toggle theme">
                        <span class="material-icons">dark_mode</span>
                    </button>
                </nav>
            </div>
        </header>

        <div class="notification" id="notification">
            <c:if test="${param.act eq 'reg'}">
                <p class="successMsg">Registered successfully</p>
            </c:if>
        </div>

        <main>
            <section class="hero-section">
                <div class="hero-content">
                    <h1 class="hero-title">Sajae Sapno Ka Ashiyana</h1>
                    <p class="hero-subtitle">
                        Transform your living space with our exquisite collection of home decor items.
                        From modern minimalist to classic elegant, find your perfect style with us.
                    </p>
                </div>
            </section>

            <section class="product-section">
                <div class="row">
                    <c:forEach items="${products}" var="product">
                        <div class="col-md-4">
                            <div class="product-card">
                                <c:choose>
                                    <c:when test="${not empty product.image}">
                                        <img
                                            src="<s:url value='/products/image/${product.id}'/>"
                                            alt="${product.name}"
                                            class="product-image"
                                            onload="handleImageLoad(this)"
                                            onerror="handleImageError(this)"
                                        />
                                    </c:when>
                                    <c:otherwise>
                                        <div class="image-placeholder">
                                            <span class="material-icons">image</span>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                                <div class="product-info">
                                    <h3 class="product-title">${product.name}</h3>
                                    <p class="product-description">${product.description}</p>
                                    <div class="product-price">₹${product.price}</div>
                                    <a href="<s:url value="/login"/>" class="btn btn-primary button login-btn">
                                        <span class="material-icons">login</span>
                                                   Buy Now
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </section>
        </main>
        <footer class="footer">
            <div class="footer-content">
                <div class="row">
                    <div class="col-md-12">
                        <div class="footer-section text-center">
                            <h2 class="footer-title" style="color: var(--text-primary);">Connect With Us</h2>
                            <div class="social-links justify-content-center">
                                <a href="#" class="social-link" aria-label="Instagram">
                                    <span class="material-icons">photo_camera</span>
                                </a>
                                <a href="linkedin.com/in/kushagra-mishra-910378231/" class="social-link" aria-label="LinkedIn">
                                    <span class="material-icons">work</span>
                                </a>
                                <a href="#" class="social-link" aria-label="Facebook">
                                    <span class="material-icons">facebook</span>
                                </a>
                                <a href="mailto:kushagram77@gmail.com" class="social-link" aria-label="Email">
                                    <span class="material-icons">email</span>
                                </a>
                                <a href="tel:+919302404656" class="social-link" aria-label="Contact">
                                    <span class="material-icons">phone</span>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="footer-bottom text-center">
                <p>&copy; 2024 Online Home Decor. All rights reserved.</p>
            </div>
        </footer>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

        <script>
            function handleImageLoad(img) {
                console.log('Image loaded successfully:', img.src);
            }

            function handleImageError(img) {
                console.error('Failed to load image:', img.src);
                const placeholder = document.createElement('div');
                placeholder.className = 'image-placeholder';
                placeholder.innerHTML = '<span class="material-icons">image</span>';
                img.parentElement.replaceChild(placeholder, img);
            }

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