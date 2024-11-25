package com.yash.onlinehomedecor.dao;




import com.yash.onlinehomedecor.domain.Feedback;

import java.util.List;

public interface FeedbackDAO {

    void insertFeedback(Feedback feedback);


    List<Feedback> getAllFeedback();


    Feedback getFeedbackById(Integer id);


    void updateFeedbackStatus(Integer id, String status);


    int getTotalFeedbackCount();
}

