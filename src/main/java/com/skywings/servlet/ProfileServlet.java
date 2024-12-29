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
import jakarta.servlet.http.HttpSession;
import com.skywings.util.DatabaseConnection;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");
        
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            Connection conn = DatabaseConnection.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(
                "SELECT * FROM registration WHERE id = ?"
            );
            pstmt.setString(1, userId);
            
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                request.setAttribute("username", rs.getString("username"));
                request.setAttribute("email", rs.getString("email"));
                request.getRequestDispatcher("profile.jsp").forward(request, response);
            } else {
                response.sendRedirect("login.jsp");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("profile.jsp?error=system");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");
        
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String username = request.getParameter("username");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        
        try {
            Connection conn = DatabaseConnection.getConnection();
            
            // Verify current password
            PreparedStatement checkStmt = conn.prepareStatement(
                "SELECT password FROM registration WHERE id = ?"
            );
            checkStmt.setString(1, userId);
            ResultSet rs = checkStmt.executeQuery();
            
            if (rs.next() && rs.getString("password").equals(currentPassword)) {
                // Update profile
                PreparedStatement updateStmt = conn.prepareStatement(
                    "UPDATE registration SET username = ?, password = ? WHERE id = ?"
                );
                updateStmt.setString(1, username);
                updateStmt.setString(2, newPassword.isEmpty() ? currentPassword : newPassword);
                updateStmt.setString(3, userId);
                
                updateStmt.executeUpdate();
                session.setAttribute("userName", username);
                response.sendRedirect("profile.jsp?success=1");
            } else {
                response.sendRedirect("profile.jsp?error=password");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("profile.jsp?error=system");
        }
    }
}
