package com.bit.spring.model;

import lombok.Data;

@Data
public class UserDTO {
    private int id;
    private String username;
    private String password;
    private String nickname;
    private String email;
    private String postcode;
    private String address;
    private String phone;
    private String role;
    private String detail;
    private int price;
    private int amount;
    private String image;
    private String goodsName;
    private String detailImg;
    private int goodsId;
}
