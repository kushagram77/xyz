package com.yash.onlinehomedecor.dao;

import com.yash.onlinehomedecor.domain.Cart;
import com.yash.onlinehomedecor.domain.CartItem;
import com.yash.onlinehomedecor.domain.Product;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcDaoSupport;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public class CartDAOImpl extends BaseDAO implements CartDAO {

    @Override
    public Cart getCartByUserId(Integer userId) {
        String sql = "SELECT * FROM cart WHERE user_id = :userId";
        MapSqlParameterSource params = new MapSqlParameterSource("userId", userId);

        Cart cart = getNamedParameterJdbcTemplate().query(sql, params, rs -> {
            if (rs.next()) {
                Cart c = new Cart();
                c.setId(rs.getInt("id"));
                c.setUserId(rs.getInt("user_id"));
                c.setCreatedAt(rs.getTimestamp("created_at"));
                c.setUpdatedAt(rs.getTimestamp("updated_at"));
                return c;
            }
            return null;
        });

        if (cart != null) {
            // Load cart items
//            String itemsSql = "SELECT ci.*, p.* FROM cart_items ci " +
//                    "JOIN products p ON ci.product_id = p.id " +
//                    "WHERE ci.cart_id = :cartId";

            String itemsSql = "SELECT ci.*, p.name, p.description, p.price, p.image " +
                    "FROM cart_items ci " +
                    "JOIN products p ON ci.product_id = p.id " +
                    "WHERE ci.cart_id = :cartId";
            params = new MapSqlParameterSource("cartId", cart.getId());

            List<CartItem> items = getNamedParameterJdbcTemplate().query(itemsSql, params, (rs, rowNum) -> {
                CartItem item = new CartItem();
                item.setId(rs.getInt("id"));
                item.setCartId(rs.getInt("cart_id"));
                item.setQuantity(rs.getInt("quantity"));

                Product product = new Product();
                product.setId(rs.getInt("product_id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getInt("price"));
                item.setProduct(product);

                return item;
            });

            cart.setCartItems(items);
        }

        return cart;
    }

    @Override
    public void createCart(Cart cart) {
        String sql = "INSERT INTO cart (user_id) VALUES (:userId)";
        KeyHolder kh = new GeneratedKeyHolder();
        MapSqlParameterSource params = new MapSqlParameterSource("userId", cart.getUserId());

        getNamedParameterJdbcTemplate().update(sql, params, kh);
        cart.setId(kh.getKey().intValue());
    }



    @Override
    public void addItemToCart(CartItem item) {
        String sql = "INSERT INTO cart_items (cart_id, product_id, quantity, price) " +
                "VALUES (:cartId, :productId, :quantity, :price)";

        MapSqlParameterSource params = new MapSqlParameterSource();
        params.addValue("cartId", item.getCartId());
        params.addValue("productId", item.getProduct().getId());
        params.addValue("quantity", item.getQuantity());
        params.addValue("price", item.getProduct().getPrice());

        getNamedParameterJdbcTemplate().update(sql, params);
    }



    @Override
    public void updateCartItem(CartItem item) {
        String sql = "UPDATE cart_items SET quantity = :quantity WHERE id = :id";

        MapSqlParameterSource params = new MapSqlParameterSource();
        params.addValue("quantity", item.getQuantity());
        params.addValue("id", item.getId());

        getNamedParameterJdbcTemplate().update(sql, params);
    }

    @Override
    public void removeCartItem(Integer cartItemId) {
        String sql = "DELETE FROM cart_items WHERE id = :id";
        MapSqlParameterSource params = new MapSqlParameterSource("id", cartItemId);
        getNamedParameterJdbcTemplate().update(sql, params);
    }

    @Override
    public CartItem getCartItem(Integer cartItemId) {
        String sql = "SELECT ci.*, p.* FROM cart_items ci " +
                "JOIN products p ON ci.product_id = p.id " +
                "WHERE ci.id = :id";

        MapSqlParameterSource params = new MapSqlParameterSource("id", cartItemId);

        return getNamedParameterJdbcTemplate().query(sql, params, rs -> {
            if (rs.next()) {
                CartItem item = new CartItem();
                item.setId(rs.getInt("id"));
                item.setCartId(rs.getInt("cart_id"));
                item.setQuantity(rs.getInt("quantity"));

                Product product = new Product();
                product.setId(rs.getInt("product_id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getInt("price"));
                item.setProduct(product);

                return item;
            }
            return null;
        });
    }

    public void removeFromCartItemBasedOnProductId(Integer productId){

        String sql = "DELETE FROM cart_items WHERE product_id = :productId";
        MapSqlParameterSource params = new MapSqlParameterSource("productId",productId);
        getNamedParameterJdbcTemplate().update(sql, params);
    }

    public void deleteByUserId(Integer userId){
        String sql="DELETE FROM cart where user_id = :userId";
        MapSqlParameterSource params=new MapSqlParameterSource("userId",userId);
        getNamedParameterJdbcTemplate().update(sql,params);
    }



    @Override
    public Integer getCartItemCount(Integer userId) {
        String sql = "SELECT COALESCE(SUM(ci.quantity), 0) " +
                "FROM cart c " +
                "LEFT JOIN cart_items ci ON c.id = ci.cart_id " +
                "WHERE c.user_id = :userId";

        MapSqlParameterSource params = new MapSqlParameterSource("userId", userId);

        return getNamedParameterJdbcTemplate().queryForObject(sql, params, Integer.class);
    }
}