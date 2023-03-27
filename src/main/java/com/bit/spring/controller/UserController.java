package com.bit.spring.controller;

import com.bit.spring.model.UserDTO;
import com.bit.spring.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/user/")
public class UserController {
    private UserService userService;

    @Autowired
    public UserController(UserService userService) {
        this.userService = userService;
    }

    // 로그인
    @GetMapping("login")
    public String showLogin(){
        return "user/login";
    }
    @PostMapping("auth")
    public String auth(HttpSession session, Model model, UserDTO attempt) {
        UserDTO result = userService.auth(attempt);

        if (result != null) {
            session.setAttribute("logIn", result);
            model.addAttribute("id", result.getId());
            return "redirect:/board/showAll/1";
        } else {
            model.addAttribute("message", "Please check your login information again");
            return "main";
        }
    }

    // 회원가입
    @GetMapping("choice_register")
    public String showChoice_Register() {
        return "user/choice_register";
    }

    @GetMapping("registerForBuy")
    public String showRegisterForBuy() {
        return "user/registerForBuy";
    }
    @GetMapping("registerForSell")
    public String showRegisterForSell() {
        return "user/registerForSell";
    }

    @PostMapping("register")
    public String register(Model model, UserDTO attempt) {
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        attempt.setPassword(passwordEncoder.encode(attempt.getPassword()));
        boolean result = userService.insert(attempt);
        if (result) {
            return "redirect:/";
        } else {
            //중복
            model.addAttribute("message","You cannot register as a member with a duplicate IDs.");
            return "user/choice_register";
        }
    }

    // 회원정보수정

    @GetMapping("update/{id}")
    public String showUpdateUser(HttpSession session, Model model, RedirectAttributes redirectAttributes, @PathVariable int id) {
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
        if (logIn == null) {
            redirectAttributes.addFlashAttribute("message", "다시 로그인해주세요.");
            return "redirect:/";
        }
        UserDTO userDTO = userService.selectOne(id);
        if(userDTO == null){
            redirectAttributes.addFlashAttribute("message", "다시 확인해주세요.");
            return "redirect:/";
        }

        model.addAttribute("result", userDTO);
        return "user/update";
    }
//
//    @PostMapping("update")
//    public String updateUser(HttpSession session,RedirectAttributes redirectAttributes, UserDTO userDTO) {
//        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
//        if (logIn == null) {
//            return "redirect:/";
//        }
//
//        UserDTO origin = userService.selectOne(userDTO.getId());
//
//        if (origin == null) {
//            return "redirect:/";
//        }
//        origin.setNickname(userDTO.getNickname());
//        origin.setPassword(userDTO.getPassword());
//
//        userService.update(origin);
//
//        return "redirect:/board/showAll/1";
//
//    }
}
