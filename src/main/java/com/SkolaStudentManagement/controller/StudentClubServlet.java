package com.SkolaStudentManagement.controller;

import com.SkolaStudentManagement.utils.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet(urlPatterns = { "/student/clubs" })
public class StudentClubServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("studentId") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        List<Map<String, String>> clubs = new ArrayList<>();

        // ── Updated to match your actual Club table columns ──
        String sql = "SELECT club_id, club_name, club_description, max_members " +
                     "FROM Club ORDER BY club_name";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, String> club = new LinkedHashMap<>();
                club.put("id",          String.valueOf(rs.getInt("club_id")));
                club.put("name",        rs.getString("club_name"));
                club.put("description", rs.getString("club_description"));
                club.put("maxMembers",  String.valueOf(rs.getInt("max_members")));
                club.put("imageUrl",    ""); // no image column — placeholder will show
                clubs.add(club);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            req.setAttribute("errorMsg", "Could not load clubs: " + e.getMessage());
        }

        req.setAttribute("clubs", clubs);
        req.getRequestDispatcher("/WEB-INF/student_clubs.jsp").forward(req, res);
    }
}