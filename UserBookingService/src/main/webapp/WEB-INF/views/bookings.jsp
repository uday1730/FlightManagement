<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bookings Page</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f0f2f5;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            overflow: hidden;
            text-align: center;
            background-image: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .container {
            background-color: #ffffff;
            padding: 40px 60px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            animation: fadeIn 1.5s ease-out;
            border: 2px solid #fff;
            position: relative;
            overflow: hidden;
        }

        .container::before {
            content: '';
            position: absolute;
            top: -50px;
            left: -50px;
            width: 200%;
            height: 200%;
            background-image: radial-gradient(circle, #a18cd1 0%, #fbc2eb 100%);
            opacity: 0.1;
            transform: rotate(45deg);
            z-index: 0;
        }
        
        h1 {
            font-size: 2.5em;
            color: #333;
            margin: 0;
            font-weight: bold;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
            position: relative;
            z-index: 1;
        }

        p {
            font-size: 1.2em;
            color: #666;
            margin-top: 15px;
            position: relative;
            z-index: 1;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: scale(0.9);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Bookings Page</h1>
        <p>This page is currently under development. Please check back later!</p>
    </div>
</body>
</html>