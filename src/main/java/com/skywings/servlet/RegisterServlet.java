package com.skywings.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.skywings.util.DatabaseConnection;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        try {
            Connection conn = DatabaseConnection.getConnection();
            
            // Check if email already exists
            PreparedStatement checkStmt = conn.prepareStatement(
                "SELECT email FROM registration WHERE email = ?"
            );
            checkStmt.setString(1, email);
            ResultSet rs = checkStmt.executeQuery();
            
            if (rs.next()) {
                response.sendRedirect("register.jsp?error=email");
                return;
            }
            
            // Insert new user
            PreparedStatement pstmt = conn.prepareStatement(
                "INSERT INTO registration (username, email, password) VALUES (?, ?, ?)"
            );
            pstmt.setString(1, username);
            pstmt.setString(2, email);
            pstmt.setString(3, password);
            
            int result = pstmt.executeUpdate();
            
            if (result > 0) {
                response.sendRedirect("login.jsp?success=1");
            } else {
                response.sendRedirect("register.jsp?error=1");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=system");
        }
    }
}
