package com.SkolaStudentManagement.controller;

import com.SkolaStudentManagement.DAO.StudentsSettingsDAO;
import com.SkolaStudentManagement.Model.SettingsStudentModel;
import com.SkolaStudentManagement.utils.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet(urlPatterns = { "/login" })
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("adminId") != null) {
            response.sendRedirect(request.getContextPath() + "/ProfileServlet");
            return;
        }
        request.getRequestDispatcher("/WEB-INF/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email    = request.getParameter("email");
        String password = request.getParameter("password");
        String role     = request.getParameter("role");

        if (email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Email and password are required.");
            request.getRequestDispatcher("/WEB-INF/login.jsp").forward(request, response);
            return;
        }

        if ("admin".equals(role)) {
            loginAdmin(request, response, email.trim(), password.trim());
        } else {
            loginStudent(request, response, email.trim(), password.trim());
        }
    }

    // ── Admin login ──────────────────────────────────────────────────────────
    private void loginAdmin(HttpServletRequest req, HttpServletResponse res,
                            String email, String password)
            throws ServletException, IOException {

        String sql = "SELECT admin_id, first_name, last_name, email, phone " +
                     "FROM Admin WHERE email = ? AND password = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession session = req.getSession(true);
                session.setAttribute("adminId",   rs.getInt("admin_id"));
                session.setAttribute("firstName", rs.getString("first_name"));
                session.setAttribute("lastName",  rs.getString("last_name"));
                session.setAttribute("email",     rs.getString("email"));
                session.setAttribute("phone",     rs.getString("phone"));
                session.setAttribute("role",      "admin");
                res.sendRedirect(req.getContextPath() + "/dashboard");
            } else {
                req.setAttribute("error", "Invalid email or password.");
                req.getRequestDispatcher("/WEB-INF/login.jsp").forward(req, res);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            req.setAttribute("error", "Database error: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/login.jsp").forward(req, res);
        }
    }

    // ── Student login ────────────────────────────────────────────────────────
    private void loginStudent(HttpServletRequest req, HttpServletResponse res,
                              String email, String password)
            throws ServletException, IOException {

        String sql = "SELECT student_id, first_name, last_name, dob, gender, " +
                     "email, phone, password, grade_level, faculty_id, " +
                     "image, admin_id, section_id " +
                     "FROM Student WHERE email = ? AND password = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Build full model object
                SettingsStudentModel student = new SettingsStudentModel();
                student.setStudentId(rs.getInt("student_id"));
                student.setFirstName(rs.getString("first_name"));
                student.setLastName(rs.getString("last_name"));
                student.setDob(rs.getDate("dob"));
                student.setGender(rs.getString("gender"));
                student.setEmail(rs.getString("email"));
                student.setPhone(rs.getString("phone"));
                student.setPassword(rs.getString("password"));
                student.setGradeLevel(rs.getString("grade_level"));
                student.setFacultyId(rs.getInt("faculty_id"));
                student.setImage(rs.getString("image"));
                student.setAdminId(rs.getInt("admin_id"));
                student.setSectionId(rs.getString("section_id"));

                HttpSession session = req.getSession(true);
                session.setAttribute("student",   student); // full object for settings page
                session.setAttribute("studentId", student.getStudentId()); // convenience
                session.setAttribute("role",      "student");

                res.sendRedirect(req.getContextPath() + "/StudentDashboardServlet");
            } else {
                req.setAttribute("error", "Invalid email or password.");
                req.getRequestDispatcher("/WEB-INF/login.jsp").forward(req, res);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            req.setAttribute("error", "Database error: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/login.jsp").forward(req, res);
        }
    }
}