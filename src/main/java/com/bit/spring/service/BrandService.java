package com.bit.spring.service;

import com.bit.spring.model.BrandDTO;
import com.bit.spring.model.GoodsDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BrandService {
    private final String NAMESPACE = "mapper.BrandMapper";
    private SqlSession session;

    @Autowired
    public BrandService(SqlSession session){
        this.session = session;
    }
    public List<BrandDTO> selectAll(){
        return session.selectList(NAMESPACE+".selectAll");
    }
    public BrandDTO selectOne(int id){
        return session.selectOne(NAMESPACE+".selectOne",id);
    }
    public List<GoodsDTO> goodsInBrand(int brandId){
        return session.selectList("mapper.GoodsMapper.goodsInBrand",brandId);
    }
    public void insert(BrandDTO brandDTO){
        session.insert(NAMESPACE+".insert",brandDTO);
    }
    public void update(BrandDTO brandDTO){
        session.update(NAMESPACE+".update",brandDTO);
    }
    public void delete(int id) {
        session.delete(NAMESPACE+".delete",id);
    }

}
