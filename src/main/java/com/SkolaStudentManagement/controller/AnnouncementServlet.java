package com.SkolaStudentManagement.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

import com.SkolaStudentManagement.model.Announcements;
import com.SkolaStudentManagement.service.AnnouncementService;

@WebServlet(asyncSupported = true, urlPatterns = { "/admin/announcements" })
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize       = 10 * 1024 * 1024,
    maxRequestSize    = 20 * 1024 * 1024
)
public class AnnouncementServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final AnnouncementService service = new AnnouncementService();

    private static final String UPLOAD_DIR = "uploads";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Pull filter param; default to "all"
        String filter = request.getParameter("filter");
        if (filter == null || filter.trim().isEmpty()) {
            filter = "all";
        }
        request.setAttribute("activeFilter", filter);

        // Transfer session flash messages to request scope, then clear them
        HttpSession session = request.getSession(false);
        if (session != null) {
            Object success = session.getAttribute("successMessage");
            Object error   = session.getAttribute("errorMessage");
            if (success != null) {
                request.setAttribute("successMessage", success);
                session.removeAttribute("successMessage");
            }
            if (error != null) {
                request.setAttribute("errorMessage", error);
                session.removeAttribute("errorMessage");
            }
        }

        try {
            List<Announcements> announcements = service.getAnnouncementsByFilter(filter);
            request.setAttribute("announcements", announcements);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Could not load announcements.");
        }

        request.getRequestDispatcher("/WEB-INF/pages/announcements.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String method = request.getParameter("_method");

        // DELETE
        if ("delete".equals(method)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean deleted = service.deleteAnnouncement(id);
                if (deleted) {
                    request.getSession().setAttribute("successMessage", "Announcement deleted.");
                } else {
                    request.getSession().setAttribute("errorMessage", "Could not delete announcement.");
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.getSession().setAttribute("errorMessage", "Error: " + e.getMessage());
            }
            response.sendRedirect(request.getContextPath() + "/admin/announcements");
            return;
        }

        // SHOW EDIT FORM
        if ("edit".equals(method)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                Announcements ann = service.getById(id);
                if (ann != null) {
                    request.setAttribute("editAnn", ann);
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Could not load announcement.");
            }
            doGet(request, response);
            return;
        }

        // SAVE EDIT
        if ("saveEdit".equals(method)) {
            String title   = nvl(request.getParameter("title"));
            String content = nvl(request.getParameter("content"));
            String genre   = nvl(request.getParameter("genre"));

            if (title.isEmpty()) {
                request.getSession().setAttribute("errorMessage", "Title is required.");
                response.sendRedirect(request.getContextPath() + "/admin/announcements");
                return;
            }
            if (content.isEmpty()) {
                request.getSession().setAttribute("errorMessage", "Content is required.");
                response.sendRedirect(request.getContextPath() + "/admin/announcements");
                return;
            }
            if (genre.isEmpty()) {
                request.getSession().setAttribute("errorMessage", "Please select a genre.");
                response.sendRedirect(request.getContextPath() + "/admin/announcements");
                return;
            }

            try {
                int id = Integer.parseInt(request.getParameter("id"));
                Announcements ann = service.getById(id);
                String uploadPath = resolveUploadPath(request);

                Part imagePart = request.getPart("imageFile");
                if (imagePart != null && imagePart.getSize() > 0) {
                    String fileName = extractFileName(imagePart);
                    imagePart.write(uploadPath + File.separator + fileName);
                    ann.setImagePath(UPLOAD_DIR + "/" + fileName);
                }

                Part attachPart = request.getPart("attachmentFile");
                if (attachPart != null && attachPart.getSize() > 0) {
                    String fileName = extractFileName(attachPart);
                    attachPart.write(uploadPath + File.separator + fileName);
                    ann.setAttachmentPath(UPLOAD_DIR + "/" + fileName);
                }

                ann.setTitle(title);
                ann.setContent(content);
                ann.setGenre(genre);
                ann.setPublishedAt(LocalDateTime.now());

                service.updateAnnouncement(ann);
                request.getSession().setAttribute("successMessage", "Announcement updated.");

            } catch (Exception e) {
                e.printStackTrace();
                request.getSession().setAttribute("errorMessage", "Could not update announcement.");
            }
            response.sendRedirect(request.getContextPath() + "/admin/announcements");
            return;
        }

        // CREATE
        request.setCharacterEncoding("UTF-8");

        String title   = nvl(request.getParameter("title"));
        String content = nvl(request.getParameter("content"));
        String genre   = nvl(request.getParameter("genre"));

        String createError = null;
        if (title.isEmpty()) {
            createError = "Title is required.";
        } else if (content.isEmpty()) {
            createError = "Content is required.";
        } else if (genre.isEmpty()) {
            createError = "Please select a genre.";
        }

        if (createError != null) {
            request.setAttribute("errorMessage", createError);
            doGet(request, response);
            return;
        }

        try {
            String uploadPath = resolveUploadPath(request);

            String imagePath = null;
            Part imagePart = request.getPart("imageFile");
            if (imagePart != null && imagePart.getSize() > 0) {
                String imageFileName = extractFileName(imagePart);
                if (imageFileName != null && !imageFileName.isEmpty()) {
                    imagePart.write(uploadPath + File.separator + imageFileName);
                    imagePath = UPLOAD_DIR + "/" + imageFileName;
                }
            }

            String attachmentPath = null;
            Part attachmentPart = request.getPart("attachmentFile");
            if (attachmentPart != null && attachmentPart.getSize() > 0) {
                String attachFileName = extractFileName(attachmentPart);
                if (attachFileName != null && !attachFileName.isEmpty()) {
                    attachmentPart.write(uploadPath + File.separator + attachFileName);
                    attachmentPath = UPLOAD_DIR + "/" + attachFileName;
                }
            }

            Announcements a = new Announcements();
            a.setAdminId(1);
            a.setTitle(title);
            a.setContent(content);
            a.setGenre(genre);
            a.setImagePath(imagePath);
            a.setAttachmentPath(attachmentPath);
            a.setPublishedAt(LocalDateTime.now());

            boolean saved = service.addAnnouncement(a);
            if (saved) {
                request.getSession().setAttribute("successMessage", "Announcement posted!");
            } else {
                request.getSession().setAttribute("errorMessage", "Failed to post. Try again.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Error: " + e.getMessage());
        }

        // PRG pattern — redirect after POST
        String sourcePage = request.getParameter("sourcePage");
        if ("dashboard".equals(sourcePage)) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/announcements");
        }
    }

    /** Null-safe trim — returns empty string instead of null. */
    private String nvl(String value) {
        return (value != null) ? value.trim() : "";
    }

    /** Ensures the upload directory exists and returns its absolute path. */
    private String resolveUploadPath(HttpServletRequest request) {
        String path = request.getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        new File(path).mkdirs();
        return path;
    }

    /** Extracts the original filename from a multipart Part's content-disposition header. */
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