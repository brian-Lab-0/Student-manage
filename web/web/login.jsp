<%--
  Created by IntelliJ IDEA.
  User: brian
  Date: 10/5/2024
  Time: 12:03 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css">
    <style>
        body {
            background-color: #1a1a1a;
            color: #ffffff;
            font-family: Arial, sans-serif;
        }

        .login-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-card {
            background-color: #2b2b2b;
            color: #ffffff;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
            width: 400px;
        }

        .form-label {
            color: #ffffff;
            font-weight: bold;
        }

        .form-control {
            background-color: #333333;
            border: 1px solid #555;
            color: #ffffff;
        }

        .form-control:focus {
            background-color: #444;
            color: #ffffff;
            border-color: #007bff;
            outline: none;
        }

        .btn-primary {
            background-color: #007bff;
            border: none;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        a {
            color: #007bff;
        }

        a:hover {
            color: #0056b3;
            text-decoration: underline;
        }

        .register-link {
            margin-top: 10px;
            font-size: 0.9em;
        }
    </style>
</head>
<body>
<div class="login-container">
    <div class="login-card">
        <h2 class="text-center mb-4">Login</h2>
        <form action="login" method="post">
            <div class="mb-3">
                <label for="email" class="form-label">Email:</label>
                <input type="email" class="form-control" id="email" name="email" placeholder="Enter your email" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password:</label>
                <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" required>
            </div>
            <div class="mb-3">
                <label for="userType" class="form-label">User Type:</label>
                <select class="form-select" id="userType" name="userType">
                    <option value="student">Student</option>
                    <option value="admin">Admin</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary w-100">Login</button>
        </form>
        <p class="text-center register-link">
            Don't have an account? <a href="register.jsp">Create one here</a>
        </p>
    </div>
</div>
</body>
</html>
