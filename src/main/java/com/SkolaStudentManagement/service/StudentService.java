package com.SkolaStudentManagement.service;

import java.util.ArrayList;
import java.util.List;

import com.SkolaStudentManagement.dao.StudentDAO;
import com.SkolaStudentManagement.model.Faculty;
import com.SkolaStudentManagement.model.Section;
import com.SkolaStudentManagement.model.StudentModel;

/**
 * Service layer for student-related operations.
 * Controllers should call this class rather than StudentDAO directly.
 */
public class StudentService {

    private final StudentDAO studentDAO = new StudentDAO();
  
    private final ScheduleService scheduleService = new ScheduleService(); 

    /** Returns the count of students with APPROVED status. */
    public int getTotalApprovedStudents() throws Exception {
        return studentDAO.getTotalApprovedStudents();
    }

    /** Returns the count of students with PENDING status. */
    public int getTotalPendingStudents() throws Exception {
        return studentDAO.getTotalPendingStudents();
    }

    /** Returns all students currently awaiting approval. */
    public List<StudentModel> getPendingStudents() throws Exception {
        return studentDAO.getPendingStudents();
    }

    /**
     * Returns students filtered by faculty, section, and/or semester with strict validation.
     * Pass null or empty strings to skip a filter.
     */
    public List<StudentModel> getFilteredStudents(String facultyId, String sectionId, String semester) throws Exception {
        String cleanFacultyId = (facultyId != null && !facultyId.trim().isEmpty()) ? facultyId.trim() : null;
        String cleanSectionId = (sectionId != null && !sectionId.trim().isEmpty()) ? sectionId.trim() : null;
        String cleanSemester  = (semester  != null && !semester.trim().isEmpty())  ? semester.trim()  : null;

        // Faculty IDs are numeric PKs — validate format.
        // Section IDs may be alphanumeric strings (e.g. "C4") — no numeric check here.
        if (cleanFacultyId != null) {
            try { Integer.parseInt(cleanFacultyId); }
            catch (NumberFormatException e) { throw new IllegalArgumentException("Invalid Faculty ID format."); }
        }

        return studentDAO.getStudents(cleanFacultyId, cleanSectionId, cleanSemester);
    }

    /** Backwards-compatible overload — no semester filter. */
    public List<StudentModel> getFilteredStudents(String facultyId, String sectionId) throws Exception {
        return getFilteredStudents(facultyId, sectionId, null);
    }

    /** Returns all available faculties registered within the system. */
    public List<Faculty> getAllFaculties() throws Exception {
        // Routed via ScheduleService wrapper cleanly
        List<Faculty> faculties = scheduleService.getAllFaculties();
        if (faculties == null) {
            return new ArrayList<>();
        }
        return faculties;
    }

    /**
     * Safely constructs a dynamic list of sections matching the chosen faculty filter scope.
     * If no faculty filter is specified, aggregates every section option available across the institution.
     */
    public List<Section> getSectionsForFacultyFilter(String facultyId, List<Faculty> faculties) throws Exception {
        List<Section> sections = new ArrayList<>();
        String cleanFacultyId = (facultyId != null && !facultyId.trim().isEmpty()) ? facultyId.trim() : null;

        if (cleanFacultyId != null) {
            try {
                int parsedFacultyId = Integer.parseInt(cleanFacultyId);
                // Routed via ScheduleService wrapper cleanly
                List<Section> facultySections = scheduleService.getSectionsByFaculty(parsedFacultyId);
                if (facultySections != null) {
                    sections.addAll(facultySections);
                }
            } catch (NumberFormatException e) {
                // Routed via ScheduleService wrapper cleanly
                List<Section> fallbackSections = scheduleService.getSectionsByFaculty(0);
                if (fallbackSections != null) {
                    sections.addAll(fallbackSections);
                }
            }
        } else {
            List<Faculty> activeFaculties = (faculties != null) ? faculties : getAllFaculties();
            for (Faculty f : activeFaculties) {
                if (f != null) {
                    // Routed via ScheduleService wrapper cleanly
                    List<Section> loopSections = scheduleService.getSectionsByFaculty(f.getFacultyId());
                    if (loopSections != null) {
                        sections.addAll(loopSections);
                    }
                }
            }
        }
        return sections;
    }

    /**
     * Returns students optionally filtered by faculty and/or section.
     * Pass null to skip a filter.
     */
    public List<StudentModel> getStudents(String facultyId, String sectionId) throws Exception {
        return studentDAO.getStudents(facultyId, sectionId);
    }

    /**
     * Returns a single student record by primary key.
     * Returns null when the student is not found.
     */
    public StudentModel getStudentById(int studentId) throws Exception {
        return studentDAO.getStudentById(studentId);
    }

    /**
     * Validates and updates the student's personal/academic fields.
     *
     * @throws IllegalArgumentException if required fields are missing or invalid
     */
    public boolean updateStudent(int studentId,
                                 String firstName, String lastName,
                                 String email, String phone,
                                 String dob, String gender,
                                 String facultyId, String sectionId,
                                 String gradeLevel) throws Exception {

        if (firstName == null || firstName.trim().isEmpty())
            throw new IllegalArgumentException("First name is required.");
        if (lastName == null || lastName.trim().isEmpty())
            throw new IllegalArgumentException("Last name is required.");
        if (email == null || !email.contains("@"))
            throw new IllegalArgumentException("A valid email address is required.");

        return studentDAO.updateStudent(
            studentId,
            firstName.trim(), lastName.trim(),
            email.trim(), phone, dob, gender,
            facultyId, sectionId, gradeLevel
        );
    }

    /** Soft-deletes a student by setting their status to INACTIVE. */
    public boolean removeStudent(int studentId) throws Exception {
        return studentDAO.removeStudent(studentId);
    }

    /** Updates only the student's profile image path. */
    public boolean updateStudentImage(int studentId, String imagePath) throws Exception {
        return studentDAO.updateStudentImage(studentId, imagePath);
    }
    /** Updates the student's encrypted credential string. */
    public boolean updateStudentPassword(int studentId, String hashedUrlPassword) throws Exception {
        return studentDAO.updateStudentPassword(studentId, hashedUrlPassword);
    }

    /**
     * Parses the integer semester number from the stored grade_level string.
     * e.g. "Semester 5" -> 5
     * Returns 0 if null or unparseable.
     */
    public int parseSemesterNumber(String gradeLevel) {
        if (gradeLevel == null || gradeLevel.trim().isEmpty()) return 0;
        try {
            return Integer.parseInt(gradeLevel.trim().replace("Semester ", "").trim());
        } catch (NumberFormatException e) {
            return 0;
        }
    }
}