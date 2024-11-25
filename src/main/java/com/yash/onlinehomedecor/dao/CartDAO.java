
package com.yash.onlinehomedecor.dao;

import com.yash.onlinehomedecor.domain.Cart;
import com.yash.onlinehomedecor.domain.CartItem;

public interface CartDAO {
    Cart getCartByUserId(Integer userId);
    void createCart(Cart cart);
    void addItemToCart(CartItem item);
    void updateCartItem(CartItem item);
    void removeCartItem(Integer cartItemId);
    CartItem getCartItem(Integer cartItemId);
    void removeFromCartItemBasedOnProductId(Integer productId);
    void deleteByUserId(Integer userId);

    Integer getCartItemCount(Integer userId);
}

