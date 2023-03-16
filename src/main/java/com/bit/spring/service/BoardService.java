package com.bit.spring.service;

import com.bit.spring.model.BoardDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BoardService {
    private final String NAMESPACE = "mapper.boardMapper";
    private final int PAGE_SIZE = 15;
    private SqlSession session;

    @Autowired
    public BoardService(SqlSession session) {
        this.session = session;
    }
    public List<BoardDTO> selectALL(int pageNo){
        return session.selectList(NAMESPACE+".selectAll");
    }

}
