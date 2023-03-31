package com.bit.spring.controller;

import com.bit.spring.model.BuyDTO;
import com.bit.spring.model.GoodsDTO;
import com.bit.spring.service.BuyService;
import com.bit.spring.service.GoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/buy/")
public class BuyController {
    private BuyService buyService;
    private GoodsService goodsService;

    @Autowired
    public BuyController(BuyService buyService, GoodsService goodsService) {
        this.buyService = buyService;
        this.goodsService = goodsService;
    }

    // 구매목록 추가
    @PostMapping("pay/{goodsId}&{userId}&{deliveryAddr}&{cnt}")
    public String addPay(BuyDTO attempt, RedirectAttributes redirectAttributes, @PathVariable int goodsId, @PathVariable int userId, @PathVariable String deliveryAddr,@PathVariable int cnt) {
        attempt.setCnt(cnt);
        attempt.setGoodsId(goodsId);
        attempt.setUserId(userId);
        attempt.setDeliveryAddr(deliveryAddr);
        GoodsDTO g = goodsService.selectOne(goodsId);
        int amount = g.getAmount();
        amount = amount - cnt;
        goodsService.updateCnt(amount,goodsId);
        buyService.insert(attempt);

        redirectAttributes.addFlashAttribute("message", "Successful purchase");
        return "redirect:/user/realMypage/" + userId;
    }
}
