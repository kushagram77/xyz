package com.yash.onlinehomedecor.service;

import com.yash.onlinehomedecor.domain.User;
import com.yash.onlinehomedecor.exception.UserBlockedException;

import java.util.List;

public interface UserService {
    void register(User u);
    void update(User u);
    void delete(Integer userId);
    User login(String email, String password) throws UserBlockedException;
    List<User> getUserList();
    User findById(Integer userId);
    List<User> findByProperty(String propName, Object propValue);
    void blockUser(Integer userId);

    public boolean isEmailExists(String email);
    public User findByUserName(String name);
}