<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<%
    // Static data for cart items
    class CartItem {
        int id;
        String name;
        double price;
        int quantity;
        String image;

        CartItem(int id, String name, double price, int quantity, String image) {
            this.id = id;
            this.name = name;
            this.price = price;
            this.quantity = quantity;
            this.image = image;
        }
    }

    List<CartItem> cartItems = new ArrayList<>();
    cartItems.add(new CartItem(1, "Modern Wall Clock", 1299.00, 1, "/api/placeholder/100/100"));
    cartItems.add(new CartItem(2, "Decorative Vase", 899.00, 2, "/api/placeholder/100/100"));
    cartItems.add(new CartItem(3, "Table Lamp", 1499.00, 1, "/api/placeholder/100/100"));

    // Calculate total
    double total = 0;
    for(CartItem item : cartItems) {
        total += item.price * item.quantity;
    }

    request.setAttribute("cartItems", cartItems);
    request.setAttribute("cartTotal", total);
%>

<!DOCTYPE html>
<html data-theme="light">
<head>
    <meta charset="UTF-8">
    <title>Shopping Cart - Online Home Decor</title>
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

        .navbar-brand {
            color: white !important;
            font-family: 'Poppins', sans-serif;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .nav-link {
            color: white !important;
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 8px 16px !important;
            transition: background-color 0.3s;
        }

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

        /* Cart styles */
        .cart-container {
            background: var(--card-bg);
            border-radius: 16px;
            padding: 24px;
            margin-top: 24px;
            box-shadow: 0 4px 12px var(--shadow);
            border: 1px solid var(--border);
        }

        .cart-item {
            display: flex;
            align-items: center;
            padding: 16px;
            border-bottom: 1px solid var(--border);
            gap: 16px;
        }

        .cart-item:last-child {
            border-bottom: none;
        }

        .item-image {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 8px;
        }

        .item-details {
            flex-grow: 1;
        }

        .item-name {
            color: var(--text-primary);
            font-weight: 600;
            margin-bottom: 4px;
        }

        .item-price {
            color: var(--primary);
            font-weight: 600;
        }

        .quantity-controls {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .quantity-btn {
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 4px;
            width: 30px;
            height: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .quantity-btn:hover {
            background: var(--primary-dark);
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
            padding: 8px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 4px;
            transition: opacity 0.3s;
        }

        .remove-btn:hover {
            opacity: 0.9;
        }

        .cart-summary {
            background: var(--card-bg);
            border-radius: 16px;
            padding: 24px;
            margin-top: 24px;
            box-shadow: 0 4px 12px var(--shadow);
            border: 1px solid var(--border);
            position: sticky;
            top: calc(var(--navbar-height) + 24px);
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 12px;
        }

        .summary-total {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--primary);
        }

        .checkout-btn {
            background: var(--success) !important;
            color: white;
            border: none;
            border-radius: 8px;
            padding: 12px 24px;
            width: 100%;
            font-weight: 600;
            margin-top: 16px;
            cursor: pointer;
            transition: opacity 0.3s;
        }

        .checkout-btn:hover {
            opacity: 0.9;
        }

        .empty-cart {
            text-align: center;
            padding: 48px;
            color: var(--text-secondary);
        }

        .continue-shopping {
            color: var(--primary);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 8px;
            margin-top: 24px;
            font-weight: 500;
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
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="/admin/dashboard">
                <span class="material-icons">shopping_bag</span>
                Shopping Cart
            </a>
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
                <button class="theme-toggle" onclick="toggleTheme()" aria-label="Toggle theme">
                    <span class="material-icons">dark_mode</span>
                </button>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="row">
            <div class="col-md-8">
                <div class="cart-container">
                    <h2 class="mb-4">Shopping Cart</h2>
                    <c:choose>
                        <c:when test="${empty cartItems}">
                            <div class="empty-cart">
                                <span class="material-icons" style="font-size: 48px; margin-bottom: 16px;">shopping_cart</span>
                                <h3>Your cart is empty</h3>
                                <p>Add some products to your cart and they will show up here</p>
                                <a href="/OHDSpring/products" class="continue-shopping">
                                    <span class="material-icons">arrow_back</span>
                                    Continue Shopping
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${cartItems}" var="item">
                                <div class="cart-item">
                                    <img src="${item.product.imagePath}" alt="${item.product.name}" class="item-image">
                                    <div class="item-details">
                                        <h3 class="item-name">Curtain</h3>
                                        <div class="item-price">782</div>
                                    </div>
                                    <div class="quantity-controls">
                                        <button class="quantity-btn" onclick="updateQuantity(${item.id}, ${item.quantity - 1})">-</button>
                                        <input type="number" class="quantity-input" value="${item.quantity}"
                                               onchange="updateQuantity(${item.id}, this.value)" min="1">
                                        <button class="quantity-btn" onclick="updateQuantity(${item.id}, ${item.quantity + 1})">+</button>
                                    </div>
                                    <button class="remove-btn" onclick="removeItem(${item.id})">
                                        <span class="material-icons">delete</span>
                                        Remove
                                    </button>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <div class="col-md-4">
                <div class="cart-summary">
                    <h3 class="mb-4">Order Summary</h3>
                    <div class="summary-row">
                        <span>Subtotal</span>
                        <span>₹782</span>
                    </div>
                    <div class="summary-row">
                        <span>Shipping</span>
                        <span>₹0.00</span>
                    </div>
                    <hr>
                    <div class="summary-row summary-total">
                        <span>Total</span>
                        <span>782</span>
                    </div>
                    <button class="checkout-btn" onclick="proceedToCheckout()">
                        Proceed to Checkout
                    </button>
                </div>
            </div>
        </div>
    </div>

    <footer class="footer">
        © 2024-2025 Copyrights by Yash Technologies | All Rights Reserved
    </footer>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

    <script>
            // Initialize theme on page load
            document.addEventListener('DOMContentLoaded', () => {
                const savedTheme = localStorage.getItem('theme') || 'light';
                document.documentElement.setAttribute('data-theme', savedTheme);
                const icon = document.querySelector('.theme-toggle .material-icons');
                icon.textContent = savedTheme === 'light' ? 'dark_mode' : 'light_mode';
            });

            function toggleTheme() {
                const html = document.documentElement;
                const theme = html.getAttribute('data-theme');
                const newTheme = theme === 'light' ? 'dark' : 'light';
                html.setAttribute('data-theme', newTheme);

                const icon = document.querySelector('.theme-toggle .material-icons');
                icon.textContent = newTheme === 'light' ? 'dark_mode' : 'light_mode';

                localStorage.setItem('theme', newTheme);
            }

            function updateQuantity(itemId, quantity) {
                if (quantity < 1) return;

                $.ajax({
                    url: '/api/cart/update',
                    method: 'POST',
                    data: {
                        itemId: itemId,
                        quantity: quantity
                    },
                    success: function(response) {
                        // Refresh the page to show updated cart
                        window.location.reload();
                    },
                    error: function(xhr, status, error) {
                        alert('Failed to update quantity. Please try again.');
                    }
                });
            }

            function removeItem(itemId) {
                if (!confirm('Are you sure you want to remove this item from your cart?')) {
                    return;
                }

                $.ajax({
                    url: '/api/cart/remove',
                    method: 'POST',
                    data: {
                        itemId: itemId
                    },
                    success: function(response) {
                        // Remove the item from DOM and update total
                        const itemElement = document.querySelector(`.cart-item[data-id="${itemId}"]`);
                        if (itemElement) {
                            itemElement.remove();
                            updateCartTotal();
                        }

                        // If cart becomes empty, show empty cart message
                        const cartItems = document.querySelectorAll('.cart-item');
                        if (cartItems.length === 0) {
                            const cartContainer = document.querySelector('.cart-container');
                            cartContainer.innerHTML = `
                                <div class="empty-cart">
                                    <span class="material-icons" style="font-size: 48px; margin-bottom: 16px;">shopping_cart</span>
                                    <h3>Your cart is empty</h3>
                                    <p>Add some products to your cart and they will show up here</p>
                                    <a href="/OHDSpring/products" class="continue-shopping">
                                        <span class="material-icons">arrow_back</span>
                                        Continue Shopping
                                    </a>
                                </div>
                            `;
                        }
                    },
                    error: function(xhr, status, error) {
                        alert('Failed to remove item. Please try again.');
                    }
                });
            }

            function updateCartTotal() {
                let total = 0;
                document.querySelectorAll('.cart-item').forEach(item => {
                    const price = parseFloat(item.querySelector('.item-price').textContent.replace('₹', ''));
                    const quantity = parseInt(item.querySelector('.quantity-input').value);
                    total += price * quantity;
                });

                // Update subtotal and total in summary
                const subtotalElement = document.querySelector('.summary-row:first-child span:last-child');
                const totalElement = document.querySelector('.summary-total span:last-child');

                if (subtotalElement && totalElement) {
                    subtotalElement.textContent = `₹${total.toFixed(2)}`;
                    totalElement.textContent = `₹${total.toFixed(2)}`;
                }
            }

            function proceedToCheckout() {
                // Check if cart is not empty
                const cartItems = document.querySelectorAll('.cart-item');
                if (cartItems.length === 0) {
                    alert('Your cart is empty. Please add items before checking out.');
                    return;
                }

                // Redirect to checkout page
                window.location.href = '/OHDSpring/checkout';
            }

            // Add input validation for quantity
            document.querySelectorAll('.quantity-input').forEach(input => {
                input.addEventListener('input', function() {
                    const value = parseInt(this.value);
                    if (isNaN(value) || value < 1) {
                        this.value = 1;
                    }
                });
            });

            // Prevent form submission on enter key in quantity input
            document.querySelectorAll('.quantity-input').forEach(input => {
                input.addEventListener('keypress', function(e) {
                    if (e.key === 'Enter') {
                        e.preventDefault();
                        this.blur();
                    }
                });
            });
        </script>

 <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>