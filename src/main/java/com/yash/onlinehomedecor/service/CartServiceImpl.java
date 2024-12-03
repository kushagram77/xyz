package com.yash.onlinehomedecor.service;

import com.yash.onlinehomedecor.dao.CartDAO;
import com.yash.onlinehomedecor.dao.OrderDAO;
import com.yash.onlinehomedecor.domain.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class CartServiceImpl implements CartService {

    @Autowired
    private CartDAO cartDAO;

    @Autowired
    private ProductService productService;

    @Autowired
    private OrderDAO orderDAO;

    @Autowired
    private UserService userService;

    @Override
    @Transactional
    public Cart getOrCreateCart(Integer userId) {
        System.out.println("In cart  service ");
        Cart cart = cartDAO.getCartByUserId(userId);
        if (cart == null) {
            cart = new Cart();
            cart.setUserId(userId);
            cartDAO.createCart(cart);
        }
        System.out.println("In cart service 2");
        return cart;
    }




    @Override
    @Transactional
    public void addToCart(Integer userId, Integer productId, Integer quantity) {
        Cart cart = getOrCreateCart(userId);
        Product product = productService.getProductById(productId);
        System.out.println("In service "+product.getId());
        CartItem item = new CartItem();
        item.setCartId(cart.getId());
        item.setProduct(product);
        item.setQuantity(quantity);

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

    public void removeFromCartItemBasedOnProductId(Integer productId){
        cartDAO.removeFromCartItemBasedOnProductId(productId);
    }

    @Override
    public Cart getCart(Integer userId) {
        return cartDAO.getCartByUserId(userId);
    }

    @Override
    public Integer getCartItemCount(Integer userId) {
        return cartDAO.getCartItemCount(userId);
    }

    @Transactional
    @Override
    public Integer createOrdersFromCart(int userId, String shippingAddress) {
        // Get all active cart items for the user
        List<CartItem> cartItems = cartDAO.getActiveCartItems(userId);
        System.out.println("IN createOrdersFromCart Service layer");
        Integer orderId=0;
        // Create an order for each cart item
        for (CartItem item : cartItems) {
            System.out.println("kushagraaaa");
            Order order = new Order();

            order.setUserId(userId);

            order.setSellerId(item.getProduct().getSeller_id());

            order.setProductId(item.getProduct().getId());

            order.setProductName(item.getProduct().getName());

            order.setQuantity(item.getQuantity());

            order.setPrice(item.getProduct().getPrice());
            order.setStatus("PENDING");

            order.setShippingAddress(shippingAddress);

            order.setCustomerName(getUserName(userId)); // You'll need to implement this method

            // Save the order
            orderId = orderDAO.save(order);
        }

        // Clear the cart after creating orders
        cartDAO.clearCart(userId);
        return orderId;
    }

    // Helper method to get user's name - implement based on your user service
    private String getUserName(int userId) {
        // Implement logic to fetch user's name from database or user service
        User user=userService.findById(userId);
        String customerName=user.getName();
        return customerName; // Placeholder
    }

    public Integer getOrderIdFromCart(){
        return cartDAO.getOrderIdFromCart();
    }
}