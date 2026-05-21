package com.SkolaStudentManagement.model;

public class Section {
    private String sectionId;
    private String    sectionName;
    private int    facultyId;
	/**
	 * @return the sectionId
	 */
	public String getSectionId() {
		return sectionId;
	}
	/**
	 * @param sectionId the sectionId to set
	 */
	public void setSectionId(String sectionId) {
		this.sectionId = sectionId;
	}
	/**
	 * @return the sectionName
	 */
	public String getSectionName() {
		return sectionName;
	}
	/**
	 * @param sectionName the sectionName to set
	 */
	public void setSectionName(String sectionName) {
		this.sectionName = sectionName;
	}
	/**
	 * @return the facultyId
	 */
	public int getFacultyId() {
		return facultyId;
	}
	/**
	 * @param facultyId the facultyId to set
	 */
	public void setFacultyId(int facultyId) {
		this.facultyId = facultyId;
	}

}