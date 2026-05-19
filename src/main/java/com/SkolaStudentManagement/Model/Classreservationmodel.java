package com.SkolaStudentManagement.Model;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;

/**
 * Maps to the ClassReservation table.
 * Added: class_id (FK to class table), class_name (joined from class table)
 *
 * SQL migration needed:
 *   ALTER TABLE ClassReservation ADD COLUMN class_id INT NOT NULL AFTER first_name;
 */
public class Classreservationmodel {

    private int       reservationId;
    private int       studentId;
    private String    firstName;
    private int       classId;       // FK → class.class_id
    private String    className;     // joined from class table — not stored in ClassReservation
    private Date      date;
    private Time      timeFrom;
    private Time      timeTo;
    private String    comment;
    private String    status;        // Pending | Approved | Disapproved
    private Timestamp createdAt;

    public Classreservationmodel() {}

    // ── Getters & Setters ─────────────────────────────────────────────

    public int       getReservationId()                        { return reservationId; }
    public void      setReservationId(int reservationId)       { this.reservationId = reservationId; }

    public int       getStudentId()                            { return studentId; }
    public void      setStudentId(int studentId)               { this.studentId = studentId; }

    public String    getFirstName()                            { return firstName; }
    public void      setFirstName(String firstName)            { this.firstName = firstName; }

    public int       getClassId()                              { return classId; }
    public void      setClassId(int classId)                   { this.classId = classId; }

    public String    getClassName()                            { return className; }
    public void      setClassName(String className)            { this.className = className; }

    public Date      getDate()                                 { return date; }
    public void      setDate(Date date)                        { this.date = date; }

    public Time      getTimeFrom()                             { return timeFrom; }
    public void      setTimeFrom(Time timeFrom)                { this.timeFrom = timeFrom; }

    public Time      getTimeTo()                               { return timeTo; }
    public void      setTimeTo(Time timeTo)                    { this.timeTo = timeTo; }

    public String    getComment()                              { return comment; }
    public void      setComment(String comment)                { this.comment = comment; }

    public String    getStatus()                               { return status; }
    public void      setStatus(String status)                  { this.status = status; }

    public Timestamp getCreatedAt()                            { return createdAt; }
    public void      setCreatedAt(Timestamp createdAt)         { this.createdAt = createdAt; }

    // ── Helper: "HH:mm - HH:mm" display ──────────────────────────────
    public String getTimeRange() {
        if (timeFrom == null || timeTo == null) return "-";
        return timeFrom.toString().substring(0, 5)
             + " - "
             + timeTo.toString().substring(0, 5);
    }
}