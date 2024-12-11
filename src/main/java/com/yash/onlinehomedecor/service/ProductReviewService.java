package com.yash.onlinehomedecor.service;


import com.yash.onlinehomedecor.domain.ProductReview;

import java.util.List;

public interface ProductReviewService {
    // Submit a new review
    void submitReview(ProductReview review);

    // Validate if a user can submit a review for a specific product
    boolean canSubmitReview(int userId, int productId);

    // Get reviews for a product (approved only)
    List<ProductReview> getApprovedReviewsForProduct(int productId);

    // Get product rating summary
    ProductRatingSummary getProductRatingSummary(int productId);

    // Moderate reviews (for admin)
    void approveReview(int reviewId);
    void hideReview(int reviewId);

    // Get user's reviews
    List<ProductReview> getUserReviews(int userId);

    // Inner class for rating summary
    class ProductRatingSummary {
        private double averageRating;
        private int totalReviews;
        private int[] ratingDistribution;

        // Constructor, getters, and setters
        public ProductRatingSummary(double averageRating, int totalReviews, int[] ratingDistribution) {
            this.averageRating = averageRating;
            this.totalReviews = totalReviews;
            this.ratingDistribution = ratingDistribution;
        }

        // Getters and setters
        public double getAverageRating() {
            return averageRating;
        }

        public int getTotalReviews() {
            return totalReviews;
        }

        public int[] getRatingDistribution() {
            return ratingDistribution;
        }
    }

    List<ProductReview> getAllReviews();
}
