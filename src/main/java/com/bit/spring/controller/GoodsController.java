package com.bit.spring.controller;

import com.bit.spring.model.GoodsDTO;
import com.bit.spring.service.GoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/products/")
public class GoodsController {
    private GoodsService goodsService;

    @Autowired
    public GoodsController(GoodsService goodsService){
        this.goodsService = goodsService;
    }

    // 상품 목록 창
    @GetMapping("goodsList")
    public String showGoodsList(Model model){
        model.addAttribute("list", goodsService.selectAll());
        return "products/goodsList";
    }

    @GetMapping("goodsListByKind/{categoryId}")
    public String showGoodsListByKind(Model model, @PathVariable int categoryId){
        model.addAttribute("list", goodsService.selectAllByCategory(categoryId));
        return "products/goodsListByKind";
    }

    @GetMapping("search")
    public String showSearch(Model model, String keyword){
        List<GoodsDTO> list = goodsService.selectByKeyword(keyword);

        model.addAttribute("list", list);
        model.addAttribute("keyword",keyword);

        return "products/goodsList";
    }

    @GetMapping("goodsOne/{id}")
    public String showOne(HttpSession session, Model model, @PathVariable int id){
        GoodsDTO g = goodsService.selectOne(id);
        if (g == null) {
            return "redirect:/products/goodsList";
        }
        model.addAttribute("goodsDTO",g);

        return "products/goodsOne";
    }
    @GetMapping("update/{id}")
    public String showUpdate(HttpSession session, Model model,@PathVariable int id){

        return "products/update";
    }

//    @GetMapping("")



}

