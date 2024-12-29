package com.skywings.servlet.admin;

import com.skywings.model.Flight;
import com.skywings.util.DatabaseConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/admin/AdminFlightManagementServlet")
public class AdminFlightManagementServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try {
            switch (action) {
                case "list":
                    listFlights(request, response);
                    break;
                case "view":
                    viewFlight(request, response);
                    break;
                case "delete":
                    deleteFlight(request, response);
                    break;
                default:
                    response.sendRedirect("flights.jsp");
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try {
            switch (action) {
                case "add":
                    addFlight(request, response);
                    break;
                case "update":
                    updateFlight(request, response);
                    break;
                default:
                    response.sendRedirect("flights.jsp");
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }
    
    private void listFlights(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<Flight> flights = new ArrayList<>();
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM flights")) {
            
            while (rs.next()) {
                Flight flight = new Flight();
                flight.setFlightNumber(rs.getString("flight_number"));
                flight.setDepartureCity(rs.getString("departure_city"));
                flight.setArrivalCity(rs.getString("arrival_city"));
                flight.setDepartureDate(rs.getDate("departure_date"));
                flight.setDepartureTime(rs.getTime("departure_time"));
                flight.setArrivalTime(rs.getTime("arrival_time"));
                flight.setTotalSeats(rs.getInt("total_seats"));
                flight.setAvailableSeats(rs.getInt("available_seats"));
                flight.setPrice(rs.getDouble("price"));
                flight.setStatus(rs.getString("status"));
                flights.add(flight);
            }
        }
        
        request.setAttribute("flights", flights);
        request.getRequestDispatcher("flights.jsp").forward(request, response);
    }
    
    private void viewFlight(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String flightNumber = request.getParameter("flightNumber");
        Flight flight = null;
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM flights WHERE flight_number = ?")) {
            
            stmt.setString(1, flightNumber);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                flight = new Flight();
                flight.setFlightNumber(rs.getString("flight_number"));
                flight.setDepartureCity(rs.getString("departure_city"));
                flight.setArrivalCity(rs.getString("arrival_city"));
                flight.setDepartureDate(rs.getDate("departure_date"));
                flight.setDepartureTime(rs.getTime("departure_time"));
                flight.setArrivalTime(rs.getTime("arrival_time"));
                flight.setTotalSeats(rs.getInt("total_seats"));
                flight.setAvailableSeats(rs.getInt("available_seats"));
                flight.setPrice(rs.getDouble("price"));
                flight.setStatus(rs.getString("status"));
            }
        }
        
        request.setAttribute("flight", flight);
        request.getRequestDispatcher("flight-details.jsp").forward(request, response);
    }
    
    private void addFlight(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String sql = "INSERT INTO flights (flight_number, departure_city, arrival_city, departure_date, " +
                    "departure_time, arrival_time, total_seats, available_seats, price, status) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, request.getParameter("flightNumber"));
            stmt.setString(2, request.getParameter("departureCity"));
            stmt.setString(3, request.getParameter("arrivalCity"));
            stmt.setDate(4, Date.valueOf(request.getParameter("departureDate")));
            stmt.setTime(5, Time.valueOf(request.getParameter("departureTime")));
            stmt.setTime(6, Time.valueOf(request.getParameter("arrivalTime")));
            stmt.setInt(7, Integer.parseInt(request.getParameter("totalSeats")));
            stmt.setInt(8, Integer.parseInt(request.getParameter("totalSeats"))); // Initially all seats are available
            stmt.setDouble(9, Double.parseDouble(request.getParameter("price")));
            stmt.setString(10, "Scheduled");
            
            stmt.executeUpdate();
        }
        
        response.sendRedirect("flights.jsp");
    }
    
    private void updateFlight(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String sql = "UPDATE flights SET departure_city = ?, arrival_city = ?, departure_date = ?, " +
                    "departure_time = ?, arrival_time = ?, total_seats = ?, price = ?, status = ? " +
                    "WHERE flight_number = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, request.getParameter("departureCity"));
            stmt.setString(2, request.getParameter("arrivalCity"));
            stmt.setDate(3, Date.valueOf(request.getParameter("departureDate")));
            stmt.setTime(4, Time.valueOf(request.getParameter("departureTime")));
            stmt.setTime(5, Time.valueOf(request.getParameter("arrivalTime")));
            stmt.setInt(6, Integer.parseInt(request.getParameter("totalSeats")));
            stmt.setDouble(7, Double.parseDouble(request.getParameter("price")));
            stmt.setString(8, request.getParameter("status"));
            stmt.setString(9, request.getParameter("flightNumber"));
            
            stmt.executeUpdate();
        }
        
        response.sendRedirect("flights.jsp");
    }
    
    private void deleteFlight(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String sql = "DELETE FROM flights WHERE flight_number = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, request.getParameter("flightNumber"));
            stmt.executeUpdate();
        }
        
        response.sendRedirect("flights.jsp");
    }
}
