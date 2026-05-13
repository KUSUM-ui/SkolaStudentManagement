package com.SkolaStudentManagement.controller;

import com.SkolaStudentManagement.DAO.StudentsSettingsDAO;
import com.SkolaStudentManagement.Model.SettingsStudentModel;

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
import java.nio.file.Paths;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize       = 1024 * 1024 * 5,
    maxRequestSize    = 1024 * 1024 * 10
)
@WebServlet(asyncSupported = true, urlPatterns = { "/SettingsStudentServlet" })
public class SettingsStudentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String IMAGE_DIR = "uploads/profile_images";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("student") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Always refresh from DB so the page shows latest data
        SettingsStudentModel student = (SettingsStudentModel) session.getAttribute("student");
        StudentsSettingsDAO dao = new StudentsSettingsDAO();
        SettingsStudentModel fresh = dao.getStudentById(student.getStudentId());
        if (fresh != null) {
            session.setAttribute("student", fresh);
            request.setAttribute("student", fresh);
        } else {
            request.setAttribute("student", student);
        }

        request.getRequestDispatcher("/WEB-INF/settings_student.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("student") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        SettingsStudentModel student = (SettingsStudentModel) session.getAttribute("student");
        StudentsSettingsDAO dao = new StudentsSettingsDAO();
        String action = request.getParameter("action");

        if (action == null) {
            request.setAttribute("error", "Invalid request.");
            doGet(request, response);
            return;
        }

        switch (action) {

            // ── UPDATE PHONE ─────────────────────────────────────────────────
            case "updatePhone": {
                String phone = request.getParameter("phone");
                if (phone == null || phone.trim().isEmpty()) {
                    request.setAttribute("error", "Phone number cannot be empty.");
                    doGet(request, response);
                    return;
                }
                phone = phone.trim();
                if (!phone.matches("^[+]?[0-9]{7,15}$")) {
                    request.setAttribute("error", "Enter a valid phone number.");
                    doGet(request, response);
                    return;
                }
                if (dao.updatePhone(student.getStudentId(), phone)) {
                    student.setPhone(phone);
                    session.setAttribute("student", student);
                    request.setAttribute("success", "Phone number updated successfully.");
                } else {
                    request.setAttribute("error", "Failed to update phone. Please try again.");
                }
                doGet(request, response);
                break;
            }

            // ── UPDATE PASSWORD ──────────────────────────────────────────────
            case "updatePassword": {
                String currentPassword = request.getParameter("currentPassword");
                String newPassword     = request.getParameter("newPassword");
                String confirmPassword = request.getParameter("confirmPassword");

                if (currentPassword == null || newPassword == null || confirmPassword == null
                        || currentPassword.isEmpty() || newPassword.isEmpty() || confirmPassword.isEmpty()) {
                    request.setAttribute("error", "All password fields are required.");
                    doGet(request, response);
                    return;
                }
                if (!currentPassword.equals(student.getPassword())) {
                    request.setAttribute("error", "Current password is incorrect.");
                    doGet(request, response);
                    return;
                }
                if (!newPassword.equals(confirmPassword)) {
                    request.setAttribute("error", "New passwords do not match.");
                    doGet(request, response);
                    return;
                }
                if (newPassword.length() < 6) {
                    request.setAttribute("error", "New password must be at least 6 characters.");
                    doGet(request, response);
                    return;
                }
                if (dao.updatePassword(student.getStudentId(), newPassword)) {
                    student.setPassword(newPassword);
                    session.setAttribute("student", student);
                    request.setAttribute("success", "Password updated successfully.");
                } else {
                    request.setAttribute("error", "Failed to update password. Please try again.");
                }
                doGet(request, response);
                break;
            }

            // ── UPDATE IMAGE ─────────────────────────────────────────────────
            case "updateImage": {
                Part filePart = request.getPart("image");

                if (filePart == null || filePart.getSize() == 0) {
                    request.setAttribute("error", "Please select an image to upload.");
                    doGet(request, response);
                    return;
                }
                if (!filePart.getContentType().startsWith("image/")) {
                    request.setAttribute("error", "Only image files are allowed.");
                    doGet(request, response);
                    return;
                }

                String appPath  = getServletContext().getRealPath("");
                String savePath = appPath + File.separator + IMAGE_DIR;
                File   saveDir  = new File(savePath);
                if (!saveDir.exists()) saveDir.mkdirs();

                String originalName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String extension    = originalName.contains(".")
                        ? originalName.substring(originalName.lastIndexOf('.')) : "";
                String fileName = "student_" + student.getStudentId()
                        + "_" + System.currentTimeMillis() + extension;

                // Delete old image file
                String oldImage = student.getImage();
                if (oldImage != null && !oldImage.isEmpty()) {
                    new File(appPath + File.separator + oldImage).delete();
                }

                filePart.write(savePath + File.separator + fileName);
                String relativePath = IMAGE_DIR + "/" + fileName;

                if (dao.updateImage(student.getStudentId(), relativePath)) {
                    student.setImage(relativePath);
                    session.setAttribute("student", student);
                    request.setAttribute("success", "Profile picture updated successfully.");
                } else {
                    request.setAttribute("error", "Failed to save image. Please try again.");
                }
                doGet(request, response);
                break;
            }

            // ── REMOVE IMAGE ─────────────────────────────────────────────────
            case "removeImage": {
                String oldImage = student.getImage();
                if (oldImage != null && !oldImage.isEmpty()) {
                    new File(getServletContext().getRealPath("") + File.separator + oldImage).delete();
                }
                if (dao.updateImage(student.getStudentId(), "")) {
                    student.setImage("");
                    session.setAttribute("student", student);
                    request.setAttribute("success", "Profile picture removed.");
                } else {
                    request.setAttribute("error", "Failed to remove image. Please try again.");
                }
                doGet(request, response);
                break;
            }

            default:
                request.setAttribute("error", "Unknown action.");
                doGet(request, response);
        }
    }
}