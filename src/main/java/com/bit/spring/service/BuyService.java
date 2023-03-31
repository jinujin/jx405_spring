package com.bit.spring.service;

import com.bit.spring.model.BuyDTO;
import com.bit.spring.model.GoodsDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BuyService {
    private final String NAMESPACE = "mapper.BuyMapper";
    private SqlSession session;

    @Autowired
    public BuyService(SqlSession session) {
        this.session = session;
    }

    public void insert(BuyDTO buyDTO) {
        session.insert(NAMESPACE + ".insert", buyDTO);
    }
    public List<BuyDTO> selectAll(int id) {
        return session.selectList(NAMESPACE + ".selectAll",id);
    }
}
