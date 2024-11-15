<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Online Home Decor</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .dashboard-card {
            transition: transform 0.2s;
        }
        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body class="bg-light">




    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="/admin/dashboard">Admin Dashboard</a>
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

    <div class="container mt-4">
        <h2 class="mb-4">Welcome, Admin!</h2>

        <div class="row">
                                    <!-- Manage Buyers Card -->
            <div class="col-md-4 mb-4">
                <div class="card dashboard-card">
                    <div class="card-body text-center">
                        <h5 class="card-title">Manage Buyers</h5>
                        <p class="card-text">View and manage all registered buyers</p>
                        <a href="admin/buyers" class="btn btn-primary">View Buyers</a>
                    </div>
                </div>
            </div>

                                <!-- Manage Sellers Card -->
            <div class="col-md-4 mb-4">
                <div class="card dashboard-card">
                    <div class="card-body text-center">
                        <h5 class="card-title">Manage Sellers</h5>
                        <p class="card-text">Approve or reject seller applications</p>
                        <a href="admin/sellers" class="btn btn-primary">View Sellers</a>
                    </div>
                </div>
            </div>

                                     <!-- Manage Products Card -->
            <div class="col-md-4 mb-4">
                <div class="card dashboard-card">
                    <div class="card-body text-center">
                        <h5 class="card-title">Manage Products</h5>
                        <p class="card-text">View and manage all products</p>
                        <a href="admin/products" class="btn btn-primary">View Products</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Buyers List Modal -->
    <div class="modal fade" id="buyersModal">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Manage Buyers</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${buyers}" var="buyer">
                                <tr>
                                    <td>23</td>
                                    <td>Sanvi</td>
                                    <td>sanvi@yash.com</td>
                                    <td>
                                        <button class="btn btn-sm btn-danger">Block</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Sellers List Modal -->
    <div class="modal fade" id="sellersModal">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Manage Sellers</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${sellers}" var="seller">
                                <tr>
                                    <td>${seller.id}</td>
                                    <td>${seller.name}</td>
                                    <td>${seller.email}</td>
                                    <td>${seller.status}</td>
                                    <td>
                                        <form action="/admin/sellers/${seller.id}/approve" method="POST" style="display: inline;">
                                            <button type="submit" class="btn btn-sm btn-success">Approve</button>
                                        </form>
                                        <form action="/admin/sellers/${seller.id}/reject" method="POST" style="display: inline;">
                                            <button type="submit" class="btn btn-sm btn-danger">Reject</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>