package com.SkolaStudentManagement.controller;

import com.SkolaStudentManagement.Model.SettingsAdminModel;
import com.SkolaStudentManagement.Service.SettingsAdminService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(asyncSupported = true, urlPatterns = {"/SettingsAdminServlet"})
public class SettingsAdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final SettingsAdminService settingsAdminService = new SettingsAdminService();
    private static final int FIXED_ADMIN_ID = 1;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            SettingsAdminModel admin = settingsAdminService.getAdmin();
            request.setAttribute("admin", admin);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Could not load admin details.");
        }
        request.getRequestDispatcher("/WEB-INF/settings_admin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        try {
            if ("changePassword".equals(action)) {
                settingsAdminService.changePassword(
                        FIXED_ADMIN_ID,
                        request.getParameter("currentPassword"),
                        request.getParameter("newPassword"),
                        request.getParameter("confirmPassword")
                );
                request.setAttribute("successMessage", "Password updated successfully.");

            } else {
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

        doGet(request, response);
    }
}