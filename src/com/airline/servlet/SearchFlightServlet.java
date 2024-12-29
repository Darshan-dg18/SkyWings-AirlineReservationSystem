package com.airline.servlet;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.airline.model.Flight;

@WebServlet("/searchFlight")
public class SearchFlightServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        if (session.getAttribute("userEmail") == null) {
            response.sendRedirect("flightSearch.jsp");
            return;
        }

        // Get search parameters
        String departureCity = request.getParameter("departureCity");
        String arrivalCity = request.getParameter("arrivalCity");
        String departureDateStr = request.getParameter("departureDate");
        int passengers = Integer.parseInt(request.getParameter("passengers"));
        String travelClass = request.getParameter("class");

        // TODO: Replace this with actual database query
        // For now, creating sample flight data
        List<Flight> flights = searchFlights(departureCity, arrivalCity, 
                                          departureDateStr, passengers, travelClass);

        // Store results in session
        request.setAttribute("flights", flights);
        request.setAttribute("passengers", passengers);
        request.setAttribute("travelClass", travelClass);
        
        // Forward to results page
        request.getRequestDispatcher("flightResults.jsp").forward(request, response);
    }

    private List<Flight> searchFlights(String departureCity, String arrivalCity, 
                                     String departureDateStr, int passengers, 
                                     String travelClass) {
        List<Flight> flights = new ArrayList<>();
        
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date departureDate = sdf.parse(departureDateStr);
            
            // Adding sample flights - Replace this with database query
            flights.add(new Flight("AI101", departureCity, arrivalCity, 
                                 departureDate, new Date(departureDate.getTime() + 7200000), 
                                 250.00, 100, travelClass, "Air India"));
            flights.add(new Flight("BA202", departureCity, arrivalCity, 
                                 new Date(departureDate.getTime() + 3600000), 
                                 new Date(departureDate.getTime() + 9000000), 
                                 300.00, 80, travelClass, "British Airways"));
            flights.add(new Flight("EK303", departureCity, arrivalCity, 
                                 new Date(departureDate.getTime() + 7200000), 
                                 new Date(departureDate.getTime() + 12600000), 
                                 275.00, 90, travelClass, "Emirates"));
        } catch (ParseException e) {
            e.printStackTrace();
        }
        
        return flights;
    }
}
