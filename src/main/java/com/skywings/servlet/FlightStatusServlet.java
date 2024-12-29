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
import java.util.ArrayList;
import java.util.List;

@WebServlet("/FlightStatusServlet")
public class FlightStatusServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String flightNumber = request.getParameter("flightNumber");
        String date = request.getParameter("date");
        
        try {
            Connection conn = DatabaseConnection.getConnection();
            
            PreparedStatement pstmt = conn.prepareStatement(
                "SELECT f.*, fs.status_message, fs.last_updated " +
                "FROM flights f " +
                "LEFT JOIN flight_status fs ON f.flight_number = fs.flight_number " +
                "WHERE f.flight_number = ? AND f.departure_date = ?"
            );
            pstmt.setString(1, flightNumber);
            pstmt.setString(2, date);
            
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                request.setAttribute("flightNumber", rs.getString("flight_number"));
                request.setAttribute("departureCity", rs.getString("departure_city"));
                request.setAttribute("arrivalCity", rs.getString("arrival_city"));
                request.setAttribute("departureDate", rs.getDate("departure_date"));
                request.setAttribute("departureTime", rs.getTime("departure_time"));
                request.setAttribute("arrivalTime", rs.getTime("arrival_time"));
                request.setAttribute("status", rs.getString("flight_status"));
                request.setAttribute("statusMessage", rs.getString("status_message"));
                request.setAttribute("lastUpdated", rs.getTimestamp("last_updated"));
                
                request.getRequestDispatcher("flightStatus.jsp").forward(request, response);
            } else {
                response.sendRedirect("checkStatus.jsp?error=notfound");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("checkStatus.jsp?error=system");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String flightNumber = request.getParameter("flightNumber");
        String status = request.getParameter("status");
        String message = request.getParameter("message");
        
        try {
            Connection conn = DatabaseConnection.getConnection();
            conn.setAutoCommit(false);
            
            try {
                // Update flight status
                PreparedStatement updateStmt = conn.prepareStatement(
                    "UPDATE flights SET flight_status = ? WHERE flight_number = ?"
                );
                updateStmt.setString(1, status);
                updateStmt.setString(2, flightNumber);
                updateStmt.executeUpdate();
                
                // Insert status message
                PreparedStatement statusStmt = conn.prepareStatement(
                    "INSERT INTO flight_status (flight_number, status_message, last_updated) " +
                    "VALUES (?, ?, NOW()) " +
                    "ON DUPLICATE KEY UPDATE status_message = ?, last_updated = NOW()"
                );
                statusStmt.setString(1, flightNumber);
                statusStmt.setString(2, message);
                statusStmt.setString(3, message);
                statusStmt.executeUpdate();
                
                // Get affected passengers for notification
                PreparedStatement bookingStmt = conn.prepareStatement(
                    "SELECT DISTINCT r.email, r.username " +
                    "FROM bookings b " +
                    "JOIN registration r ON b.user_id = r.id " +
                    "WHERE b.flight_number = ?"
                );
                bookingStmt.setString(1, flightNumber);
                ResultSet rs = bookingStmt.executeQuery();
                
                // Send notifications
                EmailNotificationServlet emailServlet = new EmailNotificationServlet();
                while (rs.next()) {
                    emailServlet.sendFlightUpdate(
                        rs.getString("email"),
                        rs.getString("username"),
                        flightNumber,
                        status,
                        message
                    );
                }
                
                conn.commit();
                response.sendRedirect("admin/flightManagement.jsp?success=updated");
                
            } catch (Exception e) {
                conn.rollback();
                throw e;
            } finally {
                conn.setAutoCommit(true);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin/flightManagement.jsp?error=system");
        }
    }
}
