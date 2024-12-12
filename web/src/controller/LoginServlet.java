package controller;

import db.DatabaseConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet(name = "LoginServlet", urlPatterns = "/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String userType = request.getParameter("userType");

        try (Connection conn = DatabaseConnection.getConnection()) {
            String query;
            if ("admin".equalsIgnoreCase(userType)) {
                query = "SELECT * FROM Admins WHERE email = ? AND password = ?";
            } else {
                query = "SELECT * FROM Students WHERE email = ? AND password = ?";
            }

            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, email);
                stmt.setString(2, password);

                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        HttpSession session = request.getSession();
                        if ("admin".equalsIgnoreCase(userType)) {
                            session.setAttribute("adminId", rs.getInt("admin_id"));
                            session.setAttribute("userType", "admin");
                            response.sendRedirect("dash0.jsp"); // Redirect to StudentServlet
                        } else {
                            session.setAttribute("studentId", rs.getInt("student_id"));
                            session.setAttribute("userType", "student");
                            response.sendRedirect("studentDashboard.jsp");
                        }
                    } else {
                        request.setAttribute("errorMessage", "Invalid email or password");
                        request.getRequestDispatcher("login.jsp").forward(request, response);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred. Please try again.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
