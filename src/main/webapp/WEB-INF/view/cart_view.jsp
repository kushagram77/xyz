<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>Shopping Cart - Online Home Decor</title>
    <style>
        /* Include the common styles from the products page */

        .cart-table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }

        .cart-table th,
        .cart-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }

        .cart-table th {
            background-color: #f8f9fa;
            font-weight: 600;
            color: #2c3e50;
        }

        .quantity-input {
            width: 60px;
            padding: 5px;
            border: 1px solid #ddd;
            border-radius: 4px;
            text-align: center;
        }

        .remove-btn {
            background: #dc3545;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 4px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .remove-btn:hover {
            background: #c82333;
        }

        .cart-summary {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-top: 20px;
        }

        .cart-total {
            font-size: 1.2rem;
            font-weight: 600;
            color: #2c3e50;
            text-align: right;
        }

        .checkout-btn {
            background: #28a745;
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 4px;
            cursor: pointer;
            float: right;
            margin-top: 20px;
            transition: background 0.3s ease;
        }

        .checkout-btn:hover {
            background: #218838;
        }

        .empty-cart {
            text-align: center;
            padding: 50px 20px;
            color: #6c757d;
        }

        .continue-shopping {
            display: inline-block;
            padding: 10px 20px;
            background: #2c3e50;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            margin-top: 20px;
        }
    </style>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
    <div class="container">
        <div class="card">
            <div class="header">
                <h1>Shopping Cart</h1>
            </div>

            <div class="content">
                <c:choose>
                    <c:when test="${empty cart.items}">
                        <div class="empty-cart">
                            <h3>Your cart is empty</h3>
                            <p>Looks like you haven't added any items to your cart yet.</p>
                            <a href="/products" class="continue-shopping">Continue Shopping</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <table class="cart-table">
                            <thead>
                                <tr>
                                    <th>Product</th>
                                    <th>Price</th>
                                    <th>Quantity</th>
                                    <th>Total</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${cart.items}" var="item">
                                    <tr data-item-id="${item.id}">
                                        <td>${item.product.name}</td>
                                        <td>₹${item.product.price}</td>
                                        <td>
                                            <input type="number"
                                                   class="quantity-input"
                                                   value="${item.quantity}"
                                                   min="1"
                                                   onchange="updateQuantity(${item.id}, this.value)">
                                        </td>
                                        <td>₹${item.product.price * item.quantity}</td>
                                        <td>
                                            <button class="remove-btn"
                                                    onclick="removeItem(${item.id})">
                                                Remove
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>

                        <div class="cart-summary">
                            <div class="cart-total">
                                Total: ₹${cart.total}
                            </div>
                            <button class="checkout-btn" onclick="window.location.href='/checkout'">
                                Proceed to Checkout
                            </button>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="footer">
                ©[2024-2025] Copyrights by Yash TECHNOLOGIES | All Rights Reserved
            </div>
        </div>
    </div>

    <script>
        function updateQuantity(cartItemId, quantity) {
            $.ajax({
                url: '/cart/update',
                method: 'POST',
                data: {
                    cartItemId: cartItemId,
                    quantity: quantity
                },
                success: function() {
                    location.reload();
                },
                error: function() {
                    alert('Error updating quantity');
                }
            });
        }

        function removeItem(cartItemId) {
            if (confirm('Are you sure you want to remove this item?')) {
                $.ajax({
                    url: '/cart/remove',
                    method: 'POST',
                    data: {
                        cartItemId: cartItemId
                    },
                    success: function() {
                        location.reload();
                    },
                    error: function() {
                        alert('Error removing item');
                    }
                });
            }
        }
    </script>
</body>
</html>