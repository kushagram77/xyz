package com.yash.onlinehomedecor.dao;



import com.yash.onlinehomedecor.domain.ProductReview;

import java.util.List;

public interface ProductReviewDAO {
    // Create a new review
    void addReview(ProductReview review);

    // Get review by ID
    ProductReview getReviewById(int reviewId);

    // Get all reviews for a specific product
    List<ProductReview> getReviewsByProductId(int productId);

    // Get reviews by user
    List<ProductReview> getReviewsByUserId(int userId);

    // Update review status (for moderation)
    void updateReviewStatus(int reviewId, ProductReview.ReviewStatus status);

    // Calculate average rating for a product
    double getAverageRatingForProduct(int productId);

    // Get total number of reviews for a product
    int getTotalReviewCountForProduct(int productId);

    // Delete a review (admin or user functionality)
    void deleteReview(int reviewId);

    List<ProductReview>getAllReviews();
}
