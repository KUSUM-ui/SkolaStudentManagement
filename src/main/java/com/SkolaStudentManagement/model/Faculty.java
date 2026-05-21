package com.SkolaStudentManagement.model;

public class Faculty {
    private int    facultyId;
    private String facultyName;
    private int total_credits;
    private String faculty_description;
	/**
	 * @return the facultyId
	 */
	public int getFacultyId() {
		return facultyId;
	}
	/**
	 * @param facultyId the facultyId to set
	 * 
	 */
	public void setFacultyId(int facultyId) {
		this.facultyId = facultyId;
	}
	/**
	 * @return the facultyName
	 */
	public String getFacultyName() {
		return facultyName;
	}
	/**
	 * @param facultyName the facultyName to set
	 */
	public void setFacultyName(String facultyName) {
		this.facultyName = facultyName;
	}
	/**
	 * @return the faculty_description
	 */
	public String getFaculty_description() {
		return faculty_description;
	}
	/**
	 * @param faculty_description the faculty_description to set
	 * 
	 */
	public void setFaculty_description(String faculty_description) {
		this.faculty_description = faculty_description;
	}
	/**
	 * @return the total_credits
	 * 
	 */
	public int getTotal_credits() {
		return total_credits;
	}
	/**
	 * @param total_credits the total_credits to set
	 */
	public void setTotal_credits(int total_credits) {
		this.total_credits = total_credits;
	}

   
}