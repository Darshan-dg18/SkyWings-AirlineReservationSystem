package com.airline.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        // TODO: Add database validation for login credentials
        // This is a placeholder for demonstration
        if(email != null && password != null) {
            HttpSession session = request.getSession();
            session.setAttribute("userEmail", email);
            
            // Redirect to the search page with the form data
            response.sendRedirect("searchFlight");
        } else {
            // If login fails, redirect back to the search page
            response.sendRedirect("flightSearch.jsp");
        }
    }
}
