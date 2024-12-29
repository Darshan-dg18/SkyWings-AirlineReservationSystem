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
import java.util.UUID;

@WebServlet("/PaymentProcessingServlet")
public class PaymentProcessingServlet extends HttpServlet {
    
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
        double amount = Double.parseDouble(request.getParameter("amount"));
        String cardNumber = request.getParameter("cardNumber");
        String cardExpiry = request.getParameter("cardExpiry");
        String cardCvv = request.getParameter("cardCvv");
        
        try {
            Connection conn = DatabaseConnection.getConnection();
            conn.setAutoCommit(false);
            
            try {
                // Create payment record
                String paymentId = UUID.randomUUID().toString();
                PreparedStatement paymentStmt = conn.prepareStatement(
                    "INSERT INTO payments (payment_id, user_id, amount, payment_status, " +
                    "payment_method, created_at) VALUES (?, ?, ?, 'Success', 'Credit Card', NOW())"
                );
                paymentStmt.setString(1, paymentId);
                paymentStmt.setString(2, userId);
                paymentStmt.setDouble(3, amount);
                paymentStmt.executeUpdate();
                
                // Create booking
                PreparedStatement bookingStmt = conn.prepareStatement(
                    "INSERT INTO bookings (user_id, flight_number, travel_class, " +
                    "passengers, payment_id, booking_date) VALUES (?, ?, ?, ?, ?, NOW())"
                );
                bookingStmt.setString(1, userId);
                bookingStmt.setString(2, flightNumber);
                bookingStmt.setString(3, travelClass);
                bookingStmt.setInt(4, passengers);
                bookingStmt.setString(5, paymentId);
                bookingStmt.executeUpdate();
                
                // Update available seats
                PreparedStatement updateStmt = conn.prepareStatement(
                    "UPDATE flights SET available_seats = available_seats - ? " +
                    "WHERE flight_number = ? AND available_seats >= ?"
                );
                updateStmt.setInt(1, passengers);
                updateStmt.setString(2, flightNumber);
                updateStmt.setInt(3, passengers);
                
                int updated = updateStmt.executeUpdate();
                if (updated == 0) {
                    throw new Exception("No available seats");
                }
                
                // Get flight details for email
                PreparedStatement flightStmt = conn.prepareStatement(
                    "SELECT * FROM flights WHERE flight_number = ?"
                );
                flightStmt.setString(1, flightNumber);
                ResultSet rs = flightStmt.executeQuery();
                
                if (rs.next()) {
                    // Send confirmation email
                    EmailNotificationServlet emailServlet = new EmailNotificationServlet();
                    PreparedStatement userStmt = conn.prepareStatement(
                        "SELECT email, username FROM registration WHERE id = ?"
                    );
                    userStmt.setString(1, userId);
                    ResultSet userRs = userStmt.executeQuery();
                    
                    if (userRs.next()) {
                        emailServlet.sendBookingConfirmation(
                            userRs.getString("email"),
                            userRs.getString("username"),
                            flightNumber,
                            rs.getString("departure_city"),
                            rs.getString("arrival_city"),
                            rs.getDate("departure_date").toString(),
                            rs.getTime("departure_time").toString(),
                            amount
                        );
                    }
                }
                
                conn.commit();
                response.sendRedirect("bookingConfirmation.jsp?paymentId=" + paymentId);
                
            } catch (Exception e) {
                conn.rollback();
                throw e;
            } finally {
                conn.setAutoCommit(true);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("payment.jsp?error=failed");
        }
    }
}
