package com.yash.onlinehomedecor.rm;

import com.yash.onlinehomedecor.domain.Product;
import org.springframework.jdbc.core.RowMapper;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ProductRowMapper implements RowMapper<Product> {
    @Override
    public Product mapRow(ResultSet rs, int rowNum) throws SQLException {
        Product product = new Product();
        product.setId(rs.getInt("id"));
        product.setName(rs.getString("name"));
        product.setDescription(rs.getString("description"));
        product.setPrice(rs.getInt("price"));
        product.setCategory_id(rs.getInt("category_id"));
        product.setSeller_id(rs.getInt("seller_id"));
        product.setShop_id(rs.getInt("shop_id"));

        // Properly fetch BLOB/BINARY data
        byte[] imageData = rs.getBytes("image"); // Use the correct column name here
        product.setImage(imageData);

        System.out.println("Mapping image data for product " + product.getId() +
                " - Image size: " + (imageData != null ? imageData.length : "null"));

        return product;
    }
}