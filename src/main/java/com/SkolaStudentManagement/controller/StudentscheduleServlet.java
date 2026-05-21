package com.SkolaStudentManagement.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import com.SkolaStudentManagement.model.Schedule;
import com.SkolaStudentManagement.service.ScheduleService;

@WebServlet("/student/schedule")
public class StudentscheduleServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final ScheduleService scheduleService = new ScheduleService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("studentId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // System fallback chain: checks common naming keys used during authentication
        String sectionId = (String) session.getAttribute("studentSectionId");
        if (sectionId == null) {
            sectionId = (String) session.getAttribute("sectionId");
        }
        if (sectionId == null) {
            sectionId = (String) session.getAttribute("studentSection");
        }

        System.out.println("[Skola Debug] Checked session sectionId value resolved to: " + sectionId);

        if (sectionId != null && !sectionId.trim().isEmpty()) {
            try {
                List<Schedule> scheduleList = scheduleService.getScheduleBySection(sectionId.trim());
                System.out.println("[Skola Debug] Total schedule rows fetched: " + (scheduleList != null ? scheduleList.size() : 0));
                request.setAttribute("scheduleList", scheduleList);
            } catch (Exception e) {
                System.err.println("[Skola Error] Exception caught reading schedule matrix rows:");
                e.printStackTrace(); 
                request.setAttribute("scheduleError", "Could not load schedule due to data error.");
            }
        } else {
            request.setAttribute("scheduleError", "No section assigned to your student profile.");
        }

        request.getRequestDispatcher("/WEB-INF/pages/StudentSchedule.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}