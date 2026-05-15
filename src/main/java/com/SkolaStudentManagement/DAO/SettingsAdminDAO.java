package com.SkolaStudentManagement.DAO;

import com.SkolaStudentManagement.Model.SettingsAdminModel;
import com.SkolaStudentManagement.utils.DBConnection;

import java.sql.*;

public class SettingsAdminDAO {

    private static final int FIXED_ADMIN_ID = 1;

    // ── READ ──────────────────────────────────────────────────────────────────
    public SettingsAdminModel getAdmin() throws SQLException {
        String sql = "SELECT admin_id, first_name, last_name, email, password FROM Admin WHERE admin_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, FIXED_ADMIN_ID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    SettingsAdminModel a = new SettingsAdminModel();
                    a.setAdminId(rs.getInt("admin_id"));
                    a.setFirstName(rs.getString("first_name"));
                    a.setLastName(rs.getString("last_name"));
                    a.setEmail(rs.getString("email"));
                    a.setPassword(rs.getString("password"));
                    return a;
                }
            }
        }
        return null;
    }

    // ── UPDATE PROFILE ────────────────────────────────────────────────────────
    public boolean updateProfile(SettingsAdminModel a) throws SQLException {
        String sql = "UPDATE Admin SET first_name=?, last_name=?, email=? WHERE admin_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, a.getFirstName());
            ps.setString(2, a.getLastName());
            ps.setString(3, a.getEmail());
            ps.setInt(4, a.getAdminId());
            return ps.executeUpdate() > 0;
        }
    }

    // ── UPDATE PASSWORD ───────────────────────────────────────────────────────
    public boolean updatePassword(int adminId, String newPassword) throws SQLException {
        String sql = "UPDATE Admin SET password=? WHERE admin_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, newPassword);
            ps.setInt(2, adminId);
            return ps.executeUpdate() > 0;
        }
    }

    // ── VERIFY CURRENT PASSWORD ───────────────────────────────────────────────
    public boolean verifyPassword(int adminId, String password) throws SQLException {
        String sql = "SELECT password FROM Admin WHERE admin_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, adminId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("password").equals(password);
                }
            }
        }
        return false;
    }
}