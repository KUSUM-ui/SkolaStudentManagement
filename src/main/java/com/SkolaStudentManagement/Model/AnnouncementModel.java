package com.SkolaStudentManagement.Model;

import java.time.LocalDateTime;

public class AnnouncementModel {
    private int announcement_id;
    private int admin_id;
    private String title;
    private String content;
    private String genre;
    private String imagePath;
    private String attachmentPath;
    private LocalDateTime published_at;

    public AnnouncementModel() {}

    public int getAnnouncementId()                         { return announcement_id; }
    public void setAnnouncementId(int id)                  { this.announcement_id = id; }

    public int getAdminId()                                { return admin_id; }
    public void setAdminId(int adminId)                    { this.admin_id = adminId; }

    public String getTitle()                               { return title; }
    public void setTitle(String title)                     { this.title = title; }

    public String getContent()                             { return content; }
    public void setContent(String content)                 { this.content = content; }

    public String getGenre()                               { return genre; }
    public void setGenre(String genre)                     { this.genre = genre; }

    public String getImagePath()                           { return imagePath; }
    public void setImagePath(String imagePath)             { this.imagePath = imagePath; }

    public String getAttachmentPath()                      { return attachmentPath; }
    public void setAttachmentPath(String attachmentPath)   { this.attachmentPath = attachmentPath; }

    public LocalDateTime getPublishedAt()                  { return published_at; }
    public void setPublishedAt(LocalDateTime published_at) { this.published_at = published_at; }
}