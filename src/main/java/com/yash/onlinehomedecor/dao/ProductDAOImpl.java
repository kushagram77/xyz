package com.yash.onlinehomedecor.dao;

import com.yash.onlinehomedecor.domain.Product;
import com.yash.onlinehomedecor.rm.ProductRowMapper;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class ProductDAOImpl extends BaseDAO implements ProductDAO {

    @Override
    public void save(Product product) {
        String sql = "INSERT INTO products (name, description, price, category_id, seller_id, shop_id) " +
                "VALUES (:name, :description, :price, :categoryId, :sellerId, :shopId)";

        Map<String, Object> params = new HashMap<>();
        params.put("name", product.getName());
        params.put("description", product.getDescription());
        params.put("price", product.getPrice());
        params.put("categoryId", product.getCategory_id());
        params.put("sellerId", product.getSeller_id());
        params.put("shopId", product.getShop_id());

        KeyHolder kh = new GeneratedKeyHolder();
        SqlParameterSource ps = new MapSqlParameterSource(params);
        super.getNamedParameterJdbcTemplate().update(sql, ps, kh);
        product.setId(kh.getKey().intValue());
    }

    @Override
    public void update(Product product) {
        String sql = "UPDATE products SET " +
                "name = :name, " +
                "description = :description, " +
                "price = :price, " +
                "category_id = :categoryId, " +
                "seller_id = :sellerId, " +
                "shop_id = :shopId " +
                "WHERE id = :productId";

        Map<String, Object> params = new HashMap<>();
        params.put("name", product.getName());
        params.put("description", product.getDescription());
        params.put("price", product.getPrice());
        params.put("categoryId", product.getCategory_id());
        params.put("sellerId", product.getSeller_id());
        params.put("shopId", product.getShop_id());
        params.put("productId", product.getId());

        getNamedParameterJdbcTemplate().update(sql, params);
    }

    @Override
    public void delete(Product product) {
        this.delete(product.getId());
    }

    @Override
    public void delete(Integer productId) {
        String sql = "DELETE FROM products WHERE id = ?";
        getJdbcTemplate().update(sql, productId);
    }

    @Override
    public Product findById(Integer productId) {
        String sql = "SELECT * FROM products WHERE id = ?";
        return getJdbcTemplate().queryForObject(sql, new ProductRowMapper(), productId);
    }

    @Override
    public List<Product> findAll() {
        String sql = "SELECT * FROM products";
        return getJdbcTemplate().query(sql, new ProductRowMapper());
    }

    @Override
    public List<Product> findByCategory(Integer categoryId) {
        String sql = "SELECT * FROM products WHERE category_id = ?";
        return getJdbcTemplate().query(sql, new ProductRowMapper(), categoryId);
    }

    @Override
    public List<Product> findByShop(Integer shopId) {
        String sql = "SELECT * FROM products WHERE shop_id = ?";
        return getJdbcTemplate().query(sql, new ProductRowMapper(), shopId);
    }

    @Override
    public List<Product> findBySeller(Integer sellerId) {
        String sql = "SELECT * FROM products WHERE seller_id = ?";
        return getJdbcTemplate().query(sql, new ProductRowMapper(), sellerId);
    }
}