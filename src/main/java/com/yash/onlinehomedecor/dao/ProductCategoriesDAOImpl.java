package com.yash.onlinehomedecor.dao;



import com.yash.onlinehomedecor.domain.ProductCategories;
import com.yash.onlinehomedecor.rm.ProductCategoriesRowMapper;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class ProductCategoriesDAOImpl extends BaseDAO implements ProductCategoriesDAO {

    @Override
    public void save(ProductCategories category) {
        String sql = "INSERT INTO product_categories (name, created_by, shop_id) " +
                "VALUES (:name, :createdBy, :shopId)";

        Map<String, Object> params = new HashMap<>();
        params.put("name", category.getName());
        params.put("createdBy", category.getCreated_by());
        params.put("shopId", category.getShop_id());

        KeyHolder kh = new GeneratedKeyHolder();
        SqlParameterSource ps = new MapSqlParameterSource(params);
        super.getNamedParameterJdbcTemplate().update(sql, ps, kh);
        category.setId(kh.getKey().intValue());
    }

    @Override
    public void update(ProductCategories category) {
        String sql = "UPDATE product_categories SET " +
                "name = :name, " +
                "created_by = :createdBy, " +
                "shop_id = :shopId " +
                "WHERE id = :categoryId";

        Map<String, Object> params = new HashMap<>();
        params.put("name", category.getName());
        params.put("createdBy", category.getCreated_by());
        params.put("shopId", category.getShop_id());
        params.put("categoryId", category.getId());

        getNamedParameterJdbcTemplate().update(sql, params);
    }

    @Override
    public void delete(ProductCategories category) {
        this.delete(category.getId());
    }

    @Override
    public void delete(Integer categoryId) {
        String sql = "DELETE FROM product_categories WHERE id = ?";
        getJdbcTemplate().update(sql, categoryId);
    }

    @Override
    public ProductCategories findById(Integer categoryId) {
        String sql = "SELECT * FROM product_categories WHERE id = ?";
        return getJdbcTemplate().queryForObject(sql, new ProductCategoriesRowMapper(), categoryId);
    }

    @Override
    public List<ProductCategories> findAll() {
        String sql = "SELECT * FROM product_categories";
        return getJdbcTemplate().query(sql, new ProductCategoriesRowMapper());
    }

    @Override
    public List<ProductCategories> findByShop(Integer shopId) {
        String sql = "SELECT * FROM product_categories WHERE shop_id = ?";
        return getJdbcTemplate().query(sql, new ProductCategoriesRowMapper(), shopId);
    }

    @Override
    public List<ProductCategories> findByCreator(Integer creatorId) {
        String sql = "SELECT * FROM product_categories WHERE created_by = ?";
        return getJdbcTemplate().query(sql, new ProductCategoriesRowMapper(), creatorId);
    }
}