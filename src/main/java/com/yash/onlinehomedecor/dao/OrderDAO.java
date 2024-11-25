package com.yash.onlinehomedecor.dao;




import com.yash.onlinehomedecor.domain.Order;
import java.util.List;

public interface OrderDAO {
    void save(Order order);
    void update(Order order);
    void delete(Order order);
    void delete(Integer orderId);
    Order findById(Integer orderId);
    List<Order> findAll();
    List<Order> findAll(Integer id);
    List<Order> findByProperty(String propName, Object propValue);
    List<Order> getOrdersBySellerId(int sellerId);
    void updateOrderStatus(int orderId, String status);
}
