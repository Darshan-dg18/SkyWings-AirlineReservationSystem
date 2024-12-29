<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Flight Search Results</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f4;
        }
        .flight-card {
            background-color: white;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .flight-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
        }
        .flight-details {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .price {
            font-size: 24px;
            color: #1a73e8;
            font-weight: bold;
        }
        .book-button {
            background-color: #1a73e8;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
        }
        .book-button:hover {
            background-color: #1557b0;
        }
        .no-flights {
            text-align: center;
            padding: 50px;
            background-color: white;
            border-radius: 8px;
        }
    </style>
</head>
<body>
    <h1>Flight Search Results</h1>
    <h3>Search Date: ${searchDate}</h3>

    <c:if test="${empty flights}">
        <div class="no-flights">
            <h2>No Flights Found</h2>
            <p>No flights available for the selected route and date.</p>
            <a href="searchflight.jsp">Search Again</a>
        </div>
    </c:if>

    <c:forEach var="flight" items="${flights}">
        <div class="flight-card">
            <div class="flight-header">
                <h3>Flight ${flight.flightNumber}</h3>
                <span>Available Seats: ${flight.availableSeats}</span>
            </div>
            <div class="flight-details">
                <div>
                    <p><strong>From:</strong> ${flight.departureCity}</p>
                    <p><strong>Departure:</strong> ${flight.departureTime}</p>
                </div>
                <div>
                    <p><strong>To:</strong> ${flight.arrivalCity}</p>
                    <p><strong>Arrival:</strong> ${flight.arrivalTime}</p>
                </div>
                <div>
                    <p class="price">Economy: ₹${flight.economyPrice}</p>
                    <p class="price">Business: ₹${flight.businessPrice}</p>
                </div>
                <form action="BookingServlet" method="post">
                    <input type="hidden" name="flightNumber" value="${flight.flightNumber}">
                    <button type="submit" class="book-button">Book Now</button>
                </form>
            </div>
        </div>
    </c:forEach>
</body>
</html>
