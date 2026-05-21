package com.SkolaStudentManagement.controller;

import java.io.IOException;
import java.util.List;

import com.SkolaStudentManagement.model.StudentModel;
import com.SkolaStudentManagement.service.StudentService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Serves the admin students overview page with total and pending counts.
 * Also handles the session flash message set by RegisterServlet after a redirect.
 */
@WebServlet("/admin/students")
public class AdminStudentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final StudentService studentService = new StudentService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("userRole"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Transfer flash messages from session to request scope, then remove them.
        // This ensures they appear only once and never leak to unrelated pages.
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

        try {
            int totalStudents = studentService.getTotalApprovedStudents();
            request.setAttribute("totalStudents", totalStudents);

            List<StudentModel> pending = studentService.getPendingStudents();
            request.setAttribute("pendingCount", pending != null ? pending.size() : 0);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Could not load student statistics.");
        }

        request.getRequestDispatcher("/WEB-INF/pages/AdminStudent.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
