
package com.yash.onlinehomedecor.controller;

import com.yash.onlinehomedecor.domain.Cart;
import com.yash.onlinehomedecor.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/cart")
public class CartController {

    @Autowired
    private CartService cartService;

    @GetMapping
    public String viewCart(HttpSession session, Model model) {
        Integer userId = (Integer) session.getAttribute("userId");
        Cart cart = cartService.getCart(userId);
        model.addAttribute("cart", cart);

        return "hello";
    }

    @RequestMapping("/add")
    @ResponseBody
    public ResponseEntity<?> addToCart(
            @RequestParam Integer productId,
            HttpSession session) {
        System.out.println("In cart controller start");
        System.out.println(productId);
        Integer userId = (Integer) session.getAttribute("userId");
        cartService.addToCart(userId, productId, 1);
        System.out.println("In cart controller");
        return ResponseEntity.ok().build();
    }

    @PostMapping("/update")
    @ResponseBody
    public ResponseEntity<?> updateQuantity(
            @RequestParam Integer cartItemId,
            @RequestParam Integer quantity) {
        cartService.updateCartItemQuantity(cartItemId, quantity);
        return ResponseEntity.ok().build();
    }

    @PostMapping("/remove")
    @ResponseBody
    public ResponseEntity<?> removeFromCart(@RequestParam Integer cartItemId) {
        cartService.removeFromCart(cartItemId);
        return ResponseEntity.ok().build();
    }

    @GetMapping("/count")
    @ResponseBody
    public Integer getCartCount(HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");
        return cartService.getCartItemCount(userId);
    }

}