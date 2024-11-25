// ProductController.java
package com.yash.onlinehomedecor.controller;

import com.yash.onlinehomedecor.domain.Product;
import com.yash.onlinehomedecor.domain.ProductCategories;
import com.yash.onlinehomedecor.service.CartService;
import com.yash.onlinehomedecor.service.ProductService;
import com.yash.onlinehomedecor.service.ProductCategoriesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/products")
public class ProductController  {

    @Autowired
    private ProductService productService;
    @Autowired
    private CartService cartService;

    @GetMapping("/add")
    public String showAddProductForm(Model model) {
        model.addAttribute("product", new Product());
        model.addAttribute("categories", productService.getAllProductCategories());
        model.addAttribute("shops", productService.getAllShops());

        return "add_product";
    }







    // Update existing listProducts method to include image URLs
    @GetMapping("/list")
    public String listProducts(Model model) {
        try {
            List<Product> products = productService.getAllProducts();
            model.addAttribute("products", products);
            return "product-list";
        } catch (Exception e) {
            model.addAttribute("error", "Failed to load products");
            return "error-page";
        }
    }

    @GetMapping("/image/{id}")
    @ResponseBody
    public ResponseEntity<byte[]> getProductImage(@PathVariable int id, HttpServletRequest request) {

        System.out.println("Request received for image with ID: " + id);
        System.out.println("Request URI: " + request.getRequestURI());

        try {
            Product product = productService.getProductById(id);

            if (product == null) {
                System.out.println("ERROR: Product not found with ID: " + id);
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }

            byte[] imageData = product.getImage();
            System.out.println("Image data retrieved - Size: " + (imageData != null ? imageData.length : "null"));

            // Print first few bytes to verify data
            if (imageData != null && imageData.length > 0) {
                System.out.println("First 5 bytes of image: ");
                for (int i = 0; i < Math.min(5, imageData.length); i++) {
                    System.out.print(imageData[i] + " ");
                }
                System.out.println();
            }

            if (imageData == null || imageData.length == 0) {
                System.out.println("ERROR: No image data found for product ID: " + id);
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }

            HttpHeaders headers = new HttpHeaders();
            headers.setCacheControl("max-age=3600");
            headers.setContentType(MediaType.IMAGE_JPEG);
            headers.setContentLength(imageData.length);

            System.out.println("Returning image response for product ID: " + id);
            System.out.println("========= DEBUG END =========");

            return new ResponseEntity<>(imageData, headers, HttpStatus.OK);

        } catch (Exception e) {
            System.out.println("ERROR OCCURRED: ");
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }


    @PostMapping("/add")
    public String addProduct(@ModelAttribute Product product,
                             @RequestParam("productImage") MultipartFile file,
                             RedirectAttributes redirectAttributes) {
        try {
            if (!file.isEmpty()) {

                System.out.println("Received file: " + file.getOriginalFilename());
                System.out.println("File size: " + file.getSize() + " bytes");
                System.out.println("Content Type: " + file.getContentType());

                byte[] imageData = file.getBytes();
                product.setImage(imageData);
               // product.setShop_id(3);
             //   product.setSeller_id(20);

                System.out.println("Image data size set to product: " + imageData.length + " bytes");
            }

            productService.addProduct(product);
            redirectAttributes.addFlashAttribute("message", "Product added successfully.");
            redirectAttributes.addFlashAttribute("messageType", "success");

        } catch (IOException e) {
            System.out.println("Error saving image: ");
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("message", "Failed to process image.");
            redirectAttributes.addFlashAttribute("messageType", "error");
        }
        return "redirect:/products/add";
        //return "dashboard_seller";
    }

//    @GetMapping
//    public String listProducts(Model model) {
//        List<Product> products = productService.getAllProducts();
//        model.addAttribute("products", products);
//        return "product-list";
//    }

    @GetMapping("/{id}")
    public String showProductDetails(@PathVariable int id, Model model) {
        Product product = productService.getProductById(id);
        model.addAttribute("product", product);
        return "product-details";
    }

    @GetMapping("/{id}/edit")
    public String showEditProductForm(@PathVariable int id, Model model) {
        Product product = productService.getProductById(id);
        model.addAttribute("product", product);
        model.addAttribute("categories", productService.getAllProductCategories());
        model.addAttribute("shops", productService.getAllShops());
        return "edit_products";
    }

    @PostMapping("/{id}/edit")
    public String updateProduct(@PathVariable int id, @ModelAttribute Product product,
                              /*  @RequestParam("productImage") MultipartFile file,
                                @RequestParam("available") boolean available,*/
                                RedirectAttributes redirectAttributes) {
        product.setId(id);
//            product.setImage(file.getBytes());
//            product.setAvailable(available);
        productService.updateProduct(product);
        redirectAttributes.addFlashAttribute("message", "Product updated successfully.");
        redirectAttributes.addFlashAttribute("messageType", "success");
        //return "dashboard_seller";
        return "redirect:/products/seller";

    }

    @PostMapping("/{id}/delete")
    public String deleteProduct(@PathVariable int id, RedirectAttributes redirectAttributes) {


        cartService.removeFromCartItemBasedOnProductId(id);
        productService.deleteProduct(id);
        redirectAttributes.addFlashAttribute("message", "Product deleted successfully.");
        redirectAttributes.addFlashAttribute("messageType", "success");
        return "redirect:/products/seller";
    }


    @GetMapping("/seller")
    public String listSellerProducts(Model model, HttpSession session) {

        Integer sellerId = (Integer) session.getAttribute("userId");
        if (sellerId == 0) {
            return "redirect:/login";
        }
        System.out.println(session.getAttribute("userId"));
        System.out.println("IN method /products/seller");
        List<Product> products = productService.getProductsBySellerId(sellerId);
        System.out.println(products);

        model.addAttribute("products", products);
        return "seller_products";
    }


}