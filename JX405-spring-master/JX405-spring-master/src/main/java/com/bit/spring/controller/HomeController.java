package com.bit.spring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class HomeController {
    @RequestMapping("/")
    public String showIndex(Model model) {
        System.out.println(model.getAttribute("message"));
        return "index";
    }
}
