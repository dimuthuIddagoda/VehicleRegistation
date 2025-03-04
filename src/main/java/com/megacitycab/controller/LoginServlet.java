package com.megacitycab.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("LoginServlet invoked"); // Debug statement

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        HttpSession session = request.getSession();

        // Check if admin login
        if ("admin".equals(username) && "admin123".equals(password)) {
            session.setAttribute("username", "admin");
            session.setAttribute("role", "admin");
            response.sendRedirect("adminDashboard.jsp");
        } else {
            // Validate customer credentials against the database
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection connection = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/vehicleReservationDb", "root", "");
                String query = "SELECT * FROM customers WHERE username = ? AND password = ?";
                PreparedStatement ps = connection.prepareStatement(query);
                ps.setString(1, username);
                ps.setString(2, password);
                ResultSet resultSet = ps.executeQuery();

                if (resultSet.next()) {
                    session.setAttribute("username", username);
                    session.setAttribute("role", "Customer");
                    response.sendRedirect("customerDashboard.jsp");
                } else {
                    response.sendRedirect("login.jsp?error=1");
                }

                resultSet.close();
                ps.close();
                connection.close();
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("login.jsp?error=2");
            }
        }
    }
}
