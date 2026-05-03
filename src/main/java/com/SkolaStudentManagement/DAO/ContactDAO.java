package com.SkolaStudentManagement.DAO;

import com.SkolaStudentManagement.Model.ContactModel;
import com.SkolaStudentManagement.utils.DBConnection;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class ContactDAO {

    // ── INSERT ────────────────────────────────────────────────
    public boolean save(ContactModel cm) {
        String sql = "INSERT INTO contact_messages (name, email, message) VALUES (?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, cm.getName());
            ps.setString(2, cm.getEmail());
            ps.setString(3, cm.getMessage());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ── SELECT ALL (useful for admin panel later) ─────────────
    public List<ContactModel> findAll() {
        List<ContactModel> list = new ArrayList<>();
        String sql = "SELECT * FROM contact_messages ORDER BY sent_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ContactModel cm = new ContactModel();
                cm.setId(rs.getInt("id"));
                cm.setName(rs.getString("name"));
                cm.setEmail(rs.getString("email"));
                cm.setMessage(rs.getString("message"));
                cm.setSentAt(rs.getTimestamp("sent_at").toLocalDateTime());
                list.add(cm);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
}