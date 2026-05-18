package com.model;

import java.sql.Date;

public class SettingsStudentModel {

    private int    studentId;
    private String firstName;
    private String lastName;
    private Date   dob;
    private String gender;
    private String email;
    private String phone;
    private String password;
    private String gradeLevel;
    private int    facultyId;
    private String image;
    private int    adminId;
    private String sectionId;

    // ── Constructors ──────────────────────────────────────────────────

    public SettingsStudentModel() {}

    public SettingsStudentModel(int studentId, String firstName, String lastName, Date dob,
                   String gender, String email, String phone, String password,
                   String gradeLevel, int facultyId, String image,
                   int adminId, String sectionId) {
        this.studentId  = studentId;
        this.firstName  = firstName;
        this.lastName   = lastName;
        this.dob        = dob;
        this.gender     = gender;
        this.email      = email;
        this.phone      = phone;
        this.password   = password;
        this.gradeLevel = gradeLevel;
        this.facultyId  = facultyId;
        this.image      = image;
        this.adminId    = adminId;
        this.sectionId  = sectionId;
    }

    // ── Getters & Setters ─────────────────────────────────────────────

    public int    getStudentId()               { return studentId; }
    public void   setStudentId(int studentId)  { this.studentId = studentId; }

    public String getFirstName()               { return firstName; }
    public void   setFirstName(String firstName) { this.firstName = firstName; }

    public String getLastName()                { return lastName; }
    public void   setLastName(String lastName) { this.lastName = lastName; }

    public Date   getDob()                     { return dob; }
    public void   setDob(Date dob)             { this.dob = dob; }

    public String getGender()                  { return gender; }
    public void   setGender(String gender)     { this.gender = gender; }

    public String getEmail()                   { return email; }
    public void   setEmail(String email)       { this.email = email; }

    public String getPhone()                   { return phone; }
    public void   setPhone(String phone)       { this.phone = phone; }

    public String getPassword()                { return password; }
    public void   setPassword(String password) { this.password = password; }

    public String getGradeLevel()              { return gradeLevel; }
    public void   setGradeLevel(String gradeLevel) { this.gradeLevel = gradeLevel; }

    public int    getFacultyId()               { return facultyId; }
    public void   setFacultyId(int facultyId)  { this.facultyId = facultyId; }

    public String getImage()                   { return image; }
    public void   setImage(String image)       { this.image = image; }

    public int    getAdminId()                 { return adminId; }
    public void   setAdminId(int adminId)      { this.adminId = adminId; }

    public String getSectionId()               { return sectionId; }
    public void   setSectionId(String sectionId) { this.sectionId = sectionId; }

    // ── Helper ────────────────────────────────────────────────────────

    public String getFullName() {
        return firstName + " " + lastName;
    }

    @Override
    public String toString() {
        return "Student{id=" + studentId + ", name=" + firstName + " " + lastName
                + ", email=" + email + "}";
    }
}
