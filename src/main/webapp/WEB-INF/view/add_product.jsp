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
        <link rel="icon" type="image/svg+xml" href="https://img.icons8.com/cute-clipart/64/home.png">

        <title>Add New Product - Online Home Decor</title>
        <!-- Material Icons -->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@600;700&display=swap" rel="stylesheet">
        <style>
            /* Keep existing root variables */
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
                padding-top: 80px; /* Added to account for fixed header */
            }

            body::before {
                content: '';
                position: fixed; /* Changed to fixed */
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
                z-index: 1001; /* Increased z-index to be above header */
            }

            .main-container {
                position: relative;
                z-index: 1;
                max-width: 1200px;
                margin: 0 auto;
                display: flex;
                flex-direction: column;
                min-height: calc(100vh - 80px); /* Adjusted for fixed header */
            }

            .header {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                background: var(--header-bg);
                padding: 20px;
                color: white;
                z-index: 1000;
                box-shadow: 0 2px 10px var(--shadow);
                display: flex;
                justify-content: space-around;
                align-items: center;
                height: 80px; /* Fixed height for header */
            }

            .header h1 {
                display: flex;
                align-items: center;
                gap: 10px;
                font-size: 24px;
            }

            .content-wrapper {
                background: var(--card-bg);
                border-radius: 24px;
                box-shadow: 0 20px 25px -5px var(--shadow);
                border: 1px solid var(--border);
                backdrop-filter: blur(10px);
                margin: 20px;
                flex: 1;
                overflow: hidden;
            }

            .content {
                padding: 40px;
                background: var(--card-bg);
            }

            /* For Welcome Message */
                    .welcome-title {
                                font-family: 'Poppins', sans-serif;
                                font-size: 2rem;
                                margin-bottom: 2rem;
                                color: var(--primary);
                                background: linear-gradient(120deg, var(--primary) 0%, var(--accent) 100%);
                                -webkit-background-clip: text;
                                -webkit-text-fill-color: transparent;
                                animation: fadeInScale 0.8s ease-out;
                    }

            /* Keep existing form styles */
            .section-title {
                font-family: 'Poppins', sans-serif;
                font-size: 24px;
                font-weight: 700;
                color: var(--primary);
                margin-bottom: 24px;
            }

            .form-group {
                margin-bottom: 24px;
            }

            .form-group label {
                display: block;
                margin-bottom: 8px;
                color: var(--text-secondary);
                font-weight: 500;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .form-group input,
            .form-group textarea,
            .form-group select {
                width: 100%;
                padding: 14px;
                border: 1px solid var(--border);
                border-radius: 12px;
                background: var(--input-bg);
                color: var(--text-primary);
                font-size: 14px;
                transition: all 0.3s ease;
            }

            .form-group input:focus,
            .form-group textarea:focus,
            .form-group select:focus {
                outline: none;
                border-color: var(--primary);
                box-shadow: 0 0 0 4px rgba(124, 58, 237, 0.1);
            }

            textarea {
                min-height: 120px;
                resize: vertical;
            }

            .submit-btn {
                background: var(--header-bg);
                color: white;
                border: none;
                border-radius: 12px;
                padding: 14px 28px;
                font-size: 16px;
                font-weight: 500;
                cursor: pointer;
                display: inline-flex;
                align-items: center;
                gap: 8px;
                transition: all 0.3s ease;
                text-decoration: none;
            }

            .submit-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 15px var(--shadow);
            }

            .footer {
                text-align: center;
                padding: 24px;
                color: var(--text-secondary);
                border-top: 1px solid var(--border);
                background: var(--card-bg);
            }

            @media (max-width: 640px) {
                body {
                    padding-top: 70px; /* Slightly reduced for mobile */
                }

                .header {
                    height: 70px;
                }

                .content-wrapper {
                    margin: 10px;
                    border-radius: 12px;
                }

                .content {
                    padding: 20px;
                }

                .section-title {
                    font-size: 20px;
                }

                .header h1 {
                    font-size: 20px;
                }
            }




            <div class="form-group">
                <div></div>
                <label for="productImage">
                    <span class="material-icons">image</span>
                    Product Image
                </label>
                <div class="image-upload-container">
                    <input type="file"
                           id="productImage"
                           name="productImage"
                           accept="image/*"
                           class="file-input"
                           required
                           onchange="previewImage(event)">
                    <div class="image-preview" id="imagePreview">
                        <img id="preview" src="#" alt="Preview" style="display: none;">
                        <span class="placeholder-text">No image selected</span>
                    </div>
                </div>
            </div>



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
        <!-- Theme Toggle Button -->
        <button class="theme-toggle" onclick="toggleTheme()" aria-label="Toggle theme">
            <span class="material-icons">dark_mode</span>
        </button>

        <!-- Fixed Header -->
        <header class="header">
                <!-- Back to Dashboard Button -->
                  <a href="${pageContext.request.contextPath}/xyz" class="back-dashboard-btn">
                    <span class="material-icons">arrow_back</span>
                    Back to Dashboard
                  </a>

                <h1>
                  <span class="material-icons">store</span>
                  Online Home Decor
                </h1>
                <div class="hidden-class"></div>
                <div class="header-actions">

                  <!-- Theme Toggle Button -->
                  <button class="theme-toggle" onclick="toggleTheme()" aria-label="Toggle theme">
                    <span class="material-icons">dark_mode</span>
                  </button>



          </div>
        </header>

        <div class="main-container">
            <div class="content-wrapper">
                <main class="content">
                    <h1 class="welcome-title">Welcome <% out.print(session.getAttribute("name")); %></h1>
                    <h2 class="section-title">Add New Product</h2>

                    <form id="productForm" action="${pageContext.request.contextPath}/products/add" method="POST" enctype="multipart/form-data">
                        <div class="form-group">
                            <label for="name">
                                <span class="material-icons">inventory_2</span>
                                Product Name
                            </label>
                            <input type="text" id="name" name="name" required maxlength="200" placeholder="Enter product name">
                        </div>

                        <div class="form-group">
                            <label for="description">
                                <span class="material-icons">description</span>
                                Description
                            </label>
                            <textarea id="description" name="description" placeholder="Enter product description"></textarea>
                        </div>

                        <div class="form-group">
                            <label for="price">
                                <span class="material-icons">payments</span>
                                Price
                            </label>
                            <input type="number" id="price" name="price" step="0.01" min="0" required placeholder="Enter price">
                        </div>

                        <div class="form-group">
                            <label for="category">
                                <span class="material-icons">category</span>
                                Category
                            </label>
                            <select id="category" name="category_id" required>
                                <option value="">Select Category</option>
                                <option value="19">Furniture</option>
                                <option value="20">Wallpaper</option>
                                <option value="21">Artifacts</option>
                            </select>
                        </div>

                     <!--   <div class="form-group">
                            <label for="shop_id">
                                <span class="material-icons">store</span>
                                Shop ID
                            </label>
                            <input type="number" id="shop_id" name="shop_id" required min="1" placeholder="Enter shop ID">
                        </div>

                        <div class="form-group">
                            <label for="seller_id">
                                <span class="material-icons">person</span>
                                Seller ID
                            </label>
                            <input type="number" id="seller_id" name="seller_id" required min="1" placeholder="Enter seller ID">
                        </div>  --!>

                        <div class="form-group">
                            <label for="productImage">
                                <span class="material-icons">image</span>
                                Product Image
                            </label>
                            <div class="image-upload-container">
                                <input type="file"
                                       id="productImage"
                                       name="productImage"
                                       accept="image/*"
                                       class="file-input"
                                       required
                                       onchange="previewImage(event)">
                                <div class="image-preview" id="imagePreview">
                                    <img id="preview" src="#" alt="Preview" style="display: none;">
                                    <span class="placeholder-text">No image selected</span>
                                </div>
                            </div>
                        </div>

                       <button type="submit" class="submit-btn">
                              <span class="material-icons">add_circle</span>
                              Add Product
                          </button>
                    </form>
                </main>

                <footer class="footer">
                    © [2024-2025] Copyrights by Yash TECHNOLOGIES | All Rights Reserved
                </footer>
            </div>
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

        <script>
            // Existing theme toggle code...

            // Image preview functionality
            function previewImage(event) {
                const reader = new FileReader();
                const image = document.getElementById('preview');
                const placeholder = document.querySelector('.placeholder-text');

                reader.onload = function() {
                    image.src = reader.result;
                    image.style.display = 'block';
                    placeholder.style.display = 'none';
                }

                if(event.target.files[0]) {
                    reader.readAsDataURL(event.target.files[0]);
                }
            }

            // Drag and drop functionality
            const dropZone = document.getElementById('productImage');

            ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
                dropZone.addEventListener(eventName, preventDefaults, false);
            });

            function preventDefaults (e) {
                e.preventDefault();
                e.stopPropagation();
            }

            ['dragenter', 'dragover'].forEach(eventName => {
                dropZone.addEventListener(eventName, highlight, false);
            });

            ['dragleave', 'drop'].forEach(eventName => {
                dropZone.addEventListener(eventName, unhighlight, false);
            });

            function highlight(e) {
                dropZone.classList.add('drag-over');
            }

            function unhighlight(e) {
                dropZone.classList.remove('drag-over');
            }

            dropZone.addEventListener('drop', handleDrop, false);

            function handleDrop(e) {
                const dt = e.dataTransfer;
                const files = dt.files;

                dropZone.files = files;
                previewImage({target: {files: files}});
            }

            // Update form validation
            document.getElementById('productForm').addEventListener('submit', function(event) {
                const requiredFields = ['name', 'price', 'categoryId', 'shopId', 'sellerId', 'productImage'];
                let isValid = true;

                requiredFields.forEach(field => {
                    const input = document.getElementById(field);
                    if (!input.value.trim()) {
                        isValid = false;
                        input.classList.add('error');
                    }
                });

                if (!isValid) {
                    event.preventDefault();
                    alert('Please fill in all required fields and select an image');
                }
            });
        </script>

    </body>
</html>