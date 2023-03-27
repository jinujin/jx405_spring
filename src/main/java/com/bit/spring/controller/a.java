package com.bit.spring.controller;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class a {
    public static void main(String[] args) {
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        System.out.println(passwordEncoder.matches("1", "$2a$10$xmUHxsJSRVoYtdWWc64ND.Uk1vp7lQOC7k4ndZCWCQ4Immb1kquZS"));

        BCryptPasswordEncoder passwordEncoder2 = new BCryptPasswordEncoder();
        System.out.println(passwordEncoder.encode("1"));


    }
}