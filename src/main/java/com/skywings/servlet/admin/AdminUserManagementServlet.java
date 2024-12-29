package com.skywings.servlet.admin;

import com.skywings.model.User;
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

@WebServlet("/admin/AdminUserManagementServlet")
public class AdminUserManagementServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try {
            switch (action) {
                case "list":
                    listUsers(request, response);
                    break;
                case "view":
                    viewUser(request, response);
                    break;
                case "block":
                    blockUser(request, response);
                    break;
                case "unblock":
                    unblockUser(request, response);
                    break;
                default:
                    response.sendRedirect("users.jsp");
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }
    
    private void listUsers(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<User> users = new ArrayList<>();
        
        String sql = "SELECT u.*, COUNT(b.booking_id) as booking_count " +
                    "FROM users u LEFT JOIN bookings b ON u.id = b.user_id " +
                    "GROUP BY u.id";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setStatus(rs.getString("status"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                user.setBookingCount(rs.getInt("booking_count"));
                users.add(user);
            }
        }
        
        request.setAttribute("users", users);
        request.getRequestDispatcher("users.jsp").forward(request, response);
    }
    
    private void viewUser(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("id"));
        User user = null;
        
        String sql = "SELECT u.*, COUNT(b.booking_id) as booking_count " +
                    "FROM users u LEFT JOIN bookings b ON u.id = b.user_id " +
                    "WHERE u.id = ? GROUP BY u.id";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setStatus(rs.getString("status"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                user.setBookingCount(rs.getInt("booking_count"));
            }
        }
        
        // Get user's bookings
        String bookingsSql = "SELECT b.*, f.departure_city, f.arrival_city " +
                           "FROM bookings b JOIN flights f ON b.flight_number = f.flight_number " +
                           "WHERE b.user_id = ? ORDER BY b.booking_date DESC";
        
        List<Object> bookings = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(bookingsSql)) {
            
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                // Create a map or object to store booking details
                java.util.Map<String, Object> booking = new java.util.HashMap<>();
                booking.put("bookingId", rs.getInt("booking_id"));
                booking.put("flightNumber", rs.getString("flight_number"));
                booking.put("departureCity", rs.getString("departure_city"));
                booking.put("arrivalCity", rs.getString("arrival_city"));
                booking.put("bookingDate", rs.getTimestamp("booking_date"));
                booking.put("status", rs.getString("status"));
                bookings.add(booking);
            }
        }
        
        request.setAttribute("user", user);
        request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("user-details.jsp").forward(request, response);
    }
    
    private void blockUser(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        updateUserStatus(request.getParameter("id"), "Blocked");
        response.sendRedirect("users.jsp");
    }
    
    private void unblockUser(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        updateUserStatus(request.getParameter("id"), "Active");
        response.sendRedirect("users.jsp");
    }
    
    private void updateUserStatus(String userId, String status) throws SQLException {
        String sql = "UPDATE users SET status = ? WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, status);
            stmt.setInt(2, Integer.parseInt(userId));
            stmt.executeUpdate();
        }
    }
}
