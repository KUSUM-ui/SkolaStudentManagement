package com.SkolaStudentManagement.controller;

import java.io.IOException;
import java.util.List;

import com.SkolaStudentManagement.model.Announcements;
import com.SkolaStudentManagement.model.StudentModel;
import com.SkolaStudentManagement.service.AnnouncementService;
import com.SkolaStudentManagement.service.ClassReservationService;
import com.SkolaStudentManagement.service.ScheduleService;
import com.SkolaStudentManagement.service.StudentService;
import com.SkolaStudentManagement.utils.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

/**
 * Serves the admin dashboard page.
 * Loads summary stats, pending students, and recent announcements.
 */
@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private final AnnouncementService announcementService = new AnnouncementService();
    private final StudentService studentService           = new StudentService();
    private final ScheduleService scheduleService         = new ScheduleService();
    private final ClassReservationService reservationService = new ClassReservationService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null ||
            session.getAttribute("userRole") == null ||
            !"admin".equals(session.getAttribute("userRole"))) {

            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Resolve admin display name
        Object nameAttr = session.getAttribute("userName");
        if (nameAttr == null) nameAttr = session.getAttribute("adminName");
        req.setAttribute("adminName", nameAttr != null ? nameAttr : "Admin");

        // Transfer session flash messages to request, then clear them
        Object success = session.getAttribute("successMessage");
        Object error   = session.getAttribute("errorMessage");
        if (success != null) {
            req.setAttribute("successMessage", success);
            session.removeAttribute("successMessage");
        }
        if (error != null) {
            req.setAttribute("errorMessage", error);
            session.removeAttribute("errorMessage");
        }

        try {
            // Announcements
            List<Announcements> announcements = announcementService.getAllAnnouncements();
            req.setAttribute("recentAnnouncements", announcements);
            req.setAttribute("totalAnnouncements", announcements.size());

            // Students
            List<StudentModel> pendingStudents = studentService.getPendingStudents();
            req.setAttribute("pendingStudents", pendingStudents);
            req.setAttribute("pendingCount", pendingStudents != null ? pendingStudents.size() : 0);

            int approved = studentService.getTotalApprovedStudents();
            int pending  = studentService.getTotalPendingStudents();
            req.setAttribute("approvedCount", approved);
            req.setAttribute("pendingStudentCount", pending);
            req.setAttribute("totalStudents", approved + pending);

            // Faculties and classes
            req.setAttribute("totalFaculties", scheduleService.getTotalFaculties());
            req.setAttribute("totalClasses", 0); // safe fallback until ClassDAO is wired

            // Reservations
            req.setAttribute("totalReservations", reservationService.getTotalReservations());
            req.setAttribute("pendingReservations", reservationService.getPendingCount());

            req.getRequestDispatcher("/WEB-INF/pages/dashboard-admin.jsp")
               .forward(req, resp);

        } catch (Exception e) {
            throw new ServletException("Error loading admin dashboard", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Dashboard POST now delegates announcement creation to AnnouncementServlet
        // via form action="/admin/announcements" — this handler is kept for safety
        resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
    }
}
