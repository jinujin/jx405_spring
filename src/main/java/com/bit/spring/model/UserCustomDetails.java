package com.bit.spring.model;

import lombok.Data;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@Data
public class UserCustomDetails implements UserDetails {
    private UserDTO userDTO;
    public UserCustomDetails(UserDTO userDTO) {
        this.userDTO = userDTO;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        List<GrantedAuthority> list = new ArrayList<>();
        list.add(new SimpleGrantedAuthority(userDTO.getRole()));

        return list;
    }

    @Override
    public String getPassword() {
        return userDTO.getPassword();
    }

    @Override
    public String getUsername() {
        return userDTO.getUsername();
    }

    @Override
    public boolean isAccountNonExpired() {
        // 회원 탈퇴 했는지 체크
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        // 게시글...뭘 막는거...잘모르겠음..
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        // 특정 시간 되면 로그인 풀리는
        return true;
    }

    @Override
    public boolean isEnabled() {
        // 위에 정보가 유효한지
        return true;
    }
}
