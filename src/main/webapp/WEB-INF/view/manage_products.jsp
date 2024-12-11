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
        <title>Seller Products - Online Home Decor</title>
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
                padding-top: 80px;
            }

            .fixed-header {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                background: var(--header-bg);
                padding: 16px 24px;
                z-index: 1000;
                box-shadow: 0 2px 10px var(--shadow);
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .header-title {
                color: white;
                font-size: 24px;
                font-family: 'Poppins', sans-serif;
                display: flex;
                align-items: center;
                gap: 12px;
            }

            .header-actions {
                display: flex;
                gap: 16px;
                align-items: center;
            }

            .theme-toggle {
                background: transparent;
                border: none;
                color: white;
                cursor: pointer;
                padding: 8px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: background-color 0.3s;
            }

            .theme-toggle:hover {
                background: rgba(255, 255, 255, 0.1);
            }

            .add-product-btn {
                background: var(--accent);
                color: white;
                border: none;
                padding: 8px 16px;
                border-radius: 8px;
                font-weight: 500;
                cursor: pointer;
                display: flex;
                align-items: center;
                gap: 8px;
                transition: all 0.3s ease;
            }

            .add-product-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 12px var(--shadow);
            }

            .products-container {
                max-width: 1200px;
                margin: 32px auto;
                padding: 0 24px;
            }

            .products-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
                gap: 24px;
                margin-top: 24px;
            }

            .product-card {
                background: var(--card-bg);
                border-radius: 16px;
                overflow: hidden;
                box-shadow: 0 4px 15px var(--shadow);
                border: 1px solid var(--border);
                transition: transform 0.3s ease;
            }

            .product-card:hover {
                transform: translateY(-5px);
            }

            .product-image {
                width: 100%;
                height: 200px;
                object-fit: cover;
            }

            .product-details {
                padding: 16px;
            }

            .product-title {
                font-size: 18px;
                font-weight: 600;
                color: var(--text-primary);
                margin-bottom: 8px;
            }

            .product-price {
                font-size: 20px;
                color: var(--primary);
                font-weight: 700;
                margin-bottom: 12px;
            }

            .product-description {
                color: var(--text-secondary);
                font-size: 14px;
                margin-bottom: 16px;
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
            }

            .product-actions {
                display: flex;
                gap: 8px;
            }

            .edit-btn, .delete-btn {
                flex: 1;
                padding: 8px;
                border: none;
                border-radius: 8px;
                font-weight: 500;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 4px;
                transition: all 0.3s ease;
            }

            .edit-btn {
                background: var(--primary);
                color: white;
            }

            .delete-btn {
                background: var(--error);
                color: white;
            }

            .edit-btn:hover, .delete-btn:hover {
                filter: brightness(110%);
            }

            @media (max-width: 640px) {
                .products-grid {
                    grid-template-columns: 1fr;
                }

                .fixed-header {
                    padding: 12px 16px;
                }

                .header-title {
                    font-size: 20px;
                }

                .product-card {
                    margin: 0 16px;
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
        <header class="fixed-header">
            <h1 class="header-title">
                <span class="material-icons">store</span>
                My Products
            </h1>
            <div class="header-actions">

                <a href="/OHDSpring/admin/dashboard" class="nav-btn">
                                                            <span class="material-icons">dashboard</span>
                                                            <span>Dashboard</span>
                                                        </a>
                <button class="theme-toggle" onclick="toggleTheme()" aria-label="Toggle theme">
                    <span class="material-icons">dark_mode</span>
                </button>

                <a href="<s:url value='/products/add'/>" class="add-product-btn">
                    <span class="material-icons">add</span>
                    Add Product
                </a>
            </div>
        </header>

        <main class="products-container">
            <div class="products-grid">
                <c:forEach var="product" items="${products}">
                    <div class="product-card">
                        <img src="<s:url value='/products/image/${product.id}'/>" alt="${product.name}" class="product-image">
                        <div class="product-details">
                            <h2 class="product-title">${product.name}</h2>
                            <p class="product-price">₹${product.price}</p>
                            <p class="product-description">${product.description}</p>
                            <div class="seller-info" style="margin-bottom: 12px; color: var(--text-secondary);">
                                            <p><strong>Seller ID:</strong> ${product.seller_id}</p>
                                            <p><strong>Seller Name:</strong> Ananya</p>

                                        </div>
                            <div class="product-actions">
                                <a href="<s:url value='/admin/products/${product.id}/edit'/>" class="edit-btn">
                                    <span class="material-icons">edit</span>
                                    Edit
                                </a>
                                <form action="<s:url value='/products/${product.id}/delete'/>" method="POST" style="flex: 1;">
                                    <button type="submit" class="delete-btn">
                                        <span class="material-icons">delete</span>
                                        Delete
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </main>

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