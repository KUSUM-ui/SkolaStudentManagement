package com.SkolaStudentManagement.controller;

import com.SkolaStudentManagement.model.SettingsAdminModel;
import com.SkolaStudentManagement.service.SettingsAdminService;
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

/**
 * Handles admin profile settings: profile info update, password change,
 * and profile photo upload. All three actions POST to this same servlet
 * with a hidden "action" field to distinguish them.
 */
@WebServlet(asyncSupported = true, urlPatterns = {"/admin/settings"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize       = 5 * 1024 * 1024,
    maxRequestSize    = 10 * 1024 * 1024
)
public class SettingsAdminServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final int  FIXED_ADMIN_ID   = 1;

    private final SettingsAdminService settingsAdminService = new SettingsAdminService();

    // ── GET: load and display admin profile ───────────────────────────────────
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("userRole"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            SettingsAdminModel admin = settingsAdminService.getAdmin();
            request.setAttribute("admin", admin);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Could not load admin details.");
        }
        request.getRequestDispatcher("/WEB-INF/pages/settings_admin.jsp").forward(request, response);
    }

    // ── POST: dispatch by action field ────────────────────────────────────────
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("userRole"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        try {
            if ("changePassword".equals(action)) {
                // ── Password change ──────────────────────────────────────────
                settingsAdminService.changePassword(
                        FIXED_ADMIN_ID,
                        request.getParameter("currentPassword"),
                        request.getParameter("newPassword"),
                        request.getParameter("confirmPassword")
                );
                request.setAttribute("successMessage", "Password updated successfully.");

        

            } else {
                // ── Profile info update (default action) ─────────────────────
                settingsAdminService.updateProfile(
                        FIXED_ADMIN_ID,
                        request.getParameter("firstName"),
                        request.getParameter("lastName"),
                        request.getParameter("email")
                );
                request.setAttribute("successMessage", "Profile updated successfully.");
            }

        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Unexpected error: " + e.getMessage());
        }

        // Reload admin data so the form reflects the latest values
        doGet(request, response);
    }
}
