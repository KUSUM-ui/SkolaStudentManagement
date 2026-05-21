package com.SkolaStudentManagement.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.SkolaStudentManagement.model.StudentModel;
import com.SkolaStudentManagement.utils.DBconfig;

public class StudentDAO {

    // =========================
    // 1. TOTAL APPROVED COUNT
    //    Used by AdminStudent.jsp stat card
    // =========================
    public int getTotalStudentCount() throws Exception {

        Connection con = DBconfig.getConnection();
        String sql = "SELECT COUNT(*) FROM student WHERE status = 'APPROVED'";
        PreparedStatement pst = con.prepareStatement(sql);
        ResultSet rs = pst.executeQuery();

        int count = 0;
        if (rs.next()) count = rs.getInt(1);

        rs.close(); pst.close(); con.close();
        return count;
    }

    // =========================
    // 2. GET STUDENTS (list view)
    //    Pass null to skip a filter
    // =========================
    public List<StudentModel> getStudents(String facultyId, String sectionId, String semester) throws Exception {

        String cleanFacultyId = (facultyId != null && !facultyId.trim().isEmpty()) ? facultyId.trim() : null;
        String cleanSectionId = (sectionId != null && !sectionId.trim().isEmpty()) ? sectionId.trim() : null;
        String cleanSemester  = (semester  != null && !semester.trim().isEmpty())  ? semester.trim()  : null;

        StringBuilder sql = new StringBuilder(
            "SELECT s.student_id, s.first_name, s.last_name, s.dob, s.gender, "
          + "       s.email, s.phone, s.image, s.status, s.section_id, "
          + "       s.faculty_id, s.grade_level, f.faculty_name "
          + "FROM student s "
          + "LEFT JOIN faculty f ON s.faculty_id = f.faculty_id "
          + "WHERE s.status = 'APPROVED'");

        if (cleanFacultyId != null) sql.append(" AND s.faculty_id = ?");
        if (cleanSectionId != null) sql.append(" AND s.section_id = ?");
        if (cleanSemester  != null) sql.append(" AND s.grade_level = ?");
        sql.append(" ORDER BY s.last_name, s.first_name");

        Connection con = DBconfig.getConnection();
        PreparedStatement pst = con.prepareStatement(sql.toString());

        int idx = 1;
        if (cleanFacultyId != null) pst.setString(idx++, cleanFacultyId);
        if (cleanSectionId != null) pst.setString(idx++, cleanSectionId);
        if (cleanSemester  != null) pst.setString(idx,   cleanSemester);

        ResultSet rs = pst.executeQuery();
        List<StudentModel> list = new ArrayList<>();
        while (rs.next()) list.add(mapRow(rs));

        rs.close(); pst.close(); con.close();
        return list;
    }

    /** Backwards-compatible overload — no semester filter. */
    public List<StudentModel> getStudents(String facultyId, String sectionId) throws Exception {
        return getStudents(facultyId, sectionId, null);
    }

    // =========================
    // 3. GET SINGLE STUDENT BY ID
    //    Used by Detailsview and Edit pages
    // =========================
    public StudentModel getStudentById(int studentId) throws Exception {

        Connection con = DBconfig.getConnection();
        String sql = "SELECT s.student_id, s.first_name, s.last_name, s.dob, s.gender, "
                   + "       s.email, s.phone, s.image, s.status, s.section_id, "
                   + "       s.faculty_id, s.grade_level, f.faculty_name "
                   + "FROM student s "
                   + "LEFT JOIN faculty f ON s.faculty_id = f.faculty_id "
                   + "WHERE s.student_id = ?";

        PreparedStatement pst = con.prepareStatement(sql);
        pst.setInt(1, studentId);

        ResultSet rs = pst.executeQuery();
        StudentModel student = null;
        if (rs.next()) student = mapRow(rs);

        rs.close(); pst.close(); con.close();
        return student;
    }

