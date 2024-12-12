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
    <title>Student Dashboard</title>
</head>
<body>
<h2>Your Courses and Grades</h2>
<table border="1">
    <tr>
        <th>Course Name</th>
        <th>Grade</th>
    </tr>
    <c:forEach var="course" items="${courses}">
        <tr>
            <td>${course.name}</td>
            <td>${course.grade}</td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
