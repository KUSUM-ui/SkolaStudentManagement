package com.SkolaStudentManagement.dao;
import com.SkolaStudentManagement.model.SettingsStudentModel;
import com.SkolaStudentManagement.utils.DBconfig;
import com.SkolaStudentManagement.utils.PasswordUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class StudentSettingsDAO {
	// ------------------------------------------------------------------
    // Fetch a single student by primary key
    // ------------------------------------------------------------------
    public SettingsStudentModel getStudentById(int studentId) {
        String sql = "SELECT * FROM Student WHERE student_id = ?";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapRow(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ------------------------------------------------------------------
    // Update phone
    // ------------------------------------------------------------------
    public boolean updatePhone(int studentId, String phone) {
        String sql = "UPDATE Student SET phone = ? WHERE student_id = ?";
        return executeUpdate(sql, phone, studentId);
    }

    // ------------------------------------------------------------------
    // Update password (stores BCrypt hash)
    // ------------------------------------------------------------------
    public boolean updatePassword(int studentId, String newPassword) throws SQLException {
        String sql = "UPDATE Student SET password = ? WHERE student_id = ?";
        try (Connection conn = DBconfig.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

               ps.setString(1, newPassword);
               ps.setInt(2, studentId);
               return ps.executeUpdate() > 0;
           }
    }    

    // ── VERIFY CURRENT PASSWORD (supports both plain and BCrypt hashes) ───────
    public boolean verifyPassword(int studentId, String rawPassword) throws SQLException {
    
        String sql = "SELECT password FROM student WHERE student_id=?";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, studentId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String stored = rs.getString("password");
                    if (stored == null) return false;
                    // BCrypt hashes start with $2a$ / $2b$
                    if (stored.startsWith("$2")) {
                        return PasswordUtil.checkPassword(rawPassword, stored);
                    }
                    // Legacy plain-text fallback
                    return stored.equals(rawPassword);
                }
            }
        }
        return false;
    }

    // ------------------------------------------------------------------
    // Update image path (pass empty string "" to clear)
    // ------------------------------------------------------------------
    public boolean updateImage(int studentId, String imagePath) {
        String sql = "UPDATE Student SET image = ? WHERE student_id = ?";
        return executeUpdate(sql, imagePath, studentId);
    }

    // ------------------------------------------------------------------
    // Private helpers
    // ------------------------------------------------------------------
    private boolean executeUpdate(String sql, String value, int studentId) {
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, value);
            ps.setInt(2, studentId);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private SettingsStudentModel mapRow(ResultSet rs) throws SQLException {
        SettingsStudentModel s = new SettingsStudentModel();
        s.setStudentId(rs.getInt("student_id"));
        s.setFirstName(rs.getString("first_name"));
        s.setLastName(rs.getString("last_name"));
        s.setDob(rs.getDate("dob"));
        s.setGender(rs.getString("gender"));
        s.setEmail(rs.getString("email"));
        s.setPhone(rs.getString("phone"));
        s.setPassword(rs.getString("password"));
        s.setGradeLevel(rs.getString("grade_level"));
        s.setFacultyId(rs.getInt("faculty_id"));
        s.setImage(rs.getString("image"));
        s.setAdminId(rs.getInt("admin_id"));
        s.setSectionId(rs.getString("section_id"));
        return s;
    }
}
