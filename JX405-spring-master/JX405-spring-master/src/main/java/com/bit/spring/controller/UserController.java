package com.bit.spring.controller;

import com.bit.spring.model.UserDTO;
import com.bit.spring.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
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
    @PostMapping("auth")
    public String auth(HttpSession session, Model model, UserDTO attempt) {
        UserDTO result = userService.auth(attempt);

        if(result != null) { // 로그인 성공 시
            session.setAttribute("login", result);
            return "redirect:/board/showAll/1";
        } else { // 로그인 실패 시
            model.addAttribute("message", "로그인 정보를 다시 확인해주세요.");
            return "index";
        }
    }

    // 회원가입
    @GetMapping("register")
    public String showRegister() {
        return "/user/register";
    }

    @PostMapping("register")
    public String registerUser(Model model, UserDTO userDTO) {
        boolean result = userService.insert(userDTO);
        if(!result) {
            model.addAttribute("message", "회원가입 실패, 다시 시도해주세요.");
            return "/user/register";
        }
        return "redirect:/";
    }

    @GetMapping("myInfo")
    public String showMyInfo(HttpSession session, RedirectAttributes redirectAttributes, Model model) {
        UserDTO login = (UserDTO) session.getAttribute("login");
        if(login == null) {
            redirectAttributes.addFlashAttribute("message", "다시 로그인해주세요.");
            return "redirect:/";
        }
        model.addAttribute("login", login);
        return "/user/myInfo";
    }

    @GetMapping("update")
    public String showUpdate(HttpSession session, RedirectAttributes redirectAttributes, Model model) {
        UserDTO login = (UserDTO) session.getAttribute("login");
        if(login == null) {
            redirectAttributes.addFlashAttribute("message", "다시 로그인해주세요.");
            return "redirect:/";
        }
        model.addAttribute("login", login);
        return "/user/update";
    }

    @PostMapping("update")
    public String updateUser(HttpSession session, RedirectAttributes redirectAttributes, UserDTO userDTO) {
        UserDTO login = (UserDTO) session.getAttribute("login");
        if(login == null) {
            redirectAttributes.addFlashAttribute("message", "다시 로그인해주세요.");
            return "redirect:/";
        }
        if(!userDTO.getPassword().equals("")) {
            login.setPassword(userDTO.getPassword());
        }
        if(!userDTO.getNickname().equals("")) {
            login.setNickname(userDTO.getNickname());
        }
        userService.update(login);
        login.setPassword(null);
        session.setAttribute("login", login);
        return "redirect:/user/myInfo";
    }

    @GetMapping("delete")
    public String deleteUser(HttpSession session, RedirectAttributes redirectAttributes) {
        UserDTO login = (UserDTO) session.getAttribute("login");
        if(login == null) {
            redirectAttributes.addFlashAttribute("message", "다시 로그인해주세요.");
            return "redirect:/";
        }
        userService.delete(login.getId());
        redirectAttributes.addFlashAttribute("message", "정상적으로 탈퇴되었습니다.");
        return "redirect:/";
    }
}
