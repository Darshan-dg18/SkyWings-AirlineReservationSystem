<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management - SkyWings</title>
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

        .search-box {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
        }

        .search-input {
            flex: 1;
            padding: 0.8rem;
            border: 2px solid var(--light-gray);
            border-radius: 5px;
            font-size: 1rem;
        }

        .search-input:focus {
            outline: none;
            border-color: var(--royal-blue);
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

        .user-details {
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

        .user-details.active {
            display: flex;
        }

        .user-details-content {
            background: var(--white);
            padding: 2rem;
            border-radius: 10px;
            width: 100%;
            max-width: 800px;
            max-height: 90vh;
            overflow-y: auto;
        }

        .booking-history {
            margin-top: 2rem;
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
                    <a href="bookings.jsp" class="nav-link">
                        <i class="fas fa-ticket-alt"></i> Bookings
                    </a>
                </li>
                <li class="nav-item">
                    <a href="users.jsp" class="nav-link active">
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
                <h1>User Management</h1>
            </div>

            <div class="search-box">
                <input type="text" class="search-input" placeholder="Search users...">
                <button class="btn btn-primary">
                    <i class="fas fa-search"></i> Search
                </button>
            </div>

            <div class="table-container">
                <table class="table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Username</th>
                            <th>Email</th>
                            <th>Joined Date</th>
                            <th>Bookings</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${users}" var="user">
                            <tr>
                                <td>#${user.id}</td>
                                <td>${user.username}</td>
                                <td>${user.email}</td>
                                <td>
                                    <fmt:formatDate value="${user.createdAt}" pattern="MMM dd, yyyy"/>
                                </td>
                                <td>${user.bookingCount}</td>
                                <td>
                                    <span class="status-pill" 
                                          style="background: ${user.status == 'Active' ? 'var(--success-green)' : 'var(--danger-red)'}; 
                                                 color: var(--white);">
                                        ${user.status}
                                    </span>
                                </td>
                                <td>
                                    <div class="action-buttons">
                                        <button class="btn btn-primary" onclick="viewUser(${user.id})">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                        <c:choose>
                                            <c:when test="${user.status == 'Active'}">
                                                <button class="btn btn-danger" onclick="blockUser(${user.id})">
                                                    <i class="fas fa-ban"></i>
                                                </button>
                                            </c:when>
                                            <c:otherwise>
                                                <button class="btn btn-success" onclick="unblockUser(${user.id})">
                                                    <i class="fas fa-check"></i>
                                                </button>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </main>
    </div>

    <!-- User Details Modal -->
    <div id="userDetailsModal" class="user-details">
        <div class="user-details-content">
            <h2>User Details</h2>
            <div id="userInfo">
                <!-- User information will be loaded here -->
            </div>
            <div class="booking-history">
                <h3>Booking History</h3>
                <table class="table">
                    <thead>
                        <tr>
                            <th>Booking ID</th>
                            <th>Flight</th>
                            <th>Route</th>
                            <th>Date</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody id="bookingHistory">
                        <!-- Booking history will be loaded here -->
                    </tbody>
                </table>
            </div>
            <div class="form-buttons">
                <button class="btn btn-danger" onclick="hideUserDetails()">
                    Close
                </button>
            </div>
        </div>
    </div>

    <script>
        function viewUser(userId) {
            // Load user details via AJAX
            fetch('UserManagementServlet?action=view&id=' + userId)
                .then(response => response.json())
                .then(data => {
                    document.getElementById('userInfo').innerHTML = `
                        <p><strong>Username:</strong> ${data.username}</p>
                        <p><strong>Email:</strong> ${data.email}</p>
                        <p><strong>Joined:</strong> ${new Date(data.createdAt).toLocaleDateString()}</p>
                        <p><strong>Status:</strong> ${data.status}</p>
                    `;
                    
                    const bookingHistory = document.getElementById('bookingHistory');
                    bookingHistory.innerHTML = '';
                    data.bookings.forEach(booking => {
                        bookingHistory.innerHTML += `
                            <tr>
                                <td>#${booking.bookingId}</td>
                                <td>${booking.flightNumber}</td>
                                <td>${booking.departureCity} - ${booking.arrivalCity}</td>
                                <td>${new Date(booking.bookingDate).toLocaleDateString()}</td>
                                <td>
                                    <span class="status-pill" style="background: var(--success-green); color: var(--white);">
                                        Confirmed
                                    </span>
                                </td>
                            </tr>
                        `;
                    });
                    
                    document.getElementById('userDetailsModal').classList.add('active');
                });
        }

        function hideUserDetails() {
            document.getElementById('userDetailsModal').classList.remove('active');
        }

        function blockUser(userId) {
            if (confirm('Are you sure you want to block this user?')) {
                window.location.href = 'UserManagementServlet?action=block&id=' + userId;
            }
        }

        function unblockUser(userId) {
            if (confirm('Are you sure you want to unblock this user?')) {
                window.location.href = 'UserManagementServlet?action=unblock&id=' + userId;
            }
        }

        // Close modal when clicking outside
        window.onclick = function(event) {
            if (event.target.classList.contains('user-details')) {
                event.target.classList.remove('active');
            }
        }

        // Search functionality
        document.querySelector('.search-input').addEventListener('input', function(e) {
            const searchTerm = e.target.value.toLowerCase();
            const rows = document.querySelectorAll('.table tbody tr');
            
            rows.forEach(row => {
                const text = row.textContent.toLowerCase();
                row.style.display = text.includes(searchTerm) ? '' : 'none';
            });
        });
    </script>
</body>
</html>
