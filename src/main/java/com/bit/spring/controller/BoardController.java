package com.bit.spring.controller;

import com.bit.spring.model.BoardDTO;
import com.bit.spring.model.UserDTO;
import com.bit.spring.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/board/")
public class BoardController {
    BoardService boardService;

    @Autowired
    public BoardController(BoardService boardService) {
        this.boardService = boardService;
    }

    @GetMapping("a")
    public String showA(){
        return "/board/a";
    }
    @GetMapping("showAll")
    public String showAll(Authentication authentication, Model model) {
//        System.out.println(authentication.getName());
//        System.out.println(authentication.getAuthorities());

        model.addAttribute("list", boardService.selectAll());

        return "/board/showAll";
    }

    @GetMapping("showAllByKind/{classify}")
    public String showAllByKind(Model model, @PathVariable int classify) {
        model.addAttribute("list",boardService.selectAllByKind(classify));

        return "/board/showAllByKind";
    }

    @GetMapping("showOne/{id}")
    public String showOne(HttpSession session, RedirectAttributes redirectAttributes, Model model, @PathVariable int id) {
        // spring security 하면 안해도 됨.
//        if (session.getAttribute("logIn") == null) {
//            redirectAttributes.addFlashAttribute("message", "다시 로그인 해주세요.");
//            return "redirect:/";
//        }

        BoardDTO b = boardService.selectOne(id);
        if (b == null) {
            redirectAttributes.addFlashAttribute("message", "존재하지 않는 글 번호입니다.");
            return "redirect:/board/showAll";
        }

        model.addAttribute("result", b);
        int logInId = ((UserDTO) session.getAttribute("logIn")).getId();
        model.addAttribute("logInId", logInId);
        return "/board/showOne";
    }

    @GetMapping("update/{id}")
    public String showUpdate(HttpSession session, Model model, RedirectAttributes redirectAttributes, @PathVariable int id) {
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
        BoardDTO b = boardService.selectOne(id);
        if (b == null || b.getWriterId() != logIn.getId()) {
            redirectAttributes.addFlashAttribute("message", "유효하지 않은 접근입니다.");
            return "redirect:/board/showAll";
        }

        model.addAttribute("board", b);
        return "/board/upsert";
    }

    @GetMapping("write")
    public String showWrite() {
        return "/board/upsert";
    }

    @PostMapping("upsert")
    public String upsert(BoardDTO boardDTO, String attemptId,HttpSession session) {
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
        if (attemptId.matches("^\\d+$")) {
            boardDTO.setId(Integer.parseInt(attemptId));
            BoardDTO origin = boardService.selectOne(boardDTO.getId());
            origin.setTitle(boardDTO.getTitle());
            origin.setContent(boardDTO.getContent());
            boardService.update(origin);
        } else {
            boardDTO.setWriterId(logIn.getId());
            boardService.insert(boardDTO);
        }

        return "redirect:/board/showOne/" + boardDTO.getId();
    }
}
