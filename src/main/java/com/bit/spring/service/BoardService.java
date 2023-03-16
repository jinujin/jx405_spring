package com.bit.spring.service;

import com.bit.spring.model.BoardDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
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

    public List<BoardDTO> selectALL(int pageNo) {
        HashMap<String, Integer> params = new HashMap<>();
        params.put("start", (pageNo - 1) * PAGE_SIZE);
        params.put("size", PAGE_SIZE);
        return session.selectList(NAMESPACE + ".selectAll", params);
    }

    public BoardDTO selectOne(int id) {
        return session.selectOne(NAMESPACE + ".selectOne", id);
    }

    public void insert(BoardDTO boardDTO) {
        session.insert(NAMESPACE + ".insert", boardDTO);
    }

    public int selectLastPage() {
        int count = session.selectOne(NAMESPACE + ".count");
        int total = count / PAGE_SIZE;
        if (count % PAGE_SIZE != 0) {
            total++;
        }
        return total;
    }
    public List<BoardDTO> selectByKeyword(String keyword){
        return session.selectList(NAMESPACE + ".selectByKeyword", keyword);
    }


}
