package com.yash.onlinehomedecor.rm;


import com.yash.onlinehomedecor.domain.ProductReview;
import org.springframework.jdbc.core.RowMapper;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ProductReviewRowMapper implements RowMapper<ProductReview> {
    @Override
    public ProductReview mapRow(ResultSet rs, int rowNum) throws SQLException {
        ProductReview review = new ProductReview();

        review.setId(rs.getInt("id"));
        review.setOrderId(rs.getInt("order_id"));
        review.setProductId(rs.getInt("product_id"));
        review.setUserId(rs.getInt("user_id"));
        review.setRating(rs.getInt("rating"));
      //  review.setUserEmail(rs.getString("user_email"));
//      review.setProductName(rs.getString("product_name"));

        // Handle potential null review text
        String reviewText = rs.getString("review_text");
        review.setReviewText(reviewText != null ? reviewText : "");

        // Convert timestamp to LocalDateTime
        review.setReviewDate(rs.getTimestamp("review_date").toLocalDateTime());

        // Convert string to enum
        review.setStatus(ProductReview.ReviewStatus.valueOf(rs.getString("status")));

        return review;
    }
}
