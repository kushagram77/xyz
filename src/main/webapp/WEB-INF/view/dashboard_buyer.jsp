<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ page
isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Products - Online Home Decor</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
        }

        .notification {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 15px 25px;
            border-radius: 5px;
            color: white;
            display: none;
            z-index: 1000;
        }

        .success {
            background-color: #28a745;
        }

        .error {
            background-color: #dc3545;
        }

        .cart-icon {
            position: fixed;
            top: 20px;
            right: 20px;
            background: #2c3e50;
            color: white;
            padding: 10px 20px;
            border-radius: 25px;
            cursor: pointer;
            z-index: 999;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .cart-count {
            background: #00bfff;
            color: white;
            border-radius: 50%;
            padding: 2px 8px;
            font-size: 0.8rem;
        }

        .container {
            margin-top: 80px;
        }

        .product-card {
            border: 1px solid #dee2e6;
            border-radius: 5px;
            padding: 20px;
            margin: 10px;
            background-color: white;
            transition: transform 0.2s;
        }

        .product-card:hover {
            transform: scale(1.05);
        }

        .footer {
            text-align: center;
            padding: 20px;
            background-color: #343a40;
            color: white;
            position: relative;
            bottom: 0;
            width: 100%;
        }
    </style>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

    <script>





                function showNotification(message, type) {
                                               var notification = $("#notification");
                                               notification.removeClass("success error").addClass(type).text(message).fadeIn();

                                               // Hide notification after 3 seconds
                                               setTimeout(function() {
                                                   notification.fadeOut();
                                               }, 3000);
                                           }


    </script>


</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="/admin/dashboard">Buyer Dashboard</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="/OHDSpring/index">Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="cart-icon" onclick="window.location.href='/cart'">
        <i class="fas fa-shopping-cart"></i>
        Cart <span class="cart-count">0</span>
    </div>

    <div class="notification" id="notification"></div>

    <div class="container">
        <div class="card">
            <div class="header">
                <h1>Online Home Decor - Products</h1>
            </div>


            <div class="content">
                <div class="row">

                    <c:forEach items="${products}" var="product">
                        <div class="col-md-4">
                            <div class="product-card">

                                <div class="product-info">
                                    <h3 class="product-title">${product.name}</h3>
                                    <p class="product-description">${product.description}</p>
                                    <div class="product-price">₹${product.price}</div>
                                    <button class="btn btn-primary add-to-cart-btn" id="addToCart" data-product-id="${product.id}" data-product-name="${product.name}">
                                        Add to Cart
                                    </button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                </div>
            </div>

            <div class="footer">
                ©[2024-2025] Copyrights by Yash Technologies
            </div>
            </head>

            <script>
            $(document).ready(function() {
                $('.add-to-cart-btn').click(function() {
                    var productId = $(this).data('product-id');
                    var productName = $(this).data('product-name');

                    console.log(JSON.stringify({ id: productId, name: productName }))

                    $.ajax({
                        url: 'cart/add',
                        contentType: 'application/json',
                        data: {productId},
                        success: function(response) {
                            alert('Product added to cart: ' + productName);
                        }
                    });
                    showNotification(`${productName} added to cart successfully!`, 'success');
                });
            });


            </script>

        </html>