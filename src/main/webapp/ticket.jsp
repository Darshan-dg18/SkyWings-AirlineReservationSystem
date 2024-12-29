<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Flight Ticket - SkyWings</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --royal-blue: #1e3799;
            --light-blue: #4a69bd;
            --white: #ffffff;
            --light-gray: #f5f6fa;
            --dark-blue: #0c2461;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background-color: #f0f2f5;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            padding: 2rem;
        }

        .ticket-container {
            max-width: 800px;
            margin: 0 auto;
            background: var(--white);
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            position: relative;
        }

        .ticket-header {
            background: var(--royal-blue);
            color: var(--white);
            padding: 2rem;
            position: relative;
            overflow: hidden;
        }

        .ticket-header::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 200px;
            height: 200px;
            background: var(--light-blue);
            opacity: 0.2;
            border-radius: 50%;
            transform: translate(50%, -50%);
        }

        .airline-info {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .airline-logo {
            font-size: 2rem;
        }

        .airline-name {
            font-size: 1.5rem;
            font-weight: 600;
        }

        .pnr-section {
            background: var(--light-gray);
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px dashed var(--royal-blue);
        }

        .pnr-number {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--royal-blue);
        }

        .flight-info {
            padding: 2rem;
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 2rem;
            border-bottom: 2px dashed var(--royal-blue);
        }

        .flight-route {
            display: flex;
            align-items: center;
            gap: 1.5rem;
            font-size: 1.2rem;
        }

        .city {
            text-align: center;
        }

        .city-code {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--royal-blue);
        }

        .city-name {
            color: var(--dark-blue);
            font-size: 0.9rem;
        }

        .route-line {
            flex: 1;
            height: 2px;
            background: var(--royal-blue);
            position: relative;
        }

        .route-line::before {
            content: '✈️';
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: var(--white);
            padding: 0 0.5rem;
        }

        .passenger-info {
            padding: 2rem;
            border-bottom: 2px dashed var(--royal-blue);
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1.5rem;
        }

        .info-item {
            margin-bottom: 1rem;
        }

        .info-label {
            color: var(--dark-blue);
            font-size: 0.9rem;
            margin-bottom: 0.3rem;
        }

        .info-value {
            color: var(--royal-blue);
            font-weight: 500;
        }

        .terms-section {
            padding: 2rem;
            background: var(--light-gray);
        }

        .terms-title {
            color: var(--royal-blue);
            font-weight: 600;
            margin-bottom: 1rem;
        }

        .terms-list {
            list-style: none;
            color: var(--dark-blue);
            font-size: 0.9rem;
        }

        .terms-list li {
            margin-bottom: 0.5rem;
            display: flex;
            align-items: baseline;
            gap: 0.5rem;
        }

        .terms-list li::before {
            content: '•';
            color: var(--royal-blue);
            font-weight: bold;
        }

        .print-btn {
            position: fixed;
            bottom: 2rem;
            right: 2rem;
            background: var(--royal-blue);
            color: var(--white);
            padding: 1rem 2rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .print-btn:hover {
            background: var(--dark-blue);
            transform: translateY(-2px);
        }

        @media print {
            body {
                padding: 0;
                background: var(--white);
            }

            .ticket-container {
                box-shadow: none;
            }

            .print-btn {
                display: none;
            }
        }

        @media (max-width: 768px) {
            .flight-info,
            .info-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="ticket-container">
        <!-- Ticket Header -->
        <div class="ticket-header">
            <div class="airline-info">
                <div class="airline-logo">
                    <i class="fas fa-plane"></i>
                </div>
                <div class="airline-name">SkyWings Airlines</div>
            </div>
            <div>E-Ticket / Boarding Pass</div>
        </div>

        <!-- PNR Section -->
        <div class="pnr-section">
            <div>
                <div class="info-label">PNR Number</div>
                <div class="pnr-number">${param.pnr}</div>
            </div>
            <div>
                <div class="info-label">Booking Date</div>
                <div class="info-value">${param.bookingDate}</div>
            </div>
        </div>

        <!-- Flight Information -->
        <div class="flight-info">
            <div class="flight-route">
                <div class="city">
                    <div class="city-code">${param.departureCode}</div>
                    <div class="city-name">${param.departureCity}</div>
                </div>
                <div class="route-line"></div>
                <div class="city">
                    <div class="city-code">${param.arrivalCode}</div>
                    <div class="city-name">${param.arrivalCity}</div>
                </div>
            </div>
            <div class="info-grid">
                <div class="info-item">
                    <div class="info-label">Flight Number</div>
                    <div class="info-value">${param.flightNumber}</div>
                </div>
                <div class="info-item">
                    <div class="info-label">Date</div>
                    <div class="info-value">${param.flightDate}</div>
                </div>
                <div class="info-item">
                    <div class="info-label">Departure Time</div>
                    <div class="info-value">${param.departureTime}</div>
                </div>
                <div class="info-item">
                    <div class="info-label">Arrival Time</div>
                    <div class="info-value">${param.arrivalTime}</div>
                </div>
            </div>
        </div>

        <!-- Passenger Information -->
        <div class="passenger-info">
            <div class="info-grid">
                <div class="info-item">
                    <div class="info-label">Passenger Name</div>
                    <div class="info-value">${param.passengerName}</div>
                </div>
                <div class="info-item">
                    <div class="info-label">Email</div>
                    <div class="info-value">${param.email}</div>
                </div>
                <div class="info-item">
                    <div class="info-label">Aadhar Number</div>
                    <div class="info-value">${param.aadhar}</div>
                </div>
                <div class="info-item">
                    <div class="info-label">Seat Number</div>
                    <div class="info-value">${param.seatNumber}</div>
                </div>
            </div>
        </div>

        <!-- Terms and Conditions -->
        <div class="terms-section">
            <div class="terms-title">Important Information</div>
            <ul class="terms-list">
                <li>Please arrive at the airport at least 2 hours before departure for domestic flights.</li>
                <li>Carry a valid photo ID proof along with this ticket for security check.</li>
                <li>Baggage allowance: Check-in: 15 kg, Cabin: 7 kg.</li>
                <li>Flight timings are subject to change. Please check flight status before departure.</li>
                <li>No refund on cancellation within 4 hours of departure.</li>
            </ul>
        </div>
    </div>

    <!-- Print Button -->
    <button onclick="window.print()" class="print-btn">
        <i class="fas fa-print"></i>
        Print Ticket
    </button>

    <script>
        // Add current date if booking date is not provided
        window.onload = function() {
            if (!document.querySelector('.pnr-section .info-value').textContent.trim()) {
                const today = new Date().toLocaleDateString('en-GB');
                document.querySelector('.pnr-section .info-value').textContent = today;
            }
        }
    </script>
</body>
</html>
