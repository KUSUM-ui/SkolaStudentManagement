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

@WebServlet("/admin/students/edit")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize       = 5 * 1024 * 1024,
    maxRequestSize    = 10 * 1024 * 1024
)
public class EditStudentDetailsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final StudentService studentService = new StudentService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                int studentId = Integer.parseInt(idParam.trim());
                StudentModel student = studentService.getStudentById(studentId);
                request.setAttribute("student", student);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Error loading profile details: " + e.getMessage());
            }
        }
        request.getRequestDispatcher("/WEB-INF/pages/Edit.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String studentIdParam = request.getParameter("studentId");
        
        int studentId = 0;
        if (studentIdParam != null && !studentIdParam.trim().isEmpty()) {
            try {
                studentId = Integer.parseInt(studentIdParam.trim());
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Invalid Student ID format.");
                request.getRequestDispatcher("/WEB-INF/pages/Edit.jsp").forward(request, response);
                return;
            }
        }

        if ("remove".equals(action)) {
            try {
                studentService.removeStudent(studentId);
                response.sendRedirect(request.getContextPath() + "/admin/students/view?successMessage=Student+removed+successfully");
                return;
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Removal action aborted: " + e.getMessage());
                forwardToEdit(studentId, request, response);
                return;
            }
        }

        try {
            StudentModel existingStudent = studentService.getStudentById(studentId);
            
            String firstName  = request.getParameter("firstName");
            String lastName   = request.getParameter("lastName");
            String email      = request.getParameter("email");
            String phone      = request.getParameter("phone");
            String dob        = request.getParameter("dob");
            String gender     = request.getParameter("gender");
            String facultyId  = existingStudent.getFacultyId();
            String gradeLevel = request.getParameter("gradeLevel");
            String sectionId  = request.getParameter("sectionId");
            
            String imagePath = existingStudent.getImage();
            Part filePart = request.getPart("image");
            
            if (filePart != null && filePart.getSize() > 0) {
                ImageUtil util = new ImageUtil();
                boolean uploadSuccess = util.uploadImage(filePart, request, "profiles");
                if (uploadSuccess) {
                    String saved = (String) request.getAttribute("dbSavedPath");
                    if (saved != null) {
                        imagePath = saved;
                        studentService.updateStudentImage(studentId, imagePath);
                    }
                }
            }

            studentService.updateStudent(
                studentId, firstName, lastName, email, phone,
                dob, gender, facultyId, sectionId, gradeLevel
            );

            // Handle password change submitted from Edit.jsp.
            // oldPassword verification is skipped for admin — admins have authority
            // to reset a student's password directly without knowing the current one.
            String newPassword = request.getParameter("newPassword");
            if (newPassword != null && !newPassword.trim().isEmpty()) {
                if (newPassword.trim().length() < 6) {
                    request.setAttribute("errorMessage", "New password must be at least 6 characters.");
                    forwardToEdit(studentId, request, response);
                    return;
                }
                studentService.updateStudentPassword(studentId, PasswordUtil.getHashPassword(newPassword.trim()));
            }

            request.setAttribute("successMessage", "Profile parameters updated successfully!");
            forwardToEdit(studentId, request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Update execution failed: " + e.getMessage());
            forwardToEdit(studentId, request, response);
        }
    }

    private void forwardToEdit(int studentId, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            StudentModel student = studentService.getStudentById(studentId);
            request.setAttribute("student", student);
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.getRequestDispatcher("/WEB-INF/pages/Edit.jsp").forward(request, response);
    }
}