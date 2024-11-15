package com.yash.onlinehomedecor.rm;

import com.yash.onlinehomedecor.domain.Product;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ProductRowMapper implements RowMapper<Product> {
    @Override
    public Product mapRow(ResultSet rs, int rowNum) throws SQLException {
        Product p = new Product();
        p.setId(rs.getInt("id"));
        p.setName(rs.getString("name"));
        p.setDescription(rs.getString("description"));
        p.setPrice(rs.getInt("price"));

        /*
        * Put p.setCategory_id to diutinguish methods from domain ProductCategories
        *
        * */

        p.setCategory_id(rs.getInt("category_id"));
        p.setSeller_id(rs.getInt("seller_id"));
        p.setShop_id(rs.getInt("shop_id"));
        return p;
    }
}
