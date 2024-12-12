package controller;

import db.DatabaseConnection;
import org.json.JSONException;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "StudentServlet", urlPatterns = "/Admin")
public class StudentServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        String id = request.getParameter("id");

        if (id != null) {
            // Fetch a single student's data
            try (Connection conn = DatabaseConnection.getConnection()) {
                String query = "SELECT * FROM students_s WHERE id = ?";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setInt(1, Integer.parseInt(id));
                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    // Return student data as JSON
                    out.println("{");
                    out.println("\"id\": " + rs.getInt("id") + ",");
                    out.println("\"student_id\": \"" + rs.getString("student_id") + "\",");
                    out.println("\"full_name\": \"" + rs.getString("full_name") + "\",");
                    out.println("\"term\": " + rs.getInt("term") + ",");
                    out.println("\"class_id\": \"" + rs.getString("class_id") + "\",");
                    out.println("\"class_name\": \"" + rs.getString("class_name") + "\",");
                    out.println("\"course_id\": \"" + rs.getString("course_id") + "\",");
                    out.println("\"course_name\": \"" + rs.getString("course_name") + "\"");
                    out.println("}");
                } else {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    out.write("{\"error\": \"Student not found\"}");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                out.write("{\"error\": \"Unable to fetch student details\"}");
            }
        } else {
            // Fetch all students
            response.setContentType("text/html");
            try (Connection conn = DatabaseConnection.getConnection()) {
                String name = request.getParameter("name");
                String studentId = request.getParameter("id");
                String query = "SELECT * FROM students_s WHERE 1=1";

                if (name != null && !name.isEmpty()) query += " AND full_name LIKE ?";
                if (studentId != null && !studentId.isEmpty()) query += " AND student_id = ?";

                PreparedStatement stmt = conn.prepareStatement(query);
                int paramIndex = 1;

                if (name != null && !name.isEmpty()) stmt.setString(paramIndex++, "%" + name + "%");
                if (studentId != null && !studentId.isEmpty()) stmt.setString(paramIndex++, studentId);

                ResultSet rs = stmt.executeQuery();

                while (rs.next()) {
                    out.println("<tr>");
                    out.println("<td><input type='checkbox' value='" + rs.getInt("id") + "'></td>");
                    out.println("<td>" + rs.getInt("id") + "</td>");
                    out.println("<td>" + rs.getString("student_id") + "</td>");
                    out.println("<td>" + rs.getString("full_name") + "</td>");
                    out.println("<td>" + rs.getInt("term") + "</td>");
                    out.println("<td>" + rs.getString("class_id") + "</td>");
                    out.println("<td>" + rs.getString("class_name") + "</td>");
                    out.println("<td>" + rs.getString("course_id") + "</td>");
                    out.println("<td>" + rs.getString("course_name") + "</td>");
                    out.println("<td>");
                    out.println("<button class='btn btn-warning' onclick='editStudent(" + rs.getInt("id") + ")'>Edit</button>");
                    out.println("<button class='btn btn-danger' onclick='deleteStudent(" + rs.getInt("id") + ")'>Delete</button>");
                    out.println("</td>");
                    out.println("</tr>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<tr><td colspan='10'>Error: " + e.getMessage() + "</td></tr>");
            }
        }
    }

    // Handle POST Requests: Add a new student
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String studentId = request.getParameter("student_id");
        String fullName = request.getParameter("full_name");
        int term = Integer.parseInt(request.getParameter("term"));
        String classId = request.getParameter("class_id");
        String className = request.getParameter("class_name");
        String courseId = request.getParameter("course_id");
        String courseName = request.getParameter("course_name");

        try (Connection conn = DatabaseConnection.getConnection()) {
            String query = "INSERT INTO students_s (student_id, full_name, term, class_id, class_name, course_id, course_name) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, studentId);
            stmt.setString(2, fullName);
            stmt.setInt(3, term);
            stmt.setString(4, classId);
            stmt.setString(5, className);
            stmt.setString(6, courseId);
            stmt.setString(7, courseName);

            int rowsInserted = stmt.executeUpdate();
            response.getWriter().write(rowsInserted > 0 ? "Student added successfully" : "Failed to add student");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error: " + e.getMessage());
        }
    }

    // Handle DELETE Requests: Delete a student
    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Read the body of the DELETE request to extract parameters
        String id = request.getParameter("id");

        // If the id is null, parse the request body (required for DELETE requests)
        if (id == null || id.isEmpty()) {
            StringBuilder requestBody = new StringBuilder();
            String line;
            try (BufferedReader reader = request.getReader()) {
                while ((line = reader.readLine()) != null) {
                    requestBody.append(line);
                }
            }

            // Parse the `id` from the request body
            String[] params = requestBody.toString().split("&");
            for (String param : params) {
                String[] keyValue = param.split("=");
                if (keyValue[0].equals("id")) {
                    id = keyValue[1];
                    break;
                }
            }
        }

        // Validate the ID
        if (id == null || id.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Error: Student ID is required.");
            return;
        }

        try (Connection conn = DatabaseConnection.getConnection()) {
            String query = "DELETE FROM students_s WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, Integer.parseInt(id));

            int rowsDeleted = stmt.executeUpdate();
            response.getWriter().write(rowsDeleted > 0 ? "Student deleted successfully" : "Failed to delete student");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error: " + e.getMessage());
        }
    }

    //updating student
    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        try {
            // Read the JSON payload
            StringBuilder jsonPayload = new StringBuilder();
            String line;
            try (BufferedReader reader = request.getReader()) {
                while ((line = reader.readLine()) != null) {
                    jsonPayload.append(line);
                }
            }

            // Parse the JSON
            JSONObject jsonObject = new JSONObject(jsonPayload.toString());

            // Extract and validate fields
            int id = jsonObject.getInt("id");
            String studentId = jsonObject.getString("student_id");
            String fullName = jsonObject.getString("full_name");
            int term = jsonObject.getInt("term");
            String classId = jsonObject.getString("class_id");
            String className = jsonObject.getString("class_name");
            String courseId = jsonObject.getString("course_id");
            String courseName = jsonObject.getString("course_name");

            // Log the received data for debugging
            System.out.println("Updating student:");
            System.out.println("ID: " + id);
            System.out.println("Student ID: " + studentId);
            System.out.println("Full Name: " + fullName);
            System.out.println("Term: " + term);
            System.out.println("Class ID: " + classId);
            System.out.println("Class Name: " + className);
            System.out.println("Course ID: " + courseId);
            System.out.println("Course Name: " + courseName);

            // Update the student's details in the database
            try (Connection conn = DatabaseConnection.getConnection()) {
                String query = "UPDATE students_s SET student_id = ?, full_name = ?, term = ?, class_id = ?, class_name = ?, course_id = ?, course_name = ? WHERE id = ?";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setString(1, studentId);
                stmt.setString(2, fullName);
                stmt.setInt(3, term);
                stmt.setString(4, classId);
                stmt.setString(5, className);
                stmt.setString(6, courseId);
                stmt.setString(7, courseName);
                stmt.setInt(8, id);

                int rowsUpdated = stmt.executeUpdate();
                if (rowsUpdated > 0) {
                    response.getWriter().write("Student updated successfully");
                } else {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write("Failed to update student");
                }
            }
        } catch (JSONException e) {
            System.err.println("Error parsing JSON: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Error: Invalid JSON data");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("" + e.getMessage());
        }
    }



}
