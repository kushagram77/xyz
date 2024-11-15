package com.yash.onlinehomedecor.dao;
/**
 *
 * @author Kushagra Mishra
 */
import com.yash.onlinehomedecor.domain.ProductCategories;
import com.yash.onlinehomedecor.domain.User;

import java.util.List;

public interface ProductCategoriesDAO {
    public void save(ProductCategories pc);
    public void update(ProductCategories category);
    public void delete(ProductCategories category);
    public void delete(Integer categoryId);
    public ProductCategories findById(Integer categoryId);
    public List<ProductCategories> findAll();
    public List<ProductCategories> findByShop(Integer shopId);
    public List<ProductCategories> findByCreator(Integer creatorId);
}
