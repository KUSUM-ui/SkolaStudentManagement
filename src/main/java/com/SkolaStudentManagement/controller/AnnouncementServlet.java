package com.SkolaStudentManagement.controller;

import com.SkolaStudentManagement.Model.AnnouncementModel;
import com.SkolaStudentManagement.Service.AnnouncementService;
import com.SkolaStudentManagement.utils.ImageUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.util.List;

@WebServlet(asyncSupported = true, urlPatterns = {"/AnnouncementServlet"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize       = 10 * 1024 * 1024,
        maxRequestSize    = 20 * 1024 * 1024
)
public class AnnouncementServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final AnnouncementService announcementService = new AnnouncementService();

    // ── GET ───────────────────────────────────────────────────────────────────
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<AnnouncementModel> announcements = announcementService.getAllAnnouncements();
            request.setAttribute("announcements", announcements);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Could not load announcements.");
        }
        request.getRequestDispatcher("/WEB-INF/announcements.jsp").forward(request, response);
    }

    // ── POST ──────────────────────────────────────────────────────────────────
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String title   = request.getParameter("title");
        String content = request.getParameter("content");
        String genre   = request.getParameter("genre");

        try {
            // getRealPath("") = webapp root, e.g. .../webapps/SkolaStudentManagement/
            String webappRoot = request.getServletContext().getRealPath("");

            // ── Image: saved to uploads/announcements/uuid.jpg
            // ImageUtil.saveImage returns "uploads/announcements/uuid.jpg" or null
            Part imagePart = request.getPart("imageFile");
            String imagePath = ImageUtil.saveImage(imagePart, webappRoot, ImageUtil.ANNOUNCEMENT_DIR);

            // ── Attachment: PDF/Word/etc saved to uploads/announcements/uuid.pdf
            Part attachPart = request.getPart("attachmentFile");
            String attachmentPath = ImageUtil.saveFile(attachPart, webappRoot, ImageUtil.ANNOUNCEMENT_DIR);

            // TODO: replace hardcoded 1 with session admin ID
            int adminId = 1;

            boolean saved = announcementService.createAnnouncement(
                    adminId, title, content, genre, imagePath, attachmentPath);

            if (saved) {
                request.setAttribute("successMessage", "Announcement posted successfully!");
            } else {
                request.setAttribute("errorMessage", "Failed to post announcement. Please try again.");
            }

        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Unexpected error: " + e.getMessage());
        }

        doGet(request, response);
    }
}