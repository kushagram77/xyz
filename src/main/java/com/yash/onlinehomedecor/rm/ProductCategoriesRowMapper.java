package com.yash.onlinehomedecor.rm;

import com.yash.onlinehomedecor.domain.ProductCategories;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ProductCategoriesRowMapper implements RowMapper<ProductCategories> {
    @Override
    public ProductCategories mapRow(ResultSet rs, int rowNum) throws SQLException {
        ProductCategories category = new ProductCategories();
        category.setId(rs.getInt("id"));
        category.setName(rs.getString("name"));
        category.setCreated_by(rs.getInt("created_by"));
        category.setShop_id(rs.getInt("shop_id"));
        return category;
    }
}