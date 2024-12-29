<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - SkyWings</title>
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
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .container {
            width: 100%;
            max-width: 400px;
        }

        .login-container {
            background: var(--white);
            padding: 2.5rem;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        .logo-section {
            text-align: center;
            margin-bottom: 2rem;
        }

        .logo-section i {
            font-size: 2.5rem;
            color: var(--royal-blue);
            margin-bottom: 1rem;
        }

        .logo-section h1 {
            color: var(--royal-blue);
            font-size: 1.8rem;
            font-weight: 600;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: var(--dark-blue);
            font-weight: 500;
        }

        .form-group input {
            width: 100%;
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

        .login-btn {
            background: var(--royal-blue);
            color: var(--white);
            padding: 1rem;
            border: none;
            border-radius: 5px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.3s ease;
            width: 100%;
            margin-bottom: 1rem;
        }

        .login-btn:hover {
            transform: translateY(-2px);
            background: var(--dark-blue);
        }

        .register-link {
            text-align: center;
            color: var(--dark-blue);
        }

        .register-link a {
            color: var(--royal-blue);
            text-decoration: none;
            font-weight: 600;
        }

        .register-link a:hover {
            text-decoration: underline;
        }

        .error-message {
            background-color: #ffebee;
            color: #c62828;
            padding: 1rem;
            border-radius: 5px;
            margin-bottom: 1rem;
            display: none;
        }

        .social-login {
            margin-top: 1.5rem;
            text-align: center;
        }

        .social-login p {
            color: var(--dark-blue);
            margin-bottom: 1rem;
        }

        .social-icons {
            display: flex;
            justify-content: center;
            gap: 1rem;
        }

        .social-icons a {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--white);
            text-decoration: none;
            transition: transform 0.3s ease;
        }

        .social-icons a:hover {
            transform: translateY(-2px);
        }

        .facebook {
            background: #3b5998;
        }

        .google {
            background: #db4437;
        }

        .twitter {
            background: #1da1f2;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="login-container">
            <div class="logo-section">
                <i class="fas fa-plane"></i>
                <h1>SkyWings</h1>
            </div>

            <% if(request.getParameter("error") != null) { %>
                <div class="error-message" style="display: block;">
                    Invalid email or password. Please try again.
                </div>
            <% } %>

            <form action="LoginServlet" method="post">
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" required placeholder="Enter your email">
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required placeholder="Enter your password">
                </div>

                <button type="submit" class="login-btn">
                    <i class="fas fa-sign-in-alt"></i> Login
                </button>

                <div class="register-link">
                    Don't have an account? <a href="register.jsp">Register Now</a>
                </div>

                <div class="social-login">
                    <p>Or login with</p>
                    <div class="social-icons">
                        <a href="#" class="facebook">
                            <i class="fab fa-facebook-f"></i>
                        </a>
                        <a href="#" class="google">
                            <i class="fab fa-google"></i>
                        </a>
                        <a href="#" class="twitter">
                            <i class="fab fa-twitter"></i>
                        </a>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Show error message if login fails
        const urlParams = new URLSearchParams(window.location.search);
        const error = urlParams.get('error');
        if (error) {
            document.querySelector('.error-message').style.display = 'block';
        }

        // Clear form on page load
        window.onload = function() {
            document.getElementById('email').value = '';
            document.getElementById('password').value = '';
        }
    </script>
</body>
</html>
