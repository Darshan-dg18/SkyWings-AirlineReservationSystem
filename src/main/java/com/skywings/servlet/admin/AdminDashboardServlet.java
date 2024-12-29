package com.skywings.servlet.admin;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.skywings.util.DatabaseConnection;

@WebServlet("/admin/DashboardServlet")
public class AdminDashboardServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        if (session.getAttribute("adminId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            Connection conn = DatabaseConnection.getConnection();
            Map<String, Object> stats = new HashMap<>();
            
            // Total Users
            PreparedStatement userStmt = conn.prepareStatement(
                "SELECT COUNT(*) as total FROM registration"
            );
            ResultSet userRs = userStmt.executeQuery();
            if (userRs.next()) {
                stats.put("totalUsers", userRs.getInt("total"));
            }
            
            // Total Flights
            PreparedStatement flightStmt = conn.prepareStatement(
                "SELECT COUNT(*) as total FROM flights"
            );
            ResultSet flightRs = flightStmt.executeQuery();
            if (flightRs.next()) {
                stats.put("totalFlights", flightRs.getInt("total"));
            }
            
            // Total Bookings
            PreparedStatement bookingStmt = conn.prepareStatement(
                "SELECT COUNT(*) as total FROM bookings"
            );
            ResultSet bookingRs = bookingStmt.executeQuery();
            if (bookingRs.next()) {
                stats.put("totalBookings", bookingRs.getInt("total"));
            }
            
            // Today's Bookings
            PreparedStatement todayBookingStmt = conn.prepareStatement(
                "SELECT COUNT(*) as total FROM bookings WHERE DATE(booking_date) = CURDATE()"
            );
            ResultSet todayBookingRs = todayBookingStmt.executeQuery();
            if (todayBookingRs.next()) {
                stats.put("todayBookings", todayBookingRs.getInt("total"));
            }
            
            // Popular Routes
            PreparedStatement routeStmt = conn.prepareStatement(
                "SELECT departure_city, arrival_city, COUNT(*) as count " +
                "FROM bookings b JOIN flights f ON b.flight_number = f.flight_number " +
                "GROUP BY departure_city, arrival_city " +
                "ORDER BY count DESC LIMIT 5"
            );
            ResultSet routeRs = routeStmt.executeQuery();
            Map<String, Integer> popularRoutes = new HashMap<>();
            while (routeRs.next()) {
                String route = routeRs.getString("departure_city") + " - " + 
                             routeRs.getString("arrival_city");
                popularRoutes.put(route, routeRs.getInt("count"));
            }
            stats.put("popularRoutes", popularRoutes);
            
            // Recent Bookings
            PreparedStatement recentStmt = conn.prepareStatement(
                "SELECT b.*, r.username, f.departure_city, f.arrival_city " +
                "FROM bookings b " +
                "JOIN registration r ON b.user_id = r.id " +
                "JOIN flights f ON b.flight_number = f.flight_number " +
                "ORDER BY b.booking_date DESC LIMIT 5"
            );
            ResultSet recentRs = recentStmt.executeQuery();
            Map<Integer, Map<String, String>> recentBookings = new HashMap<>();
            while (recentRs.next()) {
                Map<String, String> booking = new HashMap<>();
                booking.put("username", recentRs.getString("username"));
                booking.put("route", recentRs.getString("departure_city") + " - " + 
                                   recentRs.getString("arrival_city"));
                booking.put("date", recentRs.getTimestamp("booking_date").toString());
                recentBookings.put(recentRs.getInt("booking_id"), booking);
            }
            stats.put("recentBookings", recentBookings);
            
            request.setAttribute("stats", stats);
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=system");
        }
    }
}
