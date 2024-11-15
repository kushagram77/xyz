<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add New Product - Home Decor</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        .container {
            width: 80%;
            margin: 20px auto;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
            color: #333;
        }

        .form-control {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }

        .form-row {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
        }

        .form-col {
            flex: 1;
        }

        select.form-control {
            background-color: white;
        }

        .checkbox-group {
            margin: 15px 0;
        }

        .submit-btn {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        .submit-btn:hover {
            background-color: #45a049;
        }

        textarea.form-control {
            min-height: 100px;
            resize: vertical;
        }

        .error-message {
            color: red;
            font-size: 14px;
            margin-top: 5px;
        }

        .success-message {
            color: green;
            font-size: 14px;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 style="margin-bottom: 20px;">Add New Product</h2>
        
        <form action="addProduct" method="POST" enctype="multipart/form-data">
            <div class="form-row">
                <div class="form-col">
                    <div class="form-group">
                        <label class="form-label">Product Name</label>
                        <input type="text" name="name" class="form-control" required>
                    </div>
                </div>
                <div class="form-col">
                    <div class="form-group">
                        <label class="form-label">Price</label>
                        <input type="number" name="price" class="form-control" step="0.01" required>
                    </div>
                </div>
            </div>




            <div class="form-group">
                <label class="form-label">Description</label>
                <textarea name="description" class="form-control" required></textarea>
            </div>

            <div class="form-row">
                <div class="form-col">
                    <div class="form-group">
                        <label class="form-label">Category</label>
                        <select name="category" class="form-control" required>
                            <option value="">Select Category</option>
                            <option value="1">Electronics</option>
                            <option value="2">Apparel</option>
                            <option value="3">Home Decor</option>
                        </select>
                    </div>
                </div>
                <div class="form-col">
                    <div class="form-group">
                        <label class="form-label">Product Image</label>
                        <input type="file" name="productImage" class="form-control" accept="image/*" required>
                    </div>
                </div>
            </div>

            <div class="checkbox-group">
                <input type="checkbox" name="available" id="available">
                <label for="available">Product Available</label>
            </div>

            <!-- Hidden fields for seller_id and shop_id -->
            <input type="hidden" name="seller_id" value="${sessionScope.userId}">
            <input type="hidden" name="shop_id" value="${sessionScope.shopId}">

            <button type="submit" class="submit-btn">Add Product</button>
        </form>

        <!-- Display success or error messages -->
        <% if (request.getAttribute("message") != null) { %>
            <p class="${requestScope.messageType == 'success' ? 'success-message' : 'error-message'}">
                <%= request.getAttribute("message") %>
            </p>
        <% } %>
    </div>
</body>
</html>