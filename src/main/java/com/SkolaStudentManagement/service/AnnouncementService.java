package com.SkolaStudentManagement.service;

import java.sql.SQLException;
import java.util.List;

import com.SkolaStudentManagement.dao.AnnouncementDAO;
import com.SkolaStudentManagement.model.Announcements;

public class AnnouncementService {

    private AnnouncementDAO dao = new AnnouncementDAO();
    // ── Add ────────────────────────────────────────────────────────────────

    /**
     * Validates and saves a new announcement.
     *
     * @param adminId        ID of the admin posting (from session)
     * @param title          Announcement title
     * @param content        Announcement body text
     * @param genre          "academics" or "non-academics"
     * @param imagePath      Relative path to uploaded image, or null
     * @param attachmentPath Relative path to uploaded file, or null
     * @return true if saved successfully
     * @throws IllegalArgumentException if any required field is blank/invalid
     * @throws SQLException             if a database error occurs
     */

    public boolean addAnnouncement(Announcements a) throws SQLException {
        if (a.getTitle() == null || a.getTitle().trim().isEmpty()) {
            throw new IllegalArgumentException("Title cannot be empty");
        }
        if (a.getContent() == null || a.getContent().trim().isEmpty()) {
            throw new IllegalArgumentException("Content is required.");
        }
        if (a.getGenre() == null || (!a.getGenre().equals("academics") && !a.getGenre().equals("non-academics"))) {
            throw new IllegalArgumentException("Genre must be 'academics' or 'non-academics'.");
        }
        return dao.addAnnouncement(a);
    }

    public boolean updateAnnouncement(Announcements a) throws SQLException {
        return dao.updateAnnouncement(a);
    }

    public boolean deleteAnnouncement(int id) throws SQLException {
        return dao.deleteAnnouncement(id);
    }

    public List<Announcements> getAllAnnouncements() throws SQLException {
        return dao.getAllAnnouncements();
    }
    public int getTotalAnnouncements() throws Exception {
        return dao.getTotalAnnouncements();
    }

    public Announcements getById(int id) throws SQLException {
        return dao.getAnnouncementById(id);
    }
    public List<Announcements> getRecentAnnouncements(int limit) throws Exception {
        return dao.getRecentAnnouncements(limit);
    }

    /** Returns announcements filtered by genre, or all if genre is null/blank. */
    public List<Announcements> getAnnouncementsByFilter(String filter) throws SQLException {
        if (filter == null || filter.trim().isEmpty() || "all".equalsIgnoreCase(filter)) {
            return dao.getAllAnnouncements();
        }
        return dao.getAnnouncementsByGenre(filter.trim().toLowerCase());
    }
}