package com.SkolaStudentManagement.controller;

import com.SkolaStudentManagement.Model.DashboardData;
import com.SkolaStudentManagement.Model.SettingsStudentModel;
import com.SkolaStudentManagement.Service.DashboardService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(urlPatterns = { "/student/Dashboard" })
public class StudentDashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final DashboardService dashboardService = new DashboardService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ── 1. Session guard
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("student") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // ── 2. Get student from session
        SettingsStudentModel student =
                (SettingsStudentModel) session.getAttribute("student");

        // ── 3. Service builds all dashboard data
        DashboardData data = dashboardService.getDashboardData(student);

        // ── 4. Put on request — JSP reads these
        request.setAttribute("student",       data.getStudent());
        request.setAttribute("todayDay",      data.getTodayDay());
        request.setAttribute("todaySchedule", data.getTodaySchedule());
        request.setAttribute("announcements", data.getAnnouncements());
        request.setAttribute("notes",         data.getNotes());

        // ── 5. Forward to JSP
        request.getRequestDispatcher("/WEB-INF/Studentdashboard.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}