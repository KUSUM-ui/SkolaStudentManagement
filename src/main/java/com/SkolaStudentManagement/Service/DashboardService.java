package com.SkolaStudentManagement.Service;

import com.SkolaStudentManagement.DAO.AnnouncementDAO;
import com.SkolaStudentManagement.DAO.NotesDAO;
import com.SkolaStudentManagement.DAO.ScheduleDAO;
import com.SkolaStudentManagement.Model.AnnouncementModel;
import com.SkolaStudentManagement.Model.DashboardData;
import com.SkolaStudentManagement.Model.Notes;
import com.SkolaStudentManagement.Model.ScheduleModel;
import com.SkolaStudentManagement.Model.SettingsStudentModel;

import java.time.LocalDate;
import java.time.format.TextStyle;
import java.util.List;
import java.util.Locale;

/**
 * Service for the student dashboard.
 * Servlet calls this → this calls DAOs → DAOs query DB.
 * No logic lives in the servlet or JSP.
 */
public class DashboardService {

    private final ScheduleDAO      scheduleDAO      = new ScheduleDAO();
    private final AnnouncementDAO  announcementDAO  = new AnnouncementDAO();
    private final NotesDAO         notesDAO         = new NotesDAO();

    /**
     * Builds and returns everything the dashboard JSP needs.
     *
     * @param student  the logged-in student from session
     * @return         DashboardData with all fields populated
     */
    public DashboardData getDashboardData(SettingsStudentModel student) {
        DashboardData data = new DashboardData();

        data.setStudent(student);

        // ── Today's day name (e.g. "Wednesday")
        String todayDay = LocalDate.now()
                .getDayOfWeek()
                .getDisplayName(TextStyle.FULL, Locale.ENGLISH);
        data.setTodayDay(todayDay);

        // ── Today's schedule for the student's section
        try {
            List<ScheduleModel> schedule =
                    scheduleDAO.getScheduleBySection(student.getSectionId());
            // Keep only rows matching today — day column e.g. "Wednesday"
            schedule.removeIf(s -> !todayDay.equalsIgnoreCase(s.getDay()));
            data.setTodaySchedule(schedule);
        } catch (Exception e) {
            e.printStackTrace();
            data.setTodaySchedule(List.of());
        }

        // ── Latest 3 announcements
        try {
            List<AnnouncementModel> announcements =
                    announcementDAO.getLatestAnnouncements(3);
            data.setAnnouncements(announcements);
        } catch (Exception e) {
            e.printStackTrace();
            data.setAnnouncements(List.of());
        }

        // ── Latest 3 notes for this student
        try {
            List<Notes> notes =
                    notesDAO.getNotesByStudentId(student.getStudentId());
            if (notes.size() > 3) {
                notes = notes.subList(0, 3);
            }
            data.setNotes(notes);
        } catch (Exception e) {
            e.printStackTrace();
            data.setNotes(List.of());
        }

        return data;
    }
}