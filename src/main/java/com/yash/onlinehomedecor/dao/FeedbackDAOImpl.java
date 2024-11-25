package com.yash.onlinehomedecor.dao;
import com.yash.onlinehomedecor.domain.Feedback;
import com.yash.onlinehomedecor.rm.FeedbackRowMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class FeedbackDAOImpl  extends BaseDAO implements FeedbackDAO {



    @Override
    public void insertFeedback(Feedback feedback) {
        String sql = "INSERT INTO feedback (name, email, subject, message, status) " +
                "VALUES (?, ?, ?, ?, ?)";

        getJdbcTemplate().update(sql,feedback.getName(),
                feedback.getEmail(),
                feedback.getSubject(),
                feedback.getMessage(),
                feedback.getStatus());
    }

    @Override
    public List<Feedback> getAllFeedback() {
        String sql = "SELECT * FROM feedback ORDER BY id ";
        return getJdbcTemplate().query(sql,new FeedbackRowMapper());
    }

    @Override
    public Feedback getFeedbackById(Integer id) {
        try {
            String sql = "SELECT * FROM feedback WHERE id = ?";
            return getJdbcTemplate().queryForObject(sql,
                    new Object[]{id},
                    new FeedbackRowMapper()
            );
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public void updateFeedbackStatus(Integer id, String status) {
        String sql = "UPDATE feedback SET status = ?";
        getJdbcTemplate().update(sql, status, id);
    }

    @Override
    public int getTotalFeedbackCount() {
        String sql = "SELECT COUNT(*) FROM feedback";
        return getJdbcTemplate().queryForObject(sql, Integer.class);
    }
}

