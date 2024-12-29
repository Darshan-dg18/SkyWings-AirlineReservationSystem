package com.skywings.servlet;

import java.io.IOException;
import java.net.Authenticator;
import java.net.PasswordAuthentication;
import java.util.Properties;

import com.mysql.cj.Session;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.mail.*;
import jakarta.mail.internet.*;

@WebServlet("/EmailNotificationServlet")
public class EmailNotificationServlet extends HttpServlet {
    
    private static final String EMAIL_USERNAME = "your-email@gmail.com"; // Replace with your email
    private static final char[] EMAIL_PASSWORD = "your-app-password"; // Replace with your app password
    
    private void sendEmail(String to, String subject, String content) throws Exception {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        
        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL_USERNAME, EMAIL_PASSWORD);
            }
        });
        
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(EMAIL_USERNAME));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
        message.setSubject(subject);
        
        // Create HTML content
        MimeBodyPart messageBodyPart = new MimeBodyPart();
        messageBodyPart.setContent(content, "text/html");
        
        Multipart multipart = new MimeMultipart();
        multipart.addBodyPart(messageBodyPart);
        
        message.setContent(multipart);
        Transport.send(message);
    }
    
    public void sendBookingConfirmation(String email, String username, String flightNumber,
            String departureCity, String arrivalCity, String departureDate, 
            String departureTime, double price) {
        try {
            String subject = "Booking Confirmation - SkyWings Airlines";
            String content = String.format("""
                <html>
                <body style='font-family: Arial, sans-serif;'>
                    <div style='background-color: #f8f9fa; padding: 20px;'>
                        <h2 style='color: #1a73e8;'>Booking Confirmation</h2>
                        <p>Dear %s,</p>
                        <p>Your flight booking has been confirmed. Here are the details:</p>
                        <div style='background-color: white; padding: 15px; border-radius: 5px;'>
                            <p><strong>Flight Number:</strong> %s</p>
                            <p><strong>From:</strong> %s</p>
                            <p><strong>To:</strong> %s</p>
                            <p><strong>Date:</strong> %s</p>
                            <p><strong>Time:</strong> %s</p>
                            <p><strong>Price:</strong> ₹%.2f</p>
                        </div>
                        <p>Thank you for choosing SkyWings Airlines!</p>
                    </div>
                </body>
                </html>
                """, username, flightNumber, departureCity, arrivalCity, 
                     departureDate, departureTime, price);
            
            sendEmail(email, subject, content);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void sendBookingCancellation(String email, String username, String flightNumber) {
        try {
            String subject = "Booking Cancellation - SkyWings Airlines";
            String content = String.format("""
                <html>
                <body style='font-family: Arial, sans-serif;'>
                    <div style='background-color: #f8f9fa; padding: 20px;'>
                        <h2 style='color: #dc3545;'>Booking Cancellation</h2>
                        <p>Dear %s,</p>
                        <p>Your booking for flight %s has been cancelled.</p>
                        <p>If you did not request this cancellation, please contact our support team immediately.</p>
                        <p>Thank you for choosing SkyWings Airlines!</p>
                    </div>
                </body>
                </html>
                """, username, flightNumber);
            
            sendEmail(email, subject, content);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void sendFlightUpdate(String email, String username, String flightNumber, 
            String status, String message) {
        try {
            String subject = "Flight Status Update - SkyWings Airlines";
            String content = String.format("""
                <html>
                <body style='font-family: Arial, sans-serif;'>
                    <div style='background-color: #f8f9fa; padding: 20px;'>
                        <h2 style='color: #1a73e8;'>Flight Status Update</h2>
                        <p>Dear %s,</p>
                        <p>There has been an update regarding your flight %s:</p>
                        <div style='background-color: white; padding: 15px; border-radius: 5px;'>
                            <p><strong>Status:</strong> %s</p>
                            <p>%s</p>
                        </div>
                        <p>We apologize for any inconvenience caused.</p>
                    </div>
                </body>
                </html>
                """, username, flightNumber, status, message);
            
            sendEmail(email, subject, content);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
