package com.yash.onlinehomedecor.service;

import com.yash.onlinehomedecor.domain.Product;

import java.util.List;

public interface ProductService {
    public List<Product> getAllProducts();

    public Product getProductById(Integer id);

    public List<Product> getProductsByCategory(Integer categoryId);

    public List<Product> getProductsByShop(Integer shopId);

    public List<Product> getProductsBySeller(Integer sellerId);

    public void saveProduct(Product product);

    public void updateProduct(Product product);

    public void deleteProduct(Integer productId);
}
