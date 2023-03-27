package com.bit.spring.model;

import lombok.Data;

@Data
public class GoodsDTO {
    private int id;
    private int userId;
    private int brandId;
    private int categoryId;
    private String detail;
    private int price;
    private int amount;
    private String brandName;
    private String sellerName;
    private String kind;
    private String image;
    private String name;
}
