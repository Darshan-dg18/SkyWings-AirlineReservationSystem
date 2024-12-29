package com.skywings.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.skywings.util.DatabaseConnection;

@WebServlet("/MyBookingsServlet")
public class MyBookingsServlet extends HttpServlet {
    
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
                "SELECT b.*, f.departure_city, f.arrival_city, f.departure_date, " +
                "f.departure_time, f.arrival_time " +
                "FROM bookings b " +
                "JOIN flights f ON b.flight_number = f.flight_number " +
                "WHERE b.user_id = ? " +
                "ORDER BY b.booking_date DESC"
            );
            pstmt.setString(1, userId);
            
            ResultSet rs = pstmt.executeQuery();
            List<Booking> bookings = new ArrayList<>();
            
            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setFlightNumber(rs.getString("flight_number"));
                booking.setDepartureCity(rs.getString("departure_city"));
                booking.setArrivalCity(rs.getString("arrival_city"));
                booking.setDepartureDate(rs.getDate("departure_date"));
                booking.setDepartureTime(rs.getTime("departure_time"));
                booking.setArrivalTime(rs.getTime("arrival_time"));
                booking.setTravelClass(rs.getString("travel_class"));
                booking.setPassengers(rs.getInt("passengers"));
                booking.setBookingDate(rs.getTimestamp("booking_date"));
                bookings.add(booking);
            }
            
            request.setAttribute("bookings", bookings);
            request.getRequestDispatcher("mybookings.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("mybookings.jsp?error=system");
        }
    }
}

class Booking {
    private int bookingId;
    private String flightNumber;
    private String departureCity;
    private String arrivalCity;
    private java.sql.Date departureDate;
    private java.sql.Time departureTime;
    private java.sql.Time arrivalTime;
    private String travelClass;
    private int passengers;
    private java.sql.Timestamp bookingDate;
    
    // Getters and Setters
    public int getBookingId() { return bookingId; }
    public void setBookingId(int bookingId) { this.bookingId = bookingId; }
    
    public String getFlightNumber() { return flightNumber; }
    public void setFlightNumber(String flightNumber) { this.flightNumber = flightNumber; }
    
    public String getDepartureCity() { return departureCity; }
    public void setDepartureCity(String departureCity) { this.departureCity = departureCity; }
    
    public String getArrivalCity() { return arrivalCity; }
    public void setArrivalCity(String arrivalCity) { this.arrivalCity = arrivalCity; }
    
    public java.sql.Date getDepartureDate() { return departureDate; }
    public void setDepartureDate(java.sql.Date departureDate) { this.departureDate = departureDate; }
    
    public java.sql.Time getDepartureTime() { return departureTime; }
    public void setDepartureTime(java.sql.Time departureTime) { this.departureTime = departureTime; }
    
    public java.sql.Time getArrivalTime() { return arrivalTime; }
    public void setArrivalTime(java.sql.Time arrivalTime) { this.arrivalTime = arrivalTime; }
    
    public String getTravelClass() { return travelClass; }
    public void setTravelClass(String travelClass) { this.travelClass = travelClass; }
    
    public int getPassengers() { return passengers; }
    public void setPassengers(int passengers) { this.passengers = passengers; }
    
    public java.sql.Timestamp getBookingDate() { return bookingDate; }
    public void setBookingDate(java.sql.Timestamp bookingDate) { this.bookingDate = bookingDate; }
}
