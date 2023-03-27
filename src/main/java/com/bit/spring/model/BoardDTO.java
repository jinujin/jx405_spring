package com.bit.spring.model;

import lombok.Data;

import java.util.Date;

@Data
public class BoardDTO {
    private int id;
    private String title;
    private String content;
    private String writerNickname;
    private int writerId;
    private Date entryDate;
    private int classify; // 1. 공지사항(찰리소식) 2. 이벤트 3.문의 내역(로그인 필요)

}
