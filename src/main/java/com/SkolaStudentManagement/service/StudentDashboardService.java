package com.SkolaStudentManagement.service;

import java.time.LocalDate;
import java.time.format.TextStyle;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;

import com.SkolaStudentManagement.dao.AnnouncementDAO;
import com.SkolaStudentManagement.dao.NotesDAO;
import com.SkolaStudentManagement.dao.ScheduleDAO;
import com.SkolaStudentManagement.model.Announcements;
import com.SkolaStudentManagement.model.DashboardData;
import com.SkolaStudentManagement.model.Notes;
import com.SkolaStudentManagement.model.Schedule;
import com.SkolaStudentManagement.model.SettingsStudentModel;

public class StudentDashboardService {

    private final ScheduleDAO scheduleDAO = new ScheduleDAO();
    private final AnnouncementDAO announcementDAO = new AnnouncementDAO();
    private final NotesDAO notesDAO = new NotesDAO();

    /**
     * Builds and returns everything the dashboard JSP needs.
     *
     * @param student the logged-in student from session
     * @return DashboardData with all fields populated
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

            List<Schedule> schedule =
                    scheduleDAO.getScheduleBySection(student.getSectionId());

            // Keep only rows matching today
            Iterator<Schedule> iterator = schedule.iterator();

            while (iterator.hasNext()) {

                Schedule s = iterator.next();

                if (!todayDay.equalsIgnoreCase(s.getDay())) {
                    iterator.remove();
                }
            }

            data.setTodaySchedule(schedule);

        } catch (Exception e) {

            e.printStackTrace();
            data.setTodaySchedule(List.of());
        }

        // ── Latest 3 announcements
        try {

            List<Announcements> announcements =
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