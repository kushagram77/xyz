package com.yash.onlinehomedecor.command;

import com.yash.onlinehomedecor.domain.User;
//command is used to convert values obtained from jsp form to domain or entity
public class UserCommand {
    private User user = new User(); // Initialize the user object in constructor or here

    // getters and setters
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Override
    public String toString() {
        return "UserCommand{" +
                "user=" + user +
                '}';
    }
}