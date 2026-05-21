package com.SkolaStudentManagement.service;

import com.SkolaStudentManagement.dao.ClassReservationDAO;
import com.SkolaStudentManagement.model.ClassReservation;

import java.sql.Date;
import java.sql.Time;
import java.time.LocalDate;
import java.util.List;

/**
 * Service layer for Class Reservation.
 *
 * ALL validation lives here — never in the Servlet, never in the DAO.
 *
 * Status constants match what is stored in the DB by the existing DAO:
 * "Pending" / "Approved" / "Rejected"  (mixed-case, matching original DAO INSERT)
 */
public class ClassReservationService {

    private final ClassReservationDAO dao;

    // Status values that match the DAO / DB (mixed-case as in original INSERT)
    public static final String STATUS_PENDING  = "Pending";
    public static final String STATUS_APPROVED = "Approved";
    public static final String STATUS_REJECTED = "Rejected";

    public ClassReservationService() {
        this.dao = new ClassReservationDAO();
    }

    // ── Student: submit a new reservation ─────────────────────────────────────

    /**
     * Validates all fields and persists a new reservation with status = Pending.
     *
     * Validation rules (backend only, no JS/HTML required):
     * 1. studentId must be positive.
     * 2. classId must be positive (dropdown selection validation).
     * 3. firstName must not be blank.
     * 4. dateStr must parse to a valid date and must NOT be in the past.
     * 5. timeFrom and timeTo must be valid HH:mm values.
     * 6. timeFrom must be before timeTo.
     * 7. comment must not exceed 500 characters.
     *
     * @throws IllegalArgumentException for any validation failure (message shown to user)
     */
    public boolean addReservation(int studentId,
                                  int classId,       // <-- 1. ADDED CLASS ID PARAMETER
                                  String firstName,
                                  String dateStr,
                                  String timeFromStr,
                                  String timeToStr,
                                  String comment) {

        // 1. Student identity
        if (studentId <= 0) {
            throw new IllegalArgumentException("Invalid student session. Please log in again.");
        }

        // 2. Class Selection Dropdown Validation
        if (classId <= 0) {
            throw new IllegalArgumentException("Please select a valid class from the list.");
        }

        // 3. First name
        if (firstName == null || firstName.trim().isEmpty()) {
            throw new IllegalArgumentException("Name is required.");
        }

        // 4. Date — parse and future-date check
        if (dateStr == null || dateStr.trim().isEmpty()) {
            throw new IllegalArgumentException("Reservation date is required.");
        }
        Date reservationDate;
        try {
            reservationDate = Date.valueOf(dateStr.trim());
        } catch (IllegalArgumentException e) {
            throw new IllegalArgumentException("Invalid date format. Please select a valid date.");
        }
        if (reservationDate.toLocalDate().isBefore(LocalDate.now())) {
            throw new IllegalArgumentException("Reservation date must be today or in the future.");
        }

        // 5. Times
        if (timeFromStr == null || timeFromStr.trim().isEmpty()) {
            throw new IllegalArgumentException("Start time is required.");
        }
        if (timeToStr == null || timeToStr.trim().isEmpty()) {
            throw new IllegalArgumentException("End time is required.");
        }

        Time timeFrom;
        Time timeTo;
        try {
            // HTML time inputs give "HH:mm"; Time.valueOf needs "HH:mm:ss"
            timeFrom = Time.valueOf(normaliseTime(timeFromStr.trim()));
        } catch (IllegalArgumentException e) {
            throw new IllegalArgumentException("Invalid start time format.");
        }
        try {
            timeTo = Time.valueOf(normaliseTime(timeToStr.trim()));
        } catch (IllegalArgumentException e) {
            throw new IllegalArgumentException("Invalid end time format.");
        }

        // 6. Time order
        if (!timeFrom.before(timeTo)) {
            throw new IllegalArgumentException("Start time must be before end time.");
        }

        // 7. Comment length
        String cleanComment = (comment != null) ? comment.trim() : "";
        if (cleanComment.length() > 500) {
            throw new IllegalArgumentException("Comment must not exceed 500 characters.");
        }

        // Build model and persist
        ClassReservation r = new ClassReservation();
        r.setStudentId(studentId);
        r.setClassId(classId); // <-- 2. SET THE CLASS ID IN MODEL
        r.setFirstName(firstName.trim());
        r.setDate(reservationDate);
        r.setTimeFrom(timeFrom);
        r.setTimeTo(timeTo);
        r.setComment(cleanComment);

        return dao.addReservation(r);
    }

    // ── Student: list own reservations ────────────────────────────────────────

    public List<ClassReservation> getReservationsByStudent(int studentId) {
        return dao.getReservationsByStudent(studentId);
    }

    // ── Admin: list all reservations (optionally filtered by status) ──────────

    public List<ClassReservation> getAllReservations() {
        return dao.getAllReservations();
    }

    /**
     * Returns all reservations filtered by status.
     * Pass null or blank to return all.
     */
    public List<ClassReservation> getReservationsByStatus(String statusFilter) {
        if (statusFilter == null || statusFilter.trim().isEmpty()
                || "all".equalsIgnoreCase(statusFilter.trim())) {
            return dao.getAllReservations();
        }
        String normalised = normaliseStatus(statusFilter.trim());
        if (normalised == null) {
            return dao.getAllReservations();
        }
        return dao.getReservationsByStatus(normalised);
    }

    // ── Admin: approve or reject ──────────────────────────────────────────────

    public boolean updateStatus(int reservationId, String action) {
        if (reservationId <= 0) {
            throw new IllegalArgumentException("Invalid reservation ID.");
        }
        if (action == null || action.trim().isEmpty()) {
            throw new IllegalArgumentException("Action is required.");
        }

        String newStatus;
        switch (action.trim().toLowerCase()) {
            case "approve": newStatus = STATUS_APPROVED; break;
            case "reject":  newStatus = STATUS_REJECTED; break;
            default: throw new IllegalArgumentException("Unknown action: " + action);
        }

        return dao.updateStatus(reservationId, newStatus);
    }

    // ── Dashboard stats ───────────────────────────────────────────────────────

    public int getTotalReservations() {
        return dao.getTotalReservations();
    }

    public int getPendingCount() {
        return dao.getPendingCount();
    }

    // ── Private helpers ───────────────────────────────────────────────────────

    /**
     * Appends ":00" if the time string is in HH:mm format so Time.valueOf works.
     */
    private String normaliseTime(String t) {
        return (t != null && t.length() == 5) ? t + ":00" : t;
    }

    /**
     * Maps any case variant of a status string to the DB-stored form.
     */
    private String normaliseStatus(String raw) {
        switch (raw.toLowerCase()) {
            case "pending":  return STATUS_PENDING;
            case "approved": return STATUS_APPROVED;
            case "rejected": return STATUS_REJECTED;
            default:         return null;
        }
    }
}