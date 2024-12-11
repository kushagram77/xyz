<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html data-theme="light">
<head>
    <meta charset="UTF-8">
    <title>Shopping Cart - Online Home Decor</title>
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
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

        /* Navbar styles (same as product_list.jsp) */
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

        /* Cart specific styles */
        .cart-container {
            max-width: 1000px;
            margin: 2rem auto;
            padding: 0 1rem;
        }

        .cart-title {
            font-family: 'Poppins', sans-serif;
            font-size: 2rem;
            margin-bottom: 2rem;
            color: var(--text-primary);
        }

        .cart-item {
            background: var(--card-bg);
            border: 1px solid var(--border);
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 1.5rem;
            transition: transform 0.3s ease;
        }

        .cart-item:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px var(--shadow);
        }

        .cart-item-image {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 8px;
        }

        .cart-item-details {
            flex-grow: 1;
        }

        .cart-item-title {
            font-family: 'Poppins', sans-serif;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
        }

        .cart-item-price {
            color: var(--primary);
            font-weight: 600;
            font-size: 1.1rem;
        }

        .quantity-controls {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .quantity-btn {
            background: var(--bg-secondary);
            border: 1px solid var(--border);
            border-radius: 4px;
            padding: 4px 8px;
            cursor: pointer;
            color: var(--text-primary);
        }

        .quantity-input {
            width: 60px;
            text-align: center;
            border: 1px solid var(--border);
            border-radius: 4px;
            padding: 4px;
            background: var(--input-bg);
            color: var(--text-primary);
        }

        .remove-btn {
            background: var(--error);
            color: white;
            border: none;
            border-radius: 4px;
            padding: 8px 16px;
            cursor: pointer;
            transition: opacity 0.3s;
        }

        .remove-btn:hover {
            opacity: 0.9;
        }

        .cart-summary {
            background: var(--card-bg);
            border: 1px solid var(--border);
            border-radius: 12px;
            padding: 1.5rem;
            margin-top: 2rem;
        }

        .cart-total {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 1rem;
        }

        .checkout-btn {
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 8px;
            padding: 12px 24px;
            width: 100%;
            font-size: 1.1rem;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .checkout-btn:hover {
            background: var(--primary-dark);
        }

        .empty-cart {
            text-align: center;
            padding: 3rem;
            background: var(--card-bg);
            border-radius: 12px;
            margin-top: 2rem;
        }

        .empty-cart-icon {
            font-size: 4rem;
            color: var(--text-secondary);
            margin-bottom: 1rem;
        }

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

            .custom-nav-btn .material-icons {
                font-size: 20px;
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
            }

            .theme-toggle-new:hover {
                background: rgba(255, 255, 255, 0.2);
                transform: translateY(-2px);
            }

            .theme-toggle-new .material-icons {
                color: white;
                font-size: 20px;
                transition: transform 0.3s ease;
            }

            .theme-toggle-new:hover .material-icons {
                transform: rotate(180deg);
            }

            .header-controls {
                display: flex;
                align-items: center;
            }

            @media (max-width: 768px) {
                .custom-nav-btn {
                    margin: 4px 0;
                }

                .nav-and-controls {
                    flex-direction: column;
                    align-items: flex-start;
                }

                .header-controls {
                    margin-top: 8px;
                    width: 100%;
                    justify-content: flex-end;
                }

                .theme-toggle-new {
                    margin-left: 0;
                }
            }


    </style>

    <style>
        .notification {
            position: fixed;
            top: calc(var(--navbar-height) + 20px);
            right: 20px;
            padding: 15px 25px;
            border-radius: 8px;
            color: white;
            display: none;
            z-index: 1000;
            box-shadow: 0 4px 12px var(--shadow);
            animation: slideIn 0.3s ease-out;
        }

        @keyframes slideIn {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }

        .notification.success {
            background-color: var(--success);
        }

        .notification.error {
            background-color: var(--error);
        }
    </style>


</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="#">
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
    </nav>

    <div class="notification" id="notification"></div>

    <div class="cart-container">
        <h1 class="cart-title">Shopping Cart</h1>

        <c:choose>
            <c:when test="${empty cartItems}">
                <div class="empty-cart">
                    <span class="material-icons empty-cart-icon">shopping_cart</span>
                    <h2>Your cart is empty</h2>
                    <p>Looks like you haven't added any items to your cart yet.</p>
                    <a href="/OHDSpring/products/list" class="btn btn-primary mt-3">Continue Shopping</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="cart-items">
                    <c:forEach items="${cartItems}" var="item">
                        <div class="cart-item" data-item-id="${item.id}">

                            <c:choose>
                                <c:when test="${not empty item.product.image}">
                                    <img src="<s:url value='/products/image/${item.product.id}'/>"
                                         alt="${item.product.name}"
                                         class="cart-item-image"
                                         onerror="handleImageError(this)" />
                                </c:when>
                                <c:otherwise>
                                    <div class="image-placeholder cart-item-image">
                                        <span class="material-icons">image</span>
                                    </div>
                                </c:otherwise>
                            </c:choose>

                            <div class="cart-item-details">
                                <h3 class="cart-item-title">${item.product.name}</h3>
                                <p class="cart-item-price">₹${item.product.price}</p>
                            </div>

                            <div class="quantity-controls">
                               <button class="quantity-btn" onclick="updateQuantity(${item.id}, -1)">-</button>
                                <input type="number" class="quantity-input" value="${item.quantity}"
                                       min="1" onchange="updateQuantity(${item.id}, this.value)">
                              <button class="quantity-btn" onclick="updateQuantity(${item.id}, 1)">+</button>
                            </div>

                            <button class="remove-btn" onclick="removeItem(${item.id})">
                                <span class="material-icons">delete</span>
                            </button>
                        </div>
                    </c:forEach>
                </div>

                <div class="cart-summary">
                    <div class="cart-total">Total: ₹${cartTotal}</div>

                    <div class="delivery-info-section">
                            <h3 class="delivery-title">Delivery Information</h3>
                            <form id="deliveryForm">
                                <div class="row">
                                    <div class="col-md-12 mb-3">
                                        <label for="fullName" class="form-label">Full Name</label>
                                        <input type="text" class="form-control" id="fullName" required>
                                    </div>
                                    <div class="col-md-12 mb-3">
                                        <label for="address" class="form-label">Full Address</label>
                                        <textarea class="form-control" id="address" required rows="3"></textarea>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4 mb-3">
                                            <label for="state" class="form-label">State</label>
                                            <select class="form-select" id="state" required>
                                                <option value="">Select State</option>
                                                <option value="Maharashtra">Maharashtra</option>
                                                <option value="Karnataka">Karnataka</option>
                                                <option value="Tamil Nadu">Tamil Nadu</option>
                                                <!-- Add more states -->
                                            </select>
                                        </div>
                                        <div class="col-md-4 mb-3">
                                            <label for="city" class="form-label">City</label>
                                            <input type="text" class="form-control" id="city" required>
                                        </div>
                                        <div class="col-md-4 mb-3">
                                            <label for="pincode" class="form-label">Pincode</label>
                                            <input type="text" class="form-control" id="pincode"
                                                   pattern="[0-9]{6}"
                                                   title="Pincode must be 6 digits"
                                                   required>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    <form action="${pageContext.request.contextPath}/checkout" method="POST" id="checkoutForm">
                        <input type="hidden" name="amount" value="${cartTotal}">
                        <button type="button" class="checkout-btn" onclick="proceedToCheckout()">
                            Proceed to Checkout
                        </button>
                    </form>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

    <script>
        function showNotification(message, type) {
            const notification = $("#notification");
            notification.text(message)
                       .removeClass("success error")
                       .addClass(type)
                       .fadeIn();

            setTimeout(() => notification.fadeOut(), 3000);
        }

        function updateQuantity(cartItemId, change) {
            console.log("Updating quantity for cart item:", cartItemId);
            console.log("Change value:", change);

            let input = document.querySelector(`[data-item-id="${cartItemId}"] .quantity-input`);

            if (!input) {
                console.error("Could not find quantity input for cart item:", cartItemId);
                return;
            }

            let currentQuantity = parseInt(input.value);
            console.log("Current quantity:", currentQuantity);

            let newQuantity;
            if (typeof change === 'number') {
                newQuantity = currentQuantity + change;
            } else {
                newQuantity = parseInt(change);
            }

            newQuantity = Math.max(1, newQuantity);
            console.log("New quantity:", newQuantity);

            $.ajax({
                url: 'cart/update',  // Ensure this URL is correct and matches your controller mapping
                method: 'POST',
                data: {
                    cartItemId: cartItemId,
                    quantity: newQuantity
                },
                success: function(response) {
                    console.log("Cart update response:", response);
                    input.value = newQuantity;
                    location.reload();
                    showNotification("Cart updated successfully", "success");
                },
                error: function(xhr, status, error) {
                    console.error("Update cart error:", error);
                    console.error("XHR status:", status);
                    console.error("XHR response:", xhr.responseText);
                    showNotification("Failed to update cart", "error");
                }
            });
        }

        function removeItem(cartItemId) {
            $.ajax({
                url: 'cart/remove',
                method: 'POST',
                data: { cartItemId: cartItemId },
                success: function() {
                    $(`[data-item-id="${cartItemId}"]`).fadeOut(() => {
                        location.reload(); // Reload to update cart status
                    });
                    showNotification("Item removed from cart", "success");
                },
                error: function() {
                    showNotification("Failed to remove item", "error");
                }
            });
        }


    function proceedToCheckout() {
        const amount = ${cartTotal};

        // First create order on server
        $.ajax({
            url: '${pageContext.request.contextPath}/create-order',
            method: 'GET',
            data: {
                amount: amount
            },
            success: function(response) {
                console.log("Order created successfully:", response);

                // Initialize Razorpay payment
                var options = {
                    key: 'rzp_test_BZSOgBnXQoiSLs',
                    amount: amount * 100, // amount in paisa
                    currency: 'INR',
                    name: 'Online Home Decor',
                    description: 'Purchase Payment',
                    order_id: response.orderId,
                    handler: function(paymentResponse) {
                        verifyPayment(paymentResponse);
                    },
                    prefill: {
                        name: '${sessionScope.user.name}',
                        email: '${sessionScope.user.email}',
                        contact: ''
                    },
                    theme: {
                        color: '#7C3AED'
                    }
                };

                var rzp1 = new Razorpay(options);
                rzp1.on('payment.failed', function(failureResponse) {
                    console.error("Payment failed:", failureResponse);
                    showNotification("Payment failed! " + failureResponse.error.description, "error");
                });
                rzp1.open();
            },
            error: function(xhr, status, error) {
                console.error("Failed to create order:", error);
                console.error("Response:", xhr.responseText);
                showNotification("Failed to create order: " + (xhr.responseJSON?.error || error), "error");
            }
        });
    }

    function verifyPayment(response) {
        console.log("Verifying payment:", response);

        $.ajax({
            url: '${pageContext.request.contextPath}/verify',
            method: 'POST',
            data: {
                razorpay_payment_id: response.razorpay_payment_id,
                razorpay_order_id: response.razorpay_order_id,
                razorpay_signature: response.razorpay_signature
            },
            success: function(result) {
                console.log("Payment verification successful:", result);
                showNotification("Payment successful!", "success");
                // Clear cart and redirect to success page
                setTimeout(function() {
                    window.location.href = '${pageContext.request.contextPath}/payment-success';
                }, 2000);
            },
            error: function(xhr, status, error) {
                console.error("Payment verification failed:", error);
                console.error("Response:", xhr.responseText);
                showNotification("Payment verification failed!", "error");
            }
        });
    }

    function showNotification(message, type) {
        const notification = $("#notification");
        notification.text(message)
                   .removeClass("success error")
                   .addClass(type)
                   .fadeIn();

        console.log(`${type} notification: ${message}`);
        setTimeout(() => notification.fadeOut(), 3000);
    }
    // Enhance your existing showNotification function
    function showNotification(message, type) {
        const notification = $("#notification");
        notification.text(message)
                   .css('background-color', type === 'success' ? 'var(--success)' : 'var(--error)')
                   .fadeIn();

        setTimeout(() => notification.fadeOut(), 3000);
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

        function handleImageError(img) {
                    const placeholder = document.createElement('div');
                    placeholder.className = 'image-placeholder';
                    placeholder.innerHTML = '<span class="material-icons">image</span>';
                    img.parentElement.replaceChild(placeholder, img);
                }

                // Set initial theme on page load
                document.addEventListener('DOMContentLoaded', function() {
                    const savedTheme = localStorage.getItem('theme') || 'light';
                    document.documentElement.setAttribute('data-theme', savedTheme);
                    const icon = document.querySelector('.theme-toggle .material-icons');
                    icon.textContent = savedTheme === 'light' ? 'dark_mode' : 'light_mode';
                });

                // Add input validation for quantity
                document.querySelectorAll('.quantity-input').forEach(input => {
                    input.addEventListener('input', function() {
                        let value = parseInt(this.value);
                        if (isNaN(value) || value < 1) {
                            this.value = 1;
                        }
                    });
                });
            </script>
        </body>
        </html>