package com.bit.spring.service;

import com.bit.spring.connector.MySqlConnector;
import com.bit.spring.model.UserDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@Service
public class UserService {
    private MySqlConnector connector;
    private Connection connection;

    @Autowired
    public UserService(MySqlConnector connector) {
        this.connector = connector;
        connection = this.connector.makeConnection();
    }

    public boolean insert(UserDTO userDTO) {
        boolean result = true;
        String query = "INSERT INTO `user`(`username`, `password`, `nickname`) VALUES(?, ?, ?)";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, userDTO.getUsername());
            pstmt.setString(2, userDTO.getPassword());
            pstmt.setString(3, userDTO.getNickname());

            pstmt.executeUpdate();
            pstmt.close();
        } catch (SQLException e) {
            System.out.println("[회원가입] 등록 오류");
            return false;
        }

        return result;
    }

    public void update(UserDTO userDTO) {
        String query = "UPDATE `user` SET `password` = ?, `nickname` = ? WHERE `id` = ?";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, userDTO.getPassword());
            pstmt.setString(2, userDTO.getNickname());
            pstmt.setInt(3, userDTO.getId());

            pstmt.executeUpdate();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void delete(int id) {
        String query = "DELETE FROM `user` WHERE `id` = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);

            pstmt.executeUpdate();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public UserDTO auth(UserDTO attempt) {
        UserDTO userDTO = null;
        String query = "SELECT * FROM `user` WHERE `username` = ? AND `password` = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, attempt.getUsername());
            pstmt.setString(2, attempt.getPassword());

            ResultSet resultSet = pstmt.executeQuery();
            if(resultSet.next()) {
                userDTO = new UserDTO();
                userDTO.setId(resultSet.getInt("id"));
                userDTO.setUsername(resultSet.getString("username"));
                userDTO.setNickname(resultSet.getString("nickname"));
            }

            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return userDTO;
    }

    public String getNickname(int id) {
        String nick = null;
        String query = "SELECT `nickname` FROM `user` WHERE `id` = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);

            ResultSet resultSet = pstmt.executeQuery();
            if(resultSet.next()) {
                nick = resultSet.getString("nickname");
            }
            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return nick;
    }
}
