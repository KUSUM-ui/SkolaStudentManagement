package com.SkolaStudentManagement.controller;

import java.io.IOException;
import java.util.List;

import com.SkolaStudentManagement.model.StudentModel;
import com.SkolaStudentManagement.service.RegisterService; // FIXED: Interacting ONLY with service layer

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Handles the Student Registration Approvals page.
 *
 * GET  /admin/students/approvals               → show pending / approved / rejected tabs
 * POST /admin/students/approvals/approve       → approve one registration
 * POST /admin/students/approvals/reject        → reject  one registration
 */
@WebServlet(urlPatterns = {
    "/admin/students/approvals",
    "/admin/students/approvals/approve",
    "/admin/students/approvals/reject"
})
public class StudentApprovalServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    
    // FIXED: Initialized Service Layer instance to decouple DAO access
    private final RegisterService registerService = new RegisterService();

    // ── GET ────────────────────────────────────────────────────────────────
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // FIXED: Lookups are wrapped cleanly via registerService layer methods
            List<StudentModel> pending  = registerService.getStudentsByStatus("PENDING");
            List<StudentModel> approved = registerService.getStudentsByStatus("APPROVED");
            List<StudentModel> rejected = registerService.getStudentsByStatus("REJECTED");

            request.setAttribute("pendingRegistrations",  pending);
            request.setAttribute("approvedRegistrations", approved);
            request.setAttribute("rejectedRegistrations", rejected);
            request.setAttribute("pendingCount",          pending.size());
            request.setAttribute("approvedCount",         approved.size());
            request.setAttribute("rejectedCount",         rejected.size());

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Failed to load registrations: " + e.getMessage());
        }

        request.getRequestDispatcher("/WEB-INF/pages/StudentRegistrationApproval.jsp")
               .forward(request, response);
    }

    // ── POST ───────────────────────────────────────────────────────────────
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();   
        String idParam = request.getParameter("registrationId");

        try {
            if (idParam != null && !idParam.trim().isEmpty()) {
                int studentId = Integer.parseInt(idParam.trim());

                // FIXED: Direct DAO execution removed. Now processing changes through the Service layer.
                if (path.endsWith("/approve")) {
                    registerService.updateStudentStatus(studentId, "APPROVED");
                } else if (path.endsWith("/reject")) {
                    registerService.updateStudentStatus(studentId, "REJECTED");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/admin/students/approvals");
    }
}