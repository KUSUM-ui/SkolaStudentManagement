package com.SkolaStudentManagement.DAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.SkolaStudentManagement.Model.AnnouncementModel;
import com.SkolaStudentManagement.utils.DBConnection;

public class AnnouncementDAO {

    // CREATE
    public boolean addAnnouncement(AnnouncementModel a) throws SQLException {
        String sql = "INSERT INTO Announcement (admin_id, title, content, genre, image_path, attachment_path, published_at) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, a.getAdminId());
            stmt.setString(2, a.getTitle());
            stmt.setString(3, a.getContent());
            stmt.setString(4, a.getGenre());
            stmt.setString(5, a.getImagePath());
            stmt.setString(6, a.getAttachmentPath());
            stmt.setTimestamp(7, Timestamp.valueOf(a.getPublishedAt()));

            return stmt.executeUpdate() > 0;
        }
    }

    // READ ALL
    public List<AnnouncementModel> getAllAnnouncements() throws SQLException {
        String sql = "SELECT * FROM Announcement ORDER BY published_at DESC";
        List<AnnouncementModel> list = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                AnnouncementModel a = new AnnouncementModel();
                a.setAnnouncementId(rs.getInt("announcement_id"));
                a.setAdminId(rs.getInt("admin_id"));
                a.setTitle(rs.getString("title"));
                a.setContent(rs.getString("content"));
                a.setGenre(rs.getString("genre"));
                a.setImagePath(rs.getString("image_path"));
                a.setAttachmentPath(rs.getString("attachment_path"));
                a.setPublishedAt(rs.getTimestamp("published_at").toLocalDateTime());
                list.add(a);
            }
        }
        return list;
    }

    // READ BY ID
    public AnnouncementModel getAnnouncementById(int id) throws SQLException {
        String sql = "SELECT * FROM Announcement WHERE announcement_id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    AnnouncementModel a = new AnnouncementModel();
                    a.setAnnouncementId(rs.getInt("announcement_id"));
                    a.setAdminId(rs.getInt("admin_id"));
                    a.setTitle(rs.getString("title"));
                    a.setContent(rs.getString("content"));
                    a.setGenre(rs.getString("genre"));
                    a.setImagePath(rs.getString("image_path"));
                    a.setAttachmentPath(rs.getString("attachment_path"));
                    a.setPublishedAt(rs.getTimestamp("published_at").toLocalDateTime());
                    return a;
                }
            }
        }
        return null;
    }

    // UPDATE
    public boolean updateAnnouncement(AnnouncementModel a) throws SQLException {
        String sql = "UPDATE Announcement SET title=?, content=?, genre=?, image_path=?, attachment_path=?, published_at=? "
                   + "WHERE announcement_id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, a.getTitle());
            ps.setString(2, a.getContent());
            ps.setString(3, a.getGenre());
            ps.setString(4, a.getImagePath());
            ps.setString(5, a.getAttachmentPath());
            ps.setTimestamp(6, Timestamp.valueOf(a.getPublishedAt()));
            ps.setInt(7, a.getAnnouncementId());

            return ps.executeUpdate() > 0;
        }
    }

    // DELETE
    public boolean deleteAnnouncement(int id) throws SQLException {
        String sql = "DELETE FROM Announcement WHERE announcement_id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}