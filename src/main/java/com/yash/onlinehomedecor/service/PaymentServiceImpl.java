package com.yash.onlinehomedecor.service;



import com.razorpay.Order;
import com.razorpay.RazorpayClient;
import com.razorpay.RazorpayException;
import com.razorpay.Utils;  // Add this import
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class PaymentServiceImpl implements PaymentService {

    private String keyId = "rzp_test_BZSOgBnXQoiSLs";
    private String keySecret = "7w4e5De2WRns6f886ErSLi2b";

    public RazorpayClient getRazorpayClient() throws RazorpayException {
        return new RazorpayClient(keyId, keySecret);
    }

    public String createOrder(int amount, String currency, String receipt) {
        try {
            RazorpayClient razorpay = getRazorpayClient();
            JSONObject orderRequest = new JSONObject();
            orderRequest.put("amount", amount * 100); // amount in paisa
            orderRequest.put("currency", currency);
            orderRequest.put("receipt", receipt);
            Order order = razorpay.orders.create(orderRequest);
            return order.get("id");
        } catch (Exception e) {
            throw new RuntimeException("Error creating Razorpay order", e);
        }
    }

    public boolean verifySignature(String orderId, String paymentId, String signature) {
        try {
            // Generate the expected signature using the secret key
            String data = orderId + "|" + paymentId;

            // Verify the signature
            return Utils.verifySignature(data, signature, keySecret);

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
