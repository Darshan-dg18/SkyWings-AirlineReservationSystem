<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Flight Management - SkyWings</title>
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

        .btn-success {
            background: var(--success-green);
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

        .modal {
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

        .modal.active {
            display: flex;
        }

        .modal-content {
            background: var(--white);
            padding: 2rem;
            border-radius: 10px;
            width: 100%;
            max-width: 500px;
        }

        .form-group {
            margin-bottom: 1rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: var(--dark-blue);
            font-weight: 500;
        }

        .form-group input, .form-group select {
            width: 100%;
            padding: 0.8rem;
            border: 2px solid var(--light-gray);
            border-radius: 5px;
            font-size: 1rem;
        }

        .form-buttons {
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
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
                    <a href="flights.jsp" class="nav-link active">
                        <i class="fas fa-plane-departure"></i> Flights
                    </a>
                </li>
                <li class="nav-item">
                    <a href="bookings.jsp" class="nav-link">
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
                <h1>Flight Management</h1>
                <button class="btn btn-primary" onclick="showAddFlightModal()">
                    <i class="fas fa-plus"></i> Add Flight
                </button>
            </div>

            <div class="search-box">
                <input type="text" class="search-input" placeholder="Search flights...">
                <button class="btn btn-primary">
                    <i class="fas fa-search"></i> Search
                </button>
            </div>

            <div class="table-container">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Flight Number</th>
                            <th>From</th>
                            <th>To</th>
                            <th>Date</th>
                            <th>Time</th>
                            <th>Available Seats</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${flights}" var="flight">
                            <tr>
                                <td>${flight.flightNumber}</td>
                                <td>${flight.departureCity}</td>
                                <td>${flight.arrivalCity}</td>
                                <td>
                                    <fmt:formatDate value="${flight.departureDate}" pattern="MMM dd, yyyy"/>
                                </td>
                                <td>
                                    <fmt:formatDate value="${flight.departureTime}" pattern="HH:mm"/>
                                </td>
                                <td>${flight.availableSeats}</td>
                                <td>
                                    <span class="status-pill" style="background: var(--success-green); color: var(--white);">
                                        ${flight.status}
                                    </span>
                                </td>
                                <td>
                                    <div class="action-buttons">
                                        <button class="btn btn-warning" onclick="showEditFlightModal('${flight.flightNumber}')">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="btn btn-danger" onclick="deleteFlight('${flight.flightNumber}')">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </main>
    </div>

    <!-- Add Flight Modal -->
    <div id="addFlightModal" class="modal">
        <div class="modal-content">
            <h2>Add New Flight</h2>
            <form action="AdminFlightManagementServlet" method="post">
                <input type="hidden" name="action" value="add">
                
                <div class="form-group">
                    <label for="flightNumber">Flight Number</label>
                    <input type="text" id="flightNumber" name="flightNumber" required>
                </div>

                <div class="form-group">
                    <label for="departureCity">From</label>
                    <input type="text" id="departureCity" name="departureCity" required>
                </div>

                <div class="form-group">
                    <label for="arrivalCity">To</label>
                    <input type="text" id="arrivalCity" name="arrivalCity" required>
                </div>

                <div class="form-group">
                    <label for="departureDate">Date</label>
                    <input type="date" id="departureDate" name="departureDate" required>
                </div>

                <div class="form-group">
                    <label for="departureTime">Time</label>
                    <input type="time" id="departureTime" name="departureTime" required>
                </div>

                <div class="form-group">
                    <label for="totalSeats">Total Seats</label>
                    <input type="number" id="totalSeats" name="totalSeats" required>
                </div>

                <div class="form-group">
                    <label for="price">Price</label>
                    <input type="number" id="price" name="price" step="0.01" required>
                </div>

                <div class="form-buttons">
                    <button type="button" class="btn btn-danger" onclick="hideAddFlightModal()">
                        Cancel
                    </button>
                    <button type="submit" class="btn btn-primary">
                        Add Flight
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function showAddFlightModal() {
            document.getElementById('addFlightModal').classList.add('active');
        }

        function hideAddFlightModal() {
            document.getElementById('addFlightModal').classList.remove('active');
        }

        function showEditFlightModal(flightNumber) {
            // Implement edit functionality
        }

        function deleteFlight(flightNumber) {
            if (confirm('Are you sure you want to delete this flight?')) {
                window.location.href = 'AdminFlightManagementServlet?action=delete&flightNumber=' + flightNumber;
            }
        }

        // Close modal when clicking outside
        window.onclick = function(event) {
            if (event.target.classList.contains('modal')) {
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