    // =========================
    // 4. UPDATE STUDENT DETAILS
    //    Used by Edit page POST
    // =========================
    public boolean updateStudent(int studentId, String firstName, String lastName,
                                  String email, String phone, String dob,
                                  String gender, String facultyId, String sectionId,
                                  String gradeLevel) throws Exception {

        Connection con = DBconfig.getConnection();
        String sql = "UPDATE student SET "
                   + "first_name=?, last_name=?, email=?, phone=?, dob=?, "
                   + "gender=?, faculty_id=?, section_id=?, grade_level=? "
                   + "WHERE student_id=?";

        PreparedStatement pst = con.prepareStatement(sql);
        pst.setString(1, firstName);
        pst.setString(2, lastName);
        pst.setString(3, email);
        pst.setString(4, phone);
        pst.setString(5, dob);
        pst.setString(6, gender);
        pst.setString(7, facultyId);
        pst.setString(8, sectionId);
        pst.setString(9, gradeLevel);
        pst.setInt(10, studentId);

        int rows = pst.executeUpdate();
        pst.close(); con.close();
        return rows > 0;
    }
    /**
     * Updates a student's password in the database.
     */
    public boolean updateStudentPassword(int studentId, String hashedPassword) throws Exception {
        String sql = "UPDATE student SET password = ? WHERE student_id = ?";

        try (java.sql.Connection conn = com.SkolaStudentManagement.utils.DBconfig.getConnection();
             java.sql.PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, hashedPassword);
            ps.setInt(2, studentId);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (java.sql.SQLException e) {
            e.printStackTrace();
            throw new Exception("Database error updating password: " + e.getMessage());
        }
    }

    // =========================
    // 5. REMOVE STUDENT (soft delete)
    // =========================
    public boolean removeStudent(int studentId) throws Exception {

        Connection con = DBconfig.getConnection();
        String sql = "UPDATE student SET status='INACTIVE' WHERE student_id=?";

        PreparedStatement pst = con.prepareStatement(sql);
        pst.setInt(1, studentId);

        int rows = pst.executeUpdate();
        pst.close(); con.close();
        return rows > 0;
    }

    public int getTotalApprovedStudents() throws Exception {
        Connection con = DBconfig.getConnection();
        String sql = "SELECT COUNT(*) FROM student WHERE status = 'APPROVED'";
        PreparedStatement pst = con.prepareStatement(sql);
        ResultSet rs = pst.executeQuery();
        int count = 0;
        if (rs.next()) count = rs.getInt(1);
        rs.close(); pst.close(); con.close();
        return count;
    }

    public int getTotalPendingStudents() throws Exception {
        Connection con = DBconfig.getConnection();
        String sql = "SELECT COUNT(*) FROM student WHERE status = 'PENDING'";
        PreparedStatement pst = con.prepareStatement(sql);
        ResultSet rs = pst.executeQuery();
        int count = 0;
        if (rs.next()) count = rs.getInt(1);
        rs.close(); pst.close(); con.close();
        return count;
    }

    // =========================
    // 6. UPDATE STUDENT IMAGE
    // =========================
    public boolean updateStudentImage(int studentId, String imagePath) throws Exception {

        Connection con = DBconfig.getConnection();
        String sql = "UPDATE student SET image = ? WHERE student_id = ?";

        PreparedStatement pst = con.prepareStatement(sql);
        pst.setString(1, imagePath);
        pst.setInt(2, studentId);

        int rows = pst.executeUpdate();
        pst.close(); con.close();
        return rows > 0;
    }

    public List<StudentModel> getPendingStudents() throws Exception {

        List<StudentModel> list = new ArrayList<>();

        String sql = "SELECT * FROM student WHERE status = 'PENDING'";

        try (Connection con = DBconfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                StudentModel s = new StudentModel();

                s.setFirstName(rs.getString("first_name"));
                s.setLastName(rs.getString("last_name"));
                s.setEmail(rs.getString("email"));
                s.setStatus(rs.getString("status"));

                list.add(s);
            }
        }

        return list;
    }

    // =========================
    // PRIVATE: map one RS row → StudentModel
    // =========================
    private StudentModel mapRow(ResultSet rs) throws Exception {
        StudentModel s = new StudentModel();
        s.setStudentId(rs.getInt("student_id"));
        s.setFirstName(rs.getString("first_name"));
        s.setLastName(rs.getString("last_name"));
        s.setDob(rs.getDate("dob"));
        s.setGender(rs.getString("gender"));
        s.setEmail(rs.getString("email"));
        s.setNumber(rs.getString("phone"));        // DB col=phone, model field=number
        s.setImage(rs.getString("image"));
        s.setStatus(rs.getString("status"));
        s.setSectionId(rs.getString("section_id"));
        s.setFacultyId(rs.getString("faculty_id"));
        try { s.setGradeLevel(rs.getString("grade_level")); } catch (Exception ignored) {}
        try { s.setFacultyName(rs.getString("faculty_name")); } catch (Exception ignored) {}
        return s;
    }
}