package com.yash.onlinehomedecor.controller;

import com.yash.onlinehomedecor.command.PaymentCommand;
import com.yash.onlinehomedecor.service.PaymentService;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

import org.springframework.http.MediaType;
import org.springframework.http.HttpStatus;

@Controller
public class PaymentController {

    @Autowired
    private PaymentService paymentService;

    private String razorpayKeyId = "rzp_test_BZSOgBnXQoiSLs";

    @GetMapping("/checkout")
    public String showCheckoutPage(Model model) {
        System.out.println("IN checkout controller");
        model.addAttribute("razorpayKeyId", razorpayKeyId);
        return "redirect:index?act=pf";
    }

    @GetMapping(value = "/create-order", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<Map<String, Object>> createOrder(@RequestParam("amount") Integer amount, HttpSession session) {
        System.out.println("in create order controller !!!");
        Integer userId = (Integer) session.getAttribute("userId");

        if(userId == null) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("error", "User not logged in");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(errorResponse);
        }

        try {
            System.out.println("amount:" + amount);
            session.setAttribute("amount", amount);
            String orderId = paymentService.createOrder(amount, "INR", "receipt_" + System.currentTimeMillis());

            Map<String, Object> response = new HashMap<>();
            response.put("orderId", orderId);
            response.put("amount", amount);
            response.put("currency", "INR");
            response.put("key", razorpayKeyId);

            System.out.println("Order created with ID: " + orderId);
            System.out.println("Amount: " + amount);
            System.out.println("Key ID: " + razorpayKeyId);

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            e.printStackTrace();
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("error", "Error creating order: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }

    @PostMapping(value = "/verify", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<Map<String, Object>> verifyPayment(
            @RequestParam("razorpay_order_id") String razorpayOrderId,
            @RequestParam("razorpay_payment_id") String razorpayPaymentId,
            @RequestParam("razorpay_signature") String razorpaySignature) {

        System.out.println("Verifying payment...");
        System.out.println("Order ID: " + razorpayOrderId);
        System.out.println("Payment ID: " + razorpayPaymentId);

        Map<String, Object> response = new HashMap<>();

        try {
            boolean isValid = paymentService.verifySignature(
                    razorpayOrderId,
                    razorpayPaymentId,
                    razorpaySignature
            );

            if (isValid) {
                response.put("status", "success");
                response.put("message", "Payment verified successfully");
                return ResponseEntity.ok(response);
            } else {
                response.put("status", "failed");
                response.put("message", "Payment verification failed");
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.put("status", "error");
            response.put("message", "Error during payment verification: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    @RequestMapping("/payment-success")
    String success(){
        return "payment-success";
    }
}