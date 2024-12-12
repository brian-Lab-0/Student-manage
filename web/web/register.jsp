<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css">
    <style>
        body {
            background-color: #1a1a1a;
            color: #ffffff;
            font-family: Arial, sans-serif;
        }

        .register-container {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        .register-card {
            background-color: #2b2b2b;
            color: #ffffff;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
            width: 100%;
            max-width: 450px; /* Reduced width */
        }

        h2, h3 {
            font-size: 1.5rem;
            text-align: center;
            margin-bottom: 20px;
        }

        .form-label {
            color: #ffffff;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .form-control, .form-select {
            background-color: #333333;
            border: 1px solid #555;
            color: #ffffff;
            margin-bottom: 15px;
            font-size: 0.9rem;
            padding: 8px 10px;
        }

        .form-control:focus, .form-select:focus {
            background-color: #444;
            color: #ffffff;
            border-color: #007bff;
            outline: none;
        }

        .btn-primary {
            background-color: #ffc22d;
            color: #07070e;
            border: none;
            font-size: 0.9rem;
            padding: 10px;
            width: 100%;
            margin-top: 10px;
        }

        .btn-primary:hover {
            background-color: #ff8321;
            color: #07070e;
        }

        .nav-link {
            cursor: pointer;
            color: #007bff;
        }

        .nav-link:hover {
            color: #0056b3;
            text-decoration: underline;
        }

        .d-flex {
            justify-content: space-between;
            margin-bottom: 15px;
        }

        @media (max-width: 768px) {
            .register-card {
                padding: 15px;
            }
            h2, h3 {
                font-size: 1.2rem;
            }
            .form-control, .form-select {
                font-size: 0.8rem;
            }
            .btn-primary {
                font-size: 0.8rem;
                padding: 8px;
            }
        }

    </style>
    <script>
        function showForm() {
            const role = document.querySelector('input[name="userType"]:checked').value;
            document.getElementById('studentForm').style.display = role === 'student' ? 'block' : 'none';
            document.getElementById('adminForm').style.display = role === 'admin' ? 'block' : 'none';
            document.getElementById('teacherForm').style.display = role === 'teacher' ? 'block' : 'none';
        }
    </script>
</head>
<body>
<div class="register-container">
    <div class="register-card">
        <h2 class="text-center mb-4">Register</h2>
        <!-- User Type Selection -->
        <form class="mb-4">
            <div class="d-flex justify-content-between">
                <label class="form-label">
                    <input type="radio" name="userType" value="student" onclick="showForm()"> Student
                </label>
                <label class="form-label">
                    <input type="radio" name="userType" value="admin" onclick="showForm()"> Admin
                </label>
                <label class="form-label">
                    <input type="radio" name="userType" value="teacher" onclick="showForm()"> Teacher
                </label>
            </div>
        </form>

        <!-- Student Registration Form -->
        <div id="studentForm" style="display:none;">
            <h3 class="text-center mb-4">Student Registration</h3>
            <form id="studentRegistrationForm" class="registerForm" data-user-type="student">
                <input type="hidden" name="userType" value="student">

                <div class="mb-3">
                    <label for="firstName" class="form-label">First Name</label>
                    <input type="text" class="form-control" id="firstName" name="firstName" placeholder="Enter your first name" required>
                </div>
                <div class="mb-3">
                    <label for="lastName" class="form-label">Last Name</label>
                    <input type="text" class="form-control" id="lastName" name="lastName" placeholder="Enter your last name" required>
                </div>
                <div class="mb-3">
                    <label for="dob" class="form-label">Date of Birth</label>
                    <input type="date" class="form-control" id="dob" name="dob">
                </div>
                <div class="mb-3">
                    <label for="gender" class="form-label">Gender</label>
                    <select class="form-select" id="gender" name="gender" required>
                        <option value="" disabled selected>Select Gender</option>
                        <option value="Male">Male</option>
                        <option value="Female">Female</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" placeholder="Enter your email" required>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Create a password" required>
                </div>
                <div class="mb-3">
                    <label for="phone" class="form-label">Phone</label>
                    <input type="text" class="form-control" id="phone" name="phone" placeholder="Enter your phone number">
                </div>
                <div class="mb-3">
                    <label for="address" class="form-label">Address</label>
                    <input type="text" class="form-control" id="address" name="address" placeholder="Enter your address">
                </div>
                <div class="mb-3">
                    <label for="enrollmentDate" class="form-label">Enrollment Date</label>
                    <input type="date" class="form-control" id="enrollmentDate" name="enrollmentDate" required>
                </div>
                <div class="mb-3">
                    <label for="departmentName" class="form-label">Department Name</label>
                    <input type="text" class="form-control" id="departmentName" name="departmentName" placeholder="Enter your department name" required>
                </div>

                <button type="submit" class="btn btn-primary w-100">Register</button>
            </form>
        </div>

        <!-- Admin Registration Form -->
        <div id="adminForm" style="display:none;">
            <h3 class="text-center mb-4">Admin Registration</h3>
            <form id="adminRegistrationForm" class="registerForm" data-user-type="admin">
                <input type="hidden" name="userType" value="admin">
                <div class="mb-3">
                    <label for="adminUsername" class="form-label">Username</label>
                    <input type="text" class="form-control" id="adminUsername" name="username" required>
                </div>
                <div class="mb-3">
                    <label for="adminEmail" class="form-label">Email</label>
                    <input type="email" class="form-control" id="adminEmail" name="email" required>
                </div>
                <div class="mb-3">
                    <label for="adminPassword" class="form-label">Password</label>
                    <input type="password" class="form-control" id="adminPassword" name="password" required>
                </div>
                <button type="submit" class="btn btn-primary w-100">Register</button>
            </form>
        </div>

        <!-- Teacher Registration Form -->
        <div id="teacherForm" style="display:none;">
            <h3 class="text-center mb-4">Teacher Registration</h3>
            <form id="teacherRegistrationForm" class="registerForm" data-user-type="teacher">
                <input type="hidden" name="userType" value="teacher">
                <div class="mb-3">
                    <label for="teacherUsername" class="form-label">Username</label>
                    <input type="text" class="form-control" id="teacherUsername" name="username" required>
                </div>
                <div class="mb-3">
                    <label for="teacherEmail" class="form-label">Email</label>
                    <input type="email" class="form-control" id="teacherEmail" name="email" required>
                </div>
                <div class="mb-3">
                    <label for="teacherPassword" class="form-label">Password</label>
                    <input type="password" class="form-control" id="teacherPassword" name="password" required>
                </div>
                <div class="mb-3">
                    <label for="teacherDepartment" class="form-label">Department Name</label>
                    <input type="text" class="form-control" id="teacherDepartment" name="departmentName" required>
                </div>
                <button type="submit" class="btn btn-primary w-100">Register</button>
            </form>
        </div>
    </div>
</div>

<!-- Include jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function () {
        $('.registerForm').on('submit', function (e) {
            e.preventDefault();
            const formData = $(this).serialize();
            $.ajax({
                url: '/register',
                type: 'POST',
                data: formData,
                success: function (response) {
                    alert(response.message);
                    if (response.status === 'success') {
                        window.location.href = "login.jsp";
                    }
                },
                error: function () {
                    alert("An error occurred. Please try again.");
                }
            });
        });
    });
</script>
</body>
</html>
