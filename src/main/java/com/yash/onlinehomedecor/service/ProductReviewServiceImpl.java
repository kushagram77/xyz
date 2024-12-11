package com.yash.onlinehomedecor.service;


import com.yash.onlinehomedecor.dao.OrderDAO;
import com.yash.onlinehomedecor.dao.ProductReviewDAO;
import com.yash.onlinehomedecor.domain.Order;
import com.yash.onlinehomedecor.domain.ProductReview;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ProductReviewServiceImpl implements ProductReviewService {

    @Autowired
    private ProductReviewDAO productReviewDAO;

    @Autowired
    private OrderDAO orderDAO;

    @Override
    @Transactional
    public void submitReview(ProductReview review) {
        // Validate review before submission
        if (!canSubmitReview(review.getUserId(), review.getProductId())) {
            throw new IllegalArgumentException("User is not eligible to submit this review");
        }

        // Set default status to PENDING
        review.setStatus(ProductReview.ReviewStatus.PENDING);

        // Save the review
        productReviewDAO.addReview(review);
    }

    @Override
    public boolean canSubmitReview(int userId, int productId) {
        // Check if the user has purchased the product
        List<Order> ls=orderDAO.findByProductId(productId);
        if(ls.get(0)!=null){
        return true;}
        else{
            return false;
        }
    }

    @Override
    public List<ProductReview> getApprovedReviewsForProduct(int productId) {
        return productReviewDAO.getReviewsByProductId(productId);
    }

    @Override
    public ProductRatingSummary getProductRatingSummary(int productId) {
        double averageRating = productReviewDAO.getAverageRatingForProduct(productId);
        int totalReviews = productReviewDAO.getTotalReviewCountForProduct(productId);

        // Calculate rating distribution
        int[] ratingDistribution = new int[5];
        List<ProductReview> reviews = getApprovedReviewsForProduct(productId);

        for (ProductReview review : reviews) {
            if (review.getRating() > 0 && review.getRating() <= 5) {
                ratingDistribution[review.getRating() - 1]++;
            }
        }

        return new ProductRatingSummary(averageRating, totalReviews, ratingDistribution);
    }

    @Override
    @Transactional
    public void approveReview(int reviewId) {
        productReviewDAO.updateReviewStatus(reviewId, ProductReview.ReviewStatus.APPROVED);
    }

    @Override
    @Transactional
    public void hideReview(int reviewId) {
        productReviewDAO.updateReviewStatus(reviewId, ProductReview.ReviewStatus.HIDDEN);
    }

    @Override
    public List<ProductReview> getUserReviews(int userId) {
        return productReviewDAO.getReviewsByUserId(userId);
    }

    public List<ProductReview> getAllReviews(){

        return productReviewDAO.getAllReviews();
    }
}
