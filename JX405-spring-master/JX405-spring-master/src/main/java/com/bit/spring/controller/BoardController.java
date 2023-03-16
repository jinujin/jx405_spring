package com.bit.spring.controller;

import com.bit.spring.model.BoardDTO;
import com.bit.spring.model.UserDTO;
import com.bit.spring.service.BoardService;
import com.bit.spring.service.ReplyService;
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
import java.util.ArrayList;

@Controller
@RequestMapping("/board/")
public class BoardController {
    BoardService boardService;
    UserService userService;
    ReplyService replyService;

    @Autowired
    public BoardController(BoardService boardService, UserService userService, ReplyService replyService) {
        this.boardService = boardService;
        this.userService = userService;
        this.replyService = replyService;
    }

    @GetMapping("showAll/{pageNo}")
    public String showAll(HttpSession session, RedirectAttributes redirectAttributes, Model model, @PathVariable int pageNo) {
        if(session.getAttribute("login") == null) {
            redirectAttributes.addFlashAttribute("message", "다시 로그인해주세요.");
            return "redirect:/";
        }
        ArrayList<BoardDTO> list = boardService.selectAll(pageNo);

        model.addAttribute("list", list);

        return "board/showAll";
    }

    @GetMapping("showOne/{id}")
    public String showOne(HttpSession session, RedirectAttributes redirectAttributes, Model model, @PathVariable int id) {
        if(session.getAttribute("login") == null) {
            redirectAttributes.addFlashAttribute("message", "다시 로그인해주세요.");
            return "redirect:/";
        }

        BoardDTO b = boardService.selectOne(id);
        if(b == null) {
            redirectAttributes.addFlashAttribute("message", "존재하지 않는 글 번호입니다.");
            return "redirect:/board/showAll/1";
        }

        model.addAttribute("result", b);
        model.addAttribute("nickname", userService.getNickname(b.getWriterId()));
        model.addAttribute("replyList", replyService.selectByBoardId(id));
        int loginId = ((UserDTO) session.getAttribute("login")).getId();
        model.addAttribute("loginId", loginId);
        return "/board/showOne";
    }

    @GetMapping("register")
    public String showRegister(HttpSession session, RedirectAttributes redirectAttributes) {
        if(session.getAttribute("login") == null) {
            redirectAttributes.addFlashAttribute("message", "다시 로그인해주세요.");
            return "redirect:/";
        }
        return "/board/register";
    }

    @PostMapping("register")
    public String registerBoard(HttpSession session, RedirectAttributes redirectAttributes, BoardDTO boardDTO) {
        UserDTO login = (UserDTO) session.getAttribute("login");
        if(login == null) {
            redirectAttributes.addFlashAttribute("message", "다시 로그인해주세요.");
            return "redirect:/";
        }
        boardDTO.setWriterId(login.getId());
        boardService.insert(boardDTO);

        return "redirect:/board/showAll/1";
    }

    @GetMapping("update/{id}")
    public String showUpdate(HttpSession session, RedirectAttributes redirectAttributes, Model model, @PathVariable int id) {
        UserDTO login = (UserDTO) session.getAttribute("login");
        if(login == null) {
            redirectAttributes.addFlashAttribute("message", "다시 로그인해주세요.");
            return "redirect:/";
        }

        BoardDTO b = boardService.selectOne(id);
        if(b == null || b.getWriterId() != login.getId()) {
            redirectAttributes.addFlashAttribute("message", "유효하지 않은 접근입니다.");
            return "redirect:/board/showAll/1";
        }

        model.addAttribute("result", b);

        return "/board/update";
    }

    @PostMapping("update")
    public String updateBoard(HttpSession session, BoardDTO boardDTO) {
        UserDTO login = (UserDTO) session.getAttribute("login");
        if(login == null) {
            return "redirect:/";
        }

        BoardDTO origin = boardService.selectOne(boardDTO.getId());
        if(origin == null) {
            return "redirect:/board/showAll/1";
        }

        origin.setTitle(boardDTO.getTitle());
        origin.setContent(boardDTO.getContent());

        boardService.update(origin);

        return "redirect:/board/showOne/" + boardDTO.getId();
    }

    @GetMapping("delete/{id}")
    public String deleteBoard(HttpSession session, RedirectAttributes redirectAttributes, @PathVariable int id) {
        UserDTO login = (UserDTO) session.getAttribute("login");
        if(login == null) {
            redirectAttributes.addFlashAttribute("message", "다시 로그인해주세요.");
            return "redirect:/";
        }

        BoardDTO b = boardService.selectOne(id);
        if(b == null || b.getWriterId() != login.getId()) {
            redirectAttributes.addFlashAttribute("message", "유효하지 않은 접근입니다.");
            return "redirect:/board/showAll/1";
        }

        boardService.delete(id);

        return "redirect:/board/showAll/1";
    }
}


