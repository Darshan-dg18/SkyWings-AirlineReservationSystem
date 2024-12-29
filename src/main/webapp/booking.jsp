<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Flight - SkyWings</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #1a1a2e;
            --secondary-color: #16213e;
            --accent-color: #0f3460;
            --text-color: #e94560;
            --light-text: #ffffff;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background-color: var(--primary-color);
            color: var(--light-text);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* Header Styles */
        header {
            background-color: var(--secondary-color);
            padding: 1rem 5%;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 10px;
            text-decoration: none;
            color: var(--light-text);
            font-size: 1.5rem;
            font-weight: 700;
        }

        .logo i {
            color: var(--text-color);
        }

        .nav-links {
            display: flex;
            gap: 2rem;
            align-items: center;
        }

        .nav-links a {
            color: var(--light-text);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .nav-links a:hover {
            color: var(--text-color);
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .user-info i {
            color: var(--text-color);
        }

        .logout-btn {
            padding: 0.5rem 1rem;
            background-color: var(--text-color);
            border: none;
            border-radius: 5px;
            color: var(--light-text);
            cursor: pointer;
            transition: transform 0.3s ease;
        }

        .logout-btn:hover {
            transform: translateY(-2px);
        }

        /* Main Content */
        .main-container {
            flex: 1;
            padding: 2rem 5%;
            max-width: 1200px;
            margin: 0 auto;
        }

        .booking-container {
            display: grid;
            grid-template-columns: 1fr 2fr;
            gap: 2rem;
        }

        .flight-summary {
            background-color: var(--secondary-color);
            padding: 1.5rem;
            border-radius: 10px;
            height: fit-content;
            animation: slideIn 0.5s ease;
        }

        .flight-summary h2 {
            color: var(--text-color);
            margin-bottom: 1rem;
        }

        .flight-detail {
            margin: 1rem 0;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--accent-color);
        }

        .flight-detail:last-child {
            border-bottom: none;
        }

        .flight-detail span {
            color: var(--text-color);
            font-weight: 500;
        }

        .booking-form {
            background-color: var(--secondary-color);
            padding: 2rem;
            border-radius: 10px;
            animation: slideIn 0.5s ease;
        }

        .booking-form h2 {
            color: var(--text-color);
            margin-bottom: 1.5rem;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1.5rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: var(--light-text);
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 0.8rem;
            border: 2px solid var(--accent-color);
            border-radius: 5px;
            background-color: var(--primary-color);
            color: var(--light-text);
            transition: border-color 0.3s ease;
        }

        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: var(--text-color);
        }

        .payment-btn {
            width: 100%;
            padding: 1rem;
            background-color: var(--text-color);
            color: var(--light-text);
            border: none;
            border-radius: 5px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 1rem;
        }

        .payment-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(233, 69, 96, 0.3);
        }

        .error-message {
            color: var(--text-color);
            font-size: 0.9rem;
            margin-top: 0.3rem;
            display: none;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateX(-20px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        /* Footer */
        footer {
            background-color: var(--secondary-color);
            padding: 2rem 5%;
            margin-top: 2rem;
        }

        .footer-content {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
        }

        .footer-section h3 {
            color: var(--text-color);
            margin-bottom: 1rem;
        }

        .footer-section p,
        .footer-section a {
            color: #ddd;
            text-decoration: none;
            display: block;
            margin-bottom: 0.5rem;
        }

        .footer-section a:hover {
            color: var(--text-color);
        }

        .social-links {
            display: flex;
            gap: 1rem;
            margin-top: 1rem;
        }

        .social-links a {
            color: var(--light-text);
            font-size: 1.5rem;
            transition: color 0.3s ease;
        }

        .social-links a:hover {
            color: var(--text-color);
        }

        .footer-bottom {
            text-align: center;
            margin-top: 2rem;
            padding-top: 2rem;
            border-top: 1px solid #444;
        }

        @media (max-width: 768px) {
            .booking-container {
                grid-template-columns: 1fr;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header>
        <div class="header-content">
            <a href="index.jsp" class="logo">
                <i class="fas fa-plane"></i>
                SkyWings
            </a>
            <nav class="nav-links">
                <a href="index.jsp">Home</a>
                <div class="user-info">
                    <i class="fas fa-user"></i>
                    <span>${sessionScope.user.firstName}</span>
                </div>
                <form action="LogoutServlet" method="post" style="margin: 0;">
                    <button type="submit" class="logout-btn">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </button>
                </form>
            </nav>
        </div>
    </header>

    <!-- Main Content -->
    <div class="main-container">
        <div class="booking-container">
            <!-- Flight Summary -->
            <div class="flight-summary">
                <h2>Flight Details</h2>
                <div class="flight-detail">
                    <p><span>Flight Number:</span> ${param.flightId}</p>
                </div>
                <div class="flight-detail">
                    <p><span>From:</span> ${param.departure}</p>
                    <p><span>To:</span> ${param.arrival}</p>
                </div>
                <div class="flight-detail">
                    <p><span>Date:</span> ${param.date}</p>
                    <p><span>Time:</span> ${param.time}</p>
                </div>
                <div class="flight-detail">
                    <p><span>Class:</span> ${param.class}</p>
                    <p><span>Price:</span> ₹${param.price}</p>
                </div>
            </div>

            <!-- Booking Form -->
            <div class="booking-form">
                <h2>Passenger Details</h2>
                <form id="bookingForm" action="BookingServlet" method="post" onsubmit="return validateForm()">
                    <div class="form-grid">
                        <div class="form-group">
                            <label for="fullName">Full Name</label>
                            <input type="text" id="fullName" name="fullName" required>
                            <div class="error-message" id="nameError"></div>
                        </div>

                        <div class="form-group">
                            <label for="gender">Gender</label>
                            <select id="gender" name="gender" required>
                                <option value="">Select Gender</option>
                                <option value="male">Male</option>
                                <option value="female">Female</option>
                                <option value="other">Other</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="dob">Date of Birth</label>
                            <input type="date" id="dob" name="dob" required>
                            <div class="error-message" id="dobError"></div>
                        </div>

                        <div class="form-group">
                            <label for="mobile">Mobile Number</label>
                            <input type="tel" id="mobile" name="mobile" pattern="[0-9]{10}" required>
                            <div class="error-message" id="mobileError"></div>
                        </div>

                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="email" id="email" name="email" required>
                            <div class="error-message" id="emailError"></div>
                        </div>

                        <div class="form-group">
                            <label for="aadhar">Aadhar Card Number</label>
                            <input type="text" id="aadhar" name="aadhar" pattern="[0-9]{12}" required>
                            <div class="error-message" id="aadharError"></div>
                        </div>
                    </div>

                    <button type="submit" class="payment-btn">
                        <i class="fas fa-lock"></i> Proceed to Payment
                    </button>
                </form>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        <div class="footer-content">
            <div class="footer-section">
                <h3>About SkyWings</h3>
                <p>Your trusted partner for domestic flights across India. We provide comfortable and affordable air travel.</p>
            </div>
            <div class="footer-section">
                <h3>Quick Links</h3>
                <a href="#">About Us</a>
                <a href="#">Contact</a>
                <a href="#">Terms & Conditions</a>
                <a href="#">Privacy Policy</a>
            </div>
            <div class="footer-section">
                <h3>Contact Us</h3>
                <p>Email: info@skywings.com</p>
                <p>Phone: +91 1234567890</p>
                <div class="social-links">
                    <a href="#"><i class="fab fa-facebook"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-linkedin"></i></a>
                </div>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2024 SkyWings. All rights reserved.</p>
        </div>
    </footer>

    <script>
        function validateForm() {
            let isValid = true;
            
            // Full Name validation
            const fullName = document.getElementById('fullName').value;
            if (!/^[A-Za-z\s]{3,}$/.test(fullName)) {
                showError('nameError', 'Please enter a valid name (minimum 3 characters, letters only)');
                isValid = false;
            }

            // Date of Birth validation
            const dob = new Date(document.getElementById('dob').value);
            const today = new Date();
            const age = today.getFullYear() - dob.getFullYear();
            if (age < 18) {
                showError('dobError', 'You must be at least 18 years old');
                isValid = false;
            }

            // Mobile validation
            const mobile = document.getElementById('mobile').value;
            if (!/^[0-9]{10}$/.test(mobile)) {
                showError('mobileError', 'Please enter a valid 10-digit mobile number');
                isValid = false;
            }

            // Email validation
            const email = document.getElementById('email').value;
            if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
                showError('emailError', 'Please enter a valid email address');
                isValid = false;
            }

            // Aadhar validation
            const aadhar = document.getElementById('aadhar').value;
            if (!/^[0-9]{12}$/.test(aadhar)) {
                showError('aadharError', 'Please enter a valid 12-digit Aadhar number');
                isValid = false;
            }

            return isValid;
        }

        function showError(elementId, message) {
            const errorElement = document.getElementById(elementId);
            errorElement.textContent = message;
            errorElement.style.display = 'block';
        }

        // Clear error messages on input
        document.querySelectorAll('input').forEach(input => {
            input.addEventListener('input', function() {
                const errorElement = this.parentElement.querySelector('.error-message');
                if (errorElement) {
                    errorElement.style.display = 'none';
                }
            });
        });

        // Set maximum date for DOB (18 years ago)
        const dobInput = document.getElementById('dob');
        const maxDate = new Date();
        maxDate.setFullYear(maxDate.getFullYear() - 18);
        dobInput.max = maxDate.toISOString().split('T')[0];
    </script>
</body>
</html>
