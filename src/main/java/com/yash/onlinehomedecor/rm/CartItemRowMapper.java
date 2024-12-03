package com.yash.onlinehomedecor.rm;



import com.yash.onlinehomedecor.domain.CartItem;
import com.yash.onlinehomedecor.domain.Product;
import org.springframework.jdbc.core.RowMapper;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CartItemRowMapper implements RowMapper<CartItem> {
    @Override
    public CartItem mapRow(ResultSet rs, int rowNum) throws SQLException {
        CartItem cartItem = new CartItem();

        // Map basic cart item details
        cartItem.setId(rs.getInt("ci.id"));
        cartItem.setCartId(rs.getInt("ci.cart_id"));
        cartItem.setQuantity(rs.getInt("ci.quantity"));

        // Optional: If you want to map price from cart_items
        // cartItem.setPrice(rs.getInt("ci.price"));

        return cartItem;
    }
}
