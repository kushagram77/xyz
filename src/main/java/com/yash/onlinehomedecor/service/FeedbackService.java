package com.yash.onlinehomedecor.service;

import com.yash.onlinehomedecor.domain.Feedback;

import java.util.List;





public interface FeedbackService {

    boolean submitFeedback(Feedback feedback);


    List<Feedback> getAllFeedback();


    Feedback getFeedbackById(Integer id);


    boolean updateFeedbackStatus(Integer id, String status);


    int getTotalFeedbackCount();
}