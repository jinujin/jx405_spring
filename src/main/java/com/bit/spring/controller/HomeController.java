package com.bit.spring.controller;

import com.bit.spring.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {

    // 비밀번호 encoding 코드 (feat.UserService encrypt())
    UserService userService;
//
    @Autowired
    public HomeController(UserService userService) {
        this.userService = userService;
    }

    @RequestMapping("/")
    public String showIndex(Model model) {
//        userService.encrypt();

        return "main";
    }
}
