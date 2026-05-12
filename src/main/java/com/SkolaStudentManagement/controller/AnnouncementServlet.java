package com.SkolaStudentManagement.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

import com.SkolaStudentManagement.DAO.AnnouncementDAO;
import com.SkolaStudentManagement.Model.AnnouncementModel;

@WebServlet(asyncSupported = true, urlPatterns = { "/AnnouncementServlet" })
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,      // 1 MB — keep in memory below this
    maxFileSize       = 10 * 1024 * 1024, // 10 MB max per file
    maxRequestSize    = 20 * 1024 * 1024  // 20 MB max total request
)
public class AnnouncementServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final AnnouncementDAO dao = new AnnouncementDAO();

    // Folder inside your webapp to store uploads
    private static final String UPLOAD_DIR = "uploads";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<AnnouncementModel> announcements = dao.getAllAnnouncements();
            request.setAttribute("announcements", announcements);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Could not load announcements.");
        }
        request.getRequestDispatcher("/WEB-INF/announcements.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String title   = request.getParameter("title");
        String content = request.getParameter("content");
        String genre   = request.getParameter("genre");

        if (title == null || title.trim().isEmpty()
                || content == null || content.trim().isEmpty()
                || genre == null || genre.trim().isEmpty()) {

            request.setAttribute("errorMessage", "All fields are required.");

        } else {
            try {
                // ── Resolve upload directory on disk ─────────────────────────
                String appPath  = request.getServletContext().getRealPath("");
                String uploadPath = appPath + File.separator + UPLOAD_DIR;
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();

                // ── Handle image upload ───────────────────────────────────────
                String imagePath = null;
                Part imagePart = request.getPart("imageFile");
                if (imagePart != null && imagePart.getSize() > 0) {
                    String imageFileName = extractFileName(imagePart);
                    if (imageFileName != null && !imageFileName.isEmpty()) {
                        imagePart.write(uploadPath + File.separator + imageFileName);
                        imagePath = UPLOAD_DIR + "/" + imageFileName;
                    }
                }

                // ── Handle attachment upload ──────────────────────────────────
                String attachmentPath = null;
                Part attachmentPart = request.getPart("attachmentFile");
                if (attachmentPart != null && attachmentPart.getSize() > 0) {
                    String attachFileName = extractFileName(attachmentPart);
                    if (attachFileName != null && !attachFileName.isEmpty()) {
                        attachmentPart.write(uploadPath + File.separator + attachFileName);
                        attachmentPath = UPLOAD_DIR + "/" + attachFileName;
                    }
                }

                // ── Save to DB ────────────────────────────────────────────────
                AnnouncementModel a = new AnnouncementModel();
                a.setAdminId(1); // TODO: replace with session admin ID
                a.setTitle(title.trim());
                a.setContent(content.trim());
                a.setGenre(genre.trim());
                a.setImagePath(imagePath);
                a.setAttachmentPath(attachmentPath);
                a.setPublishedAt(LocalDateTime.now());

                boolean saved = dao.addAnnouncement(a);
                if (saved) {
                    request.setAttribute("successMessage", "Announcement posted!");
                } else {
                    request.setAttribute("errorMessage", "Failed to post. Try again.");
                }

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Error: " + e.getMessage());
            }
        }

        doGet(request, response);
    }

    // Extract the original filename from a Part header
    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        if (contentDisp == null) return null;
        for (String token : contentDisp.split(";")) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf('=') + 1)
                            .trim()
                            .replace("\"", "");
            }
        }
        return null;
    }
}