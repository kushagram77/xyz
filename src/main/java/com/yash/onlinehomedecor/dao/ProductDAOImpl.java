package com.yash.onlinehomedecor.dao;

import com.yash.onlinehomedecor.dao.ProductDAO;
import com.yash.onlinehomedecor.domain.Product;
import com.yash.onlinehomedecor.domain.ProductCategories;
import com.yash.onlinehomedecor.domain.Shops;
import com.yash.onlinehomedecor.rm.ProductCategoriesRowMapper;
import com.yash.onlinehomedecor.rm.ProductRowMapper;
import com.yash.onlinehomedecor.rm.ShopsRowMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

@Repository
public class ProductDAOImpl extends BaseDAO implements ProductDAO {


    @Override
    public void saveProduct(Product product) {
        String sql = "INSERT INTO products (name, description, price, category_id, seller_id, shop_id,image) " +
                "VALUES (:name, :description, :price, :category_id, :seller_id, :shop_id,:image)";
        Map m=new HashMap();
        m.put("name",product.getName());

        m.put("price",product.getPrice());
        m.put("category_id",product.getCategory_id());
        m.put("description",product.getDescription());
        m.put("seller_id",product.getSeller_id());
        m.put("shop_id",product.getShop_id());
        m.put("image",product.getImage());




        getNamedParameterJdbcTemplate().update(sql, m);
    }
    @Override
    public List<Product> getProductsBySellerId(int sellerId) {
        String sql = "SELECT * FROM products WHERE seller_id = ?";
        List<Product> ls=new ArrayList<>();
        ls=getJdbcTemplate().query(sql,new  ProductRowMapper(),sellerId);
        for(Product p:ls){
            System.out.println("In Product DAO:"+p.getDescription());
        }
        return getJdbcTemplate().query(sql, new ProductRowMapper(), sellerId);
    }

    @Override
    public List<Product> searchProductsByNameOrDescription(String query) {
        String sql = "SELECT * FROM products WHERE LOWER(name) LIKE ? OR LOWER(description) LIKE ?";
        String searchPattern = "%" + query.toLowerCase() + "%";
        return getJdbcTemplate().query(sql, new ProductRowMapper(), searchPattern, searchPattern);
    }

    @Override
    public List<Product> getAllProducts() {
        String sql = "SELECT * FROM products";
        return getJdbcTemplate().query(sql, new ProductRowMapper());
    }

    @Override
    public Product getProductById(int id) {
        String sql = "SELECT * FROM products WHERE id = ?";
        return getJdbcTemplate().queryForObject(sql, new ProductRowMapper(), id);
    }

    @Override
    public void updateProduct(Product product) {
        System.out.println("update call hui");
        String sql = "UPDATE products SET name = ?, description = ?, price = ? WHERE id = ?";
        getJdbcTemplate().update(sql, product.getName(), product.getDescription(), product.getPrice(), product.getId());
    }

    @Override
    public void deleteProduct(int id) {
        String sql = "DELETE FROM products WHERE id = ?";
        getJdbcTemplate().update(sql, id);
    }

    @Override
    public List<ProductCategories> getAllProductCategories() {
        String sql = "SELECT * FROM product_categories";
        return getJdbcTemplate().query(sql, new ProductCategoriesRowMapper());
    }

    @Override
    public ProductCategories getProductCategoryById(int id) {
        String sql = "SELECT * FROM product_categories WHERE id = ?";
        return getJdbcTemplate().queryForObject(sql, new ProductCategoriesRowMapper(), id);
    }

    @Override
    public void saveProductCategory(ProductCategories category) {
        String sql = "INSERT INTO product_categories (name, created_by, shop_id) VALUES (?, ?, ?)";
        getJdbcTemplate().update(sql, category.getName(), category.getCreated_by(), category.getShop_id());
    }

    @Override
    public void updateProductCategory(ProductCategories category) {
        String sql = "UPDATE product_categories SET name = ?, created_by = ?, shop_id = ? WHERE id = ?";
        getJdbcTemplate().update(sql, category.getName(), category.getCreated_by(), category.getShop_id(), category.getId());
    }

    @Override
    public void deleteProductCategory(int id) {
        String sql = "DELETE FROM product_categories WHERE id = ?";
        getJdbcTemplate().update(sql, id);
    }

    @Override
    public List<Shops> getAllShops() {
        String sql = "SELECT * FROM shops";
        return getJdbcTemplate().query(sql, new ShopsRowMapper());
    }

    @Override
    public Shops getShopById(int id) {
        String sql = "SELECT * FROM shops WHERE id = ?";
        return getJdbcTemplate().queryForObject(sql, new ShopsRowMapper(), id);
    }

    @Override
    public void saveShop(Shops shop) {
        String sql = "INSERT INTO shops (user_id, shop_name, shop_description, address_line1, city, state, postal_code, contact_phone, business_registration_number, status) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        getJdbcTemplate().update(sql, shop.getUser_id(), shop.getShop_name(), shop.getShop_description(), shop.getAddress_line1(), shop.getCity(), shop.getState(), shop.getPostal_code(), shop.getContact_phone(), shop.getBusiness_registration_number(), shop.getStatus().name());
    }

    @Override
    public void updateShop(Shops shop) {
        String sql = "UPDATE shops SET user_id = ?, shop_name = ?, shop_description = ?, address_line1 = ?, city = ?, state = ?, postal_code = ?, contact_phone = ?, business_registration_number = ?, status = ? WHERE id = ?";
        getJdbcTemplate().update(sql, shop.getUser_id(), shop.getShop_name(), shop.getShop_description(), shop.getAddress_line1(), shop.getCity(), shop.getState(), shop.getPostal_code(), shop.getContact_phone(), shop.getBusiness_registration_number(), shop.getStatus().name(), shop.getId());
    }

    @Override
    public void deleteShop(int id) {
        String sql = "DELETE FROM shops WHERE id = ?";
        getJdbcTemplate().update(sql, id);
    }






}