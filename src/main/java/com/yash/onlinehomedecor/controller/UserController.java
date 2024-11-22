package com.yash.onlinehomedecor.controller;

import com.yash.onlinehomedecor.command.LoginCommand;
import com.yash.onlinehomedecor.command.UserCommand;
import com.yash.onlinehomedecor.domain.User;
import com.yash.onlinehomedecor.enums.UserRole;
import com.yash.onlinehomedecor.exception.UserBlockedException;
import com.yash.onlinehomedecor.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @RequestMapping(value = {"/", "/index"})
    public String index(Model model) {
        model.addAttribute("command", new LoginCommand());
        return "index"; // JSP - /WEB-INF/view/index.jsp
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String handleLogin(@ModelAttribute("command") LoginCommand cmd, Model model, HttpSession session) {
        try {
            User loggedInUser  = userService.login(cmd.getLoginName(), cmd.getPassword());
            if (loggedInUser == null) {
                model.addAttribute("err", "Invalid username or password");
                return "redirect:/";
            }

            addUserInSession(loggedInUser , session);
            System.out.println("loggedInuser: " + loggedInUser);
            if(loggedInUser.getRole()==UserRole.ADMIN){
                return  "dashboard_admin";


            }
            else if (loggedInUser .getRole() == UserRole.SELLER) {

                return "dashboard_seller"; // Redirect to seller dashboard
                //return "redirect:/admin/dashboard";
            }
            else if (loggedInUser .getRole() == UserRole.BUYER) {

                //return "dashboard_buyer"; // Redirect to buyer dashboard
                return "redirect:/products";
            }
            else{

                return "reg_form";

                //return "redirect:/admin/dashboard";
            }

        } catch (UserBlockedException ex) {
            model.addAttribute("err", ex.getMessage());

            return "reg_form"; // JSP - index
        }
    }

    @RequestMapping(value = "/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        System.out.println("logout called");
        //return "redirect:index?act=lo";
        return "index";
    }

    @RequestMapping(value = "/user/dashboard")
    public String userDashboard() {
        return "dashboard_buyer"; // JSP for user dashboard
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

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public String registerUser(@ModelAttribute("userCommand") UserCommand cmd, Model model) {  // Change from "command" to "userCommand"
        try {
            User user = cmd.getUser();
            String selectedRole=cmd.getUser().getRole().name();
            user.setRole(UserRole.valueOf(selectedRole));
            model.addAttribute("successMessage", "Registration successful! You can now login to your account.");
            userService.register(user);

            return "redirect:index?act=reg";
        } catch (DuplicateKeyException e) {
            model.addAttribute("err", "Email is already registered. Please select another email.");
            return "reg_form";
        }
    }


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
    }
}