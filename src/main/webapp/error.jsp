<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - SkyWings</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #f5f6fa;
        }

        .error-container {
            text-align: center;
            padding: 2rem;
            background: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            width: 90%;
        }

        .error-code {
            font-size: 6rem;
            font-weight: 700;
            color: #1e3799;
            margin-bottom: 1rem;
        }

        .error-message {
            font-size: 1.5rem;
            color: #2f3640;
            margin-bottom: 2rem;
        }

        .error-description {
            color: #666;
            margin-bottom: 2rem;
        }

        .btn {
            display: inline-block;
            padding: 0.8rem 2rem;
            background: #1e3799;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: transform 0.3s ease;
        }

        .btn:hover {
            transform: translateY(-2px);
        }

        @media (max-width: 480px) {
            .error-code {
                font-size: 4rem;
            }

            .error-message {
                font-size: 1.2rem;
            }
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-code">
            <%= response.getStatus() %>
        </div>
        <h1 class="error-message">Oops! Something went wrong</h1>
        <p class="error-description">
            We're sorry, but we encountered an error while processing your request.
            Please try again later or contact support if the problem persists.
        </p>
        <a href="index.jsp" class="btn">Return Home</a>
    </div>
</body>
</html>
