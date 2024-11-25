package com.yash.onlinehomedecor.controller;



import com.yash.onlinehomedecor.domain.Product;
import com.yash.onlinehomedecor.domain.User;
import com.yash.onlinehomedecor.enums.UserRole;
import com.yash.onlinehomedecor.service.AdminService;
import com.yash.onlinehomedecor.service.ProductService;
import com.yash.onlinehomedecor.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AdminService adminService;
    @Autowired
    private ProductService productService;
    @Autowired
    private UserService userService;

    @GetMapping("/dashboard")
    public String dashboard() {
        return "dashboard_admin";
    }

    @GetMapping("/buyers")
    public String manageBuyers(Model model) {
        List<User> buyers = adminService.getAllBuyers();

        model.addAttribute("buyers", buyers);
        return "manage-buyers";
    }

    @GetMapping("/sellers")
    public String manageSellers(Model model) {
        List<User> sellers = adminService.getAllSellers();
        model.addAttribute("sellers", sellers);
        return "manage-sellers";
    }

//    @PostMapping("/admin/sellers/{id}/approve")
//    public String approveSeller(@PathVariable Integer id) {
//        adminService.approveSeller(id);
//        return "redirect:/admin/sellers";
//    }
//
//    @PostMapping("/admin/sellers/{id}/reject")
//    public String rejectSeller(@PathVariable Integer id) {
//        adminService.rejectSeller(id);
//        return "redirect:/admin/sellers";
//    }
@RequestMapping(value = "/sellers/{id}/approve", method = RequestMethod.GET)
public String approveSeller(@PathVariable("id") int sellerId, RedirectAttributes redirectAttributes) {
    try {
        User seller = userService.findById(sellerId);
        if (seller != null && seller.getRole() == UserRole.REQUESTEDSELLER) {
            seller.setRole(UserRole.SELLER);
            userService.update(seller);
            redirectAttributes.addFlashAttribute("successMessage", "Seller approved successfully!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Invalid seller or seller already approved.");
        }
    } catch (Exception e) {
        redirectAttributes.addFlashAttribute("errorMessage", "Error approving seller: " + e.getMessage());
    }
    return "redirect:/admin/sellers";
}

    @RequestMapping(value = "/sellers/{id}/reject", method = RequestMethod.GET)
    public String rejectSeller(@PathVariable("id") int sellerId, RedirectAttributes redirectAttributes) {
        try {
            User seller = userService.findById(sellerId);
            if (seller != null) {
                // You might want to either delete the user or keep them with a REJECTED status
                userService.delete(sellerId);
                redirectAttributes.addFlashAttribute("successMessage", "Seller rejected successfully!");
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "Invalid seller.");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error rejecting seller: " + e.getMessage());
        }
        return "redirect:/admin/sellers";
    }

    @PostMapping("/buyers/{id}/block")
    public String blockBuyer(@PathVariable Integer id) {

       userService.blockUser(id);
        return "redirect:/admin/buyers";
    }

    @RequestMapping("/sellers/{id}/block")
    public String blockSekller(@PathVariable Integer id,RedirectAttributes redirectAttributes ) {
        try {
            userService.blockUser(id);

        }catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error rejecting seller: " + e.getMessage());
        }

        return "redirect:/admin/sellers";
    }


    @GetMapping("/products")
    public String listProducts(Model model, HttpSession session) {



        List<Product> products = productService.getAllProducts();


        model.addAttribute("products", products);
        return "manage_products";
    }

    @GetMapping("/products/{id}/edit")
    public String showEditProductForm(@PathVariable int id, Model model) {
        Product product = productService.getProductById(id);
        model.addAttribute("product", product);
        model.addAttribute("categories", productService.getAllProductCategories());
        model.addAttribute("shops", productService.getAllShops());
        return "edit_products_admin";
    }



    @PostMapping("/products/{id}/edit")
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
        return "redirect:/admin/dashboard";

    }



    @RequestMapping(value = "/profile")
    public String sellerProfile(Model model, HttpSession session) {
        // Get the logged-in user from the session
        User user = (User) session.getAttribute("user");
        model.addAttribute("user", user);

        return "edit_admin_profile"; // This will use the new JSP
    }

    @RequestMapping(value = "/profile/update", method = RequestMethod.POST)
    public String updateProfile(@ModelAttribute("user") User updatedUser,
                                HttpSession session,
                                Model model) {
        try {

            User currentUser = (User) session.getAttribute("user");
            System.out.println(session.getAttribute("user"));
            System.out.println("IN profile update,old user "+currentUser.toString());
            // Update user details
            currentUser.setName(updatedUser.getName());
            currentUser.setEmail(updatedUser.getEmail());
            currentUser.setAddress(updatedUser.getAddress());
            System.out.println("IN profile update,new user "+updatedUser.toString());
            // Update password only if a new password is provided
            if (updatedUser.getPassword() != null && !updatedUser.getPassword().isEmpty()) {
                // Here you might want to add password encoding
                currentUser.setPassword(updatedUser.getPassword());
            }

            // Call service method to update user
            userService.update(currentUser);

            // Update session with new user details
            session.setAttribute("user", currentUser);
            session.setAttribute("name", currentUser.getName());

            model.addAttribute("successMessage", "Profile updated successfully!");
            return "dashboard_seller";
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Error updating profile. Please try again.");
            e.printStackTrace();
            return "edit_seller_profile";
        }
    }


    @RequestMapping(value = "/notifications")
    String notificationsSeller(){
        return "admin_notifications";
    }






}