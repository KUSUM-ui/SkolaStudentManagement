package com.SkolaStudentManagement.dao;

import com.SkolaStudentManagement.model.SettingsAdminModel;
import com.SkolaStudentManagement.utils.DBconfig;
import com.SkolaStudentManagement.utils.PasswordUtil;

import java.sql.*;

public class AdminDAO {

    private static final int FIXED_ADMIN_ID = 1;

    // ── READ ──────────────────────────────────────────────────────────────────
    public SettingsAdminModel getAdmin() throws SQLException {
        String sql = "SELECT admin_id, first_name, last_name, email, password FROM admin WHERE admin_id = ?";
        try (Connection conn = DBconfig.getConnection();
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

                    // Fetch image separately — silently skip if column missing
                    try {
                        String imgSql = "SELECT image FROM admin WHERE admin_id = ?";
                        try (PreparedStatement imgPs = conn.prepareStatement(imgSql)) {
                            imgPs.setInt(1, FIXED_ADMIN_ID);
                            try (ResultSet imgRs = imgPs.executeQuery()) {
                                if (imgRs.next()) {
                                    a.setImage(imgRs.getString("image"));
                                }
                            }
                        }
                    } catch (SQLException ignored) {
                        // image column does not exist yet — not fatal
                    }

                    return a;
                }
            }
        }
        return null;
    }

    // ── UPDATE PROFILE ────────────────────────────────────────────────────────
    public boolean updateProfile(SettingsAdminModel a) throws SQLException {
        // FIX 1: lowercase "admin" table name
        String sql = "UPDATE admin SET first_name=?, last_name=?, email=? WHERE admin_id=?";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, a.getFirstName());
            ps.setString(2, a.getLastName());
            ps.setString(3, a.getEmail());
            ps.setInt(4, a.getAdminId());
            return ps.executeUpdate() > 0;
        }
    }

    // ── UPDATE PASSWORD (stores BCrypt hash) ──────────────────────────────────
    public boolean updatePassword(int adminId, String newPasswordHash) throws SQLException {
        String sql = "UPDATE admin SET password=? WHERE admin_id=?";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, newPasswordHash);
            ps.setInt(2, adminId);
            return ps.executeUpdate() > 0;
        }
    }

    // ── VERIFY CURRENT PASSWORD (supports both plain and BCrypt hashes) ───────
    public boolean verifyPassword(int adminId, String rawPassword) throws SQLException {
        String sql = "SELECT password FROM admin WHERE admin_id=?";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, adminId);
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
}