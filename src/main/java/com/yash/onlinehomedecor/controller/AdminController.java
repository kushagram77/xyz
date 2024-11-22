package com.yash.onlinehomedecor.controller;



import com.yash.onlinehomedecor.domain.Product;
import com.yash.onlinehomedecor.domain.User;
import com.yash.onlinehomedecor.service.AdminService;
import com.yash.onlinehomedecor.service.ProductService;
import com.yash.onlinehomedecor.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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

    @PostMapping("/admin/sellers/{id}/approve")
    public String approveSeller(@PathVariable Integer id) {
        adminService.approveSeller(id);
        return "redirect:/admin/sellers";
    }

    @PostMapping("/admin/sellers/{id}/reject")
    public String rejectSeller(@PathVariable Integer id) {
        adminService.rejectSeller(id);
        return "redirect:/admin/sellers";
    }

    @PostMapping("/buyers/{id}/block")
    public String blockBuyer(@PathVariable Integer id) {

       userService.blockUser(id);
        return "redirect:/admin/buyers";
    }


    @GetMapping("/products")
    public String listProducts(Model model, HttpSession session) {



        List<Product> products = productService.getAllProducts();


        model.addAttribute("products", products);
        return "manage_products";
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
        return "seller_notifications";
    }






}