package com.SkolaStudentManagement.service;

import com.SkolaStudentManagement.dao.RegisterDAO;
import com.SkolaStudentManagement.model.StudentModel;
import com.SkolaStudentManagement.utils.PasswordUtil;
import java.util.*;

public class RegisterService {

    private RegisterDAO dao = new RegisterDAO();

    /**
     * Registers a new student, performs all business validation checks,
     * hashes the raw password using PasswordUtil, and assigns the correct
     * status based on the registration origin source.
     *
     * @param source "admin" → APPROVED immediately; anything else → PENDING
     */
    public void addStudent(String firstName, String lastName, String dob,
                           String gender, String email, String phone,
                           String password, int facultyId, String sectionId,
                           String gradeLevel, String image,
                           String source) throws Exception {
        
        // 1. Core Structural Validations 
        if (firstName == null || firstName.trim().isEmpty()
                || lastName == null || lastName.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || password == null || password.trim().isEmpty()
                || dob == null || dob.trim().isEmpty()
                || gender == null || gender.trim().isEmpty()
                || sectionId == null || sectionId.trim().isEmpty()
                || gradeLevel == null || gradeLevel.trim().isEmpty()
                || facultyId == 0) {

            throw new Exception("Registration failed: Please fill all required fields.");
        }

        // 2. Password Strength/Length Validations
        if (password.length() < 8) {
            throw new Exception("Password must be at least 8 characters.");
        }

        // 3. Business Identity Rule: Check for Pre-existing Accounts
        StudentModel existingStudent = dao.getStudentByEmail(email.trim());
        if (existingStudent != null) {
            throw new Exception("Registration failed: A student with this email address already exists.");
        }

        // 4. Secure Password Hashing via PasswordUtil 
        // This takes the raw input string and salts/hashes it securely using BCrypt
        String securePasswordHash = PasswordUtil.getHashPassword(password);

        // 5. Determine Enrollment Workflow status flags
        String status = "admin".equalsIgnoreCase(source) ? "APPROVED" : "PENDING";

        // 6. Data hand-off to the persistence layer (DAO)
        dao.insertStudent(
                firstName.trim(),
                lastName.trim(),
                dob,
                gender,
                email.trim(),
                phone,
                securePasswordHash, // The raw password is never stored or seen by the DAO
                facultyId,
                sectionId,
                gradeLevel,
                image,
                status);
    }

    /**
     * Overload pattern for quick admin-panel operations.
     */
    public void addStudentAsAdmin(String firstName, String lastName, String dob,
                                   String gender, String email, String phone,
                                   String password, int facultyId, String sectionId,
                                   String gradeLevel, String image) throws Exception {
        addStudent(firstName, lastName, dob, gender,
                   email, phone, password,
                   facultyId, sectionId, gradeLevel,
                   image, "admin");
    }

    public int getPendingCount() throws Exception {
        return dao.getStudentsByStatus("PENDING").size();
    }

    public StudentModel getStudentByEmail(String email) throws Exception {
        return dao.getStudentByEmail(email);
    }
    public List<StudentModel> getStudentsByStatus(String status) throws Exception {
        return dao.getStudentsByStatus(status);
    }

    public boolean updateStudentStatus(int studentId, String status) throws Exception {
        return dao.updateStudentStatus(studentId, status);
    }
}