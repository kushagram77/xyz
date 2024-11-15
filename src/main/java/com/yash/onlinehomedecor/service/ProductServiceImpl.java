package com.yash.onlinehomedecor.service;

import com.yash.onlinehomedecor.dao.ProductDAO;
import com.yash.onlinehomedecor.domain.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductDAO productDAO;

    public List<Product> getAllProducts() {

        System.out.println("IN pservice");
        return productDAO.findAll();
    }

    public Product getProductById(Integer id)
    {
        return productDAO.findById(id);
    }

    public List<Product> getProductsByCategory(Integer categoryId) {
        return productDAO.findByCategory(categoryId);
    }

    public List<Product> getProductsByShop(Integer shopId) {
        return productDAO.findByShop(shopId);
    }

    public List<Product> getProductsBySeller(Integer sellerId) {
        return productDAO.findBySeller(sellerId);
    }

    public void saveProduct(Product product) {
        productDAO.save(product);
    }

    public void updateProduct(Product product) {
        productDAO.update(product);
    }

    public void deleteProduct(Integer productId) {
        productDAO.delete(productId);
    }
}
