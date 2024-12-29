package com.skywings.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.skywings.util.DatabaseConnection;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
            
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");
        
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String flightNumber = request.getParameter("flightNumber");
        String travelClass = request.getParameter("class");
        int passengers = Integer.parseInt(request.getParameter("passengers"));
        
        try {
            Connection conn = DatabaseConnection.getConnection();
            
            // Create booking
            PreparedStatement pstmt = conn.prepareStatement(
                "INSERT INTO bookings (user_id, flight_number, travel_class, passengers, booking_date) " +
                "VALUES (?, ?, ?, ?, NOW())"
            );
            pstmt.setString(1, userId);
            pstmt.setString(2, flightNumber);
            pstmt.setString(3, travelClass);
            pstmt.setInt(4, passengers);
            
            int result = pstmt.executeUpdate();
            
            if (result > 0) {
                // Update available seats
                PreparedStatement updateStmt = conn.prepareStatement(
                    "UPDATE flights SET available_seats = available_seats - ? " +
                    "WHERE flight_number = ?"
                );
                updateStmt.setInt(1, passengers);
                updateStmt.setString(2, flightNumber);
                updateStmt.executeUpdate();
                
                response.sendRedirect("mybookings.jsp?success=1");
            } else {
                response.sendRedirect("flightResult.jsp?error=booking");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("flightResult.jsp?error=system");
        }
    }
}
