<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment - SkyWings</title>
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
            background: linear-gradient(135deg, var(--royal-blue), var(--dark-blue));
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
        }

        .payment-card {
            background: var(--white);
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        .flight-details {
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--light-gray);
        }

        .payment-form {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .form-group label {
            font-weight: 500;
            color: var(--dark-blue);
        }

        .form-group input {
            padding: 0.8rem;
            border: 2px solid var(--light-gray);
            border-radius: 5px;
            font-size: 1rem;
            transition: border-color 0.3s ease;
        }

        .form-group input:focus {
            outline: none;
            border-color: var(--royal-blue);
        }

        .card-row {
            display: flex;
            gap: 1rem;
        }

        .card-row .form-group {
            flex: 1;
        }

        .submit-btn {
            background: var(--royal-blue);
            color: var(--white);
            padding: 1rem;
            border: none;
            border-radius: 5px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.3s ease;
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            background: var(--dark-blue);
        }

        .error-message {
            color: #dc3545;
            margin-bottom: 1rem;
            padding: 0.5rem;
            background: #ffe3e5;
            border-radius: 5px;
        }

        @media (max-width: 768px) {
            .card-row {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="payment-card">
            <h2>Payment Details</h2>
            
            <div class="flight-details">
                <h3>Flight Summary</h3>
                <p><strong>Flight:</strong> ${param.flightNumber}</p>
                <p><strong>From:</strong> ${param.departureCity}</p>
                <p><strong>To:</strong> ${param.arrivalCity}</p>
                <p><strong>Date:</strong> ${param.departureDate}</p>
                <p><strong>Class:</strong> ${param.class}</p>
                <p><strong>Passengers:</strong> ${param.passengers}</p>
                <p><strong>Total Amount:</strong> ₹${param.amount}</p>
            </div>

            <% if (request.getParameter("error") != null) { %>
                <div class="error-message">
                    Payment failed. Please try again.
                </div>
            <% } %>

            <form action="PaymentProcessingServlet" method="post" class="payment-form">
                <input type="hidden" name="flightNumber" value="${param.flightNumber}">
                <input type="hidden" name="class" value="${param.class}">
                <input type="hidden" name="passengers" value="${param.passengers}">
                <input type="hidden" name="amount" value="${param.amount}">

                <div class="form-group">
                    <label for="cardName">Name on Card</label>
                    <input type="text" id="cardName" name="cardName" required>
                </div>

                <div class="form-group">
                    <label for="cardNumber">Card Number</label>
                    <input type="text" id="cardNumber" name="cardNumber" 
                           pattern="[0-9]{16}" maxlength="16" required>
                </div>

                <div class="card-row">
                    <div class="form-group">
                        <label for="cardExpiry">Expiry Date</label>
                        <input type="text" id="cardExpiry" name="cardExpiry" 
                               placeholder="MM/YY" pattern="[0-9]{2}/[0-9]{2}" required>
                    </div>

                    <div class="form-group">
                        <label for="cardCvv">CVV</label>
                        <input type="password" id="cardCvv" name="cardCvv" 
                               pattern="[0-9]{3}" maxlength="3" required>
                    </div>
                </div>

                <button type="submit" class="submit-btn">
                    <i class="fas fa-lock"></i> Pay ₹${param.amount}
                </button>
            </form>
        </div>
    </div>

    <script>
        // Format card number with spaces
        document.getElementById('cardNumber').addEventListener('input', function(e) {
            let value = e.target.value.replace(/\s/g, '');
            value = value.replace(/\D/g, '');
            e.target.value = value;
        });

        // Format expiry date
        document.getElementById('cardExpiry').addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, '');
            if (value.length >= 2) {
                value = value.slice(0,2) + '/' + value.slice(2);
            }
            e.target.value = value;
        });
    </script>
</body>
</html>
