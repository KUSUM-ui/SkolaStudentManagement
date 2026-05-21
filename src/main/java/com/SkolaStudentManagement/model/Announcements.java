package com.SkolaStudentManagement.model;

import java.time.LocalDateTime;

public class Announcements {
    private int announcement_id;
    private int admin_id;
    private String title;
    private String content;
    private String genre;
    private String imagePath;
    private String attachmentPath; // relative path stored in DB, e.g. "uploads/announcements/file.pdf"
    private LocalDateTime published_at;

    // Default constructor
    public Announcements() {}

    // Constructor with fields (optional if you want to initialize directly)
    public Announcements(int admin_id, String title, String content, LocalDateTime published_at) {
        this.admin_id = admin_id;
        this.title = title;
        this.content = content;
        this.published_at = published_at;
    }

    // Getters and Setters
    public int getAnnouncementId() {
        return announcement_id;
    }

    public void setAnnouncementId(int announcementId) {
        this.announcement_id = announcementId;
    }

    public int getAdminId() {
        return admin_id;
    }

    public void setAdminId(int adminId) {
        this.admin_id = adminId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public LocalDateTime getPublishedAt() {
        return published_at;
    }

    public void setPublishedAt(LocalDateTime published_at) {
        this.published_at = published_at;
    }

	/**
	 * @return the attachmentPath
	 */
	public String getAttachmentPath() {
		return attachmentPath;
	}

	/**
	 * @param attachmentPath the attachmentPath to set
	 */
	public void setAttachmentPath(String attachmentPath) {
		this.attachmentPath = attachmentPath;
	}

	/**
	 * @return the genre
	 */
	public String getGenre() {
		return genre;
	}

	/**
	 * @param genre the genre to set
	 */
	public void setGenre(String genre) {
		this.genre = genre;
	}

	/**
	 * @return the imagePath
	 */
	public String getImagePath() {
		return imagePath;
	}

	/**
	 * @param imagePath the imagePath to set
	 */
	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}

}
