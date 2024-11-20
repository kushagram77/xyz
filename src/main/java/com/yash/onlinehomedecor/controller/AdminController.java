package com.yash.onlinehomedecor.controller;



import com.yash.onlinehomedecor.domain.User;
import com.yash.onlinehomedecor.service.AdminService;
import com.yash.onlinehomedecor.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AdminService adminService;

    @GetMapping("/dashboard")
    public String dashboard() {
        return "admin/dashboard";
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

    @PostMapping("/admin/buyers/{id}/block")
    public String blockBuyer(@PathVariable Integer id) {
        // Implement the logic to block the buyer
        return "redirect:/admin/buyers";
    }
}