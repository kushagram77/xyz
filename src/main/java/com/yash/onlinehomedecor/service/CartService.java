package com.yash.onlinehomedecor.service;

import com.yash.onlinehomedecor.domain.Cart;
import com.yash.onlinehomedecor.domain.CartItem;

public interface CartService {
    Cart getOrCreateCart(Integer userId);
    void addToCart(Integer userId, Integer productId, Integer quantity);
    void updateCartItemQuantity(Integer cartItemId, Integer quantity);
    void removeFromCart(Integer cartItemId);
    Cart getCart(Integer userId);
    void removeFromCartItemBasedOnProductId(Integer productId);
    Integer getCartItemCount(Integer userId);

}
