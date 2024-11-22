package com.yash.onlinehomedecor.command;
//command is used to convert values obtained from jsp form to domain or entity
public class LoginCommand {
    private String loginName; // This will be the user's email
    private String password;
    private String userType;
    // Getters and Setters
    public String getLoginName() {
        return loginName;
    }

    public void setLoginName(String loginName) {
        this.loginName = loginName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUserType() {

        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }
}