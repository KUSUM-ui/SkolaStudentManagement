package com.SkolaStudentManagement.Service;

import com.SkolaStudentManagement.DAO.SettingsAdminDAO;
import com.SkolaStudentManagement.Model.SettingsAdminModel;

import java.sql.SQLException;

public class SettingsAdminService {

    private final SettingsAdminDAO settingsAdminDAO = new SettingsAdminDAO();

    // ── Fetch admin ───────────────────────────────────────────────────────────
    public SettingsAdminModel getAdmin() throws SQLException {
        SettingsAdminModel admin = settingsAdminDAO.getAdmin();
        if (admin == null) {
            throw new IllegalStateException("Admin record not found.");
        }
        return admin;
    }

    // ── Update profile ────────────────────────────────────────────────────────
    public boolean updateProfile(int adminId,
                                 String firstName,
                                 String lastName,
                                 String email) throws IllegalArgumentException, SQLException {

        if (firstName == null || firstName.trim().isEmpty())
            throw new IllegalArgumentException("First name is required.");
        if (lastName == null || lastName.trim().isEmpty())
            throw new IllegalArgumentException("Last name is required.");
        if (email == null || !email.contains("@"))
            throw new IllegalArgumentException("A valid email address is required.");

        SettingsAdminModel admin = new SettingsAdminModel();
        admin.setAdminId(adminId);
        admin.setFirstName(firstName.trim());
        admin.setLastName(lastName.trim());
        admin.setEmail(email.trim());

        return settingsAdminDAO.updateProfile(admin);
    }

    // ── Change password ───────────────────────────────────────────────────────
    public boolean changePassword(int adminId,
                                  String currentPassword,
                                  String newPassword,
                                  String confirmPassword) throws IllegalArgumentException, SQLException {

        if (currentPassword == null || currentPassword.isEmpty())
            throw new IllegalArgumentException("Current password is required.");
        if (newPassword == null || newPassword.length() < 6)
            throw new IllegalArgumentException("New password must be at least 6 characters.");
        if (!newPassword.equals(confirmPassword))
            throw new IllegalArgumentException("New passwords do not match.");
        if (!settingsAdminDAO.verifyPassword(adminId, currentPassword))
            throw new IllegalArgumentException("Current password is incorrect.");

        return settingsAdminDAO.updatePassword(adminId, newPassword);
    }
}