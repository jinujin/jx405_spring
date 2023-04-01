package com.bit.spring.controller;

import com.bit.spring.model.BuyDTO;
import com.bit.spring.model.GoodsDTO;
import com.bit.spring.model.UserDTO;
import com.bit.spring.service.BuyService;
import com.bit.spring.service.GoodsService;
import com.bit.spring.service.UserService;
import com.google.gson.JsonObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/user/")
public class UserController {
    private UserService userService;
    private BuyService buyService;
    private GoodsService goodsService;

    @Autowired
    public UserController(UserService userService, BuyService buyService, GoodsService goodsService) {
        this.userService = userService;
        this.buyService = buyService;
        this.goodsService = goodsService;
    }

    // 로그인
    @GetMapping("login")
    public String showLogin() {
        return "user/login";
    }

    @PostMapping("auth")
    public String auth(HttpSession session, Model model, UserDTO attempt) {
        UserDTO result = userService.auth(attempt);

        if (result != null) {
            session.setAttribute("logIn", result);
            model.addAttribute("id", result.getId());
            return "main";
        } else {
            model.addAttribute("message", "Please check your login information again");
            return "main";
        }
    }

    @GetMapping("mypage/{id}")
    public String showMypage(HttpSession session, Model model, @PathVariable int id) {
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
        UserDTO u = userService.selectOne(id);

        if (logIn.getId() != u.getId()) {
            return "redirect:/";
        }
        model.addAttribute("userDTO", u);

        return "/user/mypage";
    }

    @GetMapping("realMypage/{id}")
    public String showRealMypage(HttpSession session, Model model, @PathVariable int id) {
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");

        UserDTO u = userService.selectOne(id);
        List<Object> list = userService.selectSellGoods(id);
        List<UserDTO> userList = userService.selectAll();
        List<BuyDTO> buyList = buyService.selectAll(id);
        List<GoodsDTO> goodsList = goodsService.selectAll();

        if (logIn.getId() != u.getId()) {
            return "redirect:/";
        }
        if (u.getRole().equals("ROLE_SELLER")) {
            model.addAttribute("list", list);
            model.addAttribute("goodsList", goodsList);
        }

        model.addAttribute("buyList", buyList);
        model.addAttribute("userList", userList);
        model.addAttribute("userDTO", u);
        return "/user/realMypage";
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
            model.addAttribute("message", "You cannot register as a member with a duplicate IDs.");
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
        if (userDTO == null) {
            redirectAttributes.addFlashAttribute("message", "다시 확인해주세요.");
            return "redirect:/";
        }

        model.addAttribute("result", userDTO);
        return "user/update";
    }

    @PostMapping("updatePw/{id}")
    public String updatePw(Model model, RedirectAttributes redirectAttributes, @PathVariable int id, String oldPw, String newPw, String newPw2) {
        UserDTO userDTO = userService.selectOne(id);
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

        if (!passwordEncoder.matches(oldPw, userDTO.getPassword())) {
            redirectAttributes.addFlashAttribute("message", "기존 비밀번호를 확인해주세요.");
        } else if (!newPw.equals(newPw2)) {
            redirectAttributes.addFlashAttribute("message", "새 비밀번호가 서로 일치하지 않습니다.");
        } else {
            redirectAttributes.addFlashAttribute("message", "비밀번호 변경 성공!");
            userDTO.setPassword(passwordEncoder.encode(newPw));
            userService.update(userDTO);
        }

        return "redirect:/user/mypage/" + id;
    }

    @PostMapping("updateNick/{id}")
    public String updateNick(RedirectAttributes redirectAttributes, @PathVariable int id, String nickname) {
        UserDTO userDTO = userService.selectOne(id);
        userDTO.setNickname(nickname);
        userService.update(userDTO);

        return "redirect:/user/mypage/" + id;
    }

    @PostMapping("updateEmail/{id}")
    public String updateEmail(RedirectAttributes redirectAttributes, @PathVariable int id, String email) {
        UserDTO userDTO = userService.selectOne(id);
        userDTO.setEmail(email);
        userService.update(userDTO);

        return "redirect:/user/mypage/" + id;
    }

    @PostMapping("updateAddr/{id}")
    public String updateAddr(RedirectAttributes redirectAttributes, @PathVariable int id, String address, String postcode) {
        UserDTO userDTO = userService.selectOne(id);
        userDTO.setAddress(address);
        userDTO.setPostcode(postcode);
        userService.update(userDTO);

        return "redirect:/user/mypage/" + id;
    }

    @PostMapping("updateNum/{id}")
    public String updateNum(RedirectAttributes redirectAttributes, @PathVariable int id, String phone) {
        UserDTO userDTO = userService.selectOne(id);
        userDTO.setPhone(phone);
        userService.update(userDTO);

        return "redirect:/user/mypage/" + id;
    }

    @ResponseBody
    @GetMapping("delete/{id}")
    public String delete(HttpServletRequest request, HttpServletResponse response, HttpSession session, RedirectAttributes redirectAttributes, @PathVariable int id) throws IOException {
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        JsonObject object = new JsonObject();

        String content = "";
        String status = "";
        String nextPath = "";
        String message = "";

        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
        UserDTO userDTO = userService.selectOne(id);
        String oldPassword = request.getParameter("oldPassword");

        try {
            if (logIn == null || userDTO == null || !passwordEncoder.matches(oldPassword, userDTO.getPassword())) {
                throw new NullPointerException();
            }
            if (logIn.getRole().equals("ROLE_ADMIN")) {
                throw new NullPointerException();
            }
            userService.delete(id);

            content = "Withdrawal complete";
            status = "success";
            nextPath = "/";
            message = "You've been withdrawn normally.";
            session.invalidate();

        } catch (Exception e) {
            e.printStackTrace();
            if (logIn.getRole().equals("ROLE_ADMIN")) {
                content = "Failed to leave";
                status = "error";
                nextPath = "/user/mypage/" + id;
                message = "Administrators cannot leave.";
            } else {
                content = "Failed to leave";
                status = "error";
                nextPath = "/user/mypage/" + id;
                message = "Check your old password";
            }
        }

        object.addProperty("status", status);
        object.addProperty("message", message);
        object.addProperty("nextPath", nextPath);
        object.addProperty("content", content);

        return object.toString();
    }
}
