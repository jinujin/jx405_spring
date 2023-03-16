package com.bit.spring.controller;

import com.bit.spring.model.ReplyDTO;
import com.bit.spring.model.UserDTO;
import com.bit.spring.service.ReplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/reply/")
public class ReplyController {
    ReplyService replyService;

    @Autowired
    public ReplyController(ReplyService replyService) {
        this.replyService = replyService;
    }

    @PostMapping("register/{boardId}")
    public String registerReply(HttpSession session, RedirectAttributes redirectAttributes, ReplyDTO replyDTO, @PathVariable int boardId) {
        UserDTO login = (UserDTO) session.getAttribute("login");
        if(login == null) {
            redirectAttributes.addFlashAttribute("message", "다시 로그인해주세요.");
            return "redirect:/";
        }

        replyDTO.setWriterId(login.getId());
        replyDTO.setBoardId(boardId);
        replyService.insert(replyDTO);
        return "redirect:/board/showOne/" + boardId;
    }
}
