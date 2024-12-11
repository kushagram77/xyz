package com.yash.onlinehomedecor.service;

import com.yash.onlinehomedecor.domain.Cart;

public interface CartService {
    Cart getOrCreateCart(Integer userId);
    void addToCart(Integer userId, Integer productId, Integer quantity);
    //void updateCartItemQuantity(Integer cartItemId, Integer quantity);
    public void updateCartItemQuantity(Integer cartItemId, int quantity);
    void removeFromCart(Integer cartItemId);
    Cart getCart(Integer userId);
    void removeFromCartItemBasedOnProductId(Integer productId);
    Integer getCartItemCount(Integer userId);
    Integer createOrdersFromCart(int userId, String shippingAddress);
    Integer getOrderIdFromCart();

}
