<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html data-theme="light">
<head>
    <meta charset="UTF-8">
    <title>Products - Online Home Decor</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@600;700&display=swap" rel="stylesheet">
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

        /* Updated navbar styles */
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

        .navbar .container {
            position: relative;
        }

        .navbar-brand {
            color: white !important;
            font-family: 'Poppins', sans-serif;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .nav-and-controls {
            margin-left: auto;
            gap: 20px;
        }

        .nav-link {
            color: white !important;
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 8px 16px !important;
            transition: background-color 0.3s;
        }

        .nav-link:hover {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 8px;
        }

        /* Header controls */
        .header-controls {
            display: flex;
            gap: 15px;
            align-items: center;
        }

        /* Theme toggle */
        .theme-toggle {
            background: var(--card-bg);
            border: 1px solid var(--border);
            border-radius: 50%;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            box-shadow: 0 2px 8px var(--shadow);
            transition: transform 0.3s ease;
        }

        .theme-toggle:hover {
            transform: scale(1.1);
        }

        .theme-toggle .material-icons {
            color: var(--primary);
            font-size: 20px;
        }

        /* Cart icon */
        .cart-icon {
            background: var(--card-bg);
            color: var(--text-primary);
            padding: 8px 16px;
            border-radius: 20px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 2px 8px var(--shadow);
            border: 1px solid var(--border);
            font-size: 0.9rem;
            transition: transform 0.3s ease;
        }

        .cart-icon:hover {
            transform: scale(1.05);
        }

        /* For Welcome Message */
        .welcome-title {
                    font-family: 'Poppins', sans-serif;
                    font-size: 2rem;
                    margin-bottom: 2rem;
                    color: white;
                    background: linear-gradient(120deg, var(--primary) 0%, var(--accent) 100%);
                    -webkit-background-clip: text;
                    -webkit-text-fill-color: transparent;
                    animation: fadeInScale 0.8s ease-out;
        }

        .cart-count {
            background: var(--primary);
            color: white;
            border-radius: 50%;
            padding: 2px 8px;
            font-size: 0.8rem;
        }

        /* Notification */
        .notification {
            position: fixed;
            top: calc(var(--navbar-height) + 20px);
            right: 20px;
            padding: 15px 25px;
            border-radius: 12px;
            color: white;
            display: none;
            z-index: 1000;
            background: var(--success);
            box-shadow: 0 4px 12px var(--shadow);
        }

        /* Product card */
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

        .add-to-cart-btn {
            background: var(--primary) !important;
            border: none !important;
            padding: 10px 20px !important;
            border-radius: 8px !important;
            transition: all 0.3s ease !important;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .add-to-cart-btn:hover {
            background: var(--primary-dark) !important;
            transform: translateY(-2px);
        }

        /* Footer */
        .footer {
            text-align: center;
            padding: 24px;
            background: var(--card-bg);
            color: var(--text-secondary);
            position: relative;
            margin-top: 40px;
            border-top: 1px solid var(--border);
        }

        /* Responsive styles */
        @media (max-width: 768px) {
            .nav-and-controls {
                gap: 10px;
            }

            .navbar-collapse {
                position: absolute;
                top: 70px;
                left: 0;
                right: 0;
                background: var(--header-bg);
                padding: 10px;
            }

            .header-controls {
                margin-right: 60px;
            }

            .cart-icon {
                padding: 8px 12px;
            }

            .theme-toggle {
                width: 35px;
                height: 35px;
            }

            .product-card {
                margin: 8px;
            }
        }
    </style>

    <style>
            /* Add this new style for product images */
            .product-image {
                width: 100%;
                height: 200px;
                object-fit: cover;
                border-radius: 8px;
                margin-bottom: 16px;
            }

            /* Add image placeholder style */
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

            .image-placeholder .material-icons {
                font-size: 48px;
                color: var(--text-secondary);
            }

            /* ... for getting image through db ... */
        </style>


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
        </script>


    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>

    <%
    		if(session.getAttribute("userId")==null)
    		{
    			response.sendRedirect("/OHDSpring/index");
    		}

    	 %>


    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="/admin/dashboard">
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
                            <a class="nav-link" href="/OHDSpring/index">
                                <span class="material-icons">logout</span>
                                Logout
                            </a>
                        </li>
                    </ul>
                </div>
                <div class="header-controls">
                    <div class="cart-icon" onclick="window.location.href='/OHDSpring/cart'">
                        <span class="material-icons">shopping_cart</span>
                        Cart <span class="cart-count">0</span>
                    </div>
                    <button class="theme-toggle" onclick="toggleTheme()" aria-label="Toggle theme">
                        <span class="material-icons">dark_mode</span>
                    </button>
                </div>
            </div>
        </div>
    </nav>

    <div class="notification" id="notification"></div>


    <div class="container">
        <h1 style="margin-top: 20px" class="welcome-title">Welcome <% out.print(session.getAttribute("name")); %></h1>

           <!----- <div class="row">
                <div class="col-12">
                    <h1 class="text-center mb-4" style="color: var(--text-primary);">Online Home Decor - Products</h1>
                </div>
            </div>-----!>

            <div class="row">
                <c:forEach items="${products}" var="product">
                    <div class="col-md-4">
                        <div class="product-card">
                            <!-- -------- image display --------------- -->
                            <c:choose>
                                <c:when test="${not empty product.image}">
                                    <img

                                        src="<s:url value='/products/image/${product.id}'/>"
                                        alt="${product.name}"
                                        class="product-image"
                                        onload="handleImageLoad(this)"
                                        onerror="handleImageError(this)"
                                    />
                                    <script>
                                        console.log('Image URL for product ${product.id}:',
                                                   '${pageContext.request.contextPath}/products/image/${product.id}');
                                    </script>
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
                                <button class="btn btn-primary add-to-cart-btn" id="addToCart"
                                        data-product-id="${product.id}"
                                        data-product-name="${product.name}">
                                    <span class="material-icons">add_shopping_cart</span>
                                    Add to Cart
                                </button>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
    </div>

    <footer class="footer">
        © [2024-2025] Copyrights by Yash Technologies | All Rights Reserved
    </footer>

    <script>
        function showNotification(message, type) {
            var notification = $("#notification");
            notification.removeClass("success error").addClass(type).text(message).fadeIn();

            setTimeout(function() {
                notification.fadeOut();
            }, 3000);
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

       $(document).ready(function() {
           // Set initial theme
           const savedTheme = localStorage.getItem('theme') || 'light';
           document.documentElement.setAttribute('data-theme', savedTheme);
           const icon = document.querySelector('.theme-toggle .material-icons');
           icon.textContent = savedTheme === 'light' ? 'dark_mode' : 'light_mode';

           // Add to cart functionality
           $('.add-to-cart-btn').click(function() {
               var productId = $(this).data('product-id');
               var productName = $(this).data('product-name');

               $.ajax({
                   url: '${pageContext.request.contextPath}/cart/add',  // Updated URL
                   method: 'POST',  // Explicitly set the method
                   data: {productId: productId},
                   success: function(response) {
                       showNotification(`${productName} added to cart successfully!`, 'success');
                       updateCartCount();
                   },
                   error: function(xhr, status, error) {
                       console.error('Error adding to cart:', error);
                       showNotification('Failed to add item to cart', 'error');
                   }
               });
           });

           // Function to update cart count
           function updateCartCount() {
               $.ajax({
                   url: '${pageContext.request.contextPath}/cart/count',  // Updated URL
                   method: 'GET',  // Explicitly set the method
                   success: function(response) {
                       $('.cart-count').text(response);
                   },
                   error: function(xhr, status, error) {
                       console.error('Error updating cart count:', error);
                   }
               });
           }

           // Initial cart count update
           updateCartCount();
       });

       // Notification function
       function showNotification(message, type) {
           var notification = $("#notification");
           notification
               .css('background-color', type === 'success' ? 'var(--success)' : 'var(--error)')
               .text(message)
               .fadeIn();

           setTimeout(function() {
               notification.fadeOut();
           }, 3000);
       }


    </script>

    <!-- script for handling image errors -->
        <script>
            function handleImageError(img) {
                const placeholder = document.createElement('div');
                placeholder.className = 'image-placeholder';
                placeholder.innerHTML = '<span class="material-icons">image</span>';
                img.parentElement.replaceChild(placeholder, img);
            }
        </script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>