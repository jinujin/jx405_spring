package com.bit.spring.service;

import com.bit.spring.model.GoodsDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class GoodsService {
    private final String NAMESPACE = "mapper.GoodsMapper";
    private SqlSession session;

    @Autowired
    public GoodsService(SqlSession session) {
        this.session = session;
    }

    public List<GoodsDTO> selectAll() {
        return session.selectList(NAMESPACE + ".selectAll");
    }

    public GoodsDTO selectOne(int id) {
        return session.selectOne(NAMESPACE + ".selectOne", id);
    }

    public void insert(GoodsDTO goodsDTO) {
        session.insert(NAMESPACE + ".insert", goodsDTO);
    }

    public void update(GoodsDTO attempt) {
        session.update(NAMESPACE + ".update", attempt);
    }

    public void updateCnt(int amount, int id) {
        Map<String,Integer> params = new HashMap<>();
        params.put("amount",amount);
        params.put("id", id);
        session.update(NAMESPACE + ".updateCnt", params);
    }
    public void delete(int id) {
        session.delete(NAMESPACE + ".delete", id);
    }
    public List<GoodsDTO> selectAllByCategory(int categoryId){
        return session.selectList(NAMESPACE+".selectAllByCategory",categoryId);
    }
    public List<GoodsDTO> selectByKeyword(String keyword){
        return session.selectList(NAMESPACE+".selectByKeyword",keyword);
    }
}
