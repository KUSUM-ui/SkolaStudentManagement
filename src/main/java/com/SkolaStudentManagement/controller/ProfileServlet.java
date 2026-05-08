package com.SkolaStudentManagement.controller;

import com.SkolaStudentManagement.utils.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet(urlPatterns = { "/ProfileServlet" })
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // ── GET: load profile data into JSP ─────────────────────────────────────
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        // Guard: must be logged in
        if (session == null ||
           (session.getAttribute("adminId") == null && session.getAttribute("studentId") == null)) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String role = (String) session.getAttribute("role");

        // Pre-fill form from session (no extra DB call needed for GET)
        req.setAttribute("firstName", session.getAttribute("firstName"));
        req.setAttribute("lastName",  session.getAttribute("lastName"));
        req.setAttribute("email",     session.getAttribute("email"));

        if ("admin".equals(role)) {
            req.setAttribute("phone", session.getAttribute("phone"));
        }

        req.getRequestDispatcher("/WEB-INF/profile_settings.jsp").forward(req, res);
    }

    // ── POST: save changes ───────────────────────────────────────────────────
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null ||
           (session.getAttribute("adminId") == null && session.getAttribute("studentId") == null)) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String role      = (String) session.getAttribute("role");
        String firstName = req.getParameter("firstName");
        String lastName  = req.getParameter("lastName");
        String email     = req.getParameter("email");
        String phone     = req.getParameter("phone");       // admin only
        String currentPw = req.getParameter("currentPassword");
        String newPw     = req.getParameter("newPassword");

        // Basic validation
        if (firstName == null || firstName.trim().isEmpty() ||
            lastName  == null || lastName.trim().isEmpty()  ||
            email     == null || email.trim().isEmpty()) {
            req.setAttribute("errorMsg", "First name, last name and email are required.");
            doGet(req, res);
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {

            if ("admin".equals(role)) {
                int adminId = (int) session.getAttribute("adminId");

                // ── Password change? Verify current password first ──
                if (newPw != null && !newPw.trim().isEmpty()) {
                    if (!verifyPassword(conn, "Admin", "admin_id", adminId, currentPw)) {
                        req.setAttribute("errorMsg", "Current password is incorrect.");
                        doGet(req, res);
                        return;
                    }
                    String sql = "UPDATE Admin SET first_name=?, last_name=?, email=?, " +
                                 "phone=?, password=? WHERE admin_id=?";
                    try (PreparedStatement ps = conn.prepareStatement(sql)) {
                        ps.setString(1, firstName.trim());
                        ps.setString(2, lastName.trim());
                        ps.setString(3, email.trim());
                        ps.setString(4, phone != null ? phone.trim() : "");
                        ps.setString(5, newPw.trim());
                        ps.setInt   (6, adminId);
                        ps.executeUpdate();
                    }
                } else {
                    String sql = "UPDATE Admin SET first_name=?, last_name=?, email=?, " +
                                 "phone=? WHERE admin_id=?";
                    try (PreparedStatement ps = conn.prepareStatement(sql)) {
                        ps.setString(1, firstName.trim());
                        ps.setString(2, lastName.trim());
                        ps.setString(3, email.trim());
                        ps.setString(4, phone != null ? phone.trim() : "");
                        ps.setInt   (5, adminId);
                        ps.executeUpdate();
                    }
                }

                // Update session so topbar name refreshes immediately
                session.setAttribute("firstName", firstName.trim());
                session.setAttribute("lastName",  lastName.trim());
                session.setAttribute("email",     email.trim());
                session.setAttribute("phone",     phone != null ? phone.trim() : "");

            } else if ("student".equals(role)) {
                int studentId = (int) session.getAttribute("studentId");

                if (newPw != null && !newPw.trim().isEmpty()) {
                    if (!verifyPassword(conn, "Student", "student_id", studentId, currentPw)) {
                        req.setAttribute("errorMsg", "Current password is incorrect.");
                        doGet(req, res);
                        return;
                    }
                    String sql = "UPDATE Student SET first_name=?, last_name=?, email=?, " +
                                 "password=? WHERE student_id=?";
                    try (PreparedStatement ps = conn.prepareStatement(sql)) {
                        ps.setString(1, firstName.trim());
                        ps.setString(2, lastName.trim());
                        ps.setString(3, email.trim());
                        ps.setString(4, newPw.trim());
                        ps.setInt   (5, studentId);
                        ps.executeUpdate();
                    }
                } else {
                    String sql = "UPDATE Student SET first_name=?, last_name=?, " +
                                 "email=? WHERE student_id=?";
                    try (PreparedStatement ps = conn.prepareStatement(sql)) {
                        ps.setString(1, firstName.trim());
                        ps.setString(2, lastName.trim());
                        ps.setString(3, email.trim());
                        ps.setInt   (4, studentId);
                        ps.executeUpdate();
                    }
                }

                session.setAttribute("firstName", firstName.trim());
                session.setAttribute("lastName",  lastName.trim());
                session.setAttribute("email",     email.trim());
            }

            req.setAttribute("successMsg", "Profile updated successfully.");

        } catch (SQLException e) {
            e.printStackTrace();
            req.setAttribute("errorMsg", "Database error: " + e.getMessage());
        }

        doGet(req, res);
    }

    // ── Helper: check current password ──────────────────────────────────────
    private boolean verifyPassword(Connection conn, String table, String idCol,
                                   int id, String inputPassword) throws SQLException {
        String sql = "SELECT password FROM " + table + " WHERE " + idCol + " = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("password").equals(inputPassword);
            }
        }
        return false;
    }
}