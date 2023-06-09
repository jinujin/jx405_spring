package com.bit.spring.controller;

import com.bit.spring.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {
//    MemberService memberService;
//    @Autowired
//    public HomeController(MemberService memberService){
//        this.memberService = memberService;
//    }

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

        return "index";
    }


//
//    @RequestMapping("/{id}")
//    public String showId(Model model, @PathVariable int id) {
//        model.addAttribute("id", memberService.selectOne(id));
//
//        return "index";
//    }
//
//    //SOL 1
//    @RequestMapping("/show")
//    //SOL 2
//    @RequestMapping(value = "/show", method = RequestMethod.GET)
//    public String showInfo(){
//        return "show";
//    }
//    //SOL 3
//    @GetMapping("/show")
//    public String showInfo(Model model, MemberDTO memberDTO, String rank) {
//        System.out.println("id:" + memberDTO.getId());
//        System.out.println("name:" + memberDTO.getName());
//        System.out.println("rank:" + rank);
//
//        model.addAttribute("id", memberDTO.getId());
//        model.addAttribute("name", memberDTO.getName());
//        model.addAttribute("rank", rank);
//
//        return "show";
//    }
}
