<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - SkyWings</title>
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
            max-width: 500px;
        }

        .register-container {
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

        .register-btn {
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

        .register-btn:hover {
            transform: translateY(-2px);
            background: var(--dark-blue);
        }

        .login-link {
            text-align: center;
            color: var(--dark-blue);
        }

        .login-link a {
            color: var(--royal-blue);
            text-decoration: none;
            font-weight: 600;
        }

        .login-link a:hover {
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
    </style>
</head>
<body>
    <div class="container">
        <div class="register-container">
            <div class="logo-section">
                <i class="fas fa-plane"></i>
                <h1>SkyWings</h1>
            </div>

            <div id="errorMessage" class="error-message"></div>

            <form action="RegisterServlet" method="post" onsubmit="return validateForm()">
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" required placeholder="Enter your username">
                </div>

                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" required placeholder="Enter your email">
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required placeholder="Enter your password">
                </div>

                <div class="form-group">
                    <label for="confirmPassword">Confirm Password</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" required placeholder="Confirm your password">
                </div>

                <button type="submit" class="register-btn">
                    <i class="fas fa-user-plus"></i> Register
                </button>

                <div class="login-link">
                    Already have an account? <a href="login.jsp">Login</a>
                </div>
            </form>
        </div>
    </div>

    <script>
        function validateForm() {
            const username = document.getElementById('username').value;
            const email = document.getElementById('email').value;
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const errorMessage = document.getElementById('errorMessage');

            if (password !== confirmPassword) {
                errorMessage.style.display = 'block';
                errorMessage.textContent = 'Passwords do not match!';
                return false;
            }

            return true;
        }

        // Show error message if registration fails
        const urlParams = new URLSearchParams(window.location.search);
        const error = urlParams.get('error');
        const errorMessage = document.getElementById('errorMessage');

        if (error === 'email') {
            errorMessage.style.display = 'block';
            errorMessage.textContent = 'Email already exists!';
        } else if (error === 'failed') {
            errorMessage.style.display = 'block';
            errorMessage.textContent = 'Registration failed. Please try again.';
        } else if (error === 'system') {
            errorMessage.style.display = 'block';
            errorMessage.textContent = 'System error. Please try again later.';
        }
    </script>
</body>
</html>
