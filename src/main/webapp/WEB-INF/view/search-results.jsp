<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html data-theme="light">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Search Results - Online Home Decor</title>
        <link rel="icon" type="image/svg+xml" href="https://img.icons8.com/cute-clipart/64/home.png">

        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@600;700&display=swap" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
         <link rel="icon" type="image/svg+xml" href="https://img.icons8.com/cute-clipart/64/home.png">

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

                        .search-container {
                            flex-grow: 1;
                            margin: 0 1rem;
                        }

                        .search-form {
                            display: flex;
                            max-width: 400px;
                            margin: 0 auto;
                        }

                        .search-input {
                            background: var(--input-bg);
                            border: 1px solid var(--border);
                            color: var(--text-primary);
                            padding: 0.5rem 1rem;
                            border-radius: 8px 0 0 8px;
                        }

                        .search-button {
                            background: var(--primary);
                            color: white;
                            border: none;
                            padding: 0.5rem 1rem;
                            border-radius: 0 8px 8px 0;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                        }

                        .search-button:hover {
                            background: var(--primary-dark);
                        }

                        .search-button .material-icons {
                            color: white;
                        }

                        @media (max-width: 640px) {
                            .search-container {
                                display: none; /* Optional: hide search on very small screens */
                            }
                        }
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
            <div class="header-content">
                <a href="#" class="logo">
                    <span class="material-icons">home</span>
                    Online Home Decor
                </a>
                <nav class="nav-buttons">
                   <a href="/OHDSpring/products/list" class="back-dashboard-btn">
                                               <span class="material-icons">home</span>
                                               Dashboard
                                             </a>
        <button class="theme-toggle" onclick="toggleTheme()" aria-label="Toggle theme">
            <span class="material-icons">dark_mode</span>
        </button>


                </nav>
            </div>
        </header>



        <section class="search-results-section">
            <div class="search-results-header">
                <h1>Search Results</h1>
                <p>Found ${products.size()} product(s) matching your search</p>
            </div>

            <c:choose>
                <c:when test="${not empty products}">
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
                </c:when>
                <c:otherwise>
                    <div class="no-results">
                        <h2>No Results Found</h2>
                        <p>Sorry, we couldn't find any products matching your search query.</p>
                        <a href="/" class="btn btn-primary">Back to Home</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </section>
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

        <script>
                    document.getElementById('foodSearch').addEventListener('input', function(e) {
                        const searchTerm = e.target.value.toLowerCase();
                        const rows = document.querySelectorAll('.food-table tbody tr');
                        const noResultsMessage = document.getElementById('noResultsMessage');

                        let visibleRowCount = 0;
                        rows.forEach(row => {
                            const foodName = row.querySelector('td').textContent.toLowerCase();
                            const isMatch = foodName.includes(searchTerm);
                            row.style.display = isMatch ? '' : 'none';
                            if (isMatch) visibleRowCount++;
                        });

                        // Show/hide no results message
                        noResultsMessage.style.display = visibleRowCount === 0 ? 'block' : 'none';
                    });
                </script>
    </body>
</html>