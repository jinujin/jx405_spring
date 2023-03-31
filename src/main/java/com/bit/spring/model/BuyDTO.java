package com.bit.spring.model;

import lombok.Data;

import java.util.Date;

@Data
public class BuyDTO {
    private int id;
    private int goodsId;
    private int userId;
    private Date entryDate;
    private String detail;
    private int price;
    private int cnt;
    private String image;
    private String goodsName;
    private String detailImg;
    private String totalPrice;
    private String deliveryAddr;
}
