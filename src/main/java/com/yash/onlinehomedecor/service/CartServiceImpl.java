package com.yash.onlinehomedecor.service;

import com.yash.onlinehomedecor.dao.CartDAO;
import com.yash.onlinehomedecor.domain.Cart;
import com.yash.onlinehomedecor.domain.CartItem;
import com.yash.onlinehomedecor.domain.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class CartServiceImpl implements CartService {

    @Autowired
    private CartDAO cartDAO;

    @Autowired
    private ProductService productService;

    @Override
    @Transactional
    public Cart getOrCreateCart(Integer userId) {
        Cart cart = cartDAO.getCartByUserId(userId);
        if (cart == null) {
            cart = new Cart();
            cart.setUserId(userId);
            cartDAO.createCart(cart);
        }
        System.out.println("In cart service");
        return cart;
    }

    @Override
    @Transactional
    public void addToCart(Integer userId, Integer productId, Integer quantity) {

        Cart cart = getOrCreateCart(userId);
        Product product = productService.getProductById(productId);

        CartItem item = new CartItem();
        item.setCartId(cart.getId());
        item.setProduct(product);
        item.setQuantity(quantity);
        System.out.println("In cart service");
        cartDAO.addItemToCart(item);
    }

    @Override
    @Transactional
    public void updateCartItemQuantity(Integer cartItemId, Integer quantity) {
        CartItem item = cartDAO.getCartItem(cartItemId);
        if (item != null) {
            item.setQuantity(quantity);
            cartDAO.updateCartItem(item);
        }
    }

    @Override
    @Transactional
    public void removeFromCart(Integer cartItemId) {
        cartDAO.removeCartItem(cartItemId);
    }

    @Override
    public Cart getCart(Integer userId) {
        return cartDAO.getCartByUserId(userId);
    }

    @Override
    public Integer getCartItemCount(Integer userId) {
        return 108;
    }
}