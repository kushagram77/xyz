package com.yash.onlinehomedecor.service;

import com.razorpay.RazorpayClient;
import com.razorpay.RazorpayException;

public interface PaymentService {

      RazorpayClient getRazorpayClient() throws RazorpayException;
    public String createOrder(int amount, String currency, String receipt);
    public boolean verifySignature(String orderId, String paymentId, String signature);



}
