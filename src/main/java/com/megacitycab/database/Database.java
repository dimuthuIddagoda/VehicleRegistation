package com.megacitycab.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Database {
    public String validateUser(String username, String password) {
        String url = "jdbc:mysql://localhost:3306/VehicleDB";
        String dbUsername = "root";
        String dbPassword = "password";

        try (Connection conn = DriverManager.getConnection(url, dbUsername, dbPassword)) {
            String query = "SELECT role FROM customers WHERE username = ? AND password = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, username);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("role"); // Return the user's role
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Return null if the user is not found
    }
}