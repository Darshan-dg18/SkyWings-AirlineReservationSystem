<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Flights - SkyWings</title>
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
            max-width: 1200px;
            margin: 0 auto;
        }

        /* Header Styles */
        header {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            padding: 1rem;
            border-radius: 10px;
            margin-bottom: 2rem;
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
            color: var(--white);
            font-size: 1.5rem;
            font-weight: 700;
        }

        .logo i {
            color: var(--light-blue);
        }

        .user-nav {
            display: flex;
            align-items: center;
            gap: 2rem;
        }

        .user-nav a {
            color: var(--white);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .user-nav a:hover {
            color: var(--light-blue);
        }

        /* Search Form Styles */
        .search-container {
            background: var(--white);
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
        }

        .search-title {
            color: var(--royal-blue);
            margin-bottom: 1.5rem;
            font-size: 1.5rem;
            font-weight: 600;
        }

        .search-form {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }

        .form-row {
            display: flex;
            gap: 1.5rem;
            width: 100%;
        }

        .form-group {
            flex: 1;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: var(--dark-blue);
            font-weight: 500;
        }

        .form-group select,
        .form-group input {
            width: 100%;
            padding: 0.8rem;
            border: 2px solid var(--light-gray);
            border-radius: 5px;
            font-size: 1rem;
            transition: border-color 0.3s ease;
        }

        .form-group select:focus,
        .form-group input:focus {
            outline: none;
            border-color: var(--royal-blue);
        }

        .search-btn {
            background: var(--royal-blue);
            color: var(--white);
            padding: 1rem 2rem;
            border: none;
            border-radius: 5px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.3s ease;
            width: 100%;
            margin-top: 1rem;
        }

        .search-btn:hover {
            transform: translateY(-2px);
            background: var(--dark-blue);
        }

        /* Popular Routes Section */
        .popular-routes {
            background: var(--white);
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        .routes-title {
            color: var(--royal-blue);
            margin-bottom: 1.5rem;
            font-size: 1.5rem;
            font-weight: 600;
        }

        .routes-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
        }

        .route-card {
            background: var(--light-gray);
            padding: 1.5rem;
            border-radius: 10px;
            transition: transform 0.3s ease;
            cursor: pointer;
        }

        .route-card:hover {
            transform: translateY(-5px);
        }

        .route-cities {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .route-cities i {
            color: var(--royal-blue);
        }

        .city {
            font-weight: 500;
            color: var(--dark-blue);
        }

        .price {
            color: var(--royal-blue);
            font-weight: 600;
            font-size: 1.2rem;
        }

        @media (max-width: 768px) {
            .form-row {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header -->
        <header>
            <div class="header-content">
                <a href="index.jsp" class="logo">
                    <i class="fas fa-plane"></i>
                    SkyWings
                </a>
                <nav class="user-nav">
                    <span style="color: white;">Welcome, ${sessionScope.userName}</span>
                    <a href="mybookings.jsp"><i class="fas fa-ticket-alt"></i> My Bookings</a>
                    <a href="profile.jsp"><i class="fas fa-user"></i> Profile</a>
                    <a href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a>
                </nav>
            </div>
        </header>

        <!-- Search Form -->
        <div class="search-container">
            <h2 class="search-title">Search Flights</h2>
            <form action="SearchFlightServlet" method="post" class="search-form">
                <!-- First Row: Cities -->
                <div class="form-row">
                    <div class="form-group">
                        <label for="from">From</label>
                        <select id="from" name="from" required>
                            <option value="">Select Departure City</option>
                            <option value="Mumbai">Mumbai</option>
                            <option value="Delhi">Delhi</option>
                            <option value="Bangalore">Bangalore</option>
                            <option value="Chennai">Chennai</option>
                            <option value="Kolkata">Kolkata</option>
                            <option value="Hyderabad">Hyderabad</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="to">To</label>
                        <select id="to" name="to" required>
                            <option value="">Select Arrival City</option>
                            <option value="Mumbai">Mumbai</option>
                            <option value="Delhi">Delhi</option>
                            <option value="Bangalore">Bangalore</option>
                            <option value="Chennai">Chennai</option>
                            <option value="Kolkata">Kolkata</option>
                            <option value="Hyderabad">Hyderabad</option>
                        </select>
                    </div>
                </div>

                <!-- Second Row: Date, Passengers, Class -->
                <div class="form-row">
                    <div class="form-group">
                        <label for="date">Departure Date</label>
                        <input type="date" id="date" name="date" required>
                    </div>

                    <div class="form-group">
                        <label for="passengers">Number of Passengers</label>
                        <input type="number" id="passengers" name="passengers" min="1" max="10" value="1" required>
                    </div>

                    <div class="form-group">
                        <label for="class">Class</label>
                        <select id="class" name="class" required>
                            <option value="Economy">Economy</option>
                            <option value="Business">Business</option>
                        </select>
                    </div>
                </div>

                <button type="submit" class="search-btn">
                    <i class="fas fa-search"></i> Search Flights
                </button>
            </form>
        </div>

        <!-- Popular Routes -->
        <div class="popular-routes">
            <h2 class="routes-title">Popular Routes</h2>
            <div class="routes-grid">
                <div class="route-card">
                    <div class="route-cities">
                        <span class="city">Mumbai</span>
                        <i class="fas fa-plane"></i>
                        <span class="city">Delhi</span>
                    </div>
                    <div class="price">Starting from ₹5,000</div>
                </div>

                <div class="route-card">
                    <div class="route-cities">
                        <span class="city">Bangalore</span>
                        <i class="fas fa-plane"></i>
                        <span class="city">Mumbai</span>
                    </div>
                    <div class="price">Starting from ₹4,500</div>
                </div>

                <div class="route-card">
                    <div class="route-cities">
                        <span class="city">Delhi</span>
                        <i class="fas fa-plane"></i>
                        <span class="city">Bangalore</span>
                    </div>
                    <div class="price">Starting from ₹6,000</div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Set minimum date to today
        const today = new Date().toISOString().split('T')[0];
        document.getElementById('date').setAttribute('min', today);

        // Prevent selecting same cities
        document.getElementById('to').addEventListener('change', function() {
            const fromCity = document.getElementById('from').value;
            if (this.value === fromCity) {
                alert('Departure and arrival cities cannot be the same');
                this.value = '';
            }
        });

        document.getElementById('from').addEventListener('change', function() {
            const toCity = document.getElementById('to').value;
            if (this.value === toCity) {
                alert('Departure and arrival cities cannot be the same');
                this.value = '';
            }
        });

        // Click handler for popular routes
        document.querySelectorAll('.route-card').forEach(card => {
            card.addEventListener('click', function() {
                const cities = this.querySelector('.route-cities').textContent.trim().split('\n');
                document.getElementById('from').value = cities[0].trim();
                document.getElementById('to').value = cities[2].trim();
            });
        });
    </script>
</body>
</html>
