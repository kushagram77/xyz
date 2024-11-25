package com.yash.onlinehomedecor.rm;

import com.yash.onlinehomedecor.domain.Order;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class OrderRowMapper {

     public RowMapper<Order> orderRowMapper = new RowMapper<Order>() {
        @Override
        public Order mapRow(ResultSet rs, int rowNum) throws SQLException {
            Order order = new Order();
            order.setId(rs.getInt("id"));
            order.setUserId(rs.getInt("user_id"));
            order.setSellerId(rs.getInt("seller_id"));
            order.setProductId(rs.getInt("product_id"));
            order.setProductName(rs.getString("product_name"));
            order.setQuantity(rs.getInt("quantity"));
            order.setPrice(rs.getDouble("price"));
            order.setStatus(rs.getString("status"));
            order.setOrderDate(rs.getTimestamp("order_date"));
            order.setShippingAddress(rs.getString("shipping_address"));
            order.setCustomerName(rs.getString("customer_name"));
            return order;
        }
    };
}
