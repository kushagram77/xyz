package com.yash.onlinehomedecor.rm;

import com.yash.onlinehomedecor.domain.Product;
import com.yash.onlinehomedecor.domain.Shops;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ShopsRowMapper implements RowMapper<Shops> {
    @Override
    public Shops mapRow(ResultSet rs, int rowNum) throws SQLException {
        Shops shop = new Shops();
        shop.setId(rs.getInt("id"));
        shop.setUser_id(rs.getInt("user_id"));
        shop.setShop_name(rs.getString("shop_name"));
        shop.setShop_description(rs.getString("shop_description"));
        shop.setAddress_line1(rs.getString("address_line1"));
        shop.setCity(rs.getString("city"));
        shop.setState(rs.getString("state"));
        shop.setPostal_code(rs.getString("postal_code"));
        shop.setContact_phone(rs.getString("contact_phone"));
        shop.setBusiness_registration_number(rs.getString("business_registration_number"));
        shop.setStatus(Shops.ShopStatus.valueOf(rs.getString("status")));
        return shop;
    }
}