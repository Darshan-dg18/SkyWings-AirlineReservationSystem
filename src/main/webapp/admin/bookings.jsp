<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Management - SkyWings</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --royal-blue: #1e3799;
            --light-blue: #4a69bd;
            --white: #ffffff;
            --light-gray: #f5f6fa;
            --dark-blue: #0c2461;
            --success-green: #2ecc71;
            --warning-yellow: #f1c40f;
            --danger-red: #e74c3c;
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
        }

        .dashboard-container {
            display: grid;
            grid-template-columns: 250px 1fr;
            min-height: 100vh;
        }

        .sidebar {
            background: var(--dark-blue);
            color: var(--white);
            padding: 2rem;
        }

        .logo {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 2rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .nav-menu {
            list-style: none;
        }

        .nav-item {
            margin-bottom: 0.5rem;
        }

        .nav-link {
            color: var(--white);
            text-decoration: none;
            padding: 0.8rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            border-radius: 5px;
            transition: background 0.3s ease;
        }

        .nav-link:hover, .nav-link.active {
            background: var(--royal-blue);
        }

        .main-content {
            padding: 2rem;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        .filters {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
            flex-wrap: wrap;
        }

        .filter-group {
            flex: 1;
            min-width: 200px;
        }

        .filter-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: var(--dark-blue);
            font-weight: 500;
        }

        .filter-group select, .filter-group input {
            width: 100%;
            padding: 0.8rem;
            border: 2px solid var(--light-gray);
            border-radius: 5px;
            font-size: 1rem;
        }

        .table-container {
            background: var(--white);
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            overflow-x: auto;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
        }

        .table th, .table td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid var(--light-gray);
        }

        .table th {
            font-weight: 600;
            color: var(--dark-blue);
        }

        .status-pill {
            padding: 0.3rem 0.8rem;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: 500;
        }

        .action-buttons {
            display: flex;
            gap: 0.5rem;
        }

        .btn {
            padding: 0.8rem 1.5rem;
            border-radius: 5px;
            border: none;
            font-weight: 500;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            text-decoration: none;
            transition: transform 0.3s ease;
        }

        .btn:hover {
            transform: translateY(-2px);
        }

        .btn-primary {
            background: var(--royal-blue);
            color: var(--white);
        }

        .btn-warning {
            background: var(--warning-yellow);
            color: var(--dark-blue);
        }

        .btn-danger {
            background: var(--danger-red);
            color: var(--white);
        }

        .booking-details {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            align-items: center;
            justify-content: center;
        }

        .booking-details.active {
            display: flex;
        }

        .booking-details-content {
            background: var(--white);
            padding: 2rem;
            border-radius: 10px;
            width: 100%;
            max-width: 600px;
        }

        .detail-group {
            margin-bottom: 1rem;
        }

        .detail-group label {
            font-weight: 500;
            color: #666;
        }

        .detail-group p {
            color: var(--dark-blue);
            font-size: 1.1rem;
            margin-top: 0.3rem;
        }

        @media (max-width: 1024px) {
            .dashboard-container {
                grid-template-columns: 1fr;
            }
            
            .sidebar {
                display: none;
            }
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <aside class="sidebar">
            <div class="logo">
                <i class="fas fa-plane"></i>
                SkyWings Admin
            </div>
            <ul class="nav-menu">
                <li class="nav-item">
                    <a href="dashboard.jsp" class="nav-link">
                        <i class="fas fa-home"></i> Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a href="flights.jsp" class="nav-link">
                        <i class="fas fa-plane-departure"></i> Flights
                    </a>
                </li>
                <li class="nav-item">
                    <a href="bookings.jsp" class="nav-link active">
                        <i class="fas fa-ticket-alt"></i> Bookings
                    </a>
                </li>
                <li class="nav-item">
                    <a href="users.jsp" class="nav-link">
                        <i class="fas fa-users"></i> Users
                    </a>
                </li>
                <li class="nav-item">
                    <a href="reports.jsp" class="nav-link">
                        <i class="fas fa-chart-bar"></i> Reports
                    </a>
                </li>
                <li class="nav-item">
                    <a href="../LogoutServlet" class="nav-link">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </a>
                </li>
            </ul>
        </aside>

        <main class="main-content">
            <div class="header">
                <h1>Booking Management</h1>
                <button class="btn btn-primary" onclick="exportBookings()">
                    <i class="fas fa-download"></i> Export
                </button>
            </div>

            <div class="filters">
                <div class="filter-group">
                    <label>Date Range</label>
                    <input type="date" id="startDate">
                </div>
                <div class="filter-group">
                    <label>&nbsp;</label>
                    <input type="date" id="endDate">
                </div>
                <div class="filter-group">
                    <label>Flight</label>
                    <select id="flightFilter">
                        <option value="">All Flights</option>
                        <c:forEach items="${flights}" var="flight">
                            <option value="${flight.flightNumber}">${flight.flightNumber}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="filter-group">
                    <label>Status</label>
                    <select id="statusFilter">
                        <option value="">All Status</option>
                        <option value="Confirmed">Confirmed</option>
                        <option value="Cancelled">Cancelled</option>
                    </select>
                </div>
                <div class="filter-group">
                    <label>&nbsp;</label>
                    <button class="btn btn-primary" onclick="applyFilters()">
                        <i class="fas fa-filter"></i> Apply Filters
                    </button>
                </div>
            </div>

            <div class="table-container">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Booking ID</th>
                            <th>User</th>
                            <th>Flight</th>
                            <th>Route</th>
                            <th>Date</th>
                            <th>Passengers</th>
                            <th>Amount</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${bookings}" var="booking">
                            <tr>
                                <td>#${booking.bookingId}</td>
                                <td>${booking.username}</td>
                                <td>${booking.flightNumber}</td>
                                <td>${booking.departureCity} - ${booking.arrivalCity}</td>
                                <td>
                                    <fmt:formatDate value="${booking.bookingDate}" pattern="MMM dd, yyyy"/>
                                </td>
                                <td>${booking.passengers}</td>
                                <td>₹${booking.amount}</td>
                                <td>
                                    <span class="status-pill" 
                                          style="background: ${booking.status == 'Confirmed' ? 'var(--success-green)' : 'var(--danger-red)'}; 
                                                 color: var(--white);">
                                        ${booking.status}
                                    </span>
                                </td>
                                <td>
                                    <div class="action-buttons">
                                        <button class="btn btn-primary" onclick="viewBooking(${booking.bookingId})">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                        <c:if test="${booking.status == 'Confirmed'}">
                                            <button class="btn btn-danger" onclick="cancelBooking(${booking.bookingId})">
                                                <i class="fas fa-times"></i>
                                            </button>
                                        </c:if>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </main>
    </div>

    <!-- Booking Details Modal -->
    <div id="bookingDetailsModal" class="booking-details">
        <div class="booking-details-content">
            <h2>Booking Details</h2>
            <div id="bookingInfo">
                <!-- Booking information will be loaded here -->
            </div>
            <div class="form-buttons">
                <button class="btn btn-danger" onclick="hideBookingDetails()">
                    Close
                </button>
            </div>
        </div>
    </div>

    <script>
        function viewBooking(bookingId) {
            // Load booking details via AJAX
            fetch('AdminBookingManagementServlet?action=view&id=' + bookingId)
                .then(response => response.json())
                .then(data => {
                    document.getElementById('bookingInfo').innerHTML = `
                        <div class="detail-group">
                            <label>Booking ID</label>
                            <p>#${data.bookingId}</p>
                        </div>
                        <div class="detail-group">
                            <label>User</label>
                            <p>${data.username}</p>
                        </div>
                        <div class="detail-group">
                            <label>Flight</label>
                            <p>${data.flightNumber}</p>
                        </div>
                        <div class="detail-group">
                            <label>Route</label>
                            <p>${data.departureCity} - ${data.arrivalCity}</p>
                        </div>
                        <div class="detail-group">
                            <label>Date</label>
                            <p>${new Date(data.bookingDate).toLocaleDateString()}</p>
                        </div>
                        <div class="detail-group">
                            <label>Passengers</label>
                            <p>${data.passengers}</p>
                        </div>
                        <div class="detail-group">
                            <label>Amount</label>
                            <p>₹${data.amount}</p>
                        </div>
                        <div class="detail-group">
                            <label>Status</label>
                            <p>${data.status}</p>
                        </div>
                    `;
                    
                    document.getElementById('bookingDetailsModal').classList.add('active');
                });
        }

        function hideBookingDetails() {
            document.getElementById('bookingDetailsModal').classList.remove('active');
        }

        function cancelBooking(bookingId) {
            if (confirm('Are you sure you want to cancel this booking?')) {
                window.location.href = 'AdminBookingManagementServlet?action=cancel&id=' + bookingId;
            }
        }

        function applyFilters() {
            const startDate = document.getElementById('startDate').value;
            const endDate = document.getElementById('endDate').value;
            const flight = document.getElementById('flightFilter').value;
            const status = document.getElementById('statusFilter').value;

            window.location.href = `bookings.jsp?startDate=${startDate}&endDate=${endDate}&flight=${flight}&status=${status}`;
        }

        function exportBookings() {
            const startDate = document.getElementById('startDate').value;
            const endDate = document.getElementById('endDate').value;
            const flight = document.getElementById('flightFilter').value;
            const status = document.getElementById('statusFilter').value;

            window.location.href = `AdminBookingManagementServlet?action=export&startDate=${startDate}&endDate=${endDate}&flight=${flight}&status=${status}`;
        }

        // Close modal when clicking outside
        window.onclick = function(event) {
            if (event.target.classList.contains('booking-details')) {
                event.target.classList.remove('active');
            }
        }
    </script>
</body>
</html>
