// ProductController.java
package com.yash.onlinehomedecor.controller;

import com.yash.onlinehomedecor.domain.Product;
import com.yash.onlinehomedecor.domain.ProductCategories;
import com.yash.onlinehomedecor.service.ProductService;
import com.yash.onlinehomedecor.service.ProductCategoriesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/products")
public class ProductController {

    @Autowired
    private ProductService productService;

    @Autowired
    private ProductCategoriesService categoryService;



    @GetMapping
    public String viewAllProducts(Model model) {
        List<Product> products = productService.getAllProducts();
        for(Product p:products){
            System.out.println(p);
        }
        model.addAttribute("products", products);
        return "dashboard_buyer";
    }

    @GetMapping("/category/{categoryId}")
    public String viewProductsByCategory(@PathVariable Integer categoryId, Model model) {
        List<Product> products = productService.getProductsByCategory(categoryId);
        ProductCategories category = categoryService.getCategoryById(categoryId);

        model.addAttribute("products", products);
        model.addAttribute("category", category);
        return "products/by-category";
    }

    @GetMapping("/{productId}")
    public String viewProductDetails(@PathVariable Integer productId, Model model) {
        Product product = productService.getProductById(productId);
        model.addAttribute("product", product);
        return "products/details";
    }
}