package com.yash.onlinehomedecor.service;



import com.yash.onlinehomedecor.domain.Order;
import java.util.List;

public interface OrderService {
    List<Order> getOrdersBySellerId(int sellerId);
    void updateOrderStatus(int orderId, String status);
    Order getOrderById(int orderId);
    List<Order> findByProductId(Integer productId);
    public List<Order> findAll();
}