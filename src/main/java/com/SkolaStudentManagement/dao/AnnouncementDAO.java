package com.SkolaStudentManagement.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.SkolaStudentManagement.model.Announcements;
import com.SkolaStudentManagement.utils.DBconfig;

public class AnnouncementDAO {

    // CREATE
    public boolean addAnnouncement(Announcements a) throws SQLException {
        String sql = "INSERT INTO Announcement (admin_id, title, content, genre, image_path, attachment_path, published_at) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBconfig.getConnection();
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
    public List<Announcements> getAllAnnouncements() throws SQLException {
        String sql = "SELECT * FROM Announcement ORDER BY published_at DESC";
        List<Announcements> list = new ArrayList<>();

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Announcements a = new Announcements();
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
    public Announcements getAnnouncementById(int id) throws SQLException {
        String sql = "SELECT * FROM Announcement WHERE announcement_id=?";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Announcements a = new Announcements();
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
    public boolean updateAnnouncement(Announcements a) throws SQLException {
        String sql = "UPDATE Announcement SET title=?, content=?, genre=?, image_path=?, attachment_path=?, published_at=? "
                   + "WHERE announcement_id=?";

        try (Connection conn = DBconfig.getConnection();
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

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    public List<Announcements> getRecentAnnouncements(int limit) throws SQLException {
        String sql = "SELECT * FROM Announcement ORDER BY published_at DESC LIMIT ?";
        List<Announcements> list = new ArrayList<>();

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, limit);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        }

        return list;
    }
    // READ BY GENRE FILTER
    public List<Announcements> getAnnouncementsByGenre(String genre) throws SQLException {
        String sql = "SELECT * FROM Announcement WHERE genre = ? ORDER BY published_at DESC";
        List<Announcements> list = new ArrayList<>();

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, genre);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        }
        return list;
    }

    public int getTotalAnnouncements() throws Exception {
        Connection con = DBconfig.getConnection();
        String sql = "SELECT COUNT(*) FROM Announcement";
        PreparedStatement pst = con.prepareStatement(sql);
        ResultSet rs = pst.executeQuery();
        int count = 0;
        if (rs.next()) count = rs.getInt(1);
        rs.close(); pst.close(); con.close();
        return count;
    } 
    private Announcements mapRow(ResultSet rs) throws SQLException {
        Announcements a = new Announcements();
        a.setAnnouncementId(rs.getInt("announcement_id"));
        a.setAdminId(rs.getInt("admin_id"));
        a.setTitle(rs.getString("title"));
        a.setContent(rs.getString("content"));
        a.setGenre(rs.getString("genre"));
        a.setImagePath(rs.getString("image_path"));
        a.setAttachmentPath(rs.getString("attachment_path"));
        a.setPublishedAt(rs.getTimestamp("published_at").toLocalDateTime());
        Timestamp ts = rs.getTimestamp("published_at");
        if (ts != null) a.setPublishedAt(ts.toLocalDateTime());
        return a;
    }
    // READ LATEST N (for student dashboard card)
    public List<Announcements> getLatestAnnouncements(int limit) throws SQLException {
        String sql = "SELECT * FROM Announcement ORDER BY published_at DESC LIMIT ?";
        List<Announcements> list = new ArrayList<>();

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, limit);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        }
        return list;
    }
}