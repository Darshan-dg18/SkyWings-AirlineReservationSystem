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

@WebServlet("/CancelBookingServlet")
public class CancelBookingServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");
        
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String bookingId = request.getParameter("bookingId");
        
        try {
            Connection conn = DatabaseConnection.getConnection();
            
            // Verify booking belongs to user
            PreparedStatement checkStmt = conn.prepareStatement(
                "SELECT b.*, f.flight_number FROM bookings b " +
                "JOIN flights f ON b.flight_number = f.flight_number " +
                "WHERE b.booking_id = ? AND b.user_id = ?"
            );
            checkStmt.setString(1, bookingId);
            checkStmt.setString(2, userId);
            
            ResultSet rs = checkStmt.executeQuery();
            
            if (rs.next()) {
                int passengers = rs.getInt("passengers");
                String flightNumber = rs.getString("flight_number");
                
                // Start transaction
                conn.setAutoCommit(false);
                
                try {
                    // Update available seats
                    PreparedStatement updateFlightStmt = conn.prepareStatement(
                        "UPDATE flights SET available_seats = available_seats + ? " +
                        "WHERE flight_number = ?"
                    );
                    updateFlightStmt.setInt(1, passengers);
                    updateFlightStmt.setString(2, flightNumber);
                    updateFlightStmt.executeUpdate();
                    
                    // Delete booking
                    PreparedStatement deleteStmt = conn.prepareStatement(
                        "DELETE FROM bookings WHERE booking_id = ?"
                    );
                    deleteStmt.setString(1, bookingId);
                    deleteStmt.executeUpdate();
                    
                    conn.commit();
                    response.sendRedirect("mybookings.jsp?success=cancelled");
                    
                } catch (Exception e) {
                    conn.rollback();
                    throw e;
                } finally {
                    conn.setAutoCommit(true);
                }
                
            } else {
                response.sendRedirect("mybookings.jsp?error=invalid");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("mybookings.jsp?error=system");
        }
    }
}
