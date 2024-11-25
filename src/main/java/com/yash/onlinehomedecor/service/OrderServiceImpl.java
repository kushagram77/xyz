package com.yash.onlinehomedecor.service;


import com.yash.onlinehomedecor.dao.OrderDAO;
import com.yash.onlinehomedecor.domain.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderDAO orderDAO;

    @Override
    public List<Order> getOrdersBySellerId(int sellerId) {
        return orderDAO.getOrdersBySellerId(sellerId);
    }

    @Override
    public void updateOrderStatus(int orderId, String status) {
        orderDAO.updateOrderStatus(orderId, status);
    }

    @Override
    public Order getOrderById(int orderId) {
        return orderDAO.findById(orderId);
    }
}

