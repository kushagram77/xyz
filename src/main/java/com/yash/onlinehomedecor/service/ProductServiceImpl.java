package com.yash.onlinehomedecor.service.impl;

import com.yash.onlinehomedecor.dao.ProductDAO;
import com.yash.onlinehomedecor.domain.Product;
import com.yash.onlinehomedecor.domain.ProductCategories;
import com.yash.onlinehomedecor.domain.Shops;
import com.yash.onlinehomedecor.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ProductServiceImpl implements ProductService {
    @Autowired
    private ProductDAO productDAO;

    @Override
    public void addProduct(Product product) {
        productDAO.saveProduct(product);
    }

    @Override
    public List<Product> getAllProducts() {
        return productDAO.getAllProducts();
    }

    @Override
    public Product getProductById(int id) {
        return productDAO.getProductById(id);
    }

    @Override
    public void updateProduct(Product product) {
        productDAO.updateProduct(product);
    }

    @Override
    public void deleteProduct(int id) {
        productDAO.deleteProduct(id);
    }

    @Override
    public List<ProductCategories> getAllProductCategories() {
        return productDAO.getAllProductCategories();
    }

    @Override
    public ProductCategories getProductCategoryById(int id) {
        return productDAO.getProductCategoryById(id);
    }

    @Override
    public void saveProductCategory(ProductCategories category) {
        productDAO.saveProductCategory(category);
    }

    @Override
    public void updateProductCategory(ProductCategories category) {
        productDAO.updateProductCategory(category);
    }

    @Override
    public void deleteProductCategory(int id) {
        productDAO.deleteProductCategory(id);
    }

    @Override
    public List<Shops> getAllShops() {
        return productDAO.getAllShops();
    }

    @Override
    public Shops getShopById(int id) {
        return productDAO.getShopById(id);
    }

    @Override
    public void saveShop(Shops shop) {
        productDAO.saveShop(shop);
    }

    @Override
    public void updateShop(Shops shop) {
        productDAO.updateShop(shop);
    }

    @Override
    public void deleteShop(int id) {
        productDAO.deleteShop(id);
    }

    @Override
    public List<Product> getProductsBySellerId(int sellerId) {
        List<Product> ls=new ArrayList<>();
        ls=productDAO.getProductsBySellerId(sellerId);
        for(Product p:ls){
            System.out.println("In Product Service:"+p.getDescription());
        }
        return productDAO.getProductsBySellerId(sellerId);
    }
}