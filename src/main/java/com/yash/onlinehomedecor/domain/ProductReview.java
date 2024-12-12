package com.yash.onlinehomedecor.domain;



import java.time.LocalDateTime;

public class ProductReview {
    private int id;
    private int orderId;
    private int productId;
    private int userId;
    private int rating;
    private String reviewText;
    private LocalDateTime reviewDate;
    private ReviewStatus status;

    // Constructors
    public ProductReview() {}

    public ProductReview(int orderId, int productId, int userId, int rating, String reviewText) {
        this.orderId = orderId;
        this.productId = productId;
        this.userId = userId;
        this.rating = rating;
        this.reviewText = reviewText;
        this.reviewDate = LocalDateTime.now();
        this.status = ReviewStatus.PENDING;
    }

    // Enum for review status
    public enum ReviewStatus {
        PENDING,
        APPROVED,
        HIDDEN
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getReviewText() {
        return reviewText;
    }

    public void setReviewText(String reviewText) {
        this.reviewText = reviewText;
    }

    public LocalDateTime getReviewDate() {
        return reviewDate;
    }

    public void setReviewDate(LocalDateTime reviewDate) {
        this.reviewDate = reviewDate;
    }

    public ReviewStatus getStatus() {
        return status;
    }

    public void setStatus(ReviewStatus status) {
        this.status = status;
    }


    private String userEmail;
    private String productName;

    // Add getters and setters
    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    // toString method for debugging
    @Override
    public String toString() {
        return "ProductReview{" +
                "id=" + id +
                ", orderId=" + orderId +
                ", productId=" + productId +
                ", userId=" + userId +
                ", rating=" + rating +
                ", reviewText='" + reviewText + '\'' +
                ", reviewDate=" + reviewDate +
                ", status=" + status +
                '}';
    }
}
