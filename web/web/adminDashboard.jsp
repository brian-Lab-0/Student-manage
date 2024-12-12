<%--
  Created by IntelliJ IDEA.
  User: brian
  Date: 10/5/2024
  Time: 12:05 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
</head>
<body>
<h2>Assign Grades</h2>
<form action="AssignGradesServlet" method="post">
    <label>Student ID:</label>
    <input type="number" name="studentId" required><br>
    <label>Course ID:</label>
    <input type="number" name="courseId" required><br>
    <label>Grade:</label>
    <select name="grade">
        <option value="A">A</option>
        <option value="B">B</option>
        <option value="C">C</option>
        <option value="D">D</option>
        <option value="F">F</option>
    </select><br>
    <input type="submit" value="Assign Grade">
</form>
</body>
</html>

