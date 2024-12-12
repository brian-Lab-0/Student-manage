package controller;

import db.DatabaseConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import org.json.JSONObject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "RegisterServlet", urlPatterns = "/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        JSONObject jsonResponse = new JSONObject();

        String userType = request.getParameter("userType");
        Connection conn = null;

        try {
            conn = DatabaseConnection.getConnection();

            if ("student".equalsIgnoreCase(userType)) {
                registerStudent(request, conn);
            } else if ("admin".equalsIgnoreCase(userType)) {
                registerAdmin(request, conn);
            } else if ("teacher".equalsIgnoreCase(userType)) {
                registerTeacher(request, conn);
            } else {
                throw new Exception("Invalid user type specified.");
            }

            jsonResponse.put("status", "success");
            jsonResponse.put("message", userType + " registration successful!");
        } catch (Exception e) {
            e.printStackTrace();
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "Error during " + userType + " registration: " + e.getMessage());
        } finally {
            try {
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        response.getWriter().write(jsonResponse.toString());
    }

    private void registerStudent(HttpServletRequest request, Connection conn) throws Exception {
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String dob = request.getParameter("dob");
        String gender = request.getParameter("gender");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String enrollmentDate = request.getParameter("enrollmentDate");
        String departmentName = request.getParameter("departmentName");

        int departmentId = getOrCreateDepartment(departmentName, conn);

        String query = "INSERT INTO Students (first_name, last_name, dob, gender, email, password, phone, address, enrollment_date, department_id) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, firstName);
            stmt.setString(2, lastName);
            stmt.setDate(3, dob != null ? Date.valueOf(dob) : null);
            stmt.setString(4, gender);
            stmt.setString(5, email);
            stmt.setString(6, password);
            stmt.setString(7, phone);
            stmt.setString(8, address);
            stmt.setDate(9, enrollmentDate != null ? Date.valueOf(enrollmentDate) : null);
            stmt.setInt(10, departmentId);

            int rows = stmt.executeUpdate();
            if (rows == 0) {
                throw new Exception("Failed to register student.");
            }
        }
    }

    private void registerAdmin(HttpServletRequest request, Connection conn) throws Exception {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        String query = "INSERT INTO Admins (username, email, password, role_id) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, username);
            stmt.setString(2, email);
            stmt.setString(3, password);
            stmt.setInt(4, 1); // Assuming role_id = 1 for admins

            int rows = stmt.executeUpdate();
            if (rows == 0) {
                throw new Exception("Failed to register admin.");
            }
        }
    }

    private void registerTeacher(HttpServletRequest request, Connection conn) throws Exception {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String departmentName = request.getParameter("departmentName");

        int departmentId = getOrCreateDepartment(departmentName, conn);

        String query = "INSERT INTO Teachers (username, email, password, department_id) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, username);
            stmt.setString(2, email);
            stmt.setString(3, password);
            stmt.setInt(4, departmentId);

            int rows = stmt.executeUpdate();
            if (rows == 0) {
                throw new Exception("Failed to register teacher.");
            }
        }
    }

    private int getOrCreateDepartment(String departmentName, Connection conn) throws Exception {
        // Check if the department exists
        String checkQuery = "SELECT department_id FROM departments WHERE department_name = ?";
        try (PreparedStatement checkStmt = conn.prepareStatement(checkQuery)) {
            checkStmt.setString(1, departmentName);
            try (ResultSet rs = checkStmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("department_id"); // Return existing department ID
                }
            }
        }

        // Insert the department if it doesn't exist
        String insertQuery = "INSERT INTO departments (department_name) VALUES (?)";
        try (PreparedStatement insertStmt = conn.prepareStatement(insertQuery, PreparedStatement.RETURN_GENERATED_KEYS)) {
            insertStmt.setString(1, departmentName);
            insertStmt.executeUpdate();

            try (ResultSet rs = insertStmt.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1); // Return the new department ID
                }
            }
        }

        throw new Exception("Failed to create or fetch department: " + departmentName);
    }
}
