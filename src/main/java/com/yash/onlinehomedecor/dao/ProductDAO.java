package com.yash.onlinehomedecor.dao;

import com.yash.onlinehomedecor.domain.Product;
import java.util.List;

public interface ProductDAO {
    void save(Product product);
    void update(Product product);
    void delete(Product product);
    void delete(Integer productId);
    Product findById(Integer productId);
    List<Product> findAll();
    List<Product> findByCategory(Integer categoryId);
    List<Product> findByShop(Integer shopId);
    List<Product> findBySeller(Integer sellerId);
}