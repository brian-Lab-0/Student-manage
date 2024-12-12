<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Management Dashboard</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css">

    <!-- External CSS -->
    <link rel="stylesheet" href="css/style.css">

    <!-- jQuery -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <!-- Bootstrap Bundle JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>


</head>
<body>
<div class="container-fluid">
    <!-- Top Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Student Management</a>
            <div class="d-flex">
                <span class="navbar-text text-white me-3">Login: Admin</span>
                <a class="btn btn-outline-light" href="logout.jsp">Logout</a>
            </div>
        </div>
    </nav>

    <div class="row">
        <!-- Left Sidebar -->
        <div class="col-md-2 bg-dark text-white vh-100" id="sidebar">
            <div class="nav flex-column nav-pills">
                <a href="#" class="nav-link text-white">Home Page</a>
                <a href="#" class="nav-link active text-white">Student Management</a>
            </div>
        </div>

        <!-- Dashboard -->
        <div class="col-md-10">
            <div class="content0">
                <h4>Student Management</h4>
            </div>
            <div class="d-flex mb-3">
                <input type="text" id="searchName" class="search  form-control me-2" placeholder="Student Name">
                <%--<input type="text" id="searchId" class="form-control me-2" placeholder="Student ID">--%>
                <button class="search_btn btn btn-primary" onclick="searchStudents()">Search</button>
                <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#studentModal" onclick="resetForm()">Add Student</button>
            </div>
            <table class="table table-bordered text-center">
                <thead class="table-dark">
                <tr>
                    <th><input type="checkbox" id="selectAll"></th>
                    <th>Serial</th>
                    <th>Student ID</th>
                    <th>Student Name</th>
                    <th>Term</th>
                    <th>Class ID</th>
                    <th>Class Name</th>
                    <th>Course ID</th>
                    <th>Course Name</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody id="studentTable">
                <!-- Student data will be dynamically appended here -->
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Add/Edit Student Modal -->
<div class="modal fade" id="studentModal" tabindex="-1" aria-labelledby="studentModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="studentModalLabel">Add/Edit Student</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="studentForm">

                    <!-- Hidden input for student ID -->
                    <input type="hidden" id="hidden_id">

                    <div class="mb-3">
                        <label for="student_id" class="form-label">Student ID</label>
                        <input type="text" class="form-control" id="student_id" required>
                    </div>
                    <div class="mb-3">
                        <label for="full_name" class="form-label">Full Name</label>
                        <input type="text" class="form-control" id="full_name" required>
                    </div>
                    <div class="mb-3">
                        <label for="term" class="form-label">Term</label>
                        <input type="number" class="form-control" id="term" required>
                    </div>
                    <div class="mb-3">
                        <label for="class_id" class="form-label">Class ID</label>
                        <input type="text" class="form-control" id="class_id" required>
                    </div>
                    <div class="mb-3">
                        <label for="class_name" class="form-label">Class Name</label>
                        <input type="text" class="form-control" id="class_name" required>
                    </div>
                    <div class="mb-3">
                        <label for="course_id" class="form-label">Course ID</label>
                        <input type="text" class="form-control" id="course_id" required>
                    </div>
                    <div class="mb-3">
                        <label for="course_name" class="form-label">Course Name</label>
                        <input type="text" class="form-control" id="course_name" required>
                    </div>
                    <button type="button" id="submitButton" class="btn btn-primary" onclick="addStudent()">Submit</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- JavaScript -->
