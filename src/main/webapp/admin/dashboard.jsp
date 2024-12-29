<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - SkyWings</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: var(--white);
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .stat-title {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 0.5rem;
        }

        .stat-value {
            font-size: 2rem;
            font-weight: 600;
            color: var(--dark-blue);
        }

        .charts-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .chart-card {
            background: var(--white);
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .recent-bookings {
            background: var(--white);
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
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
                    <a href="dashboard.jsp" class="nav-link active">
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
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-title">Total Users</div>
                    <div class="stat-value">${stats.totalUsers}</div>
                </div>
                <div class="stat-card">
                    <div class="stat-title">Total Flights</div>
                    <div class="stat-value">${stats.totalFlights}</div>
                </div>
                <div class="stat-card">
                    <div class="stat-title">Total Bookings</div>
                    <div class="stat-value">${stats.totalBookings}</div>
                </div>
                <div class="stat-card">
                    <div class="stat-title">Today's Bookings</div>
                    <div class="stat-value">${stats.todayBookings}</div>
                </div>
            </div>

            <div class="charts-container">
                <div class="chart-card">
                    <h3>Popular Routes</h3>
                    <canvas id="routesChart"></canvas>
                </div>
                <div class="chart-card">
                    <h3>Booking Trends</h3>
                    <canvas id="bookingTrendsChart"></canvas>
                </div>
            </div>

            <div class="recent-bookings">
                <h3>Recent Bookings</h3>
                <table class="table">
                    <thead>
                        <tr>
                            <th>Booking ID</th>
                            <th>User</th>
                            <th>Route</th>
                            <th>Date</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${stats.recentBookings}" var="booking">
                            <tr>
                                <td>#${booking.key}</td>
                                <td>${booking.value.username}</td>
                                <td>${booking.value.route}</td>
                                <td>${booking.value.date}</td>
                                <td>
                                    <span class="status-pill" style="background: var(--success-green); color: var(--white);">
                                        Confirmed
                                    </span>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </main>
    </div>

    <script>
        // Popular Routes Chart
        const routesCtx = document.getElementById('routesChart').getContext('2d');
        new Chart(routesCtx, {
            type: 'bar',
            data: {
                labels: Object.keys(${stats.popularRoutes}),
                datasets: [{
                    label: 'Number of Bookings',
                    data: Object.values(${stats.popularRoutes}),
                    backgroundColor: '#4a69bd',
                    borderColor: '#1e3799',
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });

        // Booking Trends Chart (Last 7 days)
        const trendsCtx = document.getElementById('bookingTrendsChart').getContext('2d');
        new Chart(trendsCtx, {
            type: 'line',
            data: {
                labels: ['6 days ago', '5 days ago', '4 days ago', '3 days ago', '2 days ago', 'Yesterday', 'Today'],
                datasets: [{
                    label: 'Number of Bookings',
                    data: [30, 45, 25, 60, 35, 40, ${stats.todayBookings}],
                    borderColor: '#2ecc71',
                    tension: 0.4,
                    fill: false
                }]
            },
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    </script>
</body>
</html>
