package com.bit.spring.service;

import com.bit.spring.model.BoardDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BoardService {
    private final String NAMESPACE = "mapper.BoardMapper";
    private final int PAGE_SIZE = 10;
    private SqlSession session;

    @Autowired
    public BoardService(SqlSession session) {
        this.session = session;
    }

    public List<BoardDTO> selectAll() {
        return session.selectList(NAMESPACE + ".selectAll");
    }

    public List<BoardDTO> selectAllByKind(int classify) {
        return session.selectList(NAMESPACE + ".selectAllByKind", classify);
    }

    public BoardDTO selectOne(int id) {
        return session.selectOne(NAMESPACE + ".selectOne", id);
    }

    public void insert(BoardDTO boardDTO) {
        session.insert(NAMESPACE + ".insert", boardDTO);
    }

    public List<BoardDTO> selectByKeyword(String keyword) {

        return session.selectList("list", session.selectList(NAMESPACE + ".selectByKeyword"));

    }

    public int countSearchResult(String keyword) {
        int temp = session.selectOne(NAMESPACE + ".countSearchResult", keyword);
        int totalPage = temp / PAGE_SIZE;
        if (temp % PAGE_SIZE != 0) {
            totalPage++;
        }
        return totalPage;
    }

    public void update(BoardDTO attempt) {
        session.update(NAMESPACE + ".update", attempt);
    }
}
