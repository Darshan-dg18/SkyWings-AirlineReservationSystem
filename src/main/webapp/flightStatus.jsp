<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Flight Status - SkyWings</title>
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
            padding: 20px;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
        }

        .status-card {
            background: var(--white);
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        .flight-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--light-gray);
        }

        .flight-number {
            font-size: 2rem;
            color: var(--dark-blue);
        }

        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 25px;
            font-weight: 600;
        }

        .status-scheduled {
            background: var(--light-blue);
            color: var(--white);
        }

        .status-ontime {
            background: var(--success-green);
            color: var(--white);
        }

        .status-delayed {
            background: var(--warning-yellow);
            color: var(--dark-blue);
        }

        .status-cancelled {
            background: var(--danger-red);
            color: var(--white);
        }

        .flight-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            margin-bottom: 2rem;
        }

        .detail-group {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .detail-label {
            color: #666;
            font-size: 0.9rem;
        }

        .detail-value {
            color: var(--dark-blue);
            font-size: 1.2rem;
            font-weight: 600;
        }

        .timeline {
            margin-top: 2rem;
            padding-top: 2rem;
            border-top: 1px solid var(--light-gray);
        }

        .timeline-item {
            display: flex;
            gap: 1rem;
            margin-bottom: 1rem;
            padding: 1rem;
            background: var(--light-gray);
            border-radius: 10px;
        }

        .timeline-icon {
            color: var(--royal-blue);
            font-size: 1.5rem;
        }

        .timeline-content {
            flex: 1;
        }

        .timeline-time {
            color: #666;
            font-size: 0.9rem;
        }

        .timeline-message {
            color: var(--dark-blue);
            margin-top: 0.5rem;
        }

        @media (max-width: 768px) {
            .flight-header {
                flex-direction: column;
                gap: 1rem;
                text-align: center;
            }
        }
    </style>
</head>
<body>
    

    <div class="container">
        <div class="status-card">
            <div class="flight-header">
                <h1 class="flight-number">Flight ${flightNumber}</h1>
                <span class="status-badge status-${status.toLowerCase()}">
                    ${status}
                </span>
            </div>

            <div class="flight-details">
                <div class="detail-group">
                    <span class="detail-label">From</span>
                    <span class="detail-value">${departureCity}</span>
                </div>

                <div class="detail-group">
                    <span class="detail-label">To</span>
                    <span class="detail-value">${arrivalCity}</span>
                </div>

                <div class="detail-group">
                    <span class="detail-label">Date</span>
                    <span class="detail-value">
                        <fmt:formatDate value="${departureDate}" pattern="MMM dd, yyyy"/>
                    </span>
                </div>

                <div class="detail-group">
                    <span class="detail-label">Departure Time</span>
                    <span class="detail-value">
                        <fmt:formatDate value="${departureTime}" pattern="HH:mm"/>
                    </span>
                </div>

                <div class="detail-group">
                    <span class="detail-label">Arrival Time</span>
                    <span class="detail-value">
                        <fmt:formatDate value="${arrivalTime}" pattern="HH:mm"/>
                    </span>
                </div>
            </div>

            <div class="timeline">
                <h2>Status Updates</h2>
                <div class="timeline-item">
                    <div class="timeline-icon">
                        <i class="fas fa-info-circle"></i>
                    </div>
                    <div class="timeline-content">
                        <div class="timeline-time">
                            <fmt:formatDate value="${lastUpdated}" 
                                          pattern="MMM dd, yyyy HH:mm"/>
                        </div>
                        <div class="timeline-message">
                            ${statusMessage}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Auto-refresh the page every 5 minutes
        setTimeout(function() {
            location.reload();
        }, 300000);
    </script>
</body>
</html>
