package com.SkolaStudentManagement.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

import com.SkolaStudentManagement.model.DashboardData;
import com.SkolaStudentManagement.model.SettingsStudentModel;
import com.SkolaStudentManagement.service.StudentDashboardService;
import com.SkolaStudentManagement.service.StudentsSettingService;

/**
 * Serves the student dashboard.
 * Only APPROVED students may access it; PENDING students are redirected
 * to their own details/view page.
 */
@WebServlet("/student/dashboard")
public class StudentDashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final StudentDashboardService dashboardService = new StudentDashboardService();
    private final StudentsSettingService  settingService   = new StudentsSettingService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ── 1. Session guard — LoginServlet stores "studentId", not "student"
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("studentId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // ── 2. Reconstruct SettingsStudentModel from session attributes
        int studentId = (int) session.getAttribute("studentId");
        SettingsStudentModel student = settingService.getStudentById(studentId);

        if (student == null) {
            // Should not happen — guard anyway
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // PENDING students cannot access the full dashboard
        String status = (String) session.getAttribute("studentStatus");
        if (!"APPROVED".equalsIgnoreCase(status)) {
            // FIX: Removed duplicate 'Object studentId' declaration. 
            // We reuse the primitive 'studentId' from above since it's guaranteed to be populated.
            String redirect = request.getContextPath() + "/student/details?id=" + studentId;
            response.sendRedirect(redirect);
            return;
        }

        // ── 3. Service builds all dashboard data
        DashboardData data = dashboardService.getDashboardData(student);

        // ── 4. Put on request — JSP reads these
        request.setAttribute("student",       data.getStudent());
        request.setAttribute("todayDay",      data.getTodayDay());
        request.setAttribute("todaySchedule", data.getTodaySchedule());
        request.setAttribute("announcements", data.getAnnouncements());
        request.setAttribute("notes",         data.getNotes());

        // ── 5. Forward to JSP (correct path)
        request.getRequestDispatcher("/WEB-INF/pages/Studentdashboard.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}