package com.bit.spring.controller;

import com.bit.spring.model.BrandDTO;
import com.bit.spring.model.GoodsDTO;
import com.bit.spring.service.BrandService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/brand/")
public class BrandController {

    private BrandService brandService;

    @Autowired
    public BrandController(BrandService brandService){
        this.brandService = brandService;
    }

    // 브랜드 목록 창
    @GetMapping("brandList")
    public String showBrandList(Model model) {
        model.addAttribute("list",brandService.selectAll());
        return "brand/brandList";
    }

    @GetMapping("brandOne/{id}")
    public String showOne(Model model, @PathVariable int id){
        BrandDTO b = brandService.selectOne(id);
        List<GoodsDTO> list = brandService.goodsInBrand(id);
        if (b == null) {
            return "redirect:/brand/brandList";
        }
        model.addAttribute("list",list);
        model.addAttribute("brandDTO",b);

        return "brand/brandOne";
    }

}
