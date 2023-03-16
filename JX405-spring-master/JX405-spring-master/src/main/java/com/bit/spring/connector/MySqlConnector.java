package com.bit.spring.connector;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class MySqlConnector {
    private final String ADDRESS = "jdbc:mysql://localhost/basic";
    private final String USERNAME = "root";
    private final String PASSWORD = "1234";

    public Connection makeConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(ADDRESS, USERNAME, PASSWORD);
            return connection;
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
