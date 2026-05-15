package com.SkolaStudentManagement.Service;

import com.SkolaStudentManagement.DAO.AnnouncementDAO;
import com.SkolaStudentManagement.Model.AnnouncementModel;

import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;

public class AnnouncementService {

    private final AnnouncementDAO announcementDAO = new AnnouncementDAO();

    // ── Create ────────────────────────────────────────────────────────────────

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
    public boolean createAnnouncement(int adminId,
                                      String title,
                                      String content,
                                      String genre,
                                      String imagePath,
                                      String attachmentPath) throws IllegalArgumentException, SQLException {

        // ── Validation ────────────────────────────────────────────────────────
        if (title == null || title.trim().isEmpty()) {
            throw new IllegalArgumentException("Title is required.");
        }
        if (content == null || content.trim().isEmpty()) {
            throw new IllegalArgumentException("Content is required.");
        }
        if (genre == null || (!genre.equals("academics") && !genre.equals("non-academics"))) {
            throw new IllegalArgumentException("Genre must be 'academics' or 'non-academics'.");
        }

        // ── Build model ───────────────────────────────────────────────────────
        AnnouncementModel announcement = new AnnouncementModel();
        announcement.setAdminId(adminId);
        announcement.setTitle(title.trim());
        announcement.setContent(content.trim());
        announcement.setGenre(genre.trim());
        announcement.setImagePath(imagePath);
        announcement.setAttachmentPath(attachmentPath);
        announcement.setPublishedAt(LocalDateTime.now());

        return announcementDAO.addAnnouncement(announcement);
    }

    // ── Read ──────────────────────────────────────────────────────────────────

    /**
     * Returns all announcements ordered by most recent first.
     */
    public List<AnnouncementModel> getAllAnnouncements() throws SQLException {
        return announcementDAO.getAllAnnouncements();
    }

    /**
     * Returns a single announcement by ID, or null if not found.
     */
    public AnnouncementModel getAnnouncementById(int id) throws SQLException {
        if (id <= 0) {
            throw new IllegalArgumentException("Invalid announcement ID.");
        }
        return announcementDAO.getAnnouncementById(id);
    }

    /**
     * Returns only announcements matching the given genre.
     * Convenience helper — filtering could also be done in the DAO with a WHERE clause.
     */
    public List<AnnouncementModel> getAnnouncementsByGenre(String genre) throws SQLException {
        List<AnnouncementModel> all = announcementDAO.getAllAnnouncements();
        if (genre == null || genre.equalsIgnoreCase("all")) {
            return all;
        }
        List<AnnouncementModel> filtered = new java.util.ArrayList<>();
        for (AnnouncementModel a : all) {
            if (genre.equalsIgnoreCase(a.getGenre())) {
                filtered.add(a);
            }
        }
        return filtered;
    }

    // ── Update ────────────────────────────────────────────────────────────────

    /**
     * Updates an existing announcement's editable fields.
     * Pass null for imagePath / attachmentPath to leave them unchanged.
     */
    public boolean updateAnnouncement(int announcementId,
                                      String title,
                                      String content,
                                      String genre,
                                      String imagePath,
                                      String attachmentPath) throws IllegalArgumentException, SQLException {

        if (announcementId <= 0) {
            throw new IllegalArgumentException("Invalid announcement ID.");
        }
        if (title == null || title.trim().isEmpty()) {
            throw new IllegalArgumentException("Title is required.");
        }
        if (content == null || content.trim().isEmpty()) {
            throw new IllegalArgumentException("Content is required.");
        }
        if (genre == null || (!genre.equals("academics") && !genre.equals("non-academics"))) {
            throw new IllegalArgumentException("Genre must be 'academics' or 'non-academics'.");
        }

        // Fetch existing record so we don't wipe paths if no new file was uploaded
        AnnouncementModel existing = announcementDAO.getAnnouncementById(announcementId);
        if (existing == null) {
            throw new IllegalArgumentException("Announcement not found.");
        }

        existing.setTitle(title.trim());
        existing.setContent(content.trim());
        existing.setGenre(genre.trim());

        // Only overwrite paths when a new file was actually uploaded
        if (imagePath != null) {
            existing.setImagePath(imagePath);
        }
        if (attachmentPath != null) {
            existing.setAttachmentPath(attachmentPath);
        }

        return announcementDAO.updateAnnouncement(existing);
    }

    // ── Delete ────────────────────────────────────────────────────────────────

    /**
     * Deletes an announcement by ID.
     * Note: does NOT delete the uploaded files from disk — handle that in the Servlet
     * if you want to clean up physical files on deletion.
     */
    public boolean deleteAnnouncement(int id) throws IllegalArgumentException, SQLException {
        if (id <= 0) {
            throw new IllegalArgumentException("Invalid announcement ID.");
        }
        return announcementDAO.deleteAnnouncement(id);
    }
}