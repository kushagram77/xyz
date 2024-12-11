package com.yash.onlinehomedecor.controller;



import com.yash.onlinehomedecor.domain.Feedback;
import com.yash.onlinehomedecor.service.FeedbackService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import javax.validation.Valid;
import java.util.List;

@Controller
public class FeedbackController {

    @Autowired
    private FeedbackService feedbackService;

    @GetMapping("/help")
    public String showHelpPage(Model model) {
        model.addAttribute("feedback", new Feedback());
        return "help";
    }

    @PostMapping("/submit-feedback")
    public String submitFeedback(@Valid @ModelAttribute("feedback") Feedback feedback,
                                 BindingResult result,
                                 Model model) {
        if (result.hasErrors()) {
            return "help";
        }

        boolean submitted = feedbackService.submitFeedback(feedback);

        if (submitted) {
            model.addAttribute("message", "Thank you for your feedback!");
        } else {
            model.addAttribute("error", "An error occurred while submitting your feedback.");
        }

        return "help";
    }

    @RequestMapping("admin/feedback/list")
    public String feedbackList(Model m) {
        List<Feedback> feedbackList = feedbackService.getAllFeedback();
        m.addAttribute("feedbackList", feedbackList);
        return "feedback_list";
    }

}
