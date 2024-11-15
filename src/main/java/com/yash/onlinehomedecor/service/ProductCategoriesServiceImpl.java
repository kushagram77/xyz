// ProductCategoriesService.java
package com.yash.onlinehomedecor.service;

import com.yash.onlinehomedecor.dao.ProductCategoriesDAO;
import com.yash.onlinehomedecor.domain.ProductCategories;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductCategoriesServiceImpl implements ProductCategoriesService {

    @Autowired
    private ProductCategoriesDAO productCategoriesDAO;

    public List<ProductCategories> getAllCategories() {
        return productCategoriesDAO.findAll();
    }

    public ProductCategories getCategoryById(Integer id) {
        return productCategoriesDAO.findById(id);
    }

    public List<ProductCategories> getCategoriesByShop(Integer shopId) {
        return productCategoriesDAO.findByShop(shopId);
    }

    public void saveCategory(ProductCategories category) {
        productCategoriesDAO.save(category);
    }

    public void updateCategory(ProductCategories category) {
        productCategoriesDAO.update(category);
    }

    public void deleteCategory(Integer categoryId) {
        productCategoriesDAO.delete(categoryId);
    }
}