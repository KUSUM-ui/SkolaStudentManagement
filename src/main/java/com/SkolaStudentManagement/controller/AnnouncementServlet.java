package com.SkolaStudentManagement.controller;

import com.SkolaStudentManagement.Model.AnnouncementModel;
import com.SkolaStudentManagement.Service.AnnouncementService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.util.List;

@WebServlet(asyncSupported = true, urlPatterns = {"/AnnouncementServlet"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,       // 1 MB
        maxFileSize       = 10 * 1024 * 1024,  // 10 MB per file
        maxRequestSize    = 20 * 1024 * 1024   // 20 MB total
)
public class AnnouncementServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = "uploads";

    // ── Use Service, not DAO directly ─────────────────────────────────────────
    private final AnnouncementService announcementService = new AnnouncementService();

    // ── GET: load and display all announcements ───────────────────────────────
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

    // ── POST: create a new announcement ──────────────────────────────────────
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String title   = request.getParameter("title");
        String content = request.getParameter("content");
        String genre   = request.getParameter("genre");

        try {
            // ── Resolve upload directory ──────────────────────────────────────
            String appPath   = request.getServletContext().getRealPath("");
            String uploadPath = appPath + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            // ── Handle image upload ───────────────────────────────────────────
            String imagePath = saveUploadedFile(request.getPart("imageFile"), uploadPath);

            // ── Handle attachment upload ──────────────────────────────────────
            String attachmentPath = saveUploadedFile(request.getPart("attachmentFile"), uploadPath);

            // ── TODO: replace hardcoded 1 with session admin ID ──────────────
            // HttpSession session = request.getSession();
            // int adminId = (int) session.getAttribute("adminId");
            int adminId = 1;

            // ── Delegate to Service (validation lives there) ──────────────────
            boolean saved = announcementService.createAnnouncement(
                    adminId, title, content, genre, imagePath, attachmentPath);

            if (saved) {
                request.setAttribute("successMessage", "Announcement posted successfully!");
            } else {
                request.setAttribute("errorMessage", "Failed to post announcement. Please try again.");
            }

        } catch (IllegalArgumentException e) {
            // Validation errors from the Service layer
            request.setAttribute("errorMessage", e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Unexpected error: " + e.getMessage());
        }

        doGet(request, response);
    }

    // ── Helper: save an uploaded Part to disk, return relative path or null ──
    private String saveUploadedFile(Part part, String uploadPath) throws IOException, ServletException {
        if (part == null || part.getSize() == 0) return null;

        String fileName = extractFileName(part);
        if (fileName == null || fileName.isEmpty()) return null;

        // Sanitize filename to prevent path traversal
        fileName = new File(fileName).getName();

        part.write(uploadPath + File.separator + fileName);
        return UPLOAD_DIR + "/" + fileName;
    }

    // ── Helper: extract original filename from Content-Disposition header ────
    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        if (contentDisp == null) return null;
        for (String token : contentDisp.split(";")) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}