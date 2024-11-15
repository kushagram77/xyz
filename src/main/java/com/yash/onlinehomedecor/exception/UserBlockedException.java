package com.yash.onlinehomedecor.exception;


public class UserBlockedException extends Exception {




    private String errorCode;


    public UserBlockedException() {
        super();
    }


    public UserBlockedException(String errDesc) {
        super(errDesc);
    }


    public UserBlockedException(String errDesc, String errorCode) {
        super(errDesc);
        this.errorCode = errorCode;
    }


    public String getErrorCode() {
        return errorCode;
    }
}