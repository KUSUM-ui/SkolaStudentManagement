package com.SkolaStudentManagement.model;
import java.sql.Date;
import java.sql.Time;
import java.time.LocalDateTime;


public class ClassReservation {
    private int       reservationId;
    private int       studentId;
    private int       classId;
    private String    className;
    private String    firstName;
    private Date      date;
    private Time      timeFrom;
    private Time      timeTo;
    private String    comment;
    private String    status;
    private LocalDateTime CreatedAt;
    

	/**
	 * @return the reservationId
	 */
	public int getReservationId() {
		return reservationId;
	}
	/**
	 * @param reservationId the reservationId to set
	 */
	public void setReservationId(int reservationId) {
		this.reservationId = reservationId;
	}
	/**
	 * @return the studentId
	 */
	public int getStudentId() {
		return studentId;
	}
	/**
	 * @param studentId the studentId to set
	 */
	public void setStudentId(int studentId) {
		this.studentId = studentId;
	}
	/**
	 * @return the firstName
	 */
	public String getFirstName() {
		return firstName;
	}
	/**
	 * @param firstName the firstName to set
	 */
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	/**
	 * @return the date
	 */
	public Date getDate() {
		return date;
	}
	/**
	 * @param date the date to set
	 */
	public void setDate(Date date) {
		this.date = date;
	}
	/**
	 * @return the timeFrom
	 */
	public Time getTimeFrom() {
		return timeFrom;
	}
	/**
	 * @param timeFrom the timeFrom to set
	 */
	public void setTimeFrom(Time timeFrom) {
		this.timeFrom = timeFrom;
	}
	/**
	 * @return the timeTo
	 */
	public Time getTimeTo() {
		return timeTo;
	}
	/**
	 * @param timeTo the timeTo to set
	 */
	public void setTimeTo(Time timeTo) {
		this.timeTo = timeTo;
	}
	/**
	 * @return the comment
	 */
	public String getComment() {
		return comment;
	}
	/**
	 * @param comment the comment to set
	 */
	public void setComment(String comment) {
		this.comment = comment;
	}
	/**
	 * @return the status
	 */
	public String getStatus() {
		return status;
	}
	/**
	 * @param status the status to set
	 */
	public void setStatus(String status) {
		this.status = status;
	}

	/**
	 * @return the classId
	 */
	public int getClassId() {
		return classId;
	}
	/**
	 * @param classId the classId to set
	 */
	public void setClassId(int classId) {
		this.classId = classId;
	}
	/**
	 * @return the className
	 */
	public String getClassName() {
		return className;
	}
	/**
	 * @param className the className to set
	 */
	public void setClassName(String className) {
		this.className = className;
	}
	public void setCreatedAt(LocalDateTime createdAt) {
		this.CreatedAt = createdAt;
	
		
	}
    public String getTimeRange() {
        if (timeFrom == null || timeTo == null) return "-";
        return timeFrom.toString().substring(0, 5)
             + " - "
             + timeTo.toString().substring(0, 5);
    }
    
}