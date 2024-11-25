package com.yash.onlinehomedecor.service;


import com.yash.onlinehomedecor.dao.FeedbackDAO;
import com.yash.onlinehomedecor.domain.Feedback;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class FeedbackServiceImpl implements FeedbackService {

    @Autowired
    private FeedbackDAO feedbackDAO;

    @Override
    public boolean submitFeedback(Feedback feedback) {
        try {
            // Additional business logic can be added here
            // For example, setting default status, validating input, etc.
            if (feedback.getStatus() == null) {
                feedback.setStatus("pending");
            }

            // Log or perform any pre-submission checks
            feedbackDAO.insertFeedback(feedback);
            return true;
        } catch (Exception e) {
            // Log the exception
            return false;
        }
    }

    @Override
    @Transactional(readOnly = true)
    public List<Feedback> getAllFeedback() {
        return feedbackDAO.getAllFeedback();
    }

    @Override
    @Transactional(readOnly = true)
    public Feedback getFeedbackById(Integer id) {
        return feedbackDAO.getFeedbackById(id);
    }

    @Override
    public boolean updateFeedbackStatus(Integer id, String status) {
        try {
            // Potential business logic validation
            if (id == null || status == null) {
                return false;
            }

            feedbackDAO.updateFeedbackStatus(id, status);
            return true;
        } catch (Exception e) {
            // Log the exception
            return false;
        }
    }

    @Override
    @Transactional(readOnly = true)
    public int getTotalFeedbackCount() {
        return feedbackDAO.getTotalFeedbackCount();
    }
}

