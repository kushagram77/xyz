package com.yash.onlinehomedecor.dao;

import com.yash.onlinehomedecor.domain.Product;
import com.yash.onlinehomedecor.domain.ProductCategories;
import com.yash.onlinehomedecor.domain.Shops;

import java.util.List;

public interface ProductDAO {
    void saveProduct(Product product);
    List<Product> getAllProducts();
    Product getProductById(int id);
    void updateProduct(Product product);
    void deleteProduct(int id);

    List<ProductCategories> getAllProductCategories();
    ProductCategories getProductCategoryById(int id);
    void saveProductCategory(ProductCategories category);
    void updateProductCategory(ProductCategories category);
    void deleteProductCategory(int id);

    List<Shops> getAllShops();
    Shops getShopById(int id);
    void saveShop(Shops shop);
    void updateShop(Shops shop);
    void deleteShop(int id);

    List<Product> getProductsBySellerId(int sellerId);

    List<Product> searchProductsByNameOrDescription(String query);
}