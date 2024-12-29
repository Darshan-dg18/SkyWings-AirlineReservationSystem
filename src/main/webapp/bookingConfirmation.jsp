<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Confirmation - SkyWings</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --success-green: #2ecc71;
            --light-gray: #f5f6fa;
            --dark-blue: #0c2461;
            --white: #ffffff;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background: var(--light-gray);
            min-height: 100vh;
            padding: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .confirmation-card {
            background: var(--white);
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            width: 100%;
            text-align: center;
        }

        .success-icon {
            color: var(--success-green);
            font-size: 4rem;
            margin-bottom: 1rem;
        }

        .booking-details {
            margin: 2rem 0;
            text-align: left;
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            padding: 0.8rem 0;
            border-bottom: 1px solid var(--light-gray);
        }

        .detail-label {
            color: #666;
            font-weight: 500;
        }

        .detail-value {
            color: var(--dark-blue);
            font-weight: 600;
        }

        .action-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 2rem;
        }

        .btn {
            padding: 0.8rem 1.5rem;
            border-radius: 5px;
            text-decoration: none;
            font-weight: 500;
            transition: transform 0.3s ease;
        }

        .btn:hover {
            transform: translateY(-2px);
        }

        .btn-primary {
            background: var(--dark-blue);
            color: var(--white);
        }

        .btn-secondary {
            background: var(--light-gray);
            color: var(--dark-blue);
        }

        @media (max-width: 480px) {
            .action-buttons {
                flex-direction: column;
            }
            
            .btn {
                width: 100%;
                text-align: center;
            }
        }
    </style>
</head>
<body>
    <sql:setDataSource var="ds" driver="com.mysql.cj.jdbc.Driver"
        url="jdbc:mysql://localhost:3306/airline_reservation"
        user="root" password="root"/>
        
    <sql:query dataSource="${ds}" var="result">
        SELECT b.*, f.*, p.amount, r.username, r.email
        FROM bookings b
        JOIN flights f ON b.flight_number = f.flight_number
        JOIN payments p ON b.payment_id = p.payment_id
        JOIN registration r ON b.user_id = r.id
        WHERE p.payment_id = ?
        <sql:param value="${param.paymentId}"/>
    </sql:query>

    <div class="confirmation-card">
        <i class="fas fa-check-circle success-icon"></i>
        <h1>Booking Confirmed!</h1>
        <p>Thank you for choosing SkyWings Airlines</p>

        <c:forEach var="booking" items="${result.rows}">
            <div class="booking-details">
                <div class="detail-row">
                    <span class="detail-label">Booking ID</span>
                    <span class="detail-value">${booking.booking_id}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Flight Number</span>
                    <span class="detail-value">${booking.flight_number}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">From</span>
                    <span class="detail-value">${booking.departure_city}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">To</span>
                    <span class="detail-value">${booking.arrival_city}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Date</span>
                    <span class="detail-value">${booking.departure_date}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Time</span>
                    <span class="detail-value">${booking.departure_time}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Class</span>
                    <span class="detail-value">${booking.travel_class}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Passengers</span>
                    <span class="detail-value">${booking.passengers}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Amount Paid</span>
                    <span class="detail-value">₹${booking.amount}</span>
                </div>
            </div>
        </c:forEach>

        <div class="action-buttons">
            <a href="mybookings.jsp" class="btn btn-primary">
                <i class="fas fa-list"></i> My Bookings
            </a>
            <a href="index.jsp" class="btn btn-secondary">
                <i class="fas fa-home"></i> Home
            </a>
        </div>
    </div>
</body>
</html>
