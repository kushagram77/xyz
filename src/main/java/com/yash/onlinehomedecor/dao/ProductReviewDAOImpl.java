package com.yash.onlinehomedecor.dao;



import com.yash.onlinehomedecor.domain.ProductReview;
import com.yash.onlinehomedecor.rm.ProductReviewRowMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class ProductReviewDAOImpl extends BaseDAO implements ProductReviewDAO {




    @Override
    public void addReview(ProductReview review) {
        String sql = "INSERT INTO product_reviews " +
                "(order_id, product_id, user_id, rating, review_text, status, review_date) " +
                "VALUES (:order_id, :product_id, :user_id, :rating, :review_text, :status, NOW())";

        Map<String, Object> params = new HashMap<>();
        params.put("order_id", review.getOrderId());
        params.put("product_id", review.getProductId());
        params.put("user_id", review.getUserId());
        params.put("rating", review.getRating());
        params.put("review_text", review.getReviewText());
        params.put("status", review.getStatus().name());

        KeyHolder keyHolder = new GeneratedKeyHolder();
        SqlParameterSource sqlParams = new MapSqlParameterSource(params);

        super.getNamedParameterJdbcTemplate().update(sql, sqlParams, keyHolder);

        review.setId(keyHolder.getKey().intValue());
    }

    @Override
    public ProductReview getReviewById(int reviewId) {
        String sql = "SELECT * FROM product_reviews WHERE id = ?";

        try {
            return getJdbcTemplate().queryForObject(sql,

                    new ProductReviewRowMapper(),

                    reviewId
            );
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public List<ProductReview> getReviewsByProductId(int productId) {
        String sql = "SELECT * FROM product_reviews " +
                "WHERE product_id = ? AND status = 'APPROVED' " +
                "ORDER BY review_date DESC";

        return getJdbcTemplate().query(sql,

                new ProductReviewRowMapper()
        );
    }

    @Override
    public List<ProductReview> getReviewsByUserId(int userId) {
        String sql = "SELECT * FROM product_reviews " +
                "WHERE user_id = ? " +
                "ORDER BY review_date DESC";

        return getJdbcTemplate().query(sql,
                new Object[]{userId},
                new ProductReviewRowMapper()
        );
    }

    @Override
    public void updateReviewStatus(int reviewId, ProductReview.ReviewStatus status) {
        String sql = "UPDATE product_reviews SET status = ? WHERE id = ?";

        getJdbcTemplate().update(sql, status.name(), reviewId);
    }

    @Override
    public double getAverageRatingForProduct(int productId) {
        String sql = "SELECT AVG(rating) FROM product_reviews " +
                "WHERE product_id = ? AND status = 'APPROVED'";

        try {
            return getJdbcTemplate().queryForObject(sql,
                    new Object[]{productId},
                    Double.class
            );
        } catch (Exception e) {
            return 0.0;
        }
    }

    @Override
    public int getTotalReviewCountForProduct(int productId) {
        String sql = "SELECT COUNT(*) FROM product_reviews " +
                "WHERE product_id = ? AND status = 'APPROVED'";

        return getJdbcTemplate().queryForObject(sql,
                new Object[]{productId},
                Integer.class
        );
    }

    @Override
    public void deleteReview(int reviewId) {
        String sql = "DELETE FROM product_reviews WHERE id = ?";

        getJdbcTemplate().update(sql, reviewId);
    }

    @Override
    public List<ProductReview> getAllReviews() {
        String sql="SELECT * FROM product_reviews";
        try {
            return getJdbcTemplate().query(sql, new ProductReviewRowMapper());
        } catch (Exception e) {
            // Log the exception
            return Collections.emptyList();
        }


    }
}
