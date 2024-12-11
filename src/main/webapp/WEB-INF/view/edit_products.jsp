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
        <title>Edit Product - Online Home Decor</title>
        <link rel="icon" type="image/svg+xml" href="https://img.icons8.com/cute-clipart/64/home.png">

        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@600;700&display=swap" rel="stylesheet">
        <style>
            /* Reusing the exact same CSS from seller_products.jsp */
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

            .back-btn {
                background: var(--primary);
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
                text-decoration: none;
            }

            .form-container {
                max-width: 800px;
                margin: 32px auto;
                padding: 24px;
                background: var(--card-bg);
                border-radius: 16px;
                box-shadow: 0 4px 15px var(--shadow);
                border: 1px solid var(--border);
            }

            .form-title {
                font-size: 24px;
                color: var(--text-primary);
                margin-bottom: 24px;
                text-align: center;
            }

            .form-group {
                margin-bottom: 16px;
            }

            .form-label {
                display: block;
                margin-bottom: 8px;
                color: var(--text-primary);
                font-weight: 500;
            }

            .form-input {
                width: 100%;
                padding: 10px 12px;
                border: 1px solid var(--border);
                border-radius: 8px;
                background: var(--input-bg);
                color: var(--text-primary);
                transition: border-color 0.3s;
            }

            .form-input:focus {
                outline: none;
                border-color: var(--primary);
            }

            .form-checkbox {
                margin-right: 8px;
            }

            .form-submit {
                width: 100%;
                padding: 12px;
                background: var(--primary);
                color: white;
                border: none;
                border-radius: 8px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .form-submit:hover {
                filter: brightness(110%);
            }

            .image-preview {
                margin-bottom: 16px;
                max-width: 100%;
                border-radius: 8px;
                max-height: 300px;
                object-fit: cover;
            }

            @media (max-width: 640px) {
                .form-container {
                    margin: 16px;
                    padding: 16px;
                }
            }




        </style>
    </head>
    <body>
        <header class="fixed-header">
            <h1 class="header-title">
                <span class="material-icons">edit</span>
                Edit Product
            </h1>
            <div class="header-actions">
                <a href="<s:url value='/products/seller'/>" class="back-btn">
                    <span class="material-icons">arrow_back</span>
                    Back to Products
                </a>
                <button class="theme-toggle" onclick="toggleTheme()" aria-label="Toggle theme">
                    <span class="material-icons">dark_mode</span>
                </button>
            </div>
        </header>

        <main class="form-container">
            <form action="<s:url value='/products/${product.id}/edit'/>" method="POST" enctype="multipart/form-data">
                <div class="form-group">
                    <label class="form-label" for="name">Product Name</label>
                    <input type="text" id="name" name="name" class="form-input" value="${product.name}" required>
                </div>

                <div class="form-group">
                    <label class="form-label" for="price">Price</label>
                    <input type="number" id="price" name="price" class="form-input" value="${product.price}" required>
                </div>

                <div class="form-group">
                    <label class="form-label" for="description">Description</label>
                    <textarea id="description" name="description" class="form-input" rows="4" required>${product.description}</textarea>
                </div>







                <button type="submit" class="form-submit">Update Product</button>
            </form>
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