<script>
    // Load students dynamically
    function loadStudents() {
        $.ajax({
            url: "Admin",
            method: "GET",
            success: function(data) {
                $('#studentTable').html(data);
            },
            error: function(err) {
                console.error("Error loading students:", err);
                alert("Error loading students: " + err.responseText);
            }
        });
    }

    // Add a new student
    function addStudent() {
        let studentData = {
            student_id: $('#student_id').val(),
            full_name: $('#full_name').val(),
            term: $('#term').val(),
            class_id: $('#class_id').val(),
            class_name: $('#class_name').val(),
            course_id: $('#course_id').val(),
            course_name: $('#course_name').val()
        };

        $.ajax({
            url: "Admin",
            method: "POST",
            data: studentData,
            success: function(data) {
                alert(data); // Feedback
                $('#studentModal').modal('hide'); // Hide modal
                loadStudents(); // Reload the table
            },
            error: function(err) {
                console.error("Error adding student:", err);
                alert("Error adding student: " + err.responseText);
            }
        });
    }

    // Edit an existing student
    function editStudent(id) {
        console.log("Edit button clicked for student ID:", id);

        $.ajax({
            url: "Admin", // Servlet URL
            method: "GET",
            data: { id: id }, // Pass the student ID
            success: function(student) {
                console.log("Student data received:", student);

                // Populate the modal form with the current student data
                $('#hidden_id').val(student.id); // Set the hidden ID field
                $('#student_id').val(student.student_id);
                $('#full_name').val(student.full_name);
                $('#term').val(student.term);
                $('#class_id').val(student.class_id);
                $('#class_name').val(student.class_name);
                $('#course_id').val(student.course_id);
                $('#course_name').val(student.course_name);

                // Change the modal button action to updateStudent
                $('#submitButton').attr("onclick", "saveStudent()");

                // Show the modal dialog
                $('#studentModal').modal('show');
            },
            error: function(err) {
                console.error("Error fetching student details:", err);
                alert("Error fetching student details.");
            }
        });
    }



    // Update an existing student
    function saveStudent() {
        const id = $('#hidden_id').val();

        const studentData = {
            id: id ? parseInt(id, 10) : null, // Convert to integer if editing
            student_id: $('#student_id').val(),
            full_name: $('#full_name').val(),
            term: parseInt($('#term').val(), 10), // Convert to integer
            class_id: $('#class_id').val(),
            class_name: $('#class_name').val(),
            course_id: $('#course_id').val(),
            course_name: $('#course_name').val()
        };

        console.log("Saving student with data:", studentData);

        // Determine HTTP method (POST for add, PUT for update)
        const method = id ? "PUT" : "POST";

        $.ajax({
            url: "Admin",
            method: method,
            contentType: "application/json", // Specify JSON content type
            data: JSON.stringify(studentData), // Convert data to JSON string
            success: function (data) {
                console.log("Save success:", data);
                alert(data); // Show a success message
                $('#studentModal').modal('hide'); // Hide the modal dialog
                loadStudents(); // Reload the table to show updated data
            },
            error: function (err) {
                console.error("Error saving student:", err);
                alert("Error saving student: " + err.responseText);
            }
        });
    }





    // Search for students
    function searchStudents() {
        let name = $('#searchName').val();
        let id = $('#searchId').val();

        $.ajax({
            url: "Admin",
            method: "GET",
            data: { name: name, id: id },
            success: function(data) {
                $('#studentTable').html(data);
            },
            error: function(err) {
                console.error("Error searching students:", err);
                alert("Error searching students: " + err.responseText);
            }
        });
    }

    function deleteStudent(id) {
        if (confirm("Are you sure you want to delete this student?")) {
            $.ajax({
                url: "Admin",
                method: "DELETE",
                data: { id: id }, // Ensure the correct parameter name "id"
                success: function(data) {
                    alert(data); // Feedback to the user
                    loadStudents(); // Refresh the student table
                },
                error: function(err) {
                    console.error("Error deleting student:", err);
                    alert("Error deleting student: " + err.responseText);
                }
            });
        }
    }



    // Reset the form in the modal
    function resetForm() {
        $('#studentForm')[0].reset();
        $('#submitButton').attr("onclick", "addStudent()");
    }

    // Load students when the page is ready
    $(document).ready(function() {
        loadStudents();
    });
</script>
</body>
</html>