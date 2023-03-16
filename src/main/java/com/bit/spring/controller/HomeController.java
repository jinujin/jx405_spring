package com.bit.spring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class HomeController {
//    MemberService memberService;
//    @Autowired
//    public HomeController(MemberService memberService){
//        this.memberService = memberService;
//    }
    @RequestMapping("/")
    public String showIndex(Model model) {
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
////    @RequestMapping("/show")
//    //SOL 2
////    @RequestMapping(value = "/show", method = RequestMethod.GET)
////    public String showInfo(){
////        return "show";
////    }
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
