package com.yash.onlinehomedecor.controller;



import com.yash.onlinehomedecor.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/seller/orders")
public class OrderController {

    @Autowired
    private OrderService orderService;

    @GetMapping
    public String listOrders(Model model, HttpSession session) {
        Integer sellerId = (Integer) session.getAttribute("userId");
        if (sellerId == null) {
            return "redirect:/login";
        }

        model.addAttribute("orders", orderService.getOrdersBySellerId(sellerId));
        return "seller_orders";
    }

    @PostMapping("/{orderId}/status")
    public String updateOrderStatus(@PathVariable int orderId,
                                    @RequestParam String status,
                                    RedirectAttributes redirectAttributes) {
        try {
            orderService.updateOrderStatus(orderId, status);
            redirectAttributes.addFlashAttribute("message", "Order status updated successfully");
            redirectAttributes.addFlashAttribute("messageType", "success");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("message", "Failed to update order status");
            redirectAttributes.addFlashAttribute("messageType", "error");
        }
        return "redirect:/seller/orders";
    }
}
