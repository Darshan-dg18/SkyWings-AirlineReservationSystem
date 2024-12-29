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

@WebServlet(name = "SearchFlightServlet", urlPatterns = {"/SearchFlightServlet"})
public class SearchFlightServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get search parameters
        String from = request.getParameter("from");
        String to = request.getParameter("to");
        String date = request.getParameter("date");
        
        List<FlightDetails> flightsList = new ArrayList<>();
        
        try {
            // Get database connection
            Connection conn = DatabaseConnection.getConnection();
            
            // Prepare SQL query
            String sql = "SELECT * FROM flights WHERE departure_city = ? AND arrival_city = ? AND departure_date = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            
            // Set parameters
            pstmt.setString(1, from);
            pstmt.setString(2, to);
            pstmt.setString(3, date);
            
            // Execute query
            ResultSet rs = pstmt.executeQuery();
            
            // Process results
            while (rs.next()) {
                FlightDetails flight = new FlightDetails();
                flight.setFlightNumber(rs.getString("flight_number"));
                flight.setDepartureCity(rs.getString("departure_city"));
                flight.setArrivalCity(rs.getString("arrival_city"));
                flight.setDepartureTime(rs.getString("departure_time"));
                flight.setArrivalTime(rs.getString("arrival_time"));
                flight.setEconomyPrice(rs.getDouble("economy_price"));
                flight.setBusinessPrice(rs.getDouble("business_price"));
                flight.setAvailableSeats(rs.getInt("available_seats"));
                flightsList.add(flight);
            }
            
            // Close resources
            rs.close();
            pstmt.close();
            conn.close();
            
            // Set attributes and forward
            request.setAttribute("flights", flightsList);
            request.setAttribute("searchDate", date);
            request.getRequestDispatcher("/flightResult.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("searchflight.jsp?error=1");
        }
    }
}

class FlightDetails {
    private String flightNumber;
    private String departureCity;
    private String arrivalCity;
    private String departureTime;
    private String arrivalTime;
    private double economyPrice;
    private double businessPrice;
    private int availableSeats;
    
    // Getters and Setters
    public String getFlightNumber() { return flightNumber; }
    public void setFlightNumber(String flightNumber) { this.flightNumber = flightNumber; }
    
    public String getDepartureCity() { return departureCity; }
    public void setDepartureCity(String departureCity) { this.departureCity = departureCity; }
    
    public String getArrivalCity() { return arrivalCity; }
    public void setArrivalCity(String arrivalCity) { this.arrivalCity = arrivalCity; }
    
    public String getDepartureTime() { return departureTime; }
    public void setDepartureTime(String departureTime) { this.departureTime = departureTime; }
    
    public String getArrivalTime() { return arrivalTime; }
    public void setArrivalTime(String arrivalTime) { this.arrivalTime = arrivalTime; }
    
    public double getEconomyPrice() { return economyPrice; }
    public void setEconomyPrice(double economyPrice) { this.economyPrice = economyPrice; }
    
    public double getBusinessPrice() { return businessPrice; }
    public void setBusinessPrice(double businessPrice) { this.businessPrice = businessPrice; }
    
    public int getAvailableSeats() { return availableSeats; }
    public void setAvailableSeats(int availableSeats) { this.availableSeats = availableSeats; }
}
