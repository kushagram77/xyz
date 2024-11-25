package com.yash.onlinehomedecor.rm;



import com.yash.onlinehomedecor.domain.Feedback;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class FeedbackRowMapper implements RowMapper<Feedback> {

    @Override
    public Feedback mapRow(ResultSet rs, int rowNum) throws SQLException {
        Feedback feedback = new Feedback();

        feedback.setId(rs.getInt("id"));
        feedback.setName(rs.getString("name"));
        feedback.setEmail(rs.getString("email"));
        feedback.setSubject(rs.getString("subject"));
        feedback.setMessage(rs.getString("message"));
        feedback.setStatus(rs.getString("status"));


        // Handle null userId
//        Object userId = rs.getObject("user_id");
//        if (userId != null) {
//            feedback.setUserId((Integer) userId);
//        }

        return feedback;
    }
}
