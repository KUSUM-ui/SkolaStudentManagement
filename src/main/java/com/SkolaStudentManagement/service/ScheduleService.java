package com.SkolaStudentManagement.service;

import com.SkolaStudentManagement.dao.ScheduleDAO;
import com.SkolaStudentManagement.model.Faculty;
import com.SkolaStudentManagement.model.Module;
import com.SkolaStudentManagement.model.Schedule;
import com.SkolaStudentManagement.model.Section;
import com.SkolaStudentManagement.utils.DBconfig;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.*;

public class ScheduleService {

    private final ScheduleDAO dao = new ScheduleDAO();

    private static final String[] DAYS  = {"Sunday","Monday","Tuesday","Wednesday","Thursday"};
    private static final int      SLOTS = 2;

    /**
     * Validates a list of schedule entries for business-rule violations.
     * Returns an error message string if invalid, or null if valid.
     *
     * ARCHITECTURAL FIX: This validation was previously in AdminscheduleServlet
     * (MVC violation). All business rules must live in the Service layer.
     */
    public String validateSchedule(List<Schedule> schedules) {
        if (schedules == null || schedules.isEmpty()) return null;
        for (int i = 0; i < schedules.size(); i++) {
            Schedule a = schedules.get(i);
            if (a.getStartTime() == null || a.getEndTime() == null)
                return "Start and end times are required for all slots.";
            int aStart = toMinutes(a.getStartTime());
            int aEnd   = toMinutes(a.getEndTime());
            if (aEnd <= aStart)
                return "Slot on " + a.getDay() + ": end time must be after start time.";
            for (int j = i + 1; j < schedules.size(); j++) {
                Schedule b = schedules.get(j);
                if (!a.getDay().equals(b.getDay())) continue;
                int bStart = toMinutes(b.getStartTime());
                int bEnd   = toMinutes(b.getEndTime());
                if (bEnd <= bStart)
                    return "Slot on " + b.getDay() + ": end time must be after start time.";
                if (aStart < bEnd && aEnd > bStart)
                    return "Time overlap on " + a.getDay() + ": "
                         + a.getStartTime() + "–" + a.getEndTime()
                         + " conflicts with "
                         + b.getStartTime() + "–" + b.getEndTime() + ".";
            }
        }
        return null;
    }

    private int toMinutes(String time) {
        String[] parts = time.split(":");
        return Integer.parseInt(parts[0]) * 60 + Integer.parseInt(parts[1]);
    }

    public List<Schedule> getScheduleBySection(String sectionId) throws java.sql.SQLException {
        return dao.getScheduleBySection(sectionId);
    }

    public List<Faculty> getAllFaculties() throws SQLException {
        return dao.getAllFaculties();
    }

    public List<Section> getSectionsByFaculty(int facultyId) throws SQLException {
        return dao.getSectionsByFaculty(facultyId);
    }

    public List<Module> getModulesByFaculty(int facultyId, int semester) throws SQLException {
        return dao.getModulesByFacultyAndSemester(facultyId, semester);
    }
    public int getTotalFaculties() throws Exception {
        return dao.getTotalFaculties();
    }

    /**
     * Returns a map keyed "Sunday_0", "Sunday_1", "Monday_0" etc.
     * for easy EL lookup in the JSP.
     */
    public Map<String, Schedule> getScheduleMap(String sectionId) throws SQLException {
        List<Schedule> rows = dao.getScheduleBySection(sectionId);
        Map<String, Schedule> map = new LinkedHashMap<>();
        Map<String, Integer> dayCount = new LinkedHashMap<>();
        for (Schedule sc : rows) {
            String day  = sc.getDay();
            int    slot = dayCount.getOrDefault(day, 0);
            dayCount.put(day, slot + 1);
            if (slot < SLOTS) {
                map.put(day + "_" + slot, sc);
            }
        }
        return map;
    }

    /**
     * Delete + re-insert all schedule rows for a section in one transaction.
     */
    public void saveSchedule(String sectionId, List<Schedule> schedules) throws SQLException {
        try (Connection conn = DBconfig.getConnection()) {
            conn.setAutoCommit(false);
            try {
                dao.deleteScheduleBySection(conn, sectionId);
                dao.insertScheduleBatch(conn, schedules);
                conn.commit();
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            }
        }
    }

    public List<String> getTimeList() {
        List<String> list = new ArrayList<>();
        for (int h = 6; h <= 17; h++) {
            list.add(String.format("%02d:00", h));
            if (h < 17) list.add(String.format("%02d:30", h));
        }
        return list;
    }

    public List<String> getDays() {
        return Arrays.asList(DAYS);
    }

    public List<Integer> getSlots() {
        List<Integer> list = new ArrayList<>();
        for (int i = 0; i < SLOTS; i++) list.add(i);
        return list;
    }
}
