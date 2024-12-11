package com.yash.onlinehomedecor.controller;

import com.yash.onlinehomedecor.command.LoginCommand;
import com.yash.onlinehomedecor.command.UserCommand;
import com.yash.onlinehomedecor.domain.Product;
import com.yash.onlinehomedecor.domain.User;
import com.yash.onlinehomedecor.enums.UserRole;
import com.yash.onlinehomedecor.exception.UserBlockedException;
import com.yash.onlinehomedecor.service.EmailService;
import com.yash.onlinehomedecor.service.ProductService;
import com.yash.onlinehomedecor.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private ProductService productService;

    @Autowired
    private EmailService emailService;

    @RequestMapping(value = {"/", "/index"})
    public String index(Model model,@RequestParam(required = false) String search) {
        if(search!=null && !search.trim().isEmpty()){

            List<Product> searchedProducts=productService.searchProducts(search);
            model.addAttribute("products",searchedProducts);
        }
        else {
            List<Product> products = productService.getAllProducts();
            model.addAttribute("products", products);
        }
        //return "product-list";
        return "landing"; // JSP - /WEB-INF/view/landing.jsp
    }

    @RequestMapping(value = "/login")
    public String login(Model model) {
        model.addAttribute("command", new LoginCommand());
        return "index"; // JSP - /WEB-INF/view/login.jsp
    }



    @RequestMapping(value = "/loginCheck", method = RequestMethod.POST)
    public String handleLogin(@ModelAttribute("command") LoginCommand cmd, Model model, HttpSession session) {
        try {
            User loggedInUser = userService.login(cmd.getLoginName(), cmd.getPassword());
            if (loggedInUser == null) {
                model.addAttribute("err", "Invalid username or password");
                return "redirect:/";
            }

            // Check if the user is a REQUESTEDSELLER


            if (loggedInUser.getRole() == UserRole.REQUESTEDSELLER) {
                model.addAttribute("err", "Your seller account is pending approval from admin. Please wait for approval.");
                return "index";
            }

            addUserInSession(loggedInUser, session);

            if (loggedInUser.getRole() == UserRole.ADMIN) {
               // return "dashboard_admin";
                return "redirect:/admin/dashboard";
            } else if (loggedInUser.getRole() == UserRole.SELLER) {
                //return "dashboard_seller";
                return "redirect:/xyz";
            } else if (loggedInUser.getRole() == UserRole.BUYER) {
                return "redirect:/products/list";
            }
            return "reg_form";

        } catch (UserBlockedException ex) {
            model.addAttribute("err", ex.getMessage());
            return "reg_form";
        }
    }

    @RequestMapping(value = "/logout")
    public String logout(HttpSession session) {
        session.invalidate();

        //return "redirect:index?act=lo";
        return "index";
    }

    @RequestMapping(value = "/user/dashboard")
    public String userDashboard() {
        return "product-list"; // JSP for user dashboard
    }

    @RequestMapping(value = "/xyz")
    public String sellerDashboard(){
        return  "dashboard_seller";
    }

    @RequestMapping(value = "/admin/dashboard")
    public String adminDashboard() {
        return "dashboard_admin"; // JSP for admin dashboard
    }

    @RequestMapping(value = "/admin/users")
    public String getUserList(Model model) {
        List<User> userList = userService.getUserList();
        model.addAttribute("userList", userList);
        return "users"; // JSP for displaying user list
    }



    @RequestMapping(value = "/reg_form")
    public String registrationForm(Model model) {
        UserCommand userCommand = new UserCommand();
        model.addAttribute("userCommand", userCommand);  // Change from "command" to "userCommand"
        return "reg_form";//reg_form.jsp
    }




//    @RequestMapping(value = "/register", method = RequestMethod.POST)
//    public String registerUser(@ModelAttribute("userCommand") UserCommand cmd, Model model) {
//        try {
//            User user = cmd.getUser();
//            String selectedRole = cmd.getUser().getRole().name();
//            if (userService.isEmailExists(user.getEmail())) {
//                throw new DuplicateKeyException("Email already registered");
//            }
//
//            // If the user is registering as a seller, set role to REQUESTEDSELLER
//            if (UserRole.valueOf(selectedRole) == UserRole.SELLER) {
//                user.setRole(UserRole.REQUESTEDSELLER);
//                model.addAttribute("successMessage", "Registration successful! Please wait for admin approval to access your seller account.");
//            } else {
//                user.setRole(UserRole.valueOf(selectedRole));
//                model.addAttribute("successMessage", "Registration successful! You can now login to your account.");
//            }
//
//            // Register user
//            userService.register(user);
//
//            // Send registration email
//            emailService.sendRegistrationEmail(user);
//
//            return "redirect:index?act=reg";
//
//        } catch (DuplicateKeyException e) {
//            model.addAttribute("err", "Email is already registered. Please select another email.");
//            return "reg_form";
//        }
//    }

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public String registerUser(@ModelAttribute("userCommand") UserCommand cmd, Model model) {
        try {
            User user = cmd.getUser();
            String selectedRole = cmd.getUser().getRole().name();
            if (userService.isEmailExists(user.getEmail())) {
                throw new DuplicateKeyException("Email already registered");
            }

            // If the user is registering as a seller, set role to REQUESTEDSELLER
            if (UserRole.valueOf(selectedRole) == UserRole.SELLER) {
                user.setRole(UserRole.REQUESTEDSELLER);
                model.addAttribute("successMessage", "Registration successful! Please wait for admin approval to access your seller account.");
            } else {
                user.setRole(UserRole.valueOf(selectedRole));
                model.addAttribute("successMessage", "Registration successful! You can now login to your account.");
            }

            // Register user
            userService.register(user);

            // Send registration email
            emailService.sendRegistrationEmail(user);

            return "redirect:login?act=reg";

        } catch (DuplicateKeyException e) {
            model.addAttribute("err", "Email is already registered. Please select another email.");
            return "reg_form";
        }
    }


    // Add this new method to handle the login page display
//    @RequestMapping(value = "/login", method = RequestMethod.GET)
//    public String showLoginPage(Model model) {
//        model.addAttribute("command", new LoginCommand());
//        return "index";  // Your login page JSP
//    }



    @RequestMapping(value = "/seller/profile")
    public String sellerProfile(Model model, HttpSession session) {
        // Get the logged-in user from the session
        User user = (User) session.getAttribute("user");
        model.addAttribute("user", user);

        return "edit_seller_profile"; // This will use the new JSP
    }

    @RequestMapping(value = "/seller/profile/update", method = RequestMethod.POST)
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

    @RequestMapping(value = "/seller/notifications")
    String notificationsSeller(){
        return "seller_notifications";
    }





    private void addUserInSession(User user, HttpSession session) {
        session.setAttribute("user", user);
        session.setAttribute("userId", user.getId());
        session.setAttribute("role", user.getRole());
        session.setAttribute("name",user.getName());
        session.setAttribute("address",user.getAddress());
    }
}