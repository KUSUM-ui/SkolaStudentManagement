package com.SkolaStudentManagement.controller;

import com.SkolaStudentManagement.Model.SettingsStudentModel;
import com.SkolaStudentManagement.Service.SettingsStudentService;
import com.SkolaStudentManagement.utils.ImageUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.IOException;

@WebServlet(urlPatterns = { "/student/Settings" })
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize       = 5  * 1024 * 1024,
        maxRequestSize    = 10 * 1024 * 1024
)
public class SettingsStudentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final SettingsStudentService service = new SettingsStudentService();

    // ── GET ───────────────────────────────────────────────────────────
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("student") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.setAttribute("student", session.getAttribute("student"));
        request.getRequestDispatcher("/WEB-INF/settings_student.jsp")
               .forward(request, response);
    }

    // ── POST ──────────────────────────────────────────────────────────
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("student") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        SettingsStudentModel student =
                (SettingsStudentModel) session.getAttribute("student");

        String action = request.getParameter("action");
        if (action == null) action = "";

        switch (action) {

            // ── Upload profile image ──────────────────────────────────
            case "updateImage": {
                try {
                    Part imagePart = request.getPart("image");
                    if (imagePart == null || imagePart.getSize() == 0) {
                        request.setAttribute("error", "Please choose a photo first.");
                        break;
                    }

                    // Saves to uploads/profiles/uuid.jpg inside webapp root
                    // Returns relative path e.g. "uploads/profiles/uuid.jpg"
                    String webappRoot = request.getServletContext().getRealPath("");
                    String savedPath  = ImageUtil.saveImage(
                            imagePart, webappRoot, ImageUtil.PROFILE_DIR);

                    if (savedPath == null) {
                        request.setAttribute("error", "Upload failed. Please try again.");
                        break;
                    }

                    boolean ok = service.updateImage(student.getStudentId(), savedPath);
                    if (ok) {
                        student.setImage(savedPath);
                        session.setAttribute("student", student);
                        request.setAttribute("success", "Profile photo updated.");
                    } else {
                        request.setAttribute("error", "Could not save photo. Please try again.");
                    }

                } catch (IllegalArgumentException e) {
                    // ImageUtil throws this for wrong type or oversized file
                    request.setAttribute("error", e.getMessage());
                }
                break;
            }

            // ── Remove profile image ──────────────────────────────────
            case "removeImage": {
                boolean ok = service.removeImage(student.getStudentId());
                if (ok) {
                    student.setImage(null);
                    session.setAttribute("student", student);
                    request.setAttribute("success", "Profile photo removed.");
                } else {
                    request.setAttribute("error", "Could not remove photo. Please try again.");
                }
                break;
            }

            // ── Update phone ──────────────────────────────────────────
            case "updatePhone": {
                String phone = request.getParameter("phone");
                boolean ok = service.updatePhone(student.getStudentId(), phone);
                if (ok) {
                    student.setPhone(phone != null ? phone.trim() : "");
                    session.setAttribute("student", student);
                    request.setAttribute("success", "Phone number updated.");
                } else {
                    request.setAttribute("error",
                            "Invalid phone number. Use 7–15 digits, optionally starting with +.");
                }
                break;
            }

            // ── Change password ───────────────────────────────────────
            case "updatePassword": {
                String current = request.getParameter("currentPassword");
                String newPwd  = request.getParameter("newPassword");
                String confirm = request.getParameter("confirmPassword");

                boolean ok = service.updatePassword(
                        student.getStudentId(),
                        current  != null ? current : "",
                        newPwd   != null ? newPwd  : "",
                        confirm  != null ? confirm : "",
                        student.getPassword()   // actual password from session
                );

                if (ok) {
                    student.setPassword(newPwd);
                    session.setAttribute("student", student);
                    request.setAttribute("success", "Password updated successfully.");
                } else {
                    request.setAttribute("error",
                            "Password update failed. Check current password, " +
                            "confirm match, and minimum 6 characters.");
                }
                break;
            }

            default:
                request.setAttribute("error", "Unknown action.");
        }

        // Always reload fresh student from DB so page reflects latest data
        SettingsStudentModel fresh =
                service.getStudentById(student.getStudentId());
        if (fresh != null) {
            session.setAttribute("student", fresh);
            request.setAttribute("student", fresh);
        } else {
            request.setAttribute("student", student);
        }

        request.getRequestDispatcher("/WEB-INF/settings_student.jsp")
               .forward(request, response);
    }

}