package com.SkolaStudentManagement.controller;

import java.io.IOException;

import com.SkolaStudentManagement.model.StudentModel;
import com.SkolaStudentManagement.service.StudentService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Read-only view of a student's own details.
 * Accessible by both PENDING and APPROVED students.
 * Students may only view their own record (enforced by session check).
 */
@WebServlet("/student/details")
public class StudentDetailsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final StudentService studentService = new StudentService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Must be logged in as a student
        if (session == null || !"student".equals(session.getAttribute("userRole"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Object sessionStudentId = session.getAttribute("studentId");
        if (sessionStudentId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int ownId = (int) sessionStudentId;

        // Parse requested id — students can only see their own record
        String idParam = request.getParameter("id");
        int requestedId = ownId; // default to own id
        if (idParam != null && !idParam.isEmpty()) {
            try { requestedId = Integer.parseInt(idParam); }
            catch (NumberFormatException ignored) {}
        }

        // Security: students cannot view another student's details
        if (requestedId != ownId) {
            response.sendRedirect(request.getContextPath()
                + "/student/details?id=" + ownId);
            return;
        }

        try {
            StudentModel student = studentService.getStudentById(ownId);
            request.setAttribute("student", student);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Could not load your details.");
        }

        // Show pending notice if account is still awaiting approval
        String status = (String) session.getAttribute("studentStatus");
        if (!"APPROVED".equalsIgnoreCase(status)) {
            request.setAttribute("pendingNotice",
                "Your registration is pending admin approval. "
              + "Some features will be unlocked once approved.");
        }

        request.getRequestDispatcher("/WEB-INF/pages/StudentSelfView.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
