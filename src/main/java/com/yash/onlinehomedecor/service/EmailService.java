package com.yash.onlinehomedecor.service;



import com.yash.onlinehomedecor.domain.User;

public interface EmailService {
    boolean sendRegistrationEmail(User user);
}
