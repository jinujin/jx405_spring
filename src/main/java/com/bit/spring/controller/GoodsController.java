package com.bit.spring.controller;

import com.bit.spring.model.BrandDTO;
import com.bit.spring.model.GoodsDTO;
import com.bit.spring.model.UserDTO;
import com.bit.spring.service.BrandService;
import com.bit.spring.service.GoodsService;
import com.bit.spring.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/products/")
public class GoodsController {
    private GoodsService goodsService;
    private BrandService brandService;
    private UserService userService;

    @Autowired
    public GoodsController(GoodsService goodsService, BrandService brandService, UserService userService) {
        this.goodsService = goodsService;
        this.brandService = brandService;
        this.userService = userService;
    }

    // 상품 목록 창
    @GetMapping("goodsList")
    public String showGoodsList(Model model) {
        model.addAttribute("list", goodsService.selectAll());
        return "products/goodsList";
    }

    @GetMapping("delete/{id}&{userId}")
    public String processDelete(HttpSession session, @PathVariable int id, @PathVariable int userId) throws IOException {
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
        UserDTO u = userService.selectOne(userId);

        if (logIn.getId() != u.getId()) {
            return "redirect:/";
        }
        goodsService.delete(id);
        return "redirect:/user/realMypage/" + logIn.getId();
    }

    @GetMapping("goodsListByKind/{categoryId}")
    public String showGoodsListByKind(Model model, @PathVariable int categoryId) {
        model.addAttribute("list", goodsService.selectAllByCategory(categoryId));
        return "products/goodsListByKind";
    }

    @GetMapping("search")
    public String showSearch(Model model, String keyword) {
        List<GoodsDTO> list = goodsService.selectByKeyword(keyword);

        model.addAttribute("list", list);
        model.addAttribute("keyword", keyword);

        return "products/goodsList";
    }

    @GetMapping("goodsOne/{id}")
    public String showOne(HttpSession session, Model model, @PathVariable int id) {
        GoodsDTO g = goodsService.selectOne(id);

        if (g == null) {
            return "redirect:/products/goodsList";
        }
        model.addAttribute("goodsDTO", g);

        return "products/goodsOne";
    }

    @GetMapping("updateGoods/{id}")
    public String showUpdate(HttpSession session, Model model, @PathVariable int id) {
        if (session.getAttribute("logIn") == null) {
            return "redirect:/user/login";
        }
        GoodsDTO g = goodsService.selectOne(id);
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");

        if (g == null || g.getUserId() != logIn.getId()) {
            return "redirect:/products/goodsList";
        }
        List<BrandDTO> brandList = brandService.selectAll();

        model.addAttribute("brandList", brandList);
        model.addAttribute("goodsDTO", g);

        return "products/updateGoods";
    }

    @GetMapping("add")
    public String showAdd(HttpSession session, Model model) {
        if (session.getAttribute("logIn") == null) {
            return "redirect:/user/login";
        }
        List<BrandDTO> brandList = brandService.selectAll();

        model.addAttribute("brandList", brandList);
        return "products/add";
    }

//    @PostMapping("add/{id}")
//    public String addGoods(RedirectAttributes redirectAttributes,@PathVariable int id){
//
//
//        return "redirect:/user/realMypage/" + id;
//    }

    /* 이미지 파일 업로드 */
    public String fileUpload(MultipartFile file, HttpServletRequest httpServletRequest) {
        String folderPath = "/resources/images/";

        /* 파일 이름 변경 */
        UUID uuid = UUID.randomUUID();
        String filename = uuid + "_" + file.getOriginalFilename();

        File saveFile = new File(httpServletRequest.getServletContext().getRealPath(folderPath) + filename);

        /* 실제 폴더에 파일 업로드 */
        try {
            file.transferTo(saveFile);
        } catch (Exception ex) {
            System.out.println("file upload fail in method fileUpload");
        }

        return filename;
    }

    @ResponseBody
    @PostMapping("add")
    public void processUpsert(HttpServletResponse response, HttpSession session, HttpServletRequest httpServletRequest, @RequestParam("name") String name, @RequestParam("image") MultipartFile image, @RequestParam("detailImg") MultipartFile detailImg, @RequestParam("brandId") String brandId, @RequestParam("price") int price, @RequestParam("amount") int amount, @RequestParam("detail") String detail, @RequestParam("userId") int userId, @RequestParam("categoryId") String categoryId) throws IOException {

        GoodsDTO g = new GoodsDTO();
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
        try {
            String fileName = "ready.jpg";
            String detailFileName = null;
            if (!image.getOriginalFilename().equals("")) {
                fileName = fileUpload(image, httpServletRequest);
            }
            if (!detailImg.getOriginalFilename().equals("")) {
                detailFileName = fileUpload(detailImg, httpServletRequest);
            }
            String brandIdd = brandId.replaceAll("[^\\d]", "");
            String categoryIdd = categoryId.replaceAll("[^\\d]", "");
            g.setImage(fileName);
            g.setName(name);
            g.setPrice(price);
            g.setDetail(detail);
            g.setAmount(amount);
            g.setBrandId(Integer.parseInt(brandIdd));
            g.setUserId(userId);
            g.setDetailImg(detailFileName);
            g.setCategoryId(Integer.parseInt(categoryIdd));

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("products/add");
        }
//        goodsDTO.setUserId(logIn.getId());
        goodsService.insert(g);
        response.sendRedirect("/user/realMypage/" + logIn.getId());
    }

    @ResponseBody
    @PostMapping("updateGoods/{id}")
    public void processUpdate(Model model, @PathVariable int id, HttpServletResponse response, HttpSession session, HttpServletRequest httpServletRequest, @RequestParam("name") String name, @RequestParam("image") MultipartFile image, @RequestParam("detailImg") MultipartFile detailImg, @RequestParam("brandId") String brandId, @RequestParam("price") int price, @RequestParam("amount") int amount, @RequestParam("detail") String detail, @RequestParam("categoryId") String categoryId) throws IOException {

        GoodsDTO g = goodsService.selectOne(id);
        model.addAttribute("goodsDTO", g);
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
        try {
            String fileName = "ready.jpg";
            String detailFileName = null;
            if (!image.getOriginalFilename().equals("")) {
                fileName = fileUpload(image, httpServletRequest);
            }
            if (!detailImg.getOriginalFilename().equals("")) {
                detailFileName = fileUpload(detailImg, httpServletRequest);
            }
            String brandIdd = brandId.replaceAll("[^\\d]", "");
            String categoryIdd = categoryId.replaceAll("[^\\d]", "");
            g.setImage(fileName);
            g.setName(name);
            g.setPrice(price);
            g.setDetail(detail);
            g.setAmount(amount);
            g.setBrandId(Integer.parseInt(brandIdd));
            g.setDetailImg(detailFileName);
            g.setCategoryId(Integer.parseInt(categoryIdd));

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("/user/realMypage/" + logIn.getId());
        }
//        goodsDTO.setUserId(logIn.getId());
        goodsService.update(g);
        response.sendRedirect("/products/goodsOne/" + id);
    }

}

