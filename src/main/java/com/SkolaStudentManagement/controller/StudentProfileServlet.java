package com.SkolaStudentManagement.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

import com.SkolaStudentManagement.model.StudentModel;
import com.SkolaStudentManagement.service.StudentService;
import com.SkolaStudentManagement.utils.ImageUtil;
import com.SkolaStudentManagement.utils.PasswordUtil;

/**
 * Handles the student's own profile settings page modifications.
 *
 * GET  → loads the student's current record and forwards to settings_student.jsp
 * POST → Routes actions modularly based on form submissions:
 * - "updatePhone"    → updates specific contact parameters 
 * - "updatePassword" → updates verified password credentials
 * - "updateImage"    → saves uploaded image via ImageUtil
 * - "removeImage"    → clears out user avatar record paths
 */
@WebServlet("/student/settings")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize       = 5  * 1024 * 1024,
    maxRequestSize    = 10 * 1024 * 1024
)
public class StudentProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final StudentService studentService = new StudentService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !"student".equals(session.getAttribute("userRole"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Integer studentId = (Integer) session.getAttribute("studentId");
        if (studentId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        if ("1".equals(request.getParameter("updated"))) {
            request.setAttribute("success", "Profile photo updated successfully.");
        } else if ("2".equals(request.getParameter("removed"))) {
            request.setAttribute("success", "Profile photo removed successfully.");
        }

        try {
            StudentModel student = studentService.getStudentById(studentId);
            request.setAttribute("student", student);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Could not load profile details.");
        }

        request.getRequestDispatcher("/WEB-INF/pages/settings_student.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !"student".equals(session.getAttribute("userRole"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Integer studentId = (Integer) session.getAttribute("studentId");
        if (studentId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        try {
            // FIXED: Synchronized matching case actions directly with the hidden fields in settings_student.jsp
            if ("updatePhone".equals(action)) {
                handlePhoneUpdate(request, studentId);

            } else if ("updatePassword".equals(action)) {
                handlePasswordChange(request, studentId);

            } else if ("updateImage".equals(action)) {
                handlePhotoUpdate(request, response, studentId);
                return; // Redirect handled inside method

            } else if ("removeImage".equals(action)) {
                handlePhotoRemoval(request, response, studentId);
                return; // Redirect handled inside method

            } else {
                throw new IllegalArgumentException("Invalid settings action requested.");
            }

        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An unexpected system error occurred. Please try again.");
        }

        // Forward back back down to doGet to render the updated state
        doGet(request, response);
    }

    //  Updates phone parameter explicitly using form data "number" attribute ──
    private void handlePhoneUpdate(HttpServletRequest request, int studentId) throws Exception {
        String number = request.getParameter("number");

        if (number == null || number.trim().isEmpty()) {
            throw new IllegalArgumentException("Phone number parameter cannot be blank.");
        }

        // Pull existing user records to preserve read-only attributes safely
        StudentModel existing = studentService.getStudentById(studentId);
        
        studentService.updateStudent(
            studentId,
            existing.getFirstName(), 
            existing.getLastName(),
            existing.getEmail(), 
            number.trim(), // Assign correct form input data safely
            existing.getDob() != null ? existing.getDob().toString() : null, 
            existing.getGender(),
            existing.getFacultyId(), 
            existing.getSectionId(), 
            existing.getGradeLevel()
        );

        request.setAttribute("success", "Contact number updated successfully.");
    }

    // ── FIXED: Synchronized parameters with updatePassword block elements ──
    private void handlePasswordChange(HttpServletRequest request, int studentId) throws Exception {
        String currentPassword = request.getParameter("currentPassword");
        String newPassword     = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (currentPassword == null || currentPassword.isEmpty() ||
            newPassword == null || newPassword.isEmpty()) {
            throw new IllegalArgumentException("Password input fields cannot be left empty.");
        }

        if (!newPassword.equals(confirmPassword)) {
            throw new IllegalArgumentException("New password configuration confirmation mismatch.");
        }

        StudentModel student = studentService.getStudentById(studentId);
        if (student == null || !PasswordUtil.checkPassword(currentPassword, student.getPassword())) {
            throw new IllegalArgumentException("Current account password entered is incorrect.");
        }

        studentService.updateStudentPassword(studentId, PasswordUtil.getHashPassword(newPassword));
        request.setAttribute("success", "Password changed and security records updated successfully.");
    }

    // ── FIXED: Synchronized action route targets with updateImage block elements ──
    private void handlePhotoUpdate(HttpServletRequest request, HttpServletResponse response, int studentId) throws Exception {
        Part filePart = request.getPart("image");
        if (filePart == null || filePart.getSize() == 0) {
            response.sendRedirect(request.getContextPath() + "/student/settings");
            return;
        }

        ImageUtil util = new ImageUtil();
        boolean uploadSuccess = util.uploadImage(filePart, request, "profiles");

        if (uploadSuccess) {
            String saved = (String) request.getAttribute("dbSavedPath");
            if (saved != null) {
                studentService.updateStudentImage(studentId, saved);
                request.getSession().setAttribute("studentAvatar", saved);
            }
        }

        response.sendRedirect(request.getContextPath() + "/student/settings?updated=1");
    }

    // ── ADDED: Explicit method wrapper targeting the removeImage execution request ──
    private void handlePhotoRemoval(HttpServletRequest request, HttpServletResponse response, int studentId) throws Exception {
        // Clear value inside the target student persistence records
        studentService.updateStudentImage(studentId, null);
        
        // Wipe path records stored inside memory session attributes
        request.getSession().setAttribute("studentAvatar", null);
        
        response.sendRedirect(request.getContextPath() + "/student/settings?removed=2");
    }
}