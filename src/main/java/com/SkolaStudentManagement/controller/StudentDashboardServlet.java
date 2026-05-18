package com.SkolaStudentManagement.controller;

import com.SkolaStudentManagement.DAO.AnnouncementDAO;
import com.SkolaStudentManagement.DAO.NotesDAO;
import com.SkolaStudentManagement.DAO.ScheduleDAO;
import com.SkolaStudentManagement.Model.AnnouncementModel;
import com.SkolaStudentManagement.Model.ScheduleModel;
import com.SkolaStudentManagement.Model.SettingsStudentModel;
import com.SkolaStudentManagement.Model.Viewnotes;
import com.SkolaStudentManagement.utils.SessionUtil;
import com.SkolaStudentManagement.Model.Notes;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.TextStyle;
import java.util.List;
import java.util.Locale;

@WebServlet(asyncSupported = true, urlPatterns = { "/StudentDashboardServlet" })
public class StudentDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("student") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        SettingsStudentModel student =
                (SettingsStudentModel) session.getAttribute("student");
        request.setAttribute("student", student);

        // ── Today's day name — must match exactly what's stored in DB
        // e.g. "Monday", "Tuesday" etc.
        String todayDay = LocalDate.now()
                .getDayOfWeek()
                .getDisplayName(TextStyle.FULL, Locale.ENGLISH); // "Monday"
        request.setAttribute("todayDay", todayDay);

        // ── Today's schedule filtered by student's section and today's day
        try {
            ScheduleDAO scheduleDAO = new ScheduleDAO();
            List<ScheduleModel> todaySchedule =
                    scheduleDAO.getScheduleBySection(student.getSectionId());

            // Filter to only today's entries
            todaySchedule.removeIf(s -> !todayDay.equalsIgnoreCase(s.getDay()));
            request.setAttribute("todaySchedule", todaySchedule);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("todaySchedule", List.of());
        }

        // ── Latest 3 announcements
        try {
            AnnouncementDAO announcementDAO = new AnnouncementDAO();
            List<AnnouncementModel> announcements =
                    announcementDAO.getLatestAnnouncements(3);
            request.setAttribute("announcements", announcements);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("announcements", List.of());
        }

     // ── Latest 3 notes for this student
        try {
            NotesDAO notesDAO = new NotesDAO();
            List<Notes> notes = notesDAO.getNotesByStudentId(student.getStudentId());
            if (notes.size() > 3) notes = notes.subList(0, 3);
            request.setAttribute("notes", notes);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("notes", List.of());
        }
        request.getRequestDispatcher("/WEB-INF/Studentdashboard.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}