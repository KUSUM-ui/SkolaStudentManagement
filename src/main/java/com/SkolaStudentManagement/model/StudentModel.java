package com.SkolaStudentManagement.model;

import java.util.Date;

public class StudentModel {

    private int studentId; 

    private String firstName;
    private String lastName;
    private Date dob;
    private String gender;
    private String email;
    private String number;
    private String gradelevel;
    private int program;
    private String password;
    private String image;
    private String status;   
    private String facultyId;
    private String sectionId;
    private String facultyName;

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    public int getProgram() {
        return program;
    }
    public void setProgram(int program) {
        this.program = program;
    }

    public String getNumber() {
        return number;
    }
    public void setNumber(String number) {
        this.number = number;
    }

    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    public String getGender() {
        return gender;
    }
    public void setGender(String gender) {
        this.gender = gender;
    }

    public Date getDob() {
        return dob;
    }
    public void setDob(Date dob) {
        this.dob = dob;
    }

    public String getLastName() {
        return lastName;
    }
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getFirstName() {
        return firstName;
    }
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getImage() {
        return image;
    }
    public void setImage(String image) {
        this.image = image;
    }

    public String getGradeLevel() {
        return gradelevel;
    }
    public void setGradeLevel(String gradelevel) {
        this.gradelevel = gradelevel;
    }

	/**
	 * @return the facultyId
	 */
	public String getFacultyId() {
		return facultyId;
	}

	/**
	 * @param facultyId the facultyId to set
	 */
	public void setFacultyId(String facultyId) {
		this.facultyId = facultyId;
	}

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

	// ── Alias getters for the Registration Approvals page ──────────────────
	/** Alias: registrationId == studentId (pending students are in the student table) */
	public int getRegistrationId() { return studentId; }


}