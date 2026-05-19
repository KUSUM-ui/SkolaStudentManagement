package com.SkolaStudentManagement.Service;

import com.SkolaStudentManagement.DAO.ClassDAO;
import com.SkolaStudentManagement.DAO.ClassReservationDAO;
import com.SkolaStudentManagement.Model.ClassModel;
import com.SkolaStudentManagement.Model.Classreservationmodel;

import java.sql.Date;
import java.sql.Time;
import java.util.List;

public class ClassReservationService {

    private final ClassReservationDAO dao      = new ClassReservationDAO();
    private final ClassDAO            classDAO = new ClassDAO();

    // ── Fetch classes for dropdown ────────────────────────────────────

    public List<ClassModel> getAllClasses() {
        return classDAO.getAllClasses();
    }

    // ── Student: validate and submit a new reservation ────────────────

    /**
     * @return null on success, or a user-facing error message on failure.
     */
    public String submitReservation(int    studentId,
                                    String firstName,
                                    String classIdStr,
                                    String dateStr,
                                    String timeFrom,
                                    String timeTo,
                                    String comment) {

        if (isBlank(firstName))  return "First name is required.";
        if (isBlank(classIdStr)) return "Please select a class.";
        if (isBlank(dateStr))    return "Date is required.";
        if (isBlank(timeFrom))   return "Start time is required.";
        if (isBlank(timeTo))     return "End time is required.";

        // Parse class ID
        int classId;
        try {
            classId = Integer.parseInt(classIdStr);
        } catch (NumberFormatException e) {
            return "Invalid class selection.";
        }

        // Parse date
        Date date;
        try {
            date = Date.valueOf(dateStr);
        } catch (IllegalArgumentException e) {
            return "Invalid date format. Please use the date picker.";
        }

        // Parse times
        Time from;
        Time to;
        try {
            from = Time.valueOf(timeFrom + ":00");
            to   = Time.valueOf(timeTo   + ":00");
        } catch (IllegalArgumentException e) {
            return "Invalid time format. Please use the time picker.";
        }

        if (!to.after(from)) {
            return "End time must be after start time.";
        }

        // Build and persist
        Classreservationmodel r = new Classreservationmodel();
        r.setStudentId(studentId);
        r.setFirstName(firstName.trim());
        r.setClassId  (classId);
        r.setDate     (date);
        r.setTimeFrom (from);
        r.setTimeTo   (to);
        r.setComment  (comment != null ? comment.trim() : "");

        boolean saved = dao.addReservation(r);
        return saved ? null : "Failed to submit reservation. Please try again.";
    }

    // ── Student: fetch own reservations ───────────────────────────────

    public List<Classreservationmodel> getReservationsByStudent(int studentId) {
        return dao.getReservationsByStudent(studentId);
    }

    // ── Admin: fetch all reservations ─────────────────────────────────

    public List<Classreservationmodel> getAllReservations() {
        return dao.getAllReservations();
    }

    // ── Admin: approve or disapprove ──────────────────────────────────

    public String updateStatus(int reservationId, String status) {
        if (!"Approved".equals(status) && !"Disapproved".equals(status)) {
            return "Invalid status value.";
        }
        boolean updated = dao.updateStatus(reservationId, status);
        return updated ? null : "Failed to update status. Please try again.";
    }

    // ── Private helpers ───────────────────────────────────────────────

    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }
}