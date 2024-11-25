package com.yash.onlinehomedecor.dao;

import com.yash.onlinehomedecor.domain.Order;
import com.yash.onlinehomedecor.rm.OrderRowMapper;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class OrderDAOImpl extends BaseDAO implements OrderDAO {

    @Override
    public void save(Order order) {
        String sql = "INSERT INTO orders (user_id, seller_id, product_id, product_name, " +
                "quantity, price, status, order_date, shipping_address, customer_name) " +
                "VALUES (:userId, :sellerId, :productId, :productName, :quantity, " +
                ":price, :status, :orderDate, :shippingAddress, :customerName)";

        Map<String, Object> params = new HashMap<>();
        params.put("userId", order.getUserId());
        params.put("sellerId", order.getSellerId());
        params.put("productId", order.getProductId());
        params.put("productName", order.getProductName());
        params.put("quantity", order.getQuantity());
        params.put("price", order.getPrice());
        params.put("status", order.getStatus());
        params.put("orderDate", order.getOrderDate());
        params.put("shippingAddress", order.getShippingAddress());
        params.put("customerName", order.getCustomerName());

        KeyHolder kh = new GeneratedKeyHolder();
        SqlParameterSource ps = new MapSqlParameterSource(params);
        super.getNamedParameterJdbcTemplate().update(sql, ps, kh);
        order.setId(kh.getKey().intValue());
    }

    @Override
    public void update(Order order) {
        String sql = "UPDATE orders SET " +
                "user_id = :userId, " +
                "seller_id = :sellerId, " +
                "product_id = :productId, " +
                "product_name = :productName, " +
                "quantity = :quantity, " +
                "price = :price, " +
                "status = :status, " +
                "order_date = :orderDate, " +
                "shipping_address = :shippingAddress, " +
                "customer_name = :customerName " +
                "WHERE id = :orderId";

        Map<String, Object> params = new HashMap<>();
        params.put("userId", order.getUserId());
        params.put("sellerId", order.getSellerId());
        params.put("productId", order.getProductId());
        params.put("productName", order.getProductName());
        params.put("quantity", order.getQuantity());
        params.put("price", order.getPrice());
        params.put("status", order.getStatus());
        params.put("orderDate", order.getOrderDate());
        params.put("shippingAddress", order.getShippingAddress());
        params.put("customerName", order.getCustomerName());
        params.put("orderId", order.getId());

        getNamedParameterJdbcTemplate().update(sql, params);
    }

    @Override
    public void delete(Order order) {
        this.delete(order.getId());
    }

    @Override
    public void delete(Integer orderId) {
        String sql = "DELETE FROM orders WHERE id = ?";
        getJdbcTemplate().update(sql, orderId);
    }

    @Override
    public Order findById(Integer orderId) {
        String sql = "SELECT * FROM orders WHERE id = ?";
        return getJdbcTemplate().queryForObject(sql, new OrderRowMapper().orderRowMapper, orderId);
    }

    @Override
    public List<Order> findAll(Integer id) {
        return Collections.emptyList();
    }

    @Override
    public List<Order> findAll() {
        String sql = "SELECT * FROM orders";
        return getJdbcTemplate().query(sql, new OrderRowMapper().orderRowMapper);
    }

    @Override
    public List<Order> findByProperty(String propName, Object propValue) {
        String sql = "SELECT * FROM orders WHERE " + propName + " = ?";
        return getJdbcTemplate().query(sql, new OrderRowMapper().orderRowMapper, propValue);
    }

    // New method implementations
    @Override
    public List<Order> getOrdersBySellerId(int sellerId) {
        String sql = "SELECT * FROM orders WHERE seller_id = ?";
        return getJdbcTemplate().query(sql, new OrderRowMapper().orderRowMapper, sellerId);
    }

    @Override
    public void updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE orders SET status = :status WHERE id = :orderId";

        Map<String, Object> params = new HashMap<>();
        params.put("status", status);
        params.put("orderId", orderId);

        getNamedParameterJdbcTemplate().update(sql, params);
    }
}