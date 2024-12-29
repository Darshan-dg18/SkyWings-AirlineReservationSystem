package com.skywings.servlet.admin;

import com.skywings.model.Booking;
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

@WebServlet("/admin/AdminBookingManagementServlet")
public class AdminBookingManagementServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try {
            switch (action) {
                case "list":
                    listBookings(request, response);
                    break;
                case "view":
                    viewBooking(request, response);
                    break;
                case "cancel":
                    cancelBooking(request, response);
                    break;
                case "export":
                    exportBookings(request, response);
                    break;
                default:
                    response.sendRedirect("bookings.jsp");
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }
    
    private void listBookings(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<Booking> bookings = new ArrayList<>();
        
        StringBuilder sql = new StringBuilder(
            "SELECT b.*, u.username, f.departure_city, f.arrival_city " +
            "FROM bookings b " +
            "JOIN users u ON b.user_id = u.id " +
            "JOIN flights f ON b.flight_number = f.flight_number " +
            "WHERE 1=1"
        );
        
        // Add filters
        if (request.getParameter("startDate") != null && !request.getParameter("startDate").isEmpty()) {
            sql.append(" AND DATE(b.booking_date) >= ?");
        }
        if (request.getParameter("endDate") != null && !request.getParameter("endDate").isEmpty()) {
            sql.append(" AND DATE(b.booking_date) <= ?");
        }
        if (request.getParameter("flight") != null && !request.getParameter("flight").isEmpty()) {
            sql.append(" AND b.flight_number = ?");
        }
        if (request.getParameter("status") != null && !request.getParameter("status").isEmpty()) {
            sql.append(" AND b.status = ?");
        }
        
        sql.append(" ORDER BY b.booking_date DESC");
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            
            int paramIndex = 1;
            if (request.getParameter("startDate") != null && !request.getParameter("startDate").isEmpty()) {
                stmt.setDate(paramIndex++, Date.valueOf(request.getParameter("startDate")));
            }
            if (request.getParameter("endDate") != null && !request.getParameter("endDate").isEmpty()) {
                stmt.setDate(paramIndex++, Date.valueOf(request.getParameter("endDate")));
            }
            if (request.getParameter("flight") != null && !request.getParameter("flight").isEmpty()) {
                stmt.setString(paramIndex++, request.getParameter("flight"));
            }
            if (request.getParameter("status") != null && !request.getParameter("status").isEmpty()) {
                stmt.setString(paramIndex, request.getParameter("status"));
            }
            
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setUserId(rs.getInt("user_id"));
                booking.setUsername(rs.getString("username"));
                booking.setFlightNumber(rs.getString("flight_number"));
                booking.setDepartureCity(rs.getString("departure_city"));
                booking.setArrivalCity(rs.getString("arrival_city"));
                booking.setTravelClass(rs.getString("travel_class"));
                booking.setPassengers(rs.getInt("passengers"));
                booking.setAmount(rs.getDouble("amount"));
                booking.setBookingDate(rs.getTimestamp("booking_date"));
                booking.setStatus(rs.getString("status"));
                bookings.add(booking);
            }
        }
        
        request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("bookings.jsp").forward(request, response);
    }
    
    private void viewBooking(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("id"));
        Booking booking = null;
        
        String sql = "SELECT b.*, u.username, f.departure_city, f.arrival_city " +
                    "FROM bookings b " +
                    "JOIN users u ON b.user_id = u.id " +
                    "JOIN flights f ON b.flight_number = f.flight_number " +
                    "WHERE b.booking_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, bookingId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setUserId(rs.getInt("user_id"));
                booking.setUsername(rs.getString("username"));
                booking.setFlightNumber(rs.getString("flight_number"));
                booking.setDepartureCity(rs.getString("departure_city"));
                booking.setArrivalCity(rs.getString("arrival_city"));
                booking.setTravelClass(rs.getString("travel_class"));
                booking.setPassengers(rs.getInt("passengers"));
                booking.setAmount(rs.getDouble("amount"));
                booking.setBookingDate(rs.getTimestamp("booking_date"));
                booking.setStatus(rs.getString("status"));
            }
        }
        
        request.setAttribute("booking", booking);
        request.getRequestDispatcher("booking-details.jsp").forward(request, response);
    }
    
    private void cancelBooking(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("id"));
        
        try (Connection conn = DatabaseConnection.getConnection()) {
            conn.setAutoCommit(false);
            try {
                // Update booking status
                String updateBookingSql = "UPDATE bookings SET status = 'Cancelled' WHERE booking_id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(updateBookingSql)) {
                    stmt.setInt(1, bookingId);
                    stmt.executeUpdate();
                }
                
                // Get flight details and number of passengers
                String getBookingDetailsSql = "SELECT flight_number, passengers FROM bookings WHERE booking_id = ?";
                String flightNumber;
                int passengers;
                try (PreparedStatement stmt = conn.prepareStatement(getBookingDetailsSql)) {
                    stmt.setInt(1, bookingId);
                    ResultSet rs = stmt.executeQuery();
                    if (!rs.next()) {
                        throw new SQLException("Booking not found");
                    }
                    flightNumber = rs.getString("flight_number");
                    passengers = rs.getInt("passengers");
                }
                
                // Update available seats
                String updateFlightSql = "UPDATE flights SET available_seats = available_seats + ? WHERE flight_number = ?";
                try (PreparedStatement stmt = conn.prepareStatement(updateFlightSql)) {
                    stmt.setInt(1, passengers);
                    stmt.setString(2, flightNumber);
                    stmt.executeUpdate();
                }
                
                conn.commit();
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            } finally {
                conn.setAutoCommit(true);
            }
        }
        
        response.sendRedirect("bookings.jsp");
    }
    
    private void exportBookings(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment; filename=\"bookings.csv\"");
        
        StringBuilder sql = new StringBuilder(
            "SELECT b.*, u.username, f.departure_city, f.arrival_city " +
            "FROM bookings b " +
            "JOIN users u ON b.user_id = u.id " +
            "JOIN flights f ON b.flight_number = f.flight_number " +
            "WHERE 1=1"
        );
        
        // Add filters (same as listBookings)
        if (request.getParameter("startDate") != null && !request.getParameter("startDate").isEmpty()) {
            sql.append(" AND DATE(b.booking_date) >= ?");
        }
        if (request.getParameter("endDate") != null && !request.getParameter("endDate").isEmpty()) {
            sql.append(" AND DATE(b.booking_date) <= ?");
        }
        if (request.getParameter("flight") != null && !request.getParameter("flight").isEmpty()) {
            sql.append(" AND b.flight_number = ?");
        }
        if (request.getParameter("status") != null && !request.getParameter("status").isEmpty()) {
            sql.append(" AND b.status = ?");
        }
        
        sql.append(" ORDER BY b.booking_date DESC");
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            
            int paramIndex = 1;
            if (request.getParameter("startDate") != null && !request.getParameter("startDate").isEmpty()) {
                stmt.setDate(paramIndex++, Date.valueOf(request.getParameter("startDate")));
            }
            if (request.getParameter("endDate") != null && !request.getParameter("endDate").isEmpty()) {
                stmt.setDate(paramIndex++, Date.valueOf(request.getParameter("endDate")));
            }
            if (request.getParameter("flight") != null && !request.getParameter("flight").isEmpty()) {
                stmt.setString(paramIndex++, request.getParameter("flight"));
            }
            if (request.getParameter("status") != null && !request.getParameter("status").isEmpty()) {
                stmt.setString(paramIndex, request.getParameter("status"));
            }
            
            ResultSet rs = stmt.executeQuery();
            
            // Write CSV header
            response.getWriter().write("Booking ID,Username,Flight Number,Route,Travel Class,Passengers,Amount,Booking Date,Status\n");
            
            // Write data rows
            while (rs.next()) {
                response.getWriter().write(String.format("%d,%s,%s,%s - %s,%s,%d,%.2f,%s,%s\n",
                    rs.getInt("booking_id"),
                    rs.getString("username"),
                    rs.getString("flight_number"),
                    rs.getString("departure_city"),
                    rs.getString("arrival_city"),
                    rs.getString("travel_class"),
                    rs.getInt("passengers"),
                    rs.getDouble("amount"),
                    rs.getTimestamp("booking_date"),
                    rs.getString("status")
                ));
            }
        }
    }
}
