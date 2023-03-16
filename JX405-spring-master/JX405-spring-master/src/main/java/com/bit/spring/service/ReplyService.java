package com.bit.spring.service;

import com.bit.spring.connector.MySqlConnector;
import com.bit.spring.model.ReplyDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.*;
import java.util.ArrayList;

@Service
public class ReplyService {
    private MySqlConnector connector;
    private Connection connection;

    @Autowired
    public ReplyService(MySqlConnector connector) {
        this.connector = connector;
        connection = this.connector.makeConnection();
    }

    public boolean insert(ReplyDTO replyDTO) {
        boolean result = true;
        String query = "INSERT INTO `reply`(`content`, `boardId`, `writerId`, `entry_date`) VALUES(?, ?, ?, NOW())";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, replyDTO.getContent());
            pstmt.setInt(2, replyDTO.getBoardId());
            pstmt.setInt(3, replyDTO.getWriterId());

            pstmt.executeUpdate();
            pstmt.close();
        } catch (SQLException e) {
            System.out.println(e.getErrorCode());
            result = false;
        }

        return result;
    }

    public ArrayList<ReplyDTO> selectByBoardId(int boardId) {
        ArrayList<ReplyDTO> list = new ArrayList<>();
        String query = "SELECT * FROM `reply` WHERE `boardId` = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, boardId);

            ResultSet resultSet = pstmt.executeQuery();
            while(resultSet.next()) {
                ReplyDTO r = new ReplyDTO();
                r.setId(resultSet.getInt("id"));
                r.setContent(resultSet.getString("content"));
                r.setBoardId(resultSet.getInt("boardId"));
                r.setWriterId(resultSet.getInt("writerId"));
                r.setEntryDate(new Date(resultSet.getTimestamp("entry_date").getTime()));
                if(resultSet.getTimestamp("modify_date") != null) {
                    r.setModifyDate(new Date(resultSet.getTimestamp("modify_date").getTime()));
                }

                list.add(r);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
}
