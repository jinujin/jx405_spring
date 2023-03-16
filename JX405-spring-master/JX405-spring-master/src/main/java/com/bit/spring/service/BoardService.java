package com.bit.spring.service;

import com.bit.spring.connector.MySqlConnector;
import com.bit.spring.model.BoardDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.*;
import java.util.ArrayList;

@Service
public class BoardService {
    private final int PAGE_SIZE = 15;
    private Connection connection;

    @Autowired
    public BoardService(MySqlConnector mySqlConnector) {
        connection = mySqlConnector.makeConnection();
    }

    // 특정 페이지 출력하기
    public ArrayList<BoardDTO> selectAll(int pageNo) {
        ArrayList<BoardDTO> list = new ArrayList<>();
        String query = "SELECT * FROM `board` ORDER BY `id` DESC LIMIT ?, ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, (pageNo - 1) * PAGE_SIZE);
            pstmt.setInt(2, PAGE_SIZE);

            ResultSet resultSet = pstmt.executeQuery();
            while(resultSet.next()) {
                BoardDTO boardDTO = new BoardDTO();
                boardDTO.setId(resultSet.getInt("id"));
                boardDTO.setWriterId(resultSet.getInt("writerId"));
                boardDTO.setTitle(resultSet.getString("title"));
                boardDTO.setContent(resultSet.getString("content"));
                boardDTO.setEntryDate(new Date(resultSet.getTimestamp("entry_date").getTime()));
                boardDTO.setModifyDate(new Date(resultSet.getTime("modify_date").getTime()));

                list.add(boardDTO);
            }

            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public BoardDTO selectOne(int id) {
        BoardDTO b = null;

        String query = "SELECT * FROM `board` WHERE `id` = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);

            ResultSet resultSet = pstmt.executeQuery();
            if (resultSet.next()) {
                b = new BoardDTO();
                b.setId(resultSet.getInt("id"));
                b.setWriterId(resultSet.getInt("writerId"));
                b.setTitle(resultSet.getString("title"));
                b.setContent(resultSet.getString("content"));
                b.setEntryDate(new Date(resultSet.getTimestamp("entry_date").getTime()));
                b.setModifyDate(new Date(resultSet.getTimestamp("modify_date").getTime()));
            }

            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return b;
    }

    public boolean insert(BoardDTO boardDTO) {
        boolean result = true;
        String query = "INSERT INTO `board`(`title`, `content`, `writerId`, `entry_date`, `modify_date`) VALUES(?, ?, ?, NOW(), NOW())";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, boardDTO.getTitle());
            pstmt.setString(2, boardDTO.getContent());
            pstmt.setInt(3, boardDTO.getWriterId());

            pstmt.executeUpdate();
            pstmt.close();
        } catch (SQLException e) {
            result = false;
        }

        return result;
    }

    public void update(BoardDTO boardDTO) {
        String query = "UPDATE `board` SET `title` = ?, `content` = ?, `modify_date` = NOW() WHERE `id` = ?";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, boardDTO.getTitle());
            pstmt.setString(2, boardDTO.getContent());
            pstmt.setInt(3, boardDTO.getId());

            pstmt.executeUpdate();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void delete(int id) {
        String query = "DELETE FROM `board` WHERE `id` = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);

            pstmt.executeUpdate();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
