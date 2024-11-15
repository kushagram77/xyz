package com.yash.onlinehomedecor.service;

import com.yash.onlinehomedecor.domain.ProductCategories;

import java.util.List;

public interface ProductCategoriesService {
    public List<ProductCategories> getAllCategories();

    public ProductCategories getCategoryById(Integer id);

    public List<ProductCategories> getCategoriesByShop(Integer shopId);

    public void saveCategory(ProductCategories category);

    public void updateCategory(ProductCategories category);

    public void deleteCategory(Integer categoryId);
}
