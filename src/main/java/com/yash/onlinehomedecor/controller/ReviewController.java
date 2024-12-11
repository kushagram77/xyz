package com.yash.onlinehomedecor.controller;

import com.yash.onlinehomedecor.domain.Order;
import com.yash.onlinehomedecor.domain.ProductReview;
import com.yash.onlinehomedecor.domain.User;
import com.yash.onlinehomedecor.service.OrderService;
import com.yash.onlinehomedecor.service.ProductReviewService;
import com.yash.onlinehomedecor.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;

@Controller
@RequestMapping("/order")
public class ReviewController {

    @Autowired
    private ProductReviewService reviewService;

    @Autowired
    private UserService userService;

    @Autowired
    private OrderService orderService;


    @GetMapping("/review/{orderId}")
    public String showReviewPage(@PathVariable int orderId, Model model, Principal principal) {
        Order order = orderService.getOrderById(orderId);
        model.addAttribute("orderId", orderId);
        model.addAttribute("productId", order.getProductId());
        return "product-review";
    }



    @PostMapping("/submit-review")
    public String submitReview(
            @RequestParam("orderId") int orderId,
            @RequestParam("productId") int productId,
            @RequestParam("rating") int rating,
            @RequestParam(value = "reviewText", required = false) String reviewText,
            Principal principal,
            RedirectAttributes redirectAttributes
    ) {
        try {
            // Validate input parameters
            if (orderId <= 0 || productId <= 0 || rating < 1 || rating > 5) {
                throw new IllegalArgumentException("Invalid review parameters");
            }

            // Get the current logged-in user
//            String username = principal.getName();
            String username="Pratham";
            User currentUser = userService.findByUserName(username);

            if (currentUser == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "User not authenticated");
                return "redirect:/login";
            }

            // Create and save the review
            ProductReview review = new ProductReview();
            review.setOrderId(orderId);
            review.setProductId(productId);
            review.setUserId(currentUser.getId());
            review.setRating(rating);
            review.setReviewText(reviewText);
            review.setStatus(ProductReview.ReviewStatus.PENDING);

            reviewService.submitReview(review);

            redirectAttributes.addFlashAttribute("successMessage", "Thank you for your review!");
          //  return "redirect:/products/details/" + productId;
            return "redirect:/payment-success";
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to submit review: " + e.getMessage());
            return "redirect:/order/review/" + orderId;
        }
    }


}
