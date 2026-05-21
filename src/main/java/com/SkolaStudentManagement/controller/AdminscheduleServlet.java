package com.SkolaStudentManagement.controller;

import com.SkolaStudentManagement.model.Schedule;
import com.SkolaStudentManagement.service.ScheduleService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@WebServlet("/admin/schedule")
public class AdminscheduleServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final ScheduleService service = new ScheduleService();

    private static final String[] DAYS = {
            "Sunday",
            "Monday",
            "Tuesday",
            "Wednesday",
            "Thursday"
    };

    private static final int SLOTS = 2;
    private boolean isAdmin(HttpServletRequest request) {
        HttpSession s = request.getSession(false);
        return s != null && "admin".equals(s.getAttribute("userRole"));
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String selectedFaculty   = request.getParameter("faculty");
        String selectedSection   = request.getParameter("section");
        String selectedSemester  = request.getParameter("semester");
        String successMsg        = request.getParameter("success");
        String errorMsg          = request.getParameter("error");

        try {

            // ===== Static Data =====
            request.setAttribute("timeList", service.getTimeList());
            request.setAttribute("days", service.getDays());
            request.setAttribute("slots", service.getSlots());
            request.setAttribute("faculties", service.getAllFaculties());

            // Semester list
            List<Integer> semesterList =
                    Arrays.asList(1, 2, 3, 4, 5, 6);

            request.setAttribute("semesterList", semesterList);

            // ===== Faculty + Semester =====
            if (selectedFaculty != null && !selectedFaculty.isEmpty()
                    && selectedSemester != null && !selectedSemester.isEmpty()) {

                int facultyId = Integer.parseInt(selectedFaculty);
                int semester  = Integer.parseInt(selectedSemester);

                // Sections
                request.setAttribute(
                        "sections",
                        service.getSectionsByFaculty(facultyId)
                );

                // Modules
                request.setAttribute(
                        "modules",
                        service.getModulesByFaculty(facultyId, semester)
                );
            }

            // ===== Schedule =====
            if (selectedSection != null && !selectedSection.isEmpty()) {

                request.setAttribute(
                        "scheduleMap",
                        service.getScheduleMap(selectedSection)
                );
            }

        } catch (SQLException e) {

            e.printStackTrace();

            request.setAttribute(
                    "error",
                    "Database error: " + e.getMessage()
            );
        }

        // ===== Messages =====
        if (successMsg != null) {
            request.setAttribute("success", successMsg);
        }

        if (errorMsg != null) {
            request.setAttribute("error", errorMsg);
        }

        // ===== Selected Values =====
        request.setAttribute("selectedFaculty", selectedFaculty);
        request.setAttribute("selectedSection", selectedSection);
        request.setAttribute("selectedSemester", selectedSemester);

        request.getRequestDispatcher("/WEB-INF/pages/Admin-Schedule.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String sectionId = request.getParameter("section_id");
        String facultyId = request.getParameter("faculty_id");
        String semester  = request.getParameter("semester");

        List<Schedule> schedules = new ArrayList<>();

        for (String day : DAYS) {
            for (int slot = 0; slot < SLOTS; slot++) {
                String moduleId = request.getParameter("module_" + day + "_" + slot);
                String start    = request.getParameter("start_"  + day + "_" + slot);
                String end      = request.getParameter("end_"    + day + "_" + slot);

                if (moduleId == null || moduleId.isEmpty()) continue;
                if (start    == null || start.isEmpty())    continue;
                if (end      == null || end.isEmpty())      continue;

                Schedule sc = new Schedule();
                sc.setSectionId(sectionId);
                sc.setModuleId(Integer.parseInt(moduleId));
                sc.setDay(day);
                sc.setStartTime(start);
                sc.setEndTime(end);
                schedules.add(sc);
            }
        }

        // ── Overlap validation (MUST be before saveSchedule) ──────────────
        String overlapError = validateNoOverlap(schedules);
        if (overlapError != null) {
            try {
                response.sendRedirect(
                    request.getContextPath()
                    + "/admin/schedule?faculty=" + facultyId
                    + "&semester=" + semester
                    + "&section=" + sectionId
                    + "&error=" + java.net.URLEncoder.encode(overlapError, "UTF-8")
                );
            } catch (IOException ex) {
                ex.printStackTrace();
            }
            return;
        }
        // ──────────────────────────────────────────────────────────────────

        try {
            service.saveSchedule(sectionId, schedules);
            response.sendRedirect(
                request.getContextPath()
                + "/admin/schedule?faculty=" + facultyId
                + "&semester=" + semester
                + "&section=" + sectionId
                + "&success=Schedule+saved+successfully."
            );
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(
                request.getContextPath()
                + "/admin/schedule?faculty=" + facultyId
                + "&semester=" + semester
                + "&section=" + sectionId
                + "&error=Failed+to+save+schedule."
            );
        }
    }

    private String validateNoOverlap(List<Schedule> schedules) {
        for (int i = 0; i < schedules.size(); i++) {
            for (int j = i + 1; j < schedules.size(); j++) {
                Schedule a = schedules.get(i);
                Schedule b = schedules.get(j);

                if (!a.getDay().equals(b.getDay())) continue;

                int aStart = toMinutes(a.getStartTime());
                int aEnd   = toMinutes(a.getEndTime());
                int bStart = toMinutes(b.getStartTime());
                int bEnd   = toMinutes(b.getEndTime());

                if (aEnd <= aStart) {
                    return "Slot on " + a.getDay() + ": end time must be after start time.";
                }
                if (bEnd <= bStart) {
                    return "Slot on " + b.getDay() + ": end time must be after start time.";
                }

                if (aStart < bEnd && aEnd > bStart) {
                    return "Time overlap on " + a.getDay() + ": "
                         + a.getStartTime() + "–" + a.getEndTime()
                         + " conflicts with "
                         + b.getStartTime() + "–" + b.getEndTime() + ".";
                }
            }
        }
        return null;
    }

    private int toMinutes(String time) {
        String[] parts = time.split(":");
        return Integer.parseInt(parts[0]) * 60 + Integer.parseInt(parts[1]);
    }
}