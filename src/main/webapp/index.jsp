<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SkyWings - Your Journey Begins Here</title>
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
        }

        /* Header Styles */
        header {
            background-color: var(--secondary-color);
            padding: 1rem 5%;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
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
        }

        .nav-links a {
            color: var(--light-text);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
            position: relative;
            padding: 5px 10px;
        }

        .nav-links a:hover {
            color: var(--text-color);
        }

        .nav-links a::after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            bottom: 0;
            left: 0;
            background-color: var(--text-color);
            transition: width 0.3s ease;
        }

        .nav-links a:hover::after {
            width: 100%;
        }

        /* Hero Section */
        .hero {
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
            margin-top: 60px;
        }

        .hero-image {
            position: absolute;
            width: 100%;
            height: 100%;
            object-fit: cover;
            opacity: 0.3;
            transform: scale(1.1);
            transition: transform 0.3s ease;
        }

        .hero-content {
            position: relative;
            text-align: center;
            z-index: 1;
            padding: 2rem;
            transform: translateY(-50px);
            opacity: 0;
            animation: fadeInUp 1s ease forwards;
        }

        @keyframes fadeInUp {
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .hero-content h1 {
            font-size: 3.5rem;
            margin-bottom: 1rem;
            color: var(--text-color);
        }

        .hero-content p {
            font-size: 1.2rem;
            margin-bottom: 2rem;
        }

        /* Destination Cards */
        .destinations {
            padding: 4rem 5%;
            background-color: var(--secondary-color);
        }

        .section-title {
            text-align: center;
            margin-bottom: 3rem;
            color: var(--text-color);
            font-size: 2.5rem;
        }

        .cards-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            perspective: 1000px;
        }

        .card {
            background-color: var(--accent-color);
            border-radius: 15px;
            overflow: hidden;
            transform-style: preserve-3d;
            transition: transform 0.5s ease;
            cursor: pointer;
        }

        .card:hover {
            transform: translateY(-10px) rotateX(5deg);
        }

        .card-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .card-content {
            padding: 1.5rem;
        }

        .card-title {
            font-size: 1.5rem;
            margin-bottom: 0.5rem;
            color: var(--text-color);
        }

        .card-description {
            font-size: 0.9rem;
            color: #ddd;
            margin-bottom: 1rem;
        }

        .card-price {
            color: var(--text-color);
            font-weight: 600;
            font-size: 1.2rem;
        }

        /* Footer */
        footer {
            background-color: var(--secondary-color);
            padding: 3rem 5%;
            margin-top: 4rem;
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
            transition: color 0.3s ease;
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
            .hero-content h1 {
                font-size: 2.5rem;
            }
            .nav-links {
                display: none;
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
                <a href="login.jsp">Login</a>
                <a href="register.jsp">Register</a>
                <a href="admin/login.jsp">Admin</a>
            </nav>
        </div>
    </header>

    <!-- Hero Section -->
    <section class="hero">
        <img src="https://images.unsplash.com/photo-1436491865332-7a61a109cc05" alt="Airplane in sky" class="hero-image">
        <div class="hero-content">
            <h1>Explore India with SkyWings</h1>
            <p>Discover the beauty of incredible India with our premium flight services</p>
        </div>
    </section>

    <!-- Destinations Section -->
    <section class="destinations">
        <h2 class="section-title">Popular Destinations</h2>
        <div class="cards-container">
            <!-- Mumbai Card -->
            <div class="card">
                <img src="https://images.unsplash.com/photo-1570168007204-dfb528c6958f" alt="Mumbai" class="card-image">
                <div class="card-content">
                    <h3 class="card-title">Mumbai</h3>
                    <p class="card-description">Experience the city that never sleeps, from Bollywood to business.</p>
                    <p class="card-price">Starting from ₹2,999</p>
                </div>
            </div>

            <!-- Delhi Card -->
            <div class="card">
                <img src="https://images.unsplash.com/photo-1587474260584-136574528ed5" alt="Delhi" class="card-image">
                <div class="card-content">
                    <h3 class="card-title">Delhi</h3>
                    <p class="card-description">Explore the heart of India, where history meets modernity.</p>
                    <p class="card-price">Starting from ₹3,499</p>
                </div>
            </div>

            <!-- Bangalore Card -->
            <div class="card">
                <img src="https://images.unsplash.com/photo-1570168007204-dfb528c6958f" alt="Bangalore" class="card-image">
                <div class="card-content">
                    <h3 class="card-title">Bangalore</h3>
                    <p class="card-description">Visit India's Silicon Valley, known for its pleasant weather.</p>
                    <p class="card-price">Starting from ₹2,799</p>
                </div>
            </div>
        </div>
    </section>

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
        // Add smooth scrolling
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                document.querySelector(this.getAttribute('href')).scrollIntoView({
                    behavior: 'smooth'
                });
            });
        });

        // Parallax effect for hero image
        window.addEventListener('scroll', function() {
            const heroImage = document.querySelector('.hero-image');
            const scrolled = window.pageYOffset;
            heroImage.style.transform = `translate3d(0, ${scrolled * 0.4}px, 0) scale(1.1)`;
        });

        // Add animation to cards on scroll
        const cards = document.querySelectorAll('.card');
        const observer = new IntersectionObserver(entries => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.transform = 'translateY(0) rotateX(5deg)';
                    entry.target.style.opacity = '1';
                }
            });
        }, { threshold: 0.1 });

        cards.forEach(card => {
            card.style.opacity = '0';
            card.style.transform = 'translateY(50px) rotateX(5deg)';
            card.style.transition = 'all 0.6s ease';
            observer.observe(card);
        });
    </script>
</body>
</html>
