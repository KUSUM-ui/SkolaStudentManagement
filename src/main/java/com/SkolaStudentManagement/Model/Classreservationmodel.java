package com.SkolaStudentManagement.Model;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;

public class Classreservationmodel {

    private int       reservationId;
    private int       studentId;
    private String    firstName;
    private Date      date;
    private Time      timeFrom;
    private Time      timeTo;
    private String    comment;
    private String    status;      // Pending | Approved | Disapproved
    private Timestamp createdAt;

    public Classreservationmodel() {}

    // ── Getters & Setters ─────────────────────────────────────────────

    public int       getReservationId()                        { return reservationId; }
    public void      setReservationId(int reservationId)       { this.reservationId = reservationId; }

    public int       getStudentId()                            { return studentId; }
    public void      setStudentId(int studentId)               { this.studentId = studentId; }

    public String    getFirstName()                            { return firstName; }
    public void      setFirstName(String firstName)            { this.firstName = firstName; }

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

    // ── Helper: display time as "HH:mm" ──────────────────────────────
    public String getTimeRange() {
        if (timeFrom == null || timeTo == null) return "-";
        return timeFrom.toString().substring(0, 5) + " - " + timeTo.toString().substring(0, 5);
    }
